import { useEffect, useState, useRef, useCallback } from 'react';
import { supabase } from '@/lib/supabase';
import { ComplaintCard } from '@/components/ComplaintCard';
import { PageWrapper } from '@/components/PageWrapper';
import { CardSkeleton } from '@/components/LoadingSkeleton';
import type { Complaint, Category, User } from '@/types';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { motion, useScroll, useTransform, useInView, useSpring } from 'framer-motion';
import { Loader2 } from 'lucide-react';

/* ─── Scroll-reveal wrapper for each card ─────────────────────────── */
const ScrollRevealCard = ({
  children,
  index,
}: {
  children: React.ReactNode;
  index: number;
}) => {
  const ref = useRef<HTMLDivElement>(null);
  const isInView = useInView(ref, { once: true, margin: '-60px' });

  // Column position in the 3-column grid
  const col = index % 3;

  // Left card: slides from left; Right card: slides from right; Center: rises from below
  const initialState =
    col === 0
      ? { opacity: 0, x: -80, y: 20, scale: 0.9, rotateY: 6 }
      : col === 2
        ? { opacity: 0, x: 80, y: 20, scale: 0.9, rotateY: -6 }
        : { opacity: 0, x: 0, y: 70, scale: 0.88, rotateX: 8 };

  const animateState = isInView
    ? { opacity: 1, x: 0, y: 0, scale: 1, rotateX: 0, rotateY: 0 }
    : initialState;

  return (
    <motion.div
      ref={ref}
      initial={initialState}
      animate={animateState}
      transition={{
        duration: 0.6,
        delay: col * 0.1,
        ease: [0.16, 1, 0.3, 1], // smooth expo-out
      }}
      whileHover={{
        y: -8,
        scale: 1.025,
        boxShadow: '0 24px 48px rgba(0,0,0,0.14)',
        transition: { duration: 0.25, ease: 'easeOut' },
      }}
      style={{ perspective: 900, transformStyle: 'preserve-3d' }}
      className="relative will-change-transform"
    >
      {children}
    </motion.div>
  );
};

/* ─── Parallax header section ─────────────────────────────────────── */
const ParallaxHeader = ({
  children,
}: {
  children: React.ReactNode;
}) => {
  const ref = useRef<HTMLDivElement>(null);
  const { scrollYProgress } = useScroll({
    target: ref,
    offset: ['start start', 'end start'],
  });

  const y = useTransform(scrollYProgress, [0, 1], [0, 80]);
  const opacity = useTransform(scrollYProgress, [0, 0.5], [1, 0.6]);
  const smoothY = useSpring(y, { stiffness: 100, damping: 30 });
  const smoothOpacity = useSpring(opacity, { stiffness: 100, damping: 30 });

  return (
    <motion.div ref={ref} style={{ y: smoothY, opacity: smoothOpacity }} className="sticky top-0 z-10 bg-background/80 backdrop-blur-xl pb-4 border-b border-border/40">
      {children}
    </motion.div>
  );
};

