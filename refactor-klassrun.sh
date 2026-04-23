#!/usr/bin/env bash
# ────────────────────────────────────────────────────────────────────
# Klassrun · Premium Refactor
# Run this from the root of your Next.js project (where package.json lives).
#   chmod +x refactor-klassrun.sh && ./refactor-klassrun.sh
# ────────────────────────────────────────────────────────────────────
set -e

# ── sanity check ────────────────────────────────────────────────────
if [ ! -f "package.json" ]; then
  echo "✖  package.json not found. Run this from the project root."
  exit 1
fi

echo "▸ Klassrun premium refactor starting…"

mkdir -p app components components/ui lib

# ── 1. install framer-motion ────────────────────────────────────────
echo "▸ Installing framer-motion…"
if [ -f "pnpm-lock.yaml" ]; then
  pnpm add framer-motion@^11.11.17
elif [ -f "yarn.lock" ]; then
  yarn add framer-motion@^11.11.17
else
  npm install framer-motion@^11.11.17
fi

# ── 2. globals.css — design tokens, 8px scale, surfaces, typography ─
echo "▸ Writing app/globals.css…"
cat > app/globals.css <<'EOF'
@import "tailwindcss";
@import "tw-animate-css";
@import "shadcn/tailwind.css";
@source "../../components";

@custom-variant dark (&:is(.dark *));

@theme inline {
    --font-heading: var(--font-sans);
    --font-sans: var(--font-sans);
    --color-sidebar-ring: var(--sidebar-ring);
    --color-sidebar-border: var(--sidebar-border);
    --color-sidebar-accent-foreground: var(--sidebar-accent-foreground);
    --color-sidebar-accent: var(--sidebar-accent);
    --color-sidebar-primary-foreground: var(--sidebar-primary-foreground);
    --color-sidebar-primary: var(--sidebar-primary);
    --color-sidebar-foreground: var(--sidebar-foreground);
    --color-sidebar: var(--sidebar);
    --color-chart-5: var(--chart-5);
    --color-chart-4: var(--chart-4);
    --color-chart-3: var(--chart-3);
    --color-chart-2: var(--chart-2);
    --color-chart-1: var(--chart-1);
    --color-ring: var(--ring);
    --color-input: var(--input);
    --color-border: var(--border);
    --color-destructive: var(--destructive);
    --color-accent-foreground: var(--accent-foreground);
    --color-accent: var(--accent);
    --color-muted-foreground: var(--muted-foreground);
    --color-muted: var(--muted);
    --color-secondary-foreground: var(--secondary-foreground);
    --color-secondary: var(--secondary);
    --color-primary-foreground: var(--primary-foreground);
    --color-primary: var(--primary);
    --color-popover-foreground: var(--popover-foreground);
    --color-popover: var(--popover);
    --color-card-foreground: var(--card-foreground);
    --color-card: var(--card);
    --color-foreground: var(--foreground);
    --color-background: var(--background);

    /* ── Surface layers ─────────────────────────────────── */
    --color-surface-base: var(--surface-base);
    --color-surface-elevated: var(--surface-elevated);
    --color-surface-floating: var(--surface-floating);

    /* ── Radius scale ───────────────────────────────────── */
    --radius-sm: calc(var(--radius) * 0.6);
    --radius-md: calc(var(--radius) * 0.8);
    --radius-lg: var(--radius);
    --radius-xl: calc(var(--radius) * 1.4);
    --radius-2xl: calc(var(--radius) * 1.8);
    --radius-3xl: calc(var(--radius) * 2.2);
    --radius-4xl: calc(var(--radius) * 2.6);

    /* Klassrun custom color tokens (UNCHANGED palette) */
    --color-klassrun-green: oklch(0.65 0.178 145);
    --color-klassrun-green-dark: oklch(0.52 0.148 145);
    --color-klassrun-green-light: oklch(0.75 0.15 145);
    --color-klassrun-navy: oklch(0.22 0.025 255);
    --color-klassrun-navy-light: oklch(0.30 0.02 255);
}

:root {
    /* ── Klassrun palette (UNCHANGED) ───────────────────── */
    --background: oklch(1 0 0);
    --foreground: oklch(0.22 0.025 255);

    --card: oklch(1 0 0);
    --card-foreground: oklch(0.22 0.025 255);

    --popover: oklch(1 0 0);
    --popover-foreground: oklch(0.22 0.025 255);

    --primary: oklch(0.65 0.178 145);
    --primary-foreground: oklch(1 0 0);

    --secondary: oklch(0.97 0.002 260);
    --secondary-foreground: oklch(0.22 0.025 255);

    --muted: oklch(0.97 0.002 260);
    --muted-foreground: oklch(0.55 0.014 260);

    --accent: oklch(0.93 0.03 145);
    --accent-foreground: oklch(0.22 0.025 255);

    --destructive: oklch(0.577 0.245 27.325);

    --border: oklch(0.922 0.004 260);
    --input: oklch(0.922 0.004 260);
    --ring: oklch(0.65 0.178 145);

    --chart-1: oklch(0.65 0.178 145);
    --chart-2: oklch(0.22 0.025 255);
    --chart-3: oklch(0.52 0.148 145);
    --chart-4: oklch(0.55 0.014 260);
    --chart-5: oklch(0.75 0.15 145);

    --radius: 0.875rem;

    --sidebar: oklch(0.985 0.002 260);
    --sidebar-foreground: oklch(0.22 0.025 255);
    --sidebar-primary: oklch(0.65 0.178 145);
    --sidebar-primary-foreground: oklch(1 0 0);
    --sidebar-accent: oklch(0.93 0.03 145);
    --sidebar-accent-foreground: oklch(0.22 0.025 255);
    --sidebar-border: oklch(0.922 0.004 260);
    --sidebar-ring: oklch(0.65 0.178 145);

    /* ── Surface layers (base · elevated · floating) ────── */
    --surface-base: oklch(0.995 0.002 260);
    --surface-elevated: oklch(1 0 0);
    --surface-floating: oklch(1 0 0);

    /* ── Soft borders ───────────────────────────────────── */
    --border-subtle: oklch(0.945 0.003 260);
    --border-soft: oklch(0.92 0.004 260);

    /* ── Shadow tokens (subtle, layered) ────────────────── */
    --shadow-xs: 0 1px 2px 0 oklch(0.22 0.025 255 / 0.04);
    --shadow-sm: 0 1px 2px 0 oklch(0.22 0.025 255 / 0.04),
                 0 1px 3px 0 oklch(0.22 0.025 255 / 0.06);
    --shadow-md: 0 4px 6px -1px oklch(0.22 0.025 255 / 0.05),
                 0 2px 4px -2px oklch(0.22 0.025 255 / 0.04);
    --shadow-lg: 0 10px 15px -3px oklch(0.22 0.025 255 / 0.06),
                 0 4px 6px -4px oklch(0.22 0.025 255 / 0.04);
    --shadow-xl: 0 20px 25px -5px oklch(0.22 0.025 255 / 0.08),
                 0 8px 10px -6px oklch(0.22 0.025 255 / 0.05);
    --shadow-2xl: 0 25px 50px -12px oklch(0.22 0.025 255 / 0.18);
    --shadow-glow: 0 0 0 1px oklch(0.65 0.178 145 / 0.12),
                   0 8px 24px -4px oklch(0.65 0.178 145 / 0.18);
}

