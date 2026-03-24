import React, { createContext, useContext, useEffect, useState } from 'react';
import { supabase } from '@/lib/supabase';
import type { User, UserRole } from '@/types';

const ADMIN_EMAILS = ['asharaj@mgits.ac.in', 'adhithyakrishna00001@gmail.com'];

interface AuthContextType {
  user: User | null;
  loading: boolean;
  signIn: (email: string, password: string) => Promise<{ error?: string }>;
  signUp: (email: string, password: string, name: string, role: UserRole) => Promise<{ error?: string }>;
  signOut: () => Promise<void>;
  adminLogin: (email: string, password: string) => Promise<{ error?: string }>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const useAuth = () => {
  const ctx = useContext(AuthContext);
  if (!ctx) throw new Error('useAuth must be used within AuthProvider');
  return ctx;
};

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);

  const fetchProfile = async (userId: string): Promise<User | null> => {
    try {
      // Use maybeSingle() — returns null for 0 rows instead of throwing 406
      const { data, error } = await supabase
        .from('profiles')
        .select('*')
        .eq('id', userId)
        .maybeSingle();

      if (error) {
        console.error('Profile fetch error:', error.message);
        return null;
      }

      // Profile not found — user exists in auth but has no profile row
      if (!data) {
        console.warn('No profile found for user:', userId);
        return null;
      }

      return data;
    } catch (err) {
      console.error('Profile fetch exception:', err);
      return null;
    }
  };

  useEffect(() => {
    let mounted = true;

    supabase.auth.getSession().then(async ({ data: { session } }) => {
      if (!mounted) return;
      if (session?.user) {
        const profile = await fetchProfile(session.user.id);
        if (mounted) {
          if (profile) {
            setUser(profile);
          } else {
            // Stale session with no profile — sign out to clean up
            console.warn('Stale session detected (no profile). Signing out.');
            await supabase.auth.signOut();
            setUser(null);
          }
          setLoading(false);
        }
      } else {
        if (mounted) setLoading(false);
      }
    });

    const { data: { subscription } } = supabase.auth.onAuthStateChange(async (event, session) => {
      if (!mounted) return;

      if (event === 'SIGNED_OUT') {
        setUser(null);
        setLoading(false);
        return;
      }

      if (session?.user) {
        setTimeout(async () => {
          if (!mounted) return;
          const profile = await fetchProfile(session.user.id);
          if (mounted) {
            setUser(profile);
            setLoading(false);
          }
        }, 100);
      } else {
        setUser(null);
        setLoading(false);
      }
    });

    return () => {
      mounted = false;
      subscription.unsubscribe();
    };
  }, []);

  const signIn = async (email: string, password: string) => {
    try {
      const { error } = await supabase.auth.signInWithPassword({ email, password });
      if (error) {
        console.error('Sign in error:', error.message, error.status);
        if (error.status === 500) {
          return { error: 'Server error. Please ensure "Confirm email" is disabled in Supabase → Auth → Providers → Email.' };
        }
        if (error.message.includes('Invalid login credentials')) {
          return { error: 'Invalid email or password.' };
        }
        if (error.message.includes('Email not confirmed')) {
          return { error: 'Email not confirmed. Ask admin to disable email confirmation in Supabase settings.' };
        }
        return { error: error.message };
      }
      return {};
    } catch (err) {
      console.error('Sign in exception:', err);
      return { error: 'Network error. Please try again.' };
    }
  };

  const signUp = async (email: string, password: string, name: string, role: UserRole) => {
    try {
      const { data, error } = await supabase.auth.signUp({
        email,
        password,
        options: {
          emailRedirectTo: window.location.origin,
          data: { name, role },
        },
      });

      if (error) {
        console.error('Sign up error:', error.message, error.status);
        if (error.status === 500) {
          return { error: 'Server error. Email confirmation might be enabled without SMTP. Ask admin to disable "Confirm email" in Supabase → Auth → Providers → Email.' };
        }
        if (error.message.includes('already registered')) {
          return { error: 'An account with this email already exists. Try signing in.' };
        }
        return { error: error.message };
      }

      if (data.user) {
        // Check for fake signup (user exists, auto-confirm off)
        if (data.user.identities && data.user.identities.length === 0) {
          return { error: 'An account with this email already exists. Try signing in.' };
        }

        // The trigger handle_new_user should auto-create the profile.
        // But let's also upsert to be safe.
        await supabase.from('profiles').upsert({
          id: data.user.id,
          name,
          email,
          role,
          approval_status: role === 'faculty' ? 'pending' : 'approved',
        });

        if (data.session) {
          // Auto-confirm ON — user is logged in immediately
          return {};
        }

        // No session = email confirmation required
        return {};
      }

      return {};
    } catch (err) {
      console.error('Sign up exception:', err);
      return { error: 'Network error. Please try again.' };
    }
  };

  const signOut = async () => {
    await supabase.auth.signOut();
    setUser(null);
  };

  const adminLogin = async (email: string, password: string) => {
    if (!ADMIN_EMAILS.includes(email.toLowerCase())) {
      return { error: 'This email is not authorized as admin.' };
    }

    // Try sign in first
    const { data: signInData, error: signInError } = await supabase.auth.signInWithPassword({ email, password });

    if (!signInError && signInData?.session) {
      // Signed in — ensure profile is admin
      await supabase.from('profiles').upsert({
        id: signInData.user.id,
        name: 'Admin',
        email: email.toLowerCase(),
        role: 'admin',
        approval_status: 'approved',
      });
      return {};
    }

    if (signInError) {
      console.error('Admin sign in error:', signInError.message, signInError.status);

      if (signInError.message.includes('Invalid login credentials')) {
        // Account doesn't exist — create it
        const { data: signUpData, error: signUpError } = await supabase.auth.signUp({
          email,
          password,
          options: { data: { name: 'Admin', role: 'admin' } },
        });

        if (signUpError) {
          if (signUpError.message.includes('already registered')) {
            return { error: 'Invalid password for this admin account.' };
          }
          return { error: signUpError.message };
        }

        if (signUpData?.user) {
          await supabase.from('profiles').upsert({
            id: signUpData.user.id,
            name: 'Admin',
            email: email.toLowerCase(),
            role: 'admin',
            approval_status: 'approved',
          });
        }

        if (signUpData?.session) {
          return {};
        }

        // Try sign in after signup
        const { error: retryError } = await supabase.auth.signInWithPassword({ email, password });
        if (retryError) {
          return { error: 'Account created. If email confirmation is enabled, please disable it in Supabase → Auth → Providers → Email, then try again.' };
        }
        return {};
      }

      if (signInError.status === 500) {
        return { error: 'Server error. Ensure "Confirm email" is OFF in Supabase → Auth → Providers → Email.' };
      }

      return { error: signInError.message };
    }

    return { error: 'Login failed. Please try again.' };
  };

  return (
    <AuthContext.Provider value={{ user, loading, signIn, signUp, signOut, adminLogin }}>
      {children}
    </AuthContext.Provider>
  );
};