/* ─── Page component ──────────────────────────────────────────────── */
const AllComplaints = () => {
  const [complaints, setComplaints] = useState<Complaint[]>([]);
  const [categories, setCategories] = useState<Category[]>([]);
  const [profiles, setProfiles] = useState<User[]>([]);
  const [filterCategory, setFilterCategory] = useState('all');
  const [filterStatus, setFilterStatus] = useState('all');
  const [loading, setLoading] = useState(true);
  const [loadingMore, setLoadingMore] = useState(false);
  const [hasMore, setHasMore] = useState(true);
  const [tab, setTab] = useState('student');
  const perPage = 18;
  const sentinelRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    supabase.from('categories').select('*').then(({ data }) => setCategories(data || []));
    supabase.from('profiles').select('*').then(({ data }) => setProfiles(data || []));
  }, []);

  const fetchComplaints = useCallback(
    async (offset: number, append: boolean) => {
      if (profiles.length === 0) return;
      if (!append) setLoading(true);
      else setLoadingMore(true);

      const roleUserIds = profiles
        .filter((p) => (tab === 'student' ? p.role === 'student' : p.role === 'faculty'))
        .map((p) => p.id);
      if (roleUserIds.length === 0) {
        setComplaints([]);
        setLoading(false);
        setLoadingMore(false);
        setHasMore(false);
        return;
      }

      let query = supabase
        .from('complaints')
        .select('*, category:categories(*)')
        .in('user_id', roleUserIds)
        .order('created_at', { ascending: false })
        .range(offset, offset + perPage - 1);
      if (filterCategory !== 'all') query = query.eq('category_id', filterCategory);
      if (filterStatus !== 'all') query = query.eq('status', filterStatus);

      const { data } = await query;
      const enriched = (data || []).map((c) => ({
        ...c,
        user: profiles.find((p) => p.id === c.user_id),
      }));

      if (append) {
        setComplaints((prev) => [...prev, ...enriched]);
      } else {
        setComplaints(enriched);
      }
      setHasMore(enriched.length >= perPage);
      setLoading(false);
      setLoadingMore(false);
    },
    [profiles, tab, filterCategory, filterStatus]
  );

  // Reset on filter / tab change
  useEffect(() => {
    setComplaints([]);
    setHasMore(true);
    fetchComplaints(0, false);
  }, [fetchComplaints]);

  // Infinite-scroll observer
  useEffect(() => {
    if (!sentinelRef.current) return;
    const observer = new IntersectionObserver(
      (entries) => {
        if (entries[0].isIntersecting && hasMore && !loading && !loadingMore) {
          fetchComplaints(complaints.length, true);
        }
      },
      { rootMargin: '200px' }
    );
    observer.observe(sentinelRef.current);
    return () => observer.disconnect();
  }, [hasMore, loading, loadingMore, complaints.length, fetchComplaints]);

  const resetFilters = () => {
    setFilterCategory('all');
    setFilterStatus('all');
  };

  return (
    <PageWrapper className="container py-6 space-y-0 relative">
      <ParallaxHeader>
        <div className="pt-4 space-y-4">
          <motion.h1
            initial={{ opacity: 0, x: -20 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ duration: 0.5, ease: 'easeOut' }}
            className="text-2xl font-semibold text-foreground tracking-tight"
          >
            All Complaints
          </motion.h1>

          <Tabs value={tab} onValueChange={(v) => { setTab(v); resetFilters(); }}>
            <div className="flex items-center justify-between flex-wrap gap-4">
              <TabsList>
                <TabsTrigger value="student">Student Complaints</TabsTrigger>
                <TabsTrigger value="faculty">Faculty Complaints</TabsTrigger>
              </TabsList>
              <motion.div
                initial={{ opacity: 0, y: 10 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.15, duration: 0.4 }}
                className="flex gap-2"
              >
                <Select value={filterStatus} onValueChange={(v) => setFilterStatus(v)}>
                  <SelectTrigger className="w-40">
                    <SelectValue placeholder="Status" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">All Statuses</SelectItem>
                    <SelectItem value="pending">Pending</SelectItem>
                    <SelectItem value="processing">Processing</SelectItem>
                    <SelectItem value="done">Done</SelectItem>
                    <SelectItem value="undone">Undone</SelectItem>
                  </SelectContent>
                </Select>
                <Select value={filterCategory} onValueChange={(v) => setFilterCategory(v)}>
                  <SelectTrigger className="w-48">
                    <SelectValue placeholder="Category" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">All Categories</SelectItem>
                    {categories.map((c) => (
                      <SelectItem key={c.id} value={c.id}>
                        {c.name}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </motion.div>
            </div>

            {['student', 'faculty'].map((tabVal) => (
              <TabsContent key={tabVal} value={tabVal} className="mt-6">
                {loading ? (
                  <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                    {Array.from({ length: 6 }).map((_, i) => (
                      <motion.div
                        key={i}
                        initial={{ opacity: 0, y: 30 }}
                        animate={{ opacity: 1, y: 0 }}
                        transition={{ delay: i * 0.08, duration: 0.4 }}
                      >
                        <CardSkeleton />
                      </motion.div>
                    ))}
                  </div>
                ) : complaints.length === 0 ? (
                  <motion.div
                    initial={{ opacity: 0, scale: 0.9 }}
                    animate={{ opacity: 1, scale: 1 }}
                    transition={{ type: 'spring', stiffness: 200, damping: 20 }}
                    className="card-shadow rounded-lg bg-card p-12 text-center"
                  >
                    <p className="text-muted-foreground text-body">No complaints found.</p>
                  </motion.div>
                ) : (
                  <>
                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
                      {complaints.map((c, i) => (
                        <ScrollRevealCard key={c.id} index={i}>
                          <ComplaintCard complaint={c} showVotes={false} />
                          {c.user && (
                            <div className="absolute top-2 right-2">
                              <span className="text-[10px] bg-muted text-muted-foreground px-1.5 py-0.5 rounded font-medium backdrop-blur-sm">
                                {c.user.name}
                              </span>
                            </div>
                          )}
                        </ScrollRevealCard>
                      ))}
                    </div>

                    {/* Infinite scroll sentinel */}
                    <div ref={sentinelRef} className="h-2" />

                    {loadingMore && (
                      <motion.div
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        className="flex items-center justify-center py-8 gap-2 text-muted-foreground"
                      >
                        <Loader2 className="h-5 w-5 animate-spin" />
                        <span className="text-sm">Loading more complaints…</span>
                      </motion.div>
                    )}

                    {!hasMore && complaints.length > 0 && (
                      <motion.p
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        transition={{ delay: 0.3 }}
                        className="text-center text-sm text-muted-foreground py-8"
                      >
                        — You've seen all {complaints.length} complaints —
                      </motion.p>
                    )}
                  </>
                )}
              </TabsContent>
            ))}
          </Tabs>
        </div>
      </ParallaxHeader>
    </PageWrapper>
  );
};

export default AllComplaints;