.dark {
    --background: oklch(0.16 0.02 255);
    --foreground: oklch(0.97 0.002 260);

    --card: oklch(0.20 0.02 255);
    --card-foreground: oklch(0.97 0.002 260);

    --popover: oklch(0.20 0.02 255);
    --popover-foreground: oklch(0.97 0.002 260);

    --primary: oklch(0.65 0.178 145);
    --primary-foreground: oklch(1 0 0);

    --secondary: oklch(0.26 0.02 255);
    --secondary-foreground: oklch(0.97 0.002 260);

    --muted: oklch(0.26 0.02 255);
    --muted-foreground: oklch(0.65 0.01 260);

    --accent: oklch(0.26 0.02 255);
    --accent-foreground: oklch(0.97 0.002 260);

    --destructive: oklch(0.704 0.191 22.216);

    --border: oklch(1 0 0 / 10%);
    --input: oklch(1 0 0 / 15%);
    --ring: oklch(0.65 0.178 145);

    --surface-base: oklch(0.18 0.02 255);
    --surface-elevated: oklch(0.22 0.02 255);
    --surface-floating: oklch(0.24 0.02 255);

    --border-subtle: oklch(1 0 0 / 6%);
    --border-soft: oklch(1 0 0 / 10%);

    --sidebar: oklch(0.20 0.02 255);
    --sidebar-foreground: oklch(0.97 0.002 260);
    --sidebar-primary: oklch(0.65 0.178 145);
    --sidebar-primary-foreground: oklch(1 0 0);
    --sidebar-accent: oklch(0.26 0.02 255);
    --sidebar-accent-foreground: oklch(0.97 0.002 260);
    --sidebar-border: oklch(1 0 0 / 10%);
    --sidebar-ring: oklch(0.65 0.178 145);
}

@layer base {
    * {
        @apply border-border outline-ring/50;
    }
    body {
        @apply bg-background text-foreground antialiased;
        font-feature-settings: "cv11", "ss01", "ss03";
        text-rendering: optimizeLegibility;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
    }
    html {
        @apply font-sans scroll-smooth;
        text-size-adjust: 100%;
    }

    /* ── Typography hierarchy ─────────────────────────── */
    h1, h2, h3, h4 {
        letter-spacing: -0.02em;
        font-feature-settings: "ss01", "ss03";
    }
    h1 { letter-spacing: -0.035em; }
    h2 { letter-spacing: -0.028em; }

    ::selection {
        background-color: oklch(0.65 0.178 145 / 0.18);
        color: var(--foreground);
    }
}

/* ── 8px spacing system helper classes ──────────────── */
@layer utilities {
    .stack-1 > * + * { margin-top: 0.5rem; }   /* 8 */
    .stack-2 > * + * { margin-top: 1rem; }     /* 16 */
    .stack-3 > * + * { margin-top: 1.5rem; }   /* 24 */
    .stack-4 > * + * { margin-top: 2rem; }     /* 32 */
    .stack-6 > * + * { margin-top: 3rem; }     /* 48 */
    .stack-8 > * + * { margin-top: 4rem; }     /* 64 */

    .surface-base      { background-color: var(--surface-base); }
    .surface-elevated  { background-color: var(--surface-elevated); }
    .surface-floating  { background-color: var(--surface-floating); }

    .border-subtle { border-color: var(--border-subtle); }
    .border-soft   { border-color: var(--border-soft); }

    .shadow-xs   { box-shadow: var(--shadow-xs); }
    .shadow-soft { box-shadow: var(--shadow-sm); }
    .shadow-card { box-shadow: var(--shadow-md); }
    .shadow-lift { box-shadow: var(--shadow-lg); }
    .shadow-pop  { box-shadow: var(--shadow-xl); }
    .shadow-hero { box-shadow: var(--shadow-2xl); }
    .shadow-glow { box-shadow: var(--shadow-glow); }

    .glass {
        background-color: oklch(1 0 0 / 0.72);
        backdrop-filter: saturate(180%) blur(12px);
        -webkit-backdrop-filter: saturate(180%) blur(12px);
    }
    .glass-strong {
        background-color: oklch(1 0 0 / 0.85);
        backdrop-filter: saturate(180%) blur(20px);
        -webkit-backdrop-filter: saturate(180%) blur(20px);
    }

    .grain {
        position: relative;
    }
    .grain::after {
        content: "";
        position: absolute;
        inset: 0;
        background-image: url("data:image/svg+xml;utf8,<svg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'><filter id='n'><feTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='2' stitchTiles='stitch'/></filter><rect width='100%25' height='100%25' filter='url(%23n)' opacity='0.5'/></svg>");
        opacity: 0.025;
        pointer-events: none;
        mix-blend-mode: multiply;
    }

    .perspective-card {
        perspective: 1200px;
        transform-style: preserve-3d;
    }
}

/* ── Reduced motion respect ─────────────────────────── */
@media (prefers-reduced-motion: reduce) {
    *, *::before, *::after {
        animation-duration: 0.01ms !important;
        animation-iteration-count: 1 !important;
        transition-duration: 0.01ms !important;
        scroll-behavior: auto !important;
    }
}
EOF

# ── 3. lib/motion.js — shared motion variants & easings ─────────────
echo "▸ Writing lib/motion.js…"
cat > lib/motion.js <<'EOF'
// Shared Framer Motion easings & variants.
// Keeps motion identity consistent across the whole site.

export const ease = [0.22, 1, 0.36, 1]      // ease-out-expo — smooth, premium
export const easeSoft = [0.4, 0, 0.2, 1]    // material ease
export const spring = { type: 'spring', stiffness: 120, damping: 18, mass: 0.6 }

export const fadeUp = {
  hidden: { opacity: 0, y: 24 },
  show:   { opacity: 1, y: 0, transition: { duration: 0.6, ease } },
}

export const fadeIn = {
  hidden: { opacity: 0 },
  show:   { opacity: 1, transition: { duration: 0.5, ease } },
}

export const scaleIn = {
  hidden: { opacity: 0, scale: 0.96 },
  show:   { opacity: 1, scale: 1, transition: { duration: 0.5, ease } },
}

export const stagger = (delayChildren = 0.05, staggerChildren = 0.08) => ({
  hidden: {},
  show: {
    transition: { delayChildren, staggerChildren },
  },
})

// Card scroll-in: subtle lift + fade, aligns on entry.
export const cardIn = {
  hidden: { opacity: 0, y: 32, rotateX: -4 },
  show: {
    opacity: 1,
    y: 0,
    rotateX: 0,
    transition: { duration: 0.7, ease },
  },
}

export const viewportOnce = { once: true, amount: 0.2 }
EOF

# ── 4. components/ui/Section.jsx — consistent section primitive ─────
echo "▸ Writing components/ui/Section.jsx…"
cat > components/ui/Section.jsx <<'EOF'
'use client'

import { motion } from 'framer-motion'
import { fadeUp, stagger, viewportOnce } from '@/lib/motion'

/**
 * Section — the single structural primitive for landing sections.
 * Handles: max width, padding, spacing rhythm, scroll reveal.
 */
