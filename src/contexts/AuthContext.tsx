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
      // Small delay to let trigger-created profile propagate
      await new Promise(r => setTimeout(r, 500));
      const { data, error } = await supabase
        .from('profiles')
        .select('*')
        .eq('id', userId)
        .single();
      if (error) {
        console.error('Profile fetch error:', error.message);
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
          setUser(profile);
          setLoading(false);
        }
      } else {
        if (mounted) setLoading(false);
      }
    });

    const { data: { subscription } } = supabase.auth.onAuthStateChange(async (_event, session) => {
      if (!mounted) return;
      if (session?.user) {
        setTimeout(async () => {
          if (!mounted) return;
          const profile = await fetchProfile(session.user.id);
          if (mounted) {
            setUser(profile);
            setLoading(false);
          }
        }, 0);
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
          return { error: 'Server error. Please check that email confirmation is disabled in Supabase Auth settings, or verify the account exists.' };
        }
        if (error.message.includes('Invalid login credentials')) {
          return { error: 'Invalid email or password.' };
        }
        if (error.message.includes('Email not confirmed')) {
          return { error: 'Please confirm your email first. Check your inbox.' };
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
          return { error: 'Server error. Email service may not be configured. Please ask admin to enable auto-confirm in Supabase Auth settings.' };
        }
        if (error.message.includes('already registered')) {
          return { error: 'An account with this email already exists. Try signing in.' };
        }
        return { error: error.message };
      }

      if (data.user) {
        // If auto-confirm is ON, user gets a session immediately
        // If auto-confirm is OFF, user.identities will be empty for existing unconfirmed
        if (data.user.identities && data.user.identities.length === 0) {
          return { error: 'An account with this email already exists. Try signing in.' };
        }

        // Upsert profile (trigger may have already created it)
        await supabase.from('profiles').upsert({
          id: data.user.id,
          name,
          email,
          role,
          approval_status: role === 'faculty' ? 'pending' : 'approved',
        });

        // If we got a session (auto-confirm ON), we're logged in
        if (data.session) {
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

    // Try sign in
    const { data: signInData, error: signInError } = await supabase.auth.signInWithPassword({ email, password });

    if (!signInError && signInData.session) {
      // Signed in successfully — ensure profile is admin
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

      // If invalid credentials, try creating the account
      if (signInError.message.includes('Invalid login credentials')) {
        const { data: signUpData, error: signUpError } = await supabase.auth.signUp({
          email,
          password,
          options: { data: { name: 'Admin', role: 'admin' } },
        });

        if (signUpError) {
          console.error('Admin sign up error:', signUpError.message);
          if (signUpError.message.includes('already registered')) {
            return { error: 'Invalid password for this admin account.' };
          }
          return { error: signUpError.message };
        }

        if (signUpData.user) {
          await supabase.from('profiles').upsert({
            id: signUpData.user.id,
            name: 'Admin',
            email: email.toLowerCase(),
            role: 'admin',
            approval_status: 'approved',
          });
        }

        // If auto-confirm gave a session, we're done
        if (signUpData.session) {
          return {};
        }

        // Try sign in after signup (auto-confirm case)
        const { error: retryError } = await supabase.auth.signInWithPassword({ email, password });
        if (retryError) {
          return { error: 'Account created but email confirmation may be required. Check Supabase Auth settings.' };
        }
        return {};
      }

      // 500 = server issue
      if (signInError.status === 500) {
        return { error: 'Server error. The account may need to be created through the Supabase Dashboard or via the signup form.' };
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