export function Section({
  id,
  children,
  className = '',
  surface = 'base',       // 'base' | 'elevated' | 'floating' | 'muted'
  bleed = false,          // removes horizontal padding — full-bleed layouts
}) {
  const surfaceCls = {
    base: '',
    elevated: 'bg-secondary/40',
    floating: 'bg-white',
    muted: 'bg-secondary/30',
  }[surface]

  return (
    <section
      id={id}
      className={`relative py-24 md:py-32 ${surfaceCls} ${className}`}
    >
      <div className={bleed ? '' : 'mx-auto w-full max-w-6xl px-6 sm:px-8'}>
        {children}
      </div>
    </section>
  )
}

/**
 * SectionHeader — eyebrow + title + subtitle with consistent rhythm.
 */
export function SectionHeader({ eyebrow, title, subtitle, align = 'center' }) {
  const alignCls =
    align === 'center' ? 'text-center mx-auto' : 'text-left'

  return (
    <motion.div
      variants={stagger(0, 0.1)}
      initial="hidden"
      whileInView="show"
      viewport={viewportOnce}
      className={`max-w-2xl ${alignCls} mb-16 md:mb-20`}
    >
      {eyebrow && (
        <motion.p
          variants={fadeUp}
          className="text-xs font-semibold text-primary uppercase tracking-[0.18em] mb-4"
        >
          {eyebrow}
        </motion.p>
      )}
      <motion.h2
        variants={fadeUp}
        className="text-3xl sm:text-4xl md:text-[2.75rem] font-semibold text-foreground leading-[1.1]"
      >
        {title}
      </motion.h2>
      {subtitle && (
        <motion.p
          variants={fadeUp}
          className="mt-5 text-base sm:text-lg text-muted-foreground leading-relaxed"
        >
          {subtitle}
        </motion.p>
      )}
    </motion.div>
  )
}
EOF

# ── 5. components/ui/MotionCard.jsx — 3D hover + scroll reveal card ──
echo "▸ Writing components/ui/MotionCard.jsx…"
cat > components/ui/MotionCard.jsx <<'EOF'
'use client'

import { useRef } from 'react'
import { motion, useMotionValue, useSpring, useTransform } from 'framer-motion'
import { cardIn, ease, viewportOnce } from '@/lib/motion'

/**
 * MotionCard — reusable card with:
 *  • scroll-in reveal (aligns when in viewport)
 *  • 3D rotateX / rotateY tilt on pointer
 *  • translateY lift on hover
 *
 * Pointer-only effect; disabled on touch for cleaner mobile feel.
 */
export function MotionCard({
  children,
  className = '',
  intensity = 8,       // max tilt in degrees
  lift = 6,            // translateY px on hover
  asChild = false,     // render as inner wrapper only
}) {
  const ref = useRef(null)

  const mx = useMotionValue(0)
  const my = useMotionValue(0)

  const rx = useSpring(useTransform(my, [-0.5, 0.5], [intensity, -intensity]), {
    stiffness: 180, damping: 20, mass: 0.4,
  })
  const ry = useSpring(useTransform(mx, [-0.5, 0.5], [-intensity, intensity]), {
    stiffness: 180, damping: 20, mass: 0.4,
  })

  const onMove = (e) => {
    if (!ref.current) return
    // Ignore on fine-grained touch devices
    if (e.pointerType === 'touch') return
    const r = ref.current.getBoundingClientRect()
    mx.set((e.clientX - r.left) / r.width - 0.5)
    my.set((e.clientY - r.top) / r.height - 0.5)
  }
  const onLeave = () => {
    mx.set(0)
    my.set(0)
  }

  return (
    <motion.div
      ref={ref}
      variants={cardIn}
      initial="hidden"
      whileInView="show"
      viewport={viewportOnce}
      whileHover={{ y: -lift, transition: { duration: 0.35, ease } }}
      onPointerMove={onMove}
      onPointerLeave={onLeave}
      style={{
        rotateX: rx,
        rotateY: ry,
        transformStyle: 'preserve-3d',
        transformPerspective: 1200,
      }}
      className={`relative will-change-transform ${className}`}
    >
      {/* inner translateZ layer — gives genuine 3D separation */}
      <div
        style={{ transform: 'translateZ(30px)', transformStyle: 'preserve-3d' }}
        className="h-full"
      >
        {children}
      </div>
    </motion.div>
  )
}
EOF

# ── 6. Hero.jsx — tighter hero, scroll-aware, polished mockup ───────
echo "▸ Writing components/Hero.jsx…"
cat > components/Hero.jsx <<'EOF'
'use client'

import { useEffect, useState } from 'react'
import { motion } from 'framer-motion'
import { ArrowRight, Clock, FileText, GraduationCap } from 'lucide-react'
import { fadeUp, stagger, ease, viewportOnce } from '@/lib/motion'
import { MotionCard } from './ui/MotionCard'

const rotatingWords = [
  'Lesson Notes',
  'Exam Questions',
  'Schemes of Work',
  'Report Cards',
]

export default function Hero() {
  const [wordIndex, setWordIndex] = useState(0)

  useEffect(() => {
    const interval = setInterval(() => {
      setWordIndex((prev) => (prev + 1) % rotatingWords.length)
    }, 2800)
    return () => clearInterval(interval)
  }, [])

  return (
    <section className="relative min-h-[92vh] flex items-center pt-24 md:pt-28 overflow-hidden">
      {/* Background atmosphere */}
      <div className="absolute inset-0 -z-10 overflow-hidden">
        <div className="absolute top-0 right-0 w-[640px] h-[640px] bg-primary/[0.06] rounded-full blur-3xl -translate-y-1/2 translate-x-1/3" />
        <div className="absolute bottom-0 left-0 w-[440px] h-[440px] bg-primary/[0.05] rounded-full blur-3xl translate-y-1/2 -translate-x-1/3" />
        <div
          className="absolute inset-0 opacity-[0.35]"
          style={{
            backgroundImage:
              'radial-gradient(circle at 1px 1px, oklch(0.22 0.025 255 / 0.06) 1px, transparent 0)',
            backgroundSize: '32px 32px',
            maskImage:
              'radial-gradient(ellipse at center, black 40%, transparent 75%)',
          }}
        />
      </div>

      <div className="mx-auto w-full max-w-6xl px-6 sm:px-8 py-16 md:py-24">
        <div className="grid lg:grid-cols-12 gap-12 lg:gap-16 items-center">
          {/* Left — copy */}
          <motion.div
            variants={stagger(0.1, 0.12)}
            initial="hidden"
            animate="show"
            className="lg:col-span-7"
          >
            <motion.div
              variants={fadeUp}
              className="inline-flex items-center gap-2 rounded-full bg-primary/10 ring-1 ring-primary/15 px-3.5 py-1.5 mb-6"
            >
              <span className="h-1.5 w-1.5 rounded-full bg-primary animate-pulse" />
              <span className="text-[11px] font-semibold text-primary tracking-[0.14em] uppercase">
                Built for Nigerian Schools
              </span>
            </motion.div>

            <motion.h1
              variants={fadeUp}
              className="text-[2.5rem] sm:text-5xl lg:text-[3.75rem] font-semibold leading-[1.05] tracking-[-0.035em] text-foreground"
            >
              Generate{' '}
              <span className="relative inline-block align-baseline">
                <motion.span
                  key={wordIndex}
                  initial={{ y: 18, opacity: 0 }}
                  animate={{ y: 0, opacity: 1 }}
                  exit={{ y: -18, opacity: 0 }}
                  transition={{ duration: 0.5, ease }}
                  className="text-primary"
                >
                  {rotatingWords[wordIndex]}
                </motion.span>
              </span>{' '}
              in seconds, not hours.
            </motion.h1>

            <motion.p
              variants={fadeUp}
              className="mt-6 text-lg text-muted-foreground leading-relaxed max-w-xl"
            >
              KlassRun saves your teachers 10–15 hours every week by
              auto-generating curriculum-aligned content — NERDC topics,
              WAEC/NECO standards, school-branded PDFs. All on autopilot.
            </motion.p>

            <motion.div
              variants={fadeUp}
              className="mt-10 flex flex-col sm:flex-row gap-3"
            >
              <a
                href="https://app.klassrun.com/signup"
                className="group inline-flex items-center justify-center gap-2 rounded-xl bg-primary px-6 py-3.5 text-sm font-semibold text-primary-foreground shadow-[var(--shadow-glow)] hover:bg-klassrun-green-dark transition-all duration-300 ease-out hover:-translate-y-0.5"
              >
                Start Free Trial
                <ArrowRight size={16} className="transition-transform duration-300 group-hover:translate-x-0.5" />
              </a>
              <a
                href="#how-it-works"
                className="inline-flex items-center justify-center gap-2 rounded-xl border border-soft bg-white px-6 py-3.5 text-sm font-semibold text-foreground hover:bg-secondary transition-colors duration-300 ease-out"
              >
                See how it works
              </a>
            </motion.div>

            {/* Outcome metrics */}
            <motion.div
              variants={fadeUp}
              className="mt-12 grid grid-cols-3 gap-8 pt-8 border-t border-subtle"
            >
              {[
                { icon: Clock, metric: '4×', label: 'Faster lesson prep' },
                { icon: FileText, metric: '50%', label: 'Less admin work' },
                { icon: GraduationCap, metric: '100%', label: 'NERDC aligned' },
              ].map(({ icon: Icon, metric, label }) => (
                <div key={label}>
                  <div className="flex items-center gap-2 text-primary">
                    <Icon size={16} />
                    <span className="text-2xl font-semibold text-foreground tracking-tight">
                      {metric}
                    </span>
                  </div>
                  <p className="text-sm text-muted-foreground mt-1.5 leading-snug">
                    {label}
                  </p>
                </div>
              ))}
            </motion.div>
          </motion.div>

          {/* Right — product mockup */}
          <motion.div
            initial={{ opacity: 0, y: 40 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.9, ease, delay: 0.2 }}
            className="lg:col-span-5 relative"
          >
            <MotionCard
              intensity={6}
              lift={2}
              className="rounded-2xl bg-surface-elevated border border-soft p-2 shadow-hero"
            >
              {/* Browser chrome */}
              <div className="flex items-center gap-2 px-4 py-3 border-b border-subtle">
                <div className="flex gap-1.5">
                  <div className="w-2.5 h-2.5 rounded-full bg-red-400/80" />
                  <div className="w-2.5 h-2.5 rounded-full bg-yellow-400/80" />
                  <div className="w-2.5 h-2.5 rounded-full bg-green-400/80" />
                </div>
                <div className="flex-1 mx-4">
                  <div className="bg-secondary rounded-md px-3 py-1.5 text-[11px] text-muted-foreground text-center font-medium">
                    app.klassrun.com
                  </div>
                </div>
              </div>

              {/* Mockup body */}
              <div className="p-6 space-y-4">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-[11px] text-muted-foreground">Welcome back,</p>
                    <p className="text-sm font-semibold text-foreground tracking-tight">
                      Mrs. Adeyemi
                    </p>
                  </div>
                  <div className="text-[11px] bg-primary/10 text-primary px-3 py-1 rounded-full font-medium">
                    2025/2026 · Term 2
                  </div>
                </div>

                <div className="grid grid-cols-2 gap-3">
                  <div className="rounded-xl bg-primary/10 ring-1 ring-primary/15 p-4 cursor-pointer hover:bg-primary/15 transition-colors duration-300">
                    <FileText size={18} className="text-primary mb-2" />
                    <p className="text-sm font-semibold text-foreground tracking-tight">
                      Generate Lesson Note
                    </p>
                    <p className="text-[11px] text-muted-foreground mt-1">
                      JSS 2 · Mathematics
                    </p>
                  </div>
                  <div className="rounded-xl bg-secondary border border-subtle p-4 cursor-pointer hover:bg-secondary/70 transition-colors duration-300">
                    <GraduationCap size={18} className="text-foreground/60 mb-2" />
                    <p className="text-sm font-semibold text-foreground tracking-tight">
                      Create Exam Paper
                    </p>
                    <p className="text-[11px] text-muted-foreground mt-1">
                      SS 1 · English Language
                    </p>
                  </div>
                </div>

                <div className="space-y-2">
                  <p className="text-[10px] font-semibold text-muted-foreground uppercase tracking-[0.14em]">
                    Recent
                  </p>
                  {[
                    { subject: 'Basic Science', class: 'JSS 1', type: 'Lesson Note', time: '2 mins ago' },
                    { subject: 'Mathematics', class: 'SS 2', type: 'Exam Questions', time: '1 hour ago' },
                    { subject: 'Civic Education', class: 'JSS 3', type: 'Scheme of Work', time: '3 hours ago' },
                  ].map((item, i) => (
                    <motion.div
                      key={i}
                      initial={{ opacity: 0, x: -8 }}
                      animate={{ opacity: 1, x: 0 }}
                      transition={{ delay: 0.6 + i * 0.08, duration: 0.4, ease }}
                      className="flex items-center justify-between rounded-lg bg-white border border-subtle px-4 py-3"
                    >
                      <div>
                        <p className="text-sm font-medium text-foreground tracking-tight">
                          {item.subject}{' '}
                          <span className="text-muted-foreground font-normal">
                            · {item.class}
                          </span>
                        </p>
                        <p className="text-[11px] text-muted-foreground">{item.type}</p>
                      </div>
                      <span className="text-[11px] text-muted-foreground">{item.time}</span>
                    </motion.div>
                  ))}
                </div>
              </div>
            </MotionCard>

            {/* Floating badge */}
            <motion.div
              initial={{ opacity: 0, x: -16, y: 16 }}
              animate={{ opacity: 1, x: 0, y: 0 }}
              transition={{ delay: 0.8, duration: 0.6, ease }}
              className="absolute -bottom-5 -left-5 bg-white rounded-xl border border-soft shadow-lift px-4 py-3 flex items-center gap-3"
            >
              <div className="h-10 w-10 rounded-full bg-primary/10 flex items-center justify-center">
                <Clock size={18} className="text-primary" />
              </div>
              <div>
                <p className="text-sm font-semibold text-foreground tracking-tight">
                  3 hours saved
                </p>
                <p className="text-[11px] text-muted-foreground">This afternoon</p>
              </div>
            </motion.div>
          </motion.div>
        </div>
      </div>
    </section>
  )
}
EOF

# ── 7. About.jsx — pain points with MotionCard ──────────────────────
echo "▸ Writing components/About.jsx…"
cat > components/About.jsx <<'EOF'
'use client'

import { Clock, AlertTriangle, EyeOff } from 'lucide-react'
import { Section, SectionHeader } from './ui/Section'
import { MotionCard } from './ui/MotionCard'
import { motion } from 'framer-motion'
import { stagger, viewportOnce } from '@/lib/motion'

const painPoints = [
  {
    icon: Clock,
    title: 'Wasted Teacher Hours',
    description:
      "Teachers spend 10–15 hours every week writing lesson notes and preparing exams by hand. That's time stolen from actual teaching.",
  },
  {
    icon: AlertTriangle,
    title: 'Recycled Exam Questions',
    description:
      'Students share old answers every year. Recycled questions mean your assessments are compromised before they even begin.',
  },
  {
    icon: EyeOff,
    title: 'Zero Visibility',
    description:
      'School owners have no way to see what teachers are producing, when, or whether it meets curriculum standards.',
  },
]

export default function About() {
  return (
    <Section id="about">
      <SectionHeader
        eyebrow="Why KlassRun"
        title="Your school deserves better than manual processes"
        subtitle="KlassRun eliminates the repetitive admin work that burns teachers out, so they can focus on what actually matters — teaching."
      />

      <motion.div
        variants={stagger(0.05, 0.1)}
        initial="hidden"
        whileInView="show"
        viewport={viewportOnce}
        className="grid md:grid-cols-3 gap-6 md:gap-8 perspective-card"
      >
        {painPoints.map((point) => (
          <MotionCard
            key={point.title}
            intensity={5}
            lift={8}
            className="rounded-2xl border border-soft bg-white px-6 py-8 md:px-8 md:py-10 text-center shadow-xs hover:shadow-card transition-shadow duration-500"
          >
            <div className="h-12 w-12 rounded-xl bg-destructive/10 ring-1 ring-destructive/10 flex items-center justify-center mx-auto mb-6">
              <point.icon size={22} className="text-destructive" />
            </div>
            <h3 className="text-base font-semibold text-foreground mb-3 tracking-tight">
              {point.title}
            </h3>
            <p className="text-sm text-muted-foreground leading-relaxed">
              {point.description}
            </p>
          </MotionCard>
        ))}
      </motion.div>
    </Section>
  )
}
EOF

# ── 8. Product.jsx ──────────────────────────────────────────────────
echo "▸ Writing components/Product.jsx…"
cat > components/Product.jsx <<'EOF'
'use client'

import {
  FileText,
  ClipboardCheck,
  Award,
  Download,
  Wifi,
  BarChart3,
} from 'lucide-react'
import { motion } from 'framer-motion'
import { Section, SectionHeader } from './ui/Section'
import { MotionCard } from './ui/MotionCard'
import { stagger, viewportOnce } from '@/lib/motion'

const outcomes = [
  {
    icon: FileText,
    title: 'Lesson Notes on Autopilot',
    description:
      'Complete, curriculum-aligned notes generated in under 60 seconds. Teachers pick subject, class, and topic — KlassRun handles the rest.',
  },
  {
    icon: ClipboardCheck,
    title: 'Fresh Exams Every Term',
    description:
      'AI tracks every question generated for your school and never duplicates. Students can\'t recycle answers. Assessments stay credible.',
  },
  {
    icon: Award,
    title: 'WAEC/NECO Ready',
    description:
      'Every exam automatically includes questions matching national examination standards. Students walk in prepared, not surprised.',
  },
  {
    icon: Download,
    title: 'School-Branded PDFs',
    description:
      'Print-ready documents with your school name, logo, and session stamp. Submit to inspectors with confidence.',
  },
  {
    icon: BarChart3,
    title: "Know What's Happening",
    description:
      'See how many notes were generated, which teachers are active, and how many hours your school saved this term. ROI you can measure.',
  },
  {
    icon: Wifi,
    title: 'Works Without Internet',
    description:
      'Teachers in low-connectivity areas can still view, edit, and print notes offline. Everything syncs when connection returns.',
  },
]

export default function Product() {
  return (
    <Section id="product" surface="muted">
      <SectionHeader
        eyebrow="What You Get"
        title="Everything your teachers need. Nothing they don't."
        subtitle="KlassRun automates the work your teachers do every week — so they spend less time writing and more time teaching."
      />

      <motion.div
        variants={stagger(0.04, 0.08)}
        initial="hidden"
        whileInView="show"
        viewport={viewportOnce}
        className="grid sm:grid-cols-2 lg:grid-cols-3 gap-5 md:gap-6 perspective-card"
      >
        {outcomes.map((item) => (
          <MotionCard
            key={item.title}
            intensity={6}
            lift={6}
            className="group rounded-2xl border border-soft bg-white p-7 shadow-xs hover:shadow-card hover:border-primary/20 transition-all duration-500"
          >
            <div className="h-11 w-11 rounded-xl bg-primary/10 ring-1 ring-primary/10 flex items-center justify-center mb-6 group-hover:bg-primary/15 group-hover:ring-primary/20 transition-all duration-500">
              <item.icon size={20} className="text-primary" />
            </div>
            <h3 className="text-[15px] font-semibold text-foreground mb-2.5 tracking-tight">
              {item.title}
            </h3>
            <p className="text-sm text-muted-foreground leading-relaxed">
              {item.description}
            </p>
          </MotionCard>
        ))}
      </motion.div>
    </Section>
  )
}
EOF

# ── 9. HowItWorks.jsx ───────────────────────────────────────────────
echo "▸ Writing components/HowItWorks.jsx…"
cat > components/HowItWorks.jsx <<'EOF'
'use client'

import { UserPlus, BookOpen, Sparkles, Download } from 'lucide-react'
import { motion } from 'framer-motion'
import { Section, SectionHeader } from './ui/Section'
import { stagger, fadeUp, viewportOnce } from '@/lib/motion'

const steps = [
  {
    step: '01',
    icon: UserPlus,
    title: 'School Signs Up',
    description:
      'The admin creates an account, sets up classes, and invites teachers. Takes under 10 minutes.',
  },
  {
    step: '02',
    icon: BookOpen,
    title: 'Teacher Selects Topic',
    description:
      'Teacher picks subject, class, and NERDC topic for the week. The curriculum is already loaded.',
  },
  {
    step: '03',
    icon: Sparkles,
    title: 'AI Generates Content',
    description:
      'KlassRun produces a complete lesson note, exam, or scheme of work — curriculum-aligned, WAEC-standard.',
  },
  {
    step: '04',
    icon: Download,
    title: 'Download & Teach',
    description:
      'Download school-branded PDFs ready for submission. Edit if needed — the content is yours.',
  },
]

export default function HowItWorks() {
  return (
    <Section id="how-it-works">
      <SectionHeader
        eyebrow="How It Works"
        title="From signup to lesson note in 4 steps"
        subtitle="No training needed. No complicated setup. Your teachers can start generating content on their first day."
      />

      <motion.div
        variants={stagger(0.05, 0.12)}
        initial="hidden"
        whileInView="show"
        viewport={viewportOnce}
        className="grid md:grid-cols-4 gap-10 md:gap-6"
      >
        {steps.map((item, i) => (
          <motion.div key={item.step} variants={fadeUp} className="relative">
            {/* Dotted connector */}
            {i < steps.length - 1 && (
              <div
                className="hidden md:block absolute top-10 left-[calc(50%+40px)] w-[calc(100%-80px)] h-px"
                style={{
                  backgroundImage:
                    'linear-gradient(to right, oklch(0.92 0.004 260) 50%, transparent 50%)',
                  backgroundSize: '8px 1px',
                }}
              />
            )}

            <div className="text-center">
              <div className="relative inline-flex">
                <div className="h-20 w-20 rounded-2xl bg-primary/8 ring-1 ring-primary/10 flex items-center justify-center mx-auto shadow-xs">
                  <item.icon size={30} className="text-primary" />
                </div>
                <span className="absolute -top-2 -right-2 h-6 w-6 rounded-full bg-primary text-primary-foreground text-[10px] font-semibold flex items-center justify-center ring-4 ring-background">
                  {item.step}
                </span>
              </div>

              <h3 className="mt-6 text-[15px] font-semibold text-foreground tracking-tight">
                {item.title}
              </h3>
              <p className="mt-2 text-sm text-muted-foreground leading-relaxed max-w-[240px] mx-auto">
                {item.description}
              </p>
            </div>
          </motion.div>
        ))}
      </motion.div>
    </Section>
  )
}
EOF

# ── 10. Pricing.jsx ─────────────────────────────────────────────────
echo "▸ Writing components/Pricing.jsx…"
cat > components/Pricing.jsx <<'EOF'
'use client'

import { Check } from 'lucide-react'
import { motion } from 'framer-motion'
import { Section, SectionHeader } from './ui/Section'
import { MotionCard } from './ui/MotionCard'
import { stagger, viewportOnce } from '@/lib/motion'

const plans = [
  {
    name: 'Starter',
    price: '30,000',
    period: '/term',
    description: 'For schools under 200 students getting started with AI.',
    features: [
      'AI Lesson Note Generator',
      'Exam Question Generator',
      'Session Stamping',
      'PDF Export (school-branded)',
      'Offline Access (PWA)',
      'Up to 10 teachers',
    ],
    cta: 'Start Free Trial',
    highlighted: false,
  },
  {
    name: 'Standard',
    price: '60,000',
    period: '/term',
    description: 'For growing schools that want data-driven operations.',
    features: [
      'Everything in Starter',
      'School Question Bank',
      'Student Performance Tracking',
      'Report Card Comments (AI)',
      'Usage Analytics Dashboard',
      'Scheme of Work Generator',
      'Up to 30 teachers',
    ],
    cta: 'Start Free Trial',
    highlighted: true,
    badge: 'Most Popular',
  },
  {
    name: 'Premium',
    price: '100,000',
    period: '/term',
    description: 'The full School OS for serious institutions.',
    features: [
      'Everything in Standard',
      'Parent Portal',
      'Attendance Tracking',
      'Grading & Report Cards',
      'Curriculum Update Alerts',
      'Priority Support',
      'Unlimited teachers',
    ],
    cta: 'Contact Sales',
    highlighted: false,
  },
]

export default function Pricing() {
  return (
    <Section id="pricing" surface="muted">
      <SectionHeader
        eyebrow="Pricing"
        title="Simple, termly pricing"
        subtitle="Pay per term — the way Nigerian schools budget. No hidden fees, no per-teacher charges. Save 10% with annual billing."
      />

      <motion.div
        variants={stagger(0.05, 0.1)}
        initial="hidden"
        whileInView="show"
        viewport={viewportOnce}
        className="grid md:grid-cols-3 gap-6 md:gap-8 max-w-5xl mx-auto perspective-card"
      >
        {plans.map((plan) => (
          <MotionCard
            key={plan.name}
            intensity={plan.highlighted ? 4 : 6}
            lift={plan.highlighted ? 4 : 8}
            className={`relative rounded-2xl p-8 ${
              plan.highlighted
                ? 'bg-foreground text-white ring-1 ring-foreground shadow-hero md:scale-[1.03]'
                : 'bg-white border border-soft shadow-xs hover:shadow-card transition-shadow duration-500'
            }`}
          >
            {plan.badge && (
              <div className="absolute -top-3 left-1/2 -translate-x-1/2">
                <span className="inline-block rounded-full bg-primary px-3.5 py-1 text-[11px] font-semibold text-primary-foreground tracking-wide shadow-soft">
                  {plan.badge}
                </span>
              </div>
            )}

            <div className="mb-6">
              <h3
                className={`text-base font-semibold tracking-tight ${
                  plan.highlighted ? 'text-white' : 'text-foreground'
                }`}
              >
                {plan.name}
              </h3>
              <p
                className={`mt-1.5 text-sm leading-relaxed ${
                  plan.highlighted ? 'text-white/65' : 'text-muted-foreground'
                }`}
              >
                {plan.description}
              </p>
            </div>

            <div className="mb-8 flex items-baseline gap-1">
              <span
                className={`text-4xl font-semibold tracking-[-0.03em] ${
                  plan.highlighted ? 'text-white' : 'text-foreground'
                }`}
              >
                ₦{plan.price}
              </span>
              <span
                className={`text-sm ${
                  plan.highlighted ? 'text-white/55' : 'text-muted-foreground'
                }`}
              >
                {plan.period}
              </span>
            </div>

            <ul className="space-y-3 mb-8">
              {plan.features.map((feature) => (
                <li key={feature} className="flex items-start gap-3">
                  <span
                    className={`mt-0.5 flex-shrink-0 h-4 w-4 rounded-full flex items-center justify-center ${
                      plan.highlighted
                        ? 'bg-primary/20'
                        : 'bg-primary/10'
                    }`}
                  >
                    <Check size={10} className="text-primary" strokeWidth={3} />
                  </span>
                  <span
                    className={`text-sm leading-relaxed ${
                      plan.highlighted ? 'text-white/80' : 'text-muted-foreground'
                    }`}
                  >
                    {feature}
                  </span>
                </li>
              ))}
            </ul>

            <a
              href="#contact"
              className={`block w-full text-center rounded-xl px-6 py-3 text-sm font-semibold transition-all duration-300 ease-out hover:-translate-y-0.5 ${
                plan.highlighted
                  ? 'bg-primary text-primary-foreground hover:bg-klassrun-green-dark shadow-[var(--shadow-glow)]'
                  : 'bg-foreground text-white hover:bg-klassrun-navy-light'
              }`}
            >
              {plan.cta}
            </a>
          </MotionCard>
        ))}
      </motion.div>

      <div className="mt-16 text-center">
        <p className="text-sm text-muted-foreground">
          Running 3+ schools?{' '}
          <a href="#contact" className="text-primary font-semibold hover:underline underline-offset-4">
            Contact us for Enterprise pricing
          </a>{' '}
          — custom branding, multi-school management, dedicated support.
        </p>
      </div>
    </Section>
  )
}
EOF

# ── 11. CTA.jsx ─────────────────────────────────────────────────────
echo "▸ Writing components/CTA.jsx…"
cat > components/CTA.jsx <<'EOF'
'use client'

import { ArrowRight } from 'lucide-react'
import { motion } from 'framer-motion'
import { fadeUp, stagger, ease, viewportOnce } from '@/lib/motion'

export default function CTA() {
  return (
    <section id="contact" className="py-24 md:py-32">
      <div className="mx-auto w-full max-w-6xl px-6 sm:px-8">
        <motion.div
          initial={{ opacity: 0, y: 40 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={viewportOnce}
          transition={{ duration: 0.8, ease }}
          className="relative rounded-3xl bg-foreground overflow-hidden shadow-hero"
        >
          {/* Atmosphere */}
          <div className="absolute inset-0">
            <div className="absolute top-0 right-0 w-[420px] h-[420px] bg-primary/20 rounded-full blur-3xl -translate-y-1/2 translate-x-1/3" />
            <div className="absolute bottom-0 left-0 w-[320px] h-[320px] bg-primary/10 rounded-full blur-3xl translate-y-1/2 -translate-x-1/3" />
            <div
              className="absolute inset-0 opacity-30"
              style={{
                backgroundImage:
                  'radial-gradient(circle at 1px 1px, oklch(1 0 0 / 0.04) 1px, transparent 0)',
                backgroundSize: '28px 28px',
              }}
            />
          </div>

          <motion.div
            variants={stagger(0.1, 0.1)}
            initial="hidden"
            whileInView="show"
            viewport={viewportOnce}
            className="relative px-6 py-16 sm:px-12 md:px-16 md:py-24 text-center"
          >
            <motion.h2
              variants={fadeUp}
              className="text-3xl sm:text-4xl lg:text-[3.25rem] font-semibold text-white tracking-[-0.035em] max-w-3xl mx-auto leading-[1.08]"
            >
              Stop writing.{' '}
              <span className="text-primary">Start teaching.</span>
            </motion.h2>
            <motion.p
              variants={fadeUp}
              className="mt-6 text-base md:text-lg text-white/65 max-w-xl mx-auto leading-relaxed"
            >
              Your teachers deserve better than spending every evening writing
              lesson notes. KlassRun gives them their time back — starting today.
            </motion.p>

            <motion.div
              variants={fadeUp}
              className="mt-10 flex flex-col sm:flex-row items-center justify-center gap-3"
            >
              <a
                href="https://app.klassrun.com/signup"
                className="group inline-flex items-center justify-center gap-2 rounded-xl bg-primary px-7 py-3.5 text-sm font-semibold text-primary-foreground shadow-[var(--shadow-glow)] hover:bg-klassrun-green-dark transition-all duration-300 ease-out hover:-translate-y-0.5"
              >
                Start Free Trial
                <ArrowRight size={16} className="transition-transform duration-300 group-hover:translate-x-0.5" />
              </a>
              <a
                href="mailto:info@klassrun.com"
                className="inline-flex items-center justify-center gap-2 rounded-xl border border-white/15 bg-white/[0.03] px-7 py-3.5 text-sm font-semibold text-white hover:bg-white/10 transition-colors duration-300 ease-out"
              >
                Talk to us
              </a>
            </motion.div>

            <motion.p
              variants={fadeUp}
              className="mt-8 text-xs text-white/45"
            >
              No credit card required · First term free for pilot schools · Cancel anytime
            </motion.p>
          </motion.div>
        </motion.div>
      </div>
    </section>
  )
}
EOF

# ── 12. Navbar.jsx ──────────────────────────────────────────────────
echo "▸ Writing components/Navbar.jsx…"
cat > components/Navbar.jsx <<'EOF'
'use client'

import { useEffect, useState } from 'react'
import Image from 'next/image'
import Link from 'next/link'
import { Menu, X } from 'lucide-react'
import { motion, AnimatePresence } from 'framer-motion'
import { ease } from '@/lib/motion'

const navLinks = [
  { label: 'About', href: '#about' },
  { label: 'Product', href: '#product' },
  { label: 'How It Works', href: '#how-it-works' },
  { label: 'Pricing', href: '#pricing' },
]

export default function Navbar() {
  const [mobileOpen, setMobileOpen] = useState(false)
  const [scrolled, setScrolled] = useState(false)

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 12)
    onScroll()
    window.addEventListener('scroll', onScroll, { passive: true })
    return () => window.removeEventListener('scroll', onScroll)
  }, [])

  return (
    <motion.nav
      initial={{ y: -20, opacity: 0 }}
      animate={{ y: 0, opacity: 1 }}
      transition={{ duration: 0.5, ease }}
      className={`fixed top-0 left-0 right-0 z-50 transition-all duration-300 ease-out ${
        scrolled
          ? 'glass-strong border-b border-subtle shadow-xs'
          : 'bg-white/60 backdrop-blur-sm'
      }`}
    >
      <div className="mx-auto w-full max-w-6xl px-6 sm:px-8">
        <div className="flex h-16 md:h-18 items-center justify-between">
          <Link href="/" className="flex items-center gap-2 shrink-0">
            <Image
              src="/images/logo-nav.webp"
              alt="Klassrun"
              width={100}
              height={34}
              className="h-8 md:h-9 w-auto object-contain"
              priority
              unoptimized
            />
          </Link>

          <div className="hidden md:flex items-center gap-9">
            {navLinks.map((link) => (
              <a
                key={link.href}
                href={link.href}
                className="text-sm font-medium text-foreground/70 hover:text-primary transition-colors duration-300"
              >
                {link.label}
              </a>
            ))}
          </div>

          <div className="hidden md:flex items-center gap-4">
            <a
              href="#contact"
              className="text-sm font-medium text-foreground/70 hover:text-primary transition-colors duration-300"
            >
              Contact
            </a>
            <a
              href="https://app.klassrun.com/signup"
              className="inline-flex items-center justify-center rounded-lg bg-primary px-4 py-2 text-sm font-semibold text-primary-foreground shadow-soft hover:bg-klassrun-green-dark hover:-translate-y-0.5 transition-all duration-300 ease-out"
            >
              Get Started
            </a>
          </div>

          <button
            onClick={() => setMobileOpen(!mobileOpen)}
            className="md:hidden p-2 -mr-2 text-foreground"
            aria-label="Toggle menu"
          >
            {mobileOpen ? <X size={22} /> : <Menu size={22} />}
          </button>
        </div>
      </div>

      <AnimatePresence>
        {mobileOpen && (
          <motion.div
            initial={{ opacity: 0, height: 0 }}
            animate={{ opacity: 1, height: 'auto' }}
            exit={{ opacity: 0, height: 0 }}
            transition={{ duration: 0.3, ease }}
            className="md:hidden bg-white border-t border-subtle overflow-hidden"
          >
            <div className="px-6 py-5 space-y-1">
              {navLinks.map((link) => (
                <a
                  key={link.href}
                  href={link.href}
                  onClick={() => setMobileOpen(false)}
                  className="block text-base font-medium text-foreground/75 hover:text-primary py-3"
                >
                  {link.label}
                </a>
              ))}
              <a
                href="#contact"
                onClick={() => setMobileOpen(false)}
                className="block text-base font-medium text-foreground/75 hover:text-primary py-3"
              >
                Contact
              </a>
              <a
                href="https://app.klassrun.com/signup"
                onClick={() => setMobileOpen(false)}
                className="block w-full text-center rounded-xl bg-primary px-5 py-3.5 text-sm font-semibold text-primary-foreground mt-3 shadow-soft"
              >
                Get Started
              </a>
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </motion.nav>
  )
}
EOF

# ── 13. CredStrip.jsx ───────────────────────────────────────────────
echo "▸ Writing components/CredStrip.jsx…"
cat > components/CredStrip.jsx <<'EOF'
'use client'

import { BookOpen, Award, Laptop } from 'lucide-react'
import { motion } from 'framer-motion'
import { stagger, fadeUp, viewportOnce } from '@/lib/motion'

const credentials = [
  { icon: BookOpen, label: 'NERDC Aligned', detail: 'Full Curriculum' },
  { icon: Award,    label: 'WAEC / NECO',   detail: 'Exam Standards' },
  { icon: Laptop,   label: 'Works Offline', detail: 'PWA Enabled'    },
]

export default function CredStrip() {
  return (
    <section className="border-y border-subtle bg-secondary/40">
      <div className="mx-auto w-full max-w-6xl px-6 sm:px-8 py-8">
        <motion.div
          variants={stagger(0, 0.1)}
          initial="hidden"
          whileInView="show"
          viewport={viewportOnce}
          className="grid grid-cols-1 sm:grid-cols-3 gap-8 place-items-center"
        >
          {credentials.map((cred) => (
            <motion.div
              key={cred.label}
              variants={fadeUp}
              className="flex items-center gap-3 text-center sm:text-left"
            >
              <div className="h-10 w-10 rounded-lg bg-primary/10 ring-1 ring-primary/10 flex items-center justify-center shrink-0">
                <cred.icon size={18} className="text-primary" />
              </div>
              <div>
                <p className="text-sm font-semibold text-foreground tracking-tight leading-tight">
                  {cred.label}
                </p>
                <p className="text-[11px] text-muted-foreground leading-tight mt-0.5">
                  {cred.detail}
                </p>
              </div>
            </motion.div>
          ))}
        </motion.div>
      </div>
    </section>
  )
}
EOF

# ── 14. Footer.jsx ──────────────────────────────────────────────────
echo "▸ Writing components/Footer.jsx…"
cat > components/Footer.jsx <<'EOF'
import Image from 'next/image'
import { Mail, MapPin } from 'lucide-react'

function InstagramIcon({ size = 14 }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <rect width="20" height="20" x="2" y="2" rx="5" ry="5" />
      <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z" />
      <line x1="17.5" x2="17.51" y1="6.5" y2="6.5" />
    </svg>
  )
}

function LinkedInIcon({ size = 14 }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z" />
      <rect width="4" height="12" x="2" y="9" />
      <circle cx="4" cy="4" r="2" />
    </svg>
  )
}

export default function Footer() {
  const EMAIL_ADDRESS = 'info@klassrun.com'

  return (
    <footer className="border-t border-subtle bg-foreground">
      <div className="mx-auto w-full max-w-6xl px-6 sm:px-8 py-16 md:py-20">
        <div className="grid md:grid-cols-12 gap-10 md:gap-12">
          <div className="md:col-span-6">
            <Image
              src="/images/logo-nav.webp"
              alt="Klassrun"
              width={120}
              height={36}
              className="h-9 w-auto brightness-0 invert"
              unoptimized
            />
            <p className="mt-5 text-sm text-white/60 leading-relaxed max-w-sm">
              AI-powered lesson notes, exam questions, and school management —
              built exclusively for Nigerian schools. Save your teachers 10+
              hours every week.
            </p>
            <p className="mt-5 text-xs text-white/40 tracking-wide">
              Klassrun Technologies Ltd · RC 9463863 · Lagos, Nigeria
            </p>

            <div className="mt-6 flex items-center gap-5">
              <a
                href="https://www.instagram.com/klassrun/"
                target="_blank"
                rel="noopener noreferrer"
                className="text-white/45 hover:text-primary transition-colors duration-300"
                aria-label="Instagram"
              >
                <InstagramIcon size={18} />
              </a>
              <a
                href="https://www.linkedin.com/in/klassrun-ng-33013b400/"
                target="_blank"
                rel="noopener noreferrer"
                className="text-white/45 hover:text-primary transition-colors duration-300"
                aria-label="LinkedIn"
              >
                <LinkedInIcon size={18} />
              </a>
            </div>
          </div>

          <div className="md:col-span-3">
            <h4 className="text-sm font-semibold text-white mb-5 tracking-tight">
              Product
            </h4>
            <ul className="space-y-3">
              {[
                { label: 'Lesson Notes', href: '#product' },
                { label: 'Exam Questions', href: '#product' },
                { label: 'Pricing', href: '#pricing' },
                { label: 'How It Works', href: '#how-it-works' },
              ].map((link) => (
                <li key={link.label}>
                  <a
                    href={link.href}
                    className="text-sm text-white/60 hover:text-primary transition-colors duration-300"
                  >
                    {link.label}
                  </a>
                </li>
              ))}
            </ul>
          </div>

          <div className="md:col-span-3">
            <h4 className="text-sm font-semibold text-white mb-5 tracking-tight">
              Contact
            </h4>
            <ul className="space-y-3">
              <li>
                <a
                  href={`mailto:${EMAIL_ADDRESS}`}
                  className="flex items-center gap-2 text-sm text-white/60 hover:text-primary transition-colors duration-300"
                >
                  <Mail size={14} />
                  {EMAIL_ADDRESS}
                </a>
              </li>
              <li>
                <span className="flex items-center gap-2 text-sm text-white/60">
                  <MapPin size={14} />
                  Lagos, Nigeria
                </span>
              </li>
            </ul>
          </div>
        </div>

        <div className="mt-14 pt-8 border-t border-white/10 flex flex-col sm:flex-row items-center justify-between gap-4">
          <p className="text-xs text-white/40">
            © {new Date().getFullYear()} Klassrun Technologies Ltd. All rights reserved.
          </p>
          <div className="flex gap-6">
            <a href="#" className="text-xs text-white/40 hover:text-white/70 transition-colors duration-300">
              Privacy Policy
            </a>
            <a href="#" className="text-xs text-white/40 hover:text-white/70 transition-colors duration-300">
              Terms of Service
            </a>
          </div>
        </div>
      </div>
    </footer>
  )
}
EOF

# ── 15. page.jsx — unchanged wiring, just ensure order ──────────────
echo "▸ Writing app/page.jsx…"
cat > app/page.jsx <<'EOF'
import Navbar from '@/components/Navbar'
import Hero from '@/components/Hero'
import CredStrip from '@/components/CredStrip'
import About from '@/components/About'
import Product from '@/components/Product'
import HowItWorks from '@/components/HowItWorks'
import Pricing from '@/components/Pricing'
import CTA from '@/components/CTA'
import Footer from '@/components/Footer'

export default function Home() {
  return (
    <main className="relative overflow-x-hidden">
      <Navbar />
      <Hero />
      <CredStrip />
      <About />
      <Product />
      <HowItWorks />
      <Pricing />
      <CTA />
      <Footer />
    </main>
  )
}
EOF

# ── done ────────────────────────────────────────────────────────────
echo ""
echo "✓ Refactor complete."
echo ""
echo "  Added:"
echo "    • framer-motion dependency"
echo "    • lib/motion.js              — shared easings & variants"
echo "    • components/ui/Section.jsx  — section + header primitives"
echo "    • components/ui/MotionCard.jsx — 3D hover + scroll reveal card"
echo ""
echo "  Rewrote:"
echo "    • app/globals.css            — 8px scale, surfaces, shadows, typography"
echo "    • app/page.jsx"
echo "    • components/Navbar.jsx, Hero.jsx, CredStrip.jsx,"
echo "      About.jsx, Product.jsx, HowItWorks.jsx,"
echo "      Pricing.jsx, CTA.jsx, Footer.jsx"
echo ""
echo "  Palette: unchanged."
echo "  Max width: max-w-6xl across every section."
echo ""
echo "▸ Next: npm run dev"
