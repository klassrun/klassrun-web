#!/usr/bin/env bash
# ============================================================================
# KLASSRUN-WEB REDESIGN INSTALLER — Afrilearn-style landing page rebuild
# Run from Git Bash:  bash install-klassrun-web-redesign.sh
#
# What it does (all-or-nothing):
#   1. Pre-checks: repo exists, git clean, every target file accounted for
#   2. Backs up every modified/deleted file OUTSIDE the repo
#   3. npm uninstall framer-motion, npm install @fontsource/nunito
#   4. Writes 11 rewritten files + 6 new files, deletes 6 retired files
#   5. Build gate: npm run build — on FAILURE it auto-restores everything
#   6. git add + commit + push  (Cloudflare deploys from main)
# ============================================================================
set -euo pipefail

REPO="$HOME/Desktop/klassrun-web"
TS="$(date +%Y%m%d-%H%M%S)"
BACKUP="$HOME/Desktop/.klassrun-web-backup-$TS"

say() { printf '\n\033[1;32m== %s ==\033[0m\n' "$*"; }
die() { printf '\n\033[1;31mXX ABORT: %s\033[0m\n' "$*"; exit 1; }

# ---------------------------------------------------------------- pre-checks
say "Pre-checks"
[ -d "$REPO" ] || die "Repo not found at $REPO"
cd "$REPO"
grep -q '"name": "klassrun-web"' package.json 2>/dev/null || die "This is not klassrun-web (package.json mismatch)"
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || die "Not a git repository"
if [ -n "$(git status --porcelain)" ]; then
  die "Working tree is not clean. Commit or stash first, then re-run."
fi

MODIFY=(
  app/globals.css
  app/layout.jsx
  app/page.jsx
  app/sitemap.js
  components/Navbar.jsx
  components/Hero.jsx
  components/Comparison.jsx
  components/Pricing.jsx
  components/FAQ.jsx
  components/Footer.jsx
  components/ui/Section.jsx
)
DELETE=(
  components/About.jsx
  components/CredStrip.jsx
  components/HowItWorks.jsx
  components/CTA.jsx
  components/Product.jsx
  components/ui/MotionCard.jsx
  lib/motion.js
)
NEWFILES=(
  components/FeatureTabs.jsx
  components/Personas.jsx
  components/WhyKlassrun.jsx
  components/Testimonials.jsx
  app/privacy/page.jsx
  app/terms/page.jsx
)

for f in "${MODIFY[@]}" "${DELETE[@]}"; do
  [ -f "$f" ] || die "Expected file missing: $f — repo state differs from plan, nothing written."
done
for f in "${NEWFILES[@]}"; do
  [ -e "$f" ] && die "New file already exists: $f — nothing written."
done
echo "All ${#MODIFY[@]} modify targets + ${#DELETE[@]} delete targets present; ${#NEWFILES[@]} new paths free."

# ------------------------------------------------------------------- backup
say "Backing up to $BACKUP"
mkdir -p "$BACKUP"
for f in "${MODIFY[@]}" "${DELETE[@]}" package.json package-lock.json; do
  mkdir -p "$BACKUP/$(dirname "$f")"
  cp "$f" "$BACKUP/$f"
done
echo "Backup complete."

restore_all() {
  printf '\n\033[1;33m!! Restoring repo from backup...\033[0m\n'
  ( cd "$BACKUP" && find . -type f ) | while read -r rel; do
    rel="${rel#./}"
    mkdir -p "$REPO/$(dirname "$rel")"
    cp "$BACKUP/$rel" "$REPO/$rel"
  done
  for f in "${NEWFILES[@]}"; do rm -f "$REPO/$f"; done
  rmdir "$REPO/app/privacy" "$REPO/app/terms" 2>/dev/null || true
  ( cd "$REPO" && npm install --no-audit --no-fund )
  printf '\033[1;33m!! Repo restored to pre-install state.\033[0m\n'
}

# ------------------------------------------------------------- dependencies
say "Dependencies: remove framer-motion, add @fontsource/nunito"
npm uninstall framer-motion --no-audit --no-fund
npm install @fontsource/nunito --no-audit --no-fund

# ============================================================================
# FILE WRITES
# ============================================================================
say "Writing files"
mkdir -p app/privacy app/terms

# ---------------------------------------------------------- app/globals.css
cat > app/globals.css << 'H_GLOBALS'
@import "tailwindcss";
@import "tw-animate-css";
@import "shadcn/tailwind.css";
@import "@fontsource/nunito/latin-400.css";
@import "@fontsource/nunito/latin-600.css";
@import "@fontsource/nunito/latin-700.css";
@import "@fontsource/nunito/latin-800.css";
@source "../../components";

@custom-variant dark (&:is(.dark *));

@theme inline {
    --font-sans: "Nunito", ui-sans-serif, system-ui, -apple-system, "Segoe UI", Arial, sans-serif;
    --font-heading: var(--font-sans);
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

    --color-surface-base: var(--surface-base);
    --color-surface-elevated: var(--surface-elevated);
    --color-surface-floating: var(--surface-floating);

    --radius-sm: calc(var(--radius) * 0.6);
    --radius-md: calc(var(--radius) * 0.8);
    --radius-lg: var(--radius);
    --radius-xl: calc(var(--radius) * 1.4);
    --radius-2xl: calc(var(--radius) * 1.8);
    --radius-3xl: calc(var(--radius) * 2.2);
    --radius-4xl: calc(var(--radius) * 2.6);

    /* Klassrun palette (UNCHANGED) */
    --color-klassrun-green: oklch(0.65 0.178 145);
    --color-klassrun-green-dark: oklch(0.52 0.148 145);
    --color-klassrun-green-light: oklch(0.75 0.15 145);
    --color-klassrun-navy: oklch(0.22 0.025 255);
    --color-klassrun-navy-light: oklch(0.30 0.02 255);
    /* Mint section background (new — Afrilearn-style sections) */
    --color-klassrun-mint: oklch(0.955 0.022 152);
}

:root {
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

    --surface-base: oklch(0.995 0.002 260);
    --surface-elevated: oklch(1 0 0);
    --surface-floating: oklch(1 0 0);

    --border-subtle: oklch(0.945 0.003 260);
    --border-soft: oklch(0.92 0.004 260);

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
    --shadow-float: 0 8px 32px -4px oklch(0.22 0.025 255 / 0.08),
                    0 2px 8px -2px oklch(0.22 0.025 255 / 0.04);
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
    * { @apply border-border outline-ring/50; }
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

@layer utilities {
    .stack-1 > * + * { margin-top: 0.5rem; }
    .stack-2 > * + * { margin-top: 1rem; }
    .stack-3 > * + * { margin-top: 1.5rem; }
    .stack-4 > * + * { margin-top: 2rem; }
    .stack-6 > * + * { margin-top: 3rem; }
    .stack-8 > * + * { margin-top: 4rem; }

    .surface-base      { background-color: var(--surface-base); }
    .surface-elevated  { background-color: var(--surface-elevated); }
    .surface-floating  { background-color: var(--surface-floating); }

    .border-subtle { border-color: var(--border-subtle); }
    .border-soft   { border-color: var(--border-soft); }

    .shadow-xs    { box-shadow: var(--shadow-xs); }
    .shadow-soft  { box-shadow: var(--shadow-sm); }
    .shadow-card  { box-shadow: var(--shadow-md); }
    .shadow-lift  { box-shadow: var(--shadow-lg); }
    .shadow-pop   { box-shadow: var(--shadow-xl); }
    .shadow-hero  { box-shadow: var(--shadow-2xl); }
    .shadow-glow  { box-shadow: var(--shadow-glow); }
    .shadow-float { box-shadow: var(--shadow-float); }

    /* Hide horizontal scrollbars on tab rows / card rails */
    .no-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
    .no-scrollbar::-webkit-scrollbar { display: none; }

    /* Glassmorphism — true frosted glass that lets palette bleed through */
    .glass {
        background-color: oklch(1 0 0 / 0.55);
        backdrop-filter: saturate(180%) blur(14px);
        -webkit-backdrop-filter: saturate(180%) blur(14px);
    }
    .glass-strong {
        background-color: oklch(1 0 0 / 0.72);
        backdrop-filter: saturate(200%) blur(20px);
        -webkit-backdrop-filter: saturate(200%) blur(20px);
    }
    .glass-pill {
        background-color: oklch(1 0 0 / 0.65);
        backdrop-filter: saturate(180%) blur(18px);
        -webkit-backdrop-filter: saturate(180%) blur(18px);
    }

    .perspective-card {
        perspective: 1200px;
        transform-style: preserve-3d;
    }
}

@media (prefers-reduced-motion: reduce) {
    *, *::before, *::after {
        animation-duration: 0.01ms !important;
        animation-iteration-count: 1 !important;
        transition-duration: 0.01ms !important;
        scroll-behavior: auto !important;
    }
}
H_GLOBALS
echo "  wrote app/globals.css"

# ---------------------------------------------------------- app/layout.jsx
cat > app/layout.jsx << 'H_LAYOUT'
import './globals.css'
import ServiceWorkerRegister from '@/components/ServiceWorkerRegister'
import LoadingSplash from '@/components/LoadingSplash'

const BASE_URL = 'https://klassrun.com'

// ── VIEWPORT (separated from metadata — required in Next.js 14+) ──
export const viewport = {
  width: 'device-width',
  initialScale: 1,
  maximumScale: 5,
  themeColor: '#3DB54A',
  colorScheme: 'light',
}

export const metadata = {
  title: {
    default: 'Klassrun — School Management Software for Nigerian Schools',
    template: '%s | Klassrun Technologies',
  },
  description:
    'Run your school from one place. Lesson notes, schemes of work, WAEC-style exam questions, results, report cards, attendance and fees — with AI lesson note and exam question generation. Built for Nigerian schools.',
  keywords: [
    'EdTech Nigeria',
    'lesson note generator Nigeria',
    'WAEC exam questions AI',
    'NECO exam questions',
    'school management software Nigeria',
    'AI for Nigerian schools',
    'KlassRun',
    'Klassrun Technologies',
    'Nigerian curriculum AI',
    'NERDC curriculum',
  ],
  authors: [{ name: 'Klassrun Technologies Ltd' }],
  creator: 'Klassrun Technologies Ltd',
  publisher: 'Klassrun Technologies Ltd',

  openGraph: {
    type: 'website',
    locale: 'en_NG',
    url: BASE_URL,
    siteName: 'Klassrun Technologies Ltd',
    title: 'Klassrun — School Management Software for Nigerian Schools',
    description:
      'Run your school from one place. Lesson notes, schemes of work, WAEC-style exam questions, results, report cards, attendance and fees. Built for Nigerian schools.',
    images: [
      {
        url: `${BASE_URL}/images/og-image.webp`,
        width: 1200,
        height: 630,
        alt: 'Klassrun Technologies Ltd',
        type: 'image/webp',
      },
    ],
  },

  twitter: {
    card: 'summary_large_image',
    title: 'Klassrun Technologies Ltd',
    description: 'School management software built for Nigerian schools.',
    images: [`${BASE_URL}/images/og-image.webp`],
  },

  icons: {
    icon: [
      { url: '/favicon-16x16.png', sizes: '16x16', type: 'image/png' },
      { url: '/favicon-32x32.png', sizes: '32x32', type: 'image/png' },
    ],
    apple: [
      { url: '/apple-touch-icon.png', sizes: '180x180', type: 'image/png' },
    ],
    other: [
      { rel: 'mask-icon', url: '/favicon-32x32.png', color: '#3DB54A' },
    ],
  },

  alternates: {
    canonical: BASE_URL,
  },

  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      'max-video-preview': -1,
      'max-image-preview': 'large',
      'max-snippet': -1,
    },
  },
}

const jsonLd = {
  '@context': 'https://schema.org',
  '@type': 'Organization',
  name: 'Klassrun Technologies Ltd',
  url: 'https://klassrun.com',
  logo: 'https://klassrun.com/images/logo.webp',
  description:
    'School management software for Nigerian schools — lesson notes, schemes of work, WAEC-style exam questions, results, report cards, attendance and fees in one place.',
  foundingLocation: {
    '@type': 'Place',
    name: 'Nigeria',
  },
  sameAs: [],
  contactPoint: {
    '@type': 'ContactPoint',
    contactType: 'customer support',
    email: 'info@klassrun.com',
    availableLanguage: 'English',
  },
}

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <head>
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
        />
      </head>
      <body>
        <LoadingSplash />
        <ServiceWorkerRegister />
        {children}
      </body>
    </html>
  )
}
H_LAYOUT
echo "  wrote app/layout.jsx"

# ------------------------------------------------------------ app/page.jsx
cat > app/page.jsx << 'H_PAGE'
import Navbar from '@/components/Navbar'
import Hero from '@/components/Hero'
import FeatureTabs from '@/components/FeatureTabs'
import Personas from '@/components/Personas'
import WhyKlassrun from '@/components/WhyKlassrun'
import Comparison from '@/components/Comparison'
import Pricing from '@/components/Pricing'
import Testimonials from '@/components/Testimonials'
import FAQ from '@/components/FAQ'
import Footer from '@/components/Footer'

export default function Home() {
  return (
    <main className="relative overflow-x-hidden">
      <Navbar />
      <Hero />
      <FeatureTabs />
      <Personas />
      <WhyKlassrun />
      <Comparison />
      <Pricing />
      <Testimonials />
      <FAQ />
      <Footer />
    </main>
  )
}
H_PAGE
echo "  wrote app/page.jsx"

# --------------------------------------------------------- app/sitemap.js
cat > app/sitemap.js << 'H_SITEMAP'
export const dynamic = 'force-static'

export default function sitemap() {
  return [
    {
      url: 'https://klassrun.com',
      lastModified: new Date(),
      changeFrequency: 'monthly',
      priority: 1,
    },
    {
      url: 'https://klassrun.com/privacy/',
      lastModified: new Date(),
      changeFrequency: 'yearly',
      priority: 0.3,
    },
    {
      url: 'https://klassrun.com/terms/',
      lastModified: new Date(),
      changeFrequency: 'yearly',
      priority: 0.3,
    },
  ]
}
H_SITEMAP
echo "  wrote app/sitemap.js"

# ------------------------------------------------ components/ui/Section.jsx
cat > components/ui/Section.jsx << 'H_SECTION'
// Layout primitives — motion-free. Surfaces map to the Afrilearn-style
// alternating backgrounds: white → mint → navy → white.
export function Section({ id, children, className = '', surface = 'base', bleed = false }) {
  const surfaceCls = {
    base: '',
    white: 'bg-white',
    muted: 'bg-secondary/30',
    mint: 'bg-klassrun-mint',
    navy: 'bg-klassrun-navy',
  }[surface] ?? ''

  return (
    <section id={id} className={`relative py-16 md:py-24 ${surfaceCls} ${className}`}>
      <div className={bleed ? '' : 'mx-auto w-full max-w-6xl px-5 sm:px-6 lg:px-8'}>
        {children}
      </div>
    </section>
  )
}

export function SectionHeader({ title, subtitle, dark = false, className = '' }) {
  return (
    <div className={`max-w-2xl mx-auto text-center mb-10 md:mb-14 ${className}`}>
      <h2
        className={`text-[1.75rem] sm:text-4xl md:text-[2.5rem] font-bold leading-[1.12] ${
          dark ? 'text-white' : 'text-foreground'
        }`}
      >
        {title}
      </h2>
      {subtitle && (
        <p
          className={`mt-4 text-base sm:text-lg leading-relaxed ${
            dark ? 'text-white/70' : 'text-muted-foreground'
          }`}
        >
          {subtitle}
        </p>
      )}
    </div>
  )
}
H_SECTION
echo "  wrote components/ui/Section.jsx"

# --------------------------------------------------- components/Navbar.jsx
cat > components/Navbar.jsx << 'H_NAVBAR'
'use client'

import { useEffect, useState } from 'react'
import Image from 'next/image'
import Link from 'next/link'
import { Menu, X } from 'lucide-react'

const navLinks = [
  { label: 'Features', href: '#features' },
  { label: 'Pricing', href: '#pricing' },
  { label: 'FAQ', href: '#faq' },
]

export default function Navbar() {
  const [mobileOpen, setMobileOpen] = useState(false)
  const [scrolled, setScrolled] = useState(false)

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 8)
    onScroll()
    window.addEventListener('scroll', onScroll, { passive: true })
    return () => window.removeEventListener('scroll', onScroll)
  }, [])

  useEffect(() => {
    document.body.style.overflow = mobileOpen ? 'hidden' : ''
    return () => { document.body.style.overflow = '' }
  }, [mobileOpen])

  return (
    <header
      className={`fixed top-0 left-0 right-0 z-50 bg-white border-b border-subtle transition-shadow duration-300 ${
        scrolled ? 'shadow-soft' : ''
      }`}
    >
      <nav className="mx-auto w-full max-w-6xl px-5 sm:px-6 lg:px-8">
        <div className="flex h-16 items-center justify-between gap-3">
          {/* Logo */}
          <Link href="/" className="flex items-center shrink-0" onClick={() => setMobileOpen(false)}>
            <Image
              src="/images/logo-nav.webp"
              alt="Klassrun"
              width={100}
              height={34}
              className="h-7 sm:h-8 w-auto object-contain"
              priority
              unoptimized
            />
          </Link>

          {/* Desktop links */}
          <div className="hidden md:flex items-center gap-8">
            {navLinks.map((link) => (
              <a
                key={link.href}
                href={link.href}
                className="text-sm font-semibold text-foreground/70 hover:text-primary transition-colors duration-300"
              >
                {link.label}
              </a>
            ))}
          </div>

          {/* Right side — Get Started stays visible on every screen size */}
          <div className="flex items-center gap-2 sm:gap-3">
            <a
              href="https://app.klassrun.com"
              className="hidden md:inline-flex items-center text-sm font-semibold text-foreground/70 hover:text-primary transition-colors duration-300 px-2 py-2"
            >
              Login
            </a>
            <a
              href="https://app.klassrun.com/signup"
              className="inline-flex items-center justify-center rounded-full bg-primary px-4 sm:px-5 py-2 text-sm font-bold text-primary-foreground hover:bg-klassrun-green-dark transition-colors duration-300"
            >
              Get Started
            </a>
            <button
              onClick={() => setMobileOpen(!mobileOpen)}
              className="md:hidden inline-flex items-center justify-center h-10 w-10 rounded-full text-foreground/80 hover:bg-foreground/5 active:bg-foreground/10 transition-colors duration-200"
              aria-label={mobileOpen ? 'Close menu' : 'Open menu'}
              aria-expanded={mobileOpen}
            >
              {mobileOpen ? <X size={20} /> : <Menu size={20} />}
            </button>
          </div>
        </div>
      </nav>

      {/* Mobile menu */}
      {mobileOpen && (
        <div className="md:hidden border-t border-subtle bg-white">
          <nav className="mx-auto w-full max-w-6xl px-5 py-3 flex flex-col">
            {navLinks.map((link) => (
              <a
                key={link.href}
                href={link.href}
                onClick={() => setMobileOpen(false)}
                className="px-2 py-3.5 text-base font-semibold text-foreground/80 hover:text-primary transition-colors border-b border-subtle last:border-0"
              >
                {link.label}
              </a>
            ))}
            <a
              href="https://app.klassrun.com"
              onClick={() => setMobileOpen(false)}
              className="px-2 py-3.5 text-base font-semibold text-foreground/80 hover:text-primary transition-colors"
            >
              Login
            </a>
          </nav>
        </div>
      )}
    </header>
  )
}
H_NAVBAR
echo "  wrote components/Navbar.jsx"

# ----------------------------------------------------- components/Hero.jsx
cat > components/Hero.jsx << 'H_HERO'
import { Check, Clock, FileText, ClipboardCheck, ArrowRight } from 'lucide-react'

const bullets = [
  { verb: 'Generate', rest: ' lesson notes and schemes of work with AI, aligned to the NERDC curriculum' },
  { verb: 'Set', rest: ' WAEC-style exam questions from a question bank your school owns' },
  { verb: 'Compute', rest: ' results and print proper Nigerian report cards' },
  { verb: 'Track', rest: ' attendance, behaviour and promotions in one place' },
  { verb: 'Mark', rest: ' fees paid or unpaid — your bursar sees everything at a glance' },
]

export default function Hero() {
  return (
    <section className="relative pt-28 sm:pt-32 pb-12 md:pb-20 overflow-hidden bg-white">
      <div className="mx-auto w-full max-w-6xl px-5 sm:px-6 lg:px-8">
        <div className="grid lg:grid-cols-12 gap-12 lg:gap-14 items-center">
          {/* Left — copy */}
          <div className="lg:col-span-7">
            <h1 className="text-[2.25rem] sm:text-5xl lg:text-[3.5rem] font-extrabold leading-[1.06] text-foreground">
              Run your whole school{' '}
              <span className="text-primary">from one place</span>
            </h1>

            <ul className="mt-7 sm:mt-9 space-y-3.5">
              {bullets.map((b) => (
                <li key={b.verb} className="flex items-start gap-3">
                  <span className="mt-0.5 flex-shrink-0 h-5 w-5 rounded-full bg-primary/12 flex items-center justify-center">
                    <Check size={12} className="text-primary" strokeWidth={3.5} />
                  </span>
                  <span className="text-[15px] sm:text-base text-foreground/85 leading-snug">
                    <strong className="font-bold text-foreground">{b.verb}</strong>
                    {b.rest}
                  </span>
                </li>
              ))}
            </ul>

            <div className="mt-9 flex flex-col sm:flex-row gap-3">
              <a
                href="https://app.klassrun.com/signup"
                className="group inline-flex items-center justify-center gap-2 rounded-full bg-primary px-7 py-3.5 text-sm font-bold text-primary-foreground hover:bg-klassrun-green-dark transition-colors duration-300"
              >
                Start Free Trial
                <ArrowRight size={16} className="transition-transform duration-300 group-hover:translate-x-0.5" />
              </a>
              <a
                href="mailto:info@klassrun.com"
                className="inline-flex items-center justify-center gap-2 rounded-full border border-soft bg-white px-7 py-3.5 text-sm font-bold text-foreground hover:bg-secondary transition-colors duration-300"
              >
                Talk to us
              </a>
            </div>

            <p className="mt-5 text-xs text-muted-foreground">
              14-day free trial · No card required
            </p>
          </div>

          {/* Right — static product mockup (illustration, no live data) */}
          <div className="lg:col-span-5 relative">
            <div className="rounded-2xl border border-soft bg-white shadow-lift overflow-hidden">
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

              <div className="p-5 sm:p-6 space-y-4">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-[11px] text-muted-foreground">Welcome back,</p>
                    <p className="text-sm font-bold text-foreground">Mrs. Adeyemi</p>
                  </div>
                  <div className="text-[11px] bg-primary/10 text-primary px-3 py-1 rounded-full font-semibold">
                    2025/2026 · Term 2
                  </div>
                </div>

                <div className="grid grid-cols-2 gap-3">
                  <div className="rounded-xl bg-primary/10 ring-1 ring-primary/15 p-4">
                    <FileText size={18} className="text-primary mb-2" />
                    <p className="text-sm font-bold text-foreground">Generate Lesson Note</p>
                    <p className="text-[11px] text-muted-foreground mt-1">JSS 2 · Mathematics</p>
                  </div>
                  <div className="rounded-xl bg-secondary border border-subtle p-4">
                    <ClipboardCheck size={18} className="text-foreground/60 mb-2" />
                    <p className="text-sm font-bold text-foreground">Set Exam Questions</p>
                    <p className="text-[11px] text-muted-foreground mt-1">SS 1 · English Language</p>
                  </div>
                </div>

                <div className="space-y-2">
                  <p className="text-[10px] font-bold text-muted-foreground uppercase tracking-[0.14em]">
                    Recent
                  </p>
                  {[
                    { subject: 'Basic Science', cls: 'JSS 1', type: 'Lesson Note', time: '2 mins ago' },
                    { subject: 'Mathematics', cls: 'SS 2', type: 'Exam Questions', time: '1 hour ago' },
                    { subject: 'Civic Education', cls: 'JSS 3', type: 'Scheme of Work', time: '3 hours ago' },
                  ].map((item) => (
                    <div
                      key={item.subject}
                      className="flex items-center justify-between rounded-lg bg-white border border-subtle px-4 py-3"
                    >
                      <div>
                        <p className="text-sm font-semibold text-foreground">
                          {item.subject}{' '}
                          <span className="text-muted-foreground font-normal">· {item.cls}</span>
                        </p>
                        <p className="text-[11px] text-muted-foreground">{item.type}</p>
                      </div>
                      <span className="text-[11px] text-muted-foreground">{item.time}</span>
                    </div>
                  ))}
                </div>
              </div>
            </div>

            <div className="absolute -bottom-4 -left-2 sm:-bottom-5 sm:-left-5 bg-white rounded-xl border border-soft shadow-lift px-3.5 py-2.5 sm:px-4 sm:py-3 flex items-center gap-3">
              <div className="h-9 w-9 sm:h-10 sm:w-10 rounded-full bg-primary/10 flex items-center justify-center">
                <Clock size={17} className="text-primary" />
              </div>
              <div>
                <p className="text-sm font-bold text-foreground">3 hours saved</p>
                <p className="text-[11px] text-muted-foreground">This afternoon</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  )
}
H_HERO
echo "  wrote components/Hero.jsx"

# ---------------------------------------------- components/FeatureTabs.jsx
cat > components/FeatureTabs.jsx << 'H_TABS'
'use client'

import { useState } from 'react'
import {
  FileText, CalendarDays, ClipboardCheck, GraduationCap,
  ClipboardList, Wallet, Sparkles, Check, ArrowRight,
} from 'lucide-react'
import { Section, SectionHeader } from './ui/Section'

const TABS = [
  {
    id: 'lesson-notes',
    label: 'Lesson Notes',
    icon: FileText,
    title: 'Complete lesson notes in minutes',
    body:
      'Pick the class, subject and topic. Klassrun’s AI writes a full lesson note in the format Nigerian schools submit — objectives, content, evaluation. The teacher reviews, edits and prints.',
    points: ['NERDC topics built in', 'Edit everything before you print', 'Export as PDF'],
    rows: [
      { a: 'Basic Science · JSS 1', b: 'Lesson Note', chip: 'Ready' },
      { a: 'Mathematics · SS 2', b: 'Lesson Note', chip: 'Ready' },
      { a: 'English · JSS 3', b: 'Draft', chip: 'Editing' },
    ],
  },
  {
    id: 'schemes',
    label: 'Schemes of Work',
    icon: CalendarDays,
    title: 'A full scheme of work for the term',
    body:
      'Generate the whole term week by week, matched to the three-term calendar. Submit it once, reuse it next session, and keep every class on the same page.',
    points: ['Week-by-week breakdown', 'Matches the three-term calendar', 'Reuse next session'],
    rows: [
      { a: 'First Term · Week 1–13', b: 'Mathematics, JSS 2', chip: 'Complete' },
      { a: 'Second Term · Week 1–12', b: 'Basic Science, JSS 1', chip: 'Complete' },
      { a: 'Third Term · Week 1–11', b: 'English, SS 1', chip: 'In use' },
    ],
  },
  {
    id: 'exams',
    label: 'Exam Questions',
    icon: ClipboardCheck,
    title: 'WAEC-style questions, saved to your bank',
    body:
      'Generate objective and theory questions in WAEC style, with marking guides. Every question goes into a private bank your school owns — so you never set the same paper twice.',
    points: ['Objective and theory formats', 'Marking guides included', 'School-owned question bank'],
    rows: [
      { a: 'SS 1 English · 50 objectives', b: 'First C.A.', chip: 'In bank' },
      { a: 'JSS 2 Maths · Theory ×6', b: 'Terminal exam', chip: 'In bank' },
      { a: 'JSS 3 Basic Sci · Mixed', b: 'Mock exam', chip: 'In bank' },
    ],
  },
  {
    id: 'results',
    label: 'Results & Report Cards',
    icon: GraduationCap,
    title: 'From scores to printed report cards',
    body:
      'Teachers enter CA and exam scores; totals, grades and class positions compute themselves. Print proper Nigerian report cards as PDF, with behaviour records included.',
    points: ['Totals and grades computed for you', 'Class positions worked out automatically', 'Report cards print as PDF'],
    rows: [
      { a: 'JSS 2 · 38 students', b: 'Second Term results', chip: 'Compiled' },
      { a: 'SS 1 · 41 students', b: 'Report cards', chip: 'Printed' },
      { a: 'JSS 3 · 35 students', b: 'Positions', chip: 'Ranked' },
    ],
  },
  {
    id: 'attendance',
    label: 'Attendance',
    icon: ClipboardList,
    title: 'Attendance and behaviour, on the record',
    body:
      'Take daily attendance per class, record termly behaviour assessments, and carry it all onto the report card. Promotion decisions at term end happen in the same place.',
    points: ['Daily attendance per class', 'Termly behaviour assessment', 'Promotions handled at term end'],
    rows: [
      { a: 'JSS 1A · Today', b: '36 present · 2 absent', chip: 'Taken' },
      { a: 'SS 2B · Today', b: '39 present · 1 absent', chip: 'Taken' },
      { a: 'Term 2 promotions', b: 'JSS 3 → SS 1', chip: 'Done' },
    ],
  },
  {
    id: 'fees',
    label: 'Fees',
    icon: Wallet,
    title: 'Know who has paid at a glance',
    body:
      'Your bursar marks fees paid or unpaid per student and sees collection status for every class. A separate bursar login keeps money matters away from teaching tools.',
    points: ['Paid / unpaid per student', 'Collection view per class', 'Separate bursar role'],
    rows: [
      { a: 'Adaeze O. · JSS 2', b: 'Second Term fees', chip: 'PAID' },
      { a: 'Tunde A. · SS 1', b: 'Second Term fees', chip: 'UNPAID' },
      { a: 'JSS 2 class', b: '31 of 38 paid', chip: '82%' },
    ],
  },
  {
    id: 'next',
    label: 'What’s Next',
    icon: Sparkles,
    title: 'On the roadmap',
    body:
      'These ship next, and your plan includes them as they land. No upgrade gymnastics — they appear in your school’s account when ready.',
    points: [],
    roadmap: [
      { title: 'Parent & Student Portal', body: 'Parents see results, attendance and fees from home.' },
      { title: 'CBT Exams', body: 'Timed, computer-based papers from your question bank.' },
      { title: 'Online Fee Payments', body: 'Parents pay school fees directly through Paystack.' },
      { title: 'WhatsApp Notifications', body: 'Results and fee reminders straight to parents’ phones.' },
    ],
  },
]

export default function FeatureTabs() {
  const [active, setActive] = useState(0)
  const tab = TABS[active]
  const Icon = tab.icon

  return (
    <Section id="features" surface="white">
      <SectionHeader
        title="Everything your school runs on, in one place"
        subtitle="Lesson notes, exams, results, fees and attendance — one login for the whole school."
      />

      {/* Pill tab row */}
      <div className="flex justify-center">
        <div className="flex gap-1.5 overflow-x-auto no-scrollbar rounded-full bg-secondary/70 p-1.5 max-w-full">
          {TABS.map((t, i) => (
            <button
              key={t.id}
              onClick={() => setActive(i)}
              className={`whitespace-nowrap rounded-full px-4 py-2 text-sm font-bold transition-colors duration-200 ${
                i === active
                  ? 'bg-klassrun-navy text-white'
                  : 'text-foreground/65 hover:text-foreground'
              }`}
            >
              {t.label}
            </button>
          ))}
        </div>
      </div>

      {/* Active panel */}
      <div className="mt-10 md:mt-14 grid lg:grid-cols-2 gap-10 lg:gap-14 items-center">
        <div>
          <h3 className="text-2xl sm:text-3xl font-bold text-foreground leading-tight">
            {tab.title}
          </h3>
          <p className="mt-4 text-base text-muted-foreground leading-relaxed">{tab.body}</p>

          {tab.points.length > 0 && (
            <ul className="mt-6 space-y-3">
              {tab.points.map((p) => (
                <li key={p} className="flex items-start gap-3">
                  <span className="mt-0.5 flex-shrink-0 h-5 w-5 rounded-full bg-primary/12 flex items-center justify-center">
                    <Check size={12} className="text-primary" strokeWidth={3.5} />
                  </span>
                  <span className="text-sm text-foreground/85">{p}</span>
                </li>
              ))}
            </ul>
          )}

          <div className="mt-8 flex flex-col sm:flex-row gap-3">
            <a
              href="https://app.klassrun.com/signup"
              className="group inline-flex items-center justify-center gap-2 rounded-full bg-primary px-6 py-3 text-sm font-bold text-primary-foreground hover:bg-klassrun-green-dark transition-colors duration-300"
            >
              Get Started
              <ArrowRight size={15} className="transition-transform duration-300 group-hover:translate-x-0.5" />
            </a>
            <a
              href="mailto:info@klassrun.com"
              className="inline-flex items-center justify-center rounded-full border border-soft bg-white px-6 py-3 text-sm font-bold text-foreground hover:bg-secondary transition-colors duration-300"
            >
              Talk to us
            </a>
          </div>
        </div>

        {/* Visual side */}
        <div className="rounded-3xl bg-secondary/40 border border-subtle p-6 sm:p-8">
          {tab.roadmap ? (
            <div className="grid sm:grid-cols-2 gap-4">
              {tab.roadmap.map((r) => (
                <div key={r.title} className="rounded-2xl bg-white border border-subtle p-5">
                  <span className="inline-block rounded-full bg-foreground/8 text-foreground/65 px-2.5 py-0.5 text-[10px] font-bold tracking-wide mb-3">
                    Coming soon
                  </span>
                  <p className="text-sm font-bold text-foreground">{r.title}</p>
                  <p className="mt-1.5 text-xs text-muted-foreground leading-relaxed">{r.body}</p>
                </div>
              ))}
            </div>
          ) : (
            <div>
              <div className="h-12 w-12 rounded-xl bg-primary/12 ring-1 ring-primary/15 flex items-center justify-center mb-5">
                <Icon size={22} className="text-primary" />
              </div>
              <div className="space-y-2.5">
                {tab.rows.map((row) => (
                  <div
                    key={row.a}
                    className="flex items-center justify-between gap-3 rounded-xl bg-white border border-subtle px-4 py-3.5"
                  >
                    <div className="min-w-0">
                      <p className="text-sm font-semibold text-foreground truncate">{row.a}</p>
                      <p className="text-[11px] text-muted-foreground">{row.b}</p>
                    </div>
                    <span
                      className={`flex-shrink-0 rounded-full px-2.5 py-1 text-[10px] font-bold tracking-wide ${
                        row.chip === 'UNPAID'
                          ? 'bg-destructive/10 text-destructive'
                          : 'bg-primary/10 text-primary'
                      }`}
                    >
                      {row.chip}
                    </span>
                  </div>
                ))}
              </div>
            </div>
          )}
        </div>
      </div>
    </Section>
  )
}
H_TABS
echo "  wrote components/FeatureTabs.jsx"

# ------------------------------------------------- components/Personas.jsx
cat > components/Personas.jsx << 'H_PERSONAS'
'use client'

import { useState } from 'react'
import {
  LayoutDashboard, Printer, Wallet, ArrowUpDown, ClipboardList, Users,
  FileText, CalendarDays, ClipboardCheck, Calculator, Smartphone, RefreshCw,
  CheckCircle2, Eye, Table, Lock, CreditCard, BarChart3,
} from 'lucide-react'
import { Section, SectionHeader } from './ui/Section'

// PLACEHOLDER — replace each persona's `quote` with a real quote from a real
// school before launch. They render exactly as written below, so the bracketed
// text is intentionally impossible to mistake for a real testimonial.
const PERSONAS = [
  {
    id: 'owners',
    label: 'School Owners & Admins',
    headline: 'Run your school with confidence',
    benefits: [
      { icon: LayoutDashboard, text: 'See what every teacher has prepared, class by class, term by term.' },
      { icon: Printer, text: 'Print report cards for the whole school from one place.' },
      { icon: Wallet, text: 'Know who has paid fees and who hasn’t, at a glance.' },
      { icon: ArrowUpDown, text: 'Handle end-of-term promotions without shuffling paper.' },
      { icon: ClipboardList, text: 'Keep attendance and behaviour records that follow each student.' },
      { icon: Users, text: 'One school account — owners, teachers and bursars each get their own role.' },
    ],
    quote: '[PLACEHOLDER — quote from a real school owner goes here]',
    attribution: '[Name, School, Location]',
  },
  {
    id: 'teachers',
    label: 'Teachers',
    headline: 'Get your evenings back',
    benefits: [
      { icon: FileText, text: 'Write a complete lesson note in minutes, not hours.' },
      { icon: CalendarDays, text: 'Generate a full scheme of work for the term, week by week.' },
      { icon: ClipboardCheck, text: 'Set WAEC-style exam questions and keep them in your own bank.' },
      { icon: Calculator, text: 'Enter CA and exam scores — totals and grades compute themselves.' },
      { icon: Smartphone, text: 'Take attendance from your phone in seconds.' },
      { icon: RefreshCw, text: 'Reuse and edit everything you’ve made, any term, any session.' },
    ],
    quote: '[PLACEHOLDER — quote from a real teacher goes here]',
    attribution: '[Name, Role, School]',
  },
  {
    id: 'bursars',
    label: 'Bursars',
    headline: 'Every fee, accounted for',
    benefits: [
      { icon: CheckCircle2, text: 'Mark fees paid or unpaid per student in two clicks.' },
      { icon: Eye, text: 'See collection status for every class at a glance.' },
      { icon: Table, text: 'Fee records tied to each student’s profile, term by term.' },
      { icon: Lock, text: 'Your own bursar login, separate from the teaching tools.' },
      { icon: BarChart3, text: 'Spot outstanding balances per class before the term ends.' },
      { icon: CreditCard, text: 'Online payments through Paystack — coming soon.', soon: true },
    ],
    quote: '[PLACEHOLDER — quote from a real bursar goes here]',
    attribution: '[Name, School]',
  },
]

export default function Personas() {
  const [active, setActive] = useState(0)
  const p = PERSONAS[active]

  return (
    <Section id="who" surface="muted">
      <SectionHeader title="Who is Klassrun for?" />

      {/* Underlined persona tabs */}
      <div className="-mt-4 mb-10 flex flex-wrap justify-center gap-x-7 gap-y-2">
        {PERSONAS.map((persona, i) => (
          <button
            key={persona.id}
            onClick={() => setActive(i)}
            className={`pb-1.5 text-sm sm:text-[15px] font-bold border-b-2 transition-colors duration-200 ${
              i === active
                ? 'border-foreground text-foreground'
                : 'border-transparent text-muted-foreground hover:text-foreground'
            }`}
          >
            {persona.label}
          </button>
        ))}
      </div>

      <h3 className="text-center text-xl sm:text-2xl font-bold text-foreground mb-10 md:mb-12">
        {p.headline}
      </h3>

      {/* 2×3 benefit grid */}
      <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-x-8 gap-y-9 max-w-5xl mx-auto">
        {p.benefits.map((b) => (
          <div key={b.text} className="flex items-start gap-4">
            <span className="flex-shrink-0 h-12 w-12 rounded-full bg-white border border-subtle shadow-soft flex items-center justify-center">
              <b.icon size={20} className="text-primary" />
            </span>
            <p className="text-sm text-foreground/85 leading-relaxed pt-1">
              {b.text}
              {b.soon && (
                <span className="ml-2 inline-block rounded-full bg-foreground/8 text-foreground/65 px-2 py-0.5 text-[10px] font-bold tracking-wide align-middle">
                  Coming soon
                </span>
              )}
            </p>
          </div>
        ))}
      </div>

      {/* Pull-quote between hairlines — PLACEHOLDER until a real quote exists */}
      <div className="max-w-3xl mx-auto mt-12 md:mt-16">
        <div className="border-t border-soft" />
        <blockquote className="py-7 text-center">
          <p className="text-base sm:text-lg italic text-foreground/80 leading-relaxed">
            “{p.quote}”
          </p>
          <footer className="mt-3 text-sm text-muted-foreground">— {p.attribution}</footer>
        </blockquote>
        <div className="border-t border-soft" />
      </div>
    </Section>
  )
}
H_PERSONAS
echo "  wrote components/Personas.jsx"

# ---------------------------------------------- components/WhyKlassrun.jsx
cat > components/WhyKlassrun.jsx << 'H_WHY'
import { Layers, MapPin, PenLine, MonitorSmartphone } from 'lucide-react'
import { Section, SectionHeader } from './ui/Section'

const cards = [
  {
    icon: Layers,
    title: 'Everything in one place',
    body: 'Lesson notes, exams, results, report cards, attendance and fees under one login. No more juggling templates, folders and WhatsApp groups.',
  },
  {
    icon: MapPin,
    title: 'Built for Nigerian schools',
    body: 'Three-term calendar, NERDC topics, WAEC-style questions, proper Nigerian report cards and naira pricing. Not a foreign tool squeezed to fit.',
  },
  {
    icon: PenLine,
    title: 'Notes and exams, written for you',
    body: 'Klassrun’s AI drafts complete lesson notes and exam questions from the curriculum topic. Teachers review, edit and teach — Sunday nights belong to them again.',
  },
  {
    icon: MonitorSmartphone,
    title: 'Works where schools work',
    body: 'Runs in the browser on any device, installs like an app, and is built to cope with slow connections.',
  },
]

export default function WhyKlassrun() {
  return (
    <Section id="why" surface="navy">
      <SectionHeader dark title="Why schools choose Klassrun" />
      <div className="grid sm:grid-cols-2 gap-x-12 gap-y-10 max-w-4xl mx-auto">
        {cards.map((c) => (
          <div key={c.title} className="flex items-start gap-5">
            <span className="flex-shrink-0 h-12 w-12 rounded-xl bg-white/10 ring-1 ring-white/15 flex items-center justify-center">
              <c.icon size={21} className="text-klassrun-green-light" />
            </span>
            <div>
              <h3 className="text-base sm:text-lg font-bold text-white">{c.title}</h3>
              <p className="mt-1.5 text-sm text-white/70 leading-relaxed">{c.body}</p>
            </div>
          </div>
        ))}
      </div>
    </Section>
  )
}
H_WHY
echo "  wrote components/WhyKlassrun.jsx"

# ----------------------------------------------- components/Comparison.jsx
cat > components/Comparison.jsx << 'H_COMPARE'
import { Check, X } from 'lucide-react'
import { Section, SectionHeader } from './ui/Section'

// REVIEW BEFORE LAUNCH — every cell in the three competitor columns is a
// claim about other products. Confirm each one yourself before this goes live.
const COLUMNS = [
  { key: 'klassrun', label: 'Klassrun', sub: null },
  { key: 'chatbot', label: 'Generic AI chatbots', sub: '(ChatGPT, e.t.c)' },
  { key: 'sms', label: 'School management software', sub: '(Edves, Educare, e.t.c)' },
  { key: 'manual', label: 'Manual / paper process', sub: null },
]

const ROWS = [
  {
    title: 'Writes lesson notes, schemes and exam questions',
    sub: 'Complete drafts the teacher reviews and edits',
    values: { klassrun: true, chatbot: true, sms: false, manual: false },
  },
  {
    title: 'Tied to NERDC topics per class and term',
    sub: 'The curriculum is built in — no copy-paste prompting',
    values: { klassrun: true, chatbot: false, sms: false, manual: false },
  },
  {
    title: 'School-owned question bank',
    sub: 'Every question saved and reusable for years',
    values: { klassrun: true, chatbot: false, sms: false, manual: false },
  },
  {
    title: 'Nigerian report cards, computed and printed',
    sub: 'Totals, grades and positions worked out for you',
    values: { klassrun: true, chatbot: false, sms: true, manual: false },
  },
  {
    title: 'Attendance, behaviour, promotions and fees together',
    sub: 'Academic and money records in the same system',
    values: { klassrun: true, chatbot: false, sms: true, manual: false },
  },
  {
    title: 'One school account with owner, teacher and bursar roles',
    sub: 'Everyone sees what their role allows',
    values: { klassrun: true, chatbot: false, sms: true, manual: false },
  },
]

function Cell({ yes, highlighted }) {
  return (
    <td className={`px-4 py-5 text-center ${highlighted ? 'bg-klassrun-navy' : ''}`}>
      <span className="inline-flex items-center gap-1.5">
        <span
          className={`h-5 w-5 rounded-full flex items-center justify-center ${
            yes ? 'bg-primary/15' : 'bg-destructive/10'
          }`}
        >
          {yes ? (
            <Check size={12} className="text-primary" strokeWidth={3.5} />
          ) : (
            <X size={12} className="text-destructive" strokeWidth={3.5} />
          )}
        </span>
        <span
          className={`text-sm font-semibold ${
            highlighted ? 'text-white' : 'text-foreground/75'
          }`}
        >
          {yes ? 'Yes' : 'No'}
        </span>
      </span>
    </td>
  )
}

export default function Comparison() {
  return (
    <Section id="compare" surface="mint">
      <SectionHeader
        title="How we compare"
        subtitle="Why Nigerian schools pick Klassrun"
      />

      <div className="overflow-x-auto rounded-2xl bg-white shadow-card">
        <table className="w-full min-w-[820px] text-left border-collapse">
          <thead>
            <tr className="border-b border-soft">
              <th className="px-5 py-5 text-sm font-bold text-foreground w-[30%]">Offerings</th>
              {COLUMNS.map((col) => (
                <th
                  key={col.key}
                  className={`px-4 py-5 text-center align-top ${
                    col.key === 'klassrun' ? 'bg-klassrun-navy' : ''
                  }`}
                >
                  <span
                    className={`block text-sm font-bold leading-snug ${
                      col.key === 'klassrun' ? 'text-white' : 'text-foreground'
                    }`}
                  >
                    {col.label}
                  </span>
                  {col.sub && (
                    <span className="block mt-1 text-[11px] font-normal text-muted-foreground">
                      {col.sub}
                    </span>
                  )}
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {ROWS.map((row, i) => (
              <tr key={row.title} className={i < ROWS.length - 1 ? 'border-b border-subtle' : ''}>
                <td className="px-5 py-5 align-top">
                  <p className="text-sm font-bold text-foreground leading-snug">{row.title}</p>
                  <p className="mt-1 text-xs text-muted-foreground leading-relaxed">{row.sub}</p>
                </td>
                {COLUMNS.map((col) => (
                  <Cell
                    key={col.key}
                    yes={row.values[col.key]}
                    highlighted={col.key === 'klassrun'}
                  />
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <p className="mt-4 text-center text-xs text-muted-foreground sm:hidden">
        Swipe sideways to see the full table
      </p>
    </Section>
  )
}
H_COMPARE
echo "  wrote components/Comparison.jsx"

# -------------------------------------------------- components/Pricing.jsx
cat > components/Pricing.jsx << 'H_PRICING'
import { Check } from 'lucide-react'
import { Section, SectionHeader } from './ui/Section'

// Final amounts are not announced yet — every tier shows "Coming soon".
// REVIEW the feature split across tiers before launch.
const plans = [
  {
    name: 'Starter',
    description: 'For schools getting started with faster lesson planning.',
    features: [
      { text: 'Lesson note generation', soon: false },
      { text: 'Scheme of work generation', soon: false },
      { text: 'Session & term management', soon: false },
      { text: 'Up to 10 teachers', soon: false },
    ],
    cta: 'Start Free Trial',
    ctaHref: 'https://app.klassrun.com/signup',
    highlighted: false,
  },
  {
    name: 'Standard',
    description: 'For schools running their whole term inside Klassrun.',
    features: [
      { text: 'Everything in Starter', soon: false },
      { text: 'Exam question generation', soon: false },
      { text: 'School question bank (never repeat questions)', soon: false },
      { text: 'Upload your scheme → matching lesson notes', soon: true },
      { text: 'PDF export with school branding', soon: true },
      { text: 'Usage analytics', soon: true },
      { text: 'Up to 30 teachers', soon: false },
    ],
    cta: 'Start Free Trial',
    ctaHref: 'https://app.klassrun.com/signup',
    highlighted: true,
    badge: 'Most Popular',
  },
  {
    name: 'Premium',
    description: 'The full school operations platform.',
    features: [
      { text: 'Everything in Standard', soon: false },
      { text: 'Results & report cards', soon: false },
      { text: 'Attendance & behaviour tracking', soon: false },
      { text: 'Fees & bursar tools', soon: false },
      { text: 'Report card comments, written for you', soon: true },
      { text: 'Parent portal', soon: true },
      { text: 'Unlimited teachers', soon: false },
      { text: 'Priority support', soon: false },
    ],
    cta: 'Contact Sales',
    ctaHref: 'mailto:info@klassrun.com',
    highlighted: false,
  },
]

export default function Pricing() {
  return (
    <Section id="pricing" surface="white">
      <SectionHeader
        title="Simple, termly pricing"
        subtitle="Pay per term — the way Nigerian schools budget. Final amounts are coming soon; the free trial is open now."
      />

      <div className="text-center mb-10 sm:mb-12">
        <div className="inline-flex items-center gap-2 rounded-full bg-primary/10 ring-1 ring-primary/15 px-4 py-2">
          <Check size={14} className="text-primary" strokeWidth={3} />
          <span className="text-xs sm:text-sm font-semibold text-foreground">
            All plans start with a 14-day free trial. No card required.
          </span>
        </div>
      </div>

      <div className="grid md:grid-cols-3 gap-6 md:gap-7 max-w-5xl mx-auto">
        {plans.map((plan) => (
          <div
            key={plan.name}
            className={`relative rounded-3xl p-7 sm:p-8 ${
              plan.highlighted
                ? 'bg-klassrun-navy text-white shadow-hero md:scale-[1.03]'
                : 'bg-white border border-soft shadow-xs'
            }`}
          >
            {plan.badge && (
              <div className="absolute -top-3 left-1/2 -translate-x-1/2">
                <span className="inline-block rounded-full bg-primary px-3.5 py-1 text-[11px] font-bold text-primary-foreground tracking-wide shadow-soft">
                  {plan.badge}
                </span>
              </div>
            )}

            <div className="mb-6">
              <h3 className={`text-base font-bold ${plan.highlighted ? 'text-white' : 'text-foreground'}`}>
                {plan.name}
              </h3>
              <p className={`mt-1.5 text-sm leading-relaxed ${plan.highlighted ? 'text-white/65' : 'text-muted-foreground'}`}>
                {plan.description}
              </p>
            </div>

            <div className="mb-8 flex items-baseline gap-2">
              <span className={`text-2xl font-bold ${plan.highlighted ? 'text-white' : 'text-foreground'}`}>
                Coming soon
              </span>
              <span className={`text-sm ${plan.highlighted ? 'text-white/55' : 'text-muted-foreground'}`}>
                per term
              </span>
            </div>

            <ul className="space-y-3 mb-8">
              {plan.features.map((feature) => (
                <li key={feature.text} className="flex items-start gap-3">
                  <span
                    className={`mt-0.5 flex-shrink-0 h-4 w-4 rounded-full flex items-center justify-center ${
                      plan.highlighted ? 'bg-primary/25' : 'bg-primary/10'
                    }`}
                  >
                    <Check size={10} className={plan.highlighted ? 'text-klassrun-green-light' : 'text-primary'} strokeWidth={3.5} />
                  </span>
                  <span className={`text-sm leading-relaxed flex-1 ${plan.highlighted ? 'text-white/80' : 'text-muted-foreground'}`}>
                    {feature.text}
                    {feature.soon && (
                      <span
                        className={`ml-2 inline-block rounded-full px-2 py-0.5 text-[10px] font-bold tracking-wide ${
                          plan.highlighted ? 'bg-white/15 text-white/80' : 'bg-foreground/8 text-foreground/65'
                        }`}
                      >
                        Soon
                      </span>
                    )}
                  </span>
                </li>
              ))}
            </ul>

            <a
              href={plan.ctaHref}
              className={`block w-full text-center rounded-full px-6 py-3 text-sm font-bold transition-colors duration-300 ${
                plan.highlighted
                  ? 'bg-primary text-primary-foreground hover:bg-klassrun-green-dark'
                  : 'bg-klassrun-navy text-white hover:bg-klassrun-navy-light'
              }`}
            >
              {plan.cta}
            </a>
          </div>
        ))}
      </div>

      <div className="mt-12 sm:mt-14 text-center max-w-2xl mx-auto">
        <p className="text-sm text-muted-foreground leading-relaxed">
          Larger school or multi-campus group?{' '}
          <a href="mailto:info@klassrun.com" className="text-primary font-bold hover:underline underline-offset-4">
            Contact us
          </a>{' '}
          — we’ll quote and plan with you directly.
        </p>
      </div>
    </Section>
  )
}
H_PRICING
echo "  wrote components/Pricing.jsx"

# --------------------------------------------- components/Testimonials.jsx
cat > components/Testimonials.jsx << 'H_TESTI'
import { Quote, ArrowRight } from 'lucide-react'
import { Section, SectionHeader } from './ui/Section'

// PLACEHOLDER — replace with real quotes from real schools before launch.
// These render exactly as written, so the bracketed text cannot be mistaken
// for a genuine testimonial. Do NOT invent names here.
const quotes = [
  {
    quote: '[PLACEHOLDER — real quote from a pilot school goes here]',
    name: '[Name Surname]',
    role: '[Role, School]',
  },
  {
    quote: '[PLACEHOLDER — real quote from a teacher goes here]',
    name: '[Name Surname]',
    role: '[Role, School]',
  },
  {
    quote: '[PLACEHOLDER — real quote from a school owner goes here]',
    name: '[Name Surname]',
    role: '[Role, School]',
  },
]

export default function Testimonials() {
  return (
    <Section id="testimonials" surface="mint">
      <SectionHeader title="What schools are saying" />

      <div className="flex gap-5 overflow-x-auto no-scrollbar snap-x snap-mandatory pb-2 -mx-5 px-5 sm:mx-0 sm:px-0">
        {quotes.map((q) => (
          <figure
            key={q.quote}
            className="snap-start flex-shrink-0 w-[85%] sm:w-[420px] rounded-3xl bg-white p-7 sm:p-8 shadow-soft"
          >
            <Quote size={22} className="text-primary mb-4" fill="currentColor" strokeWidth={0} />
            <blockquote className="text-sm sm:text-[15px] text-foreground/85 leading-relaxed">
              {q.quote}
            </blockquote>
            <figcaption className="mt-5 text-sm italic text-muted-foreground">
              — {q.name}, {q.role}
            </figcaption>
          </figure>
        ))}
      </div>

      <div className="mt-10 flex flex-col sm:flex-row items-center justify-center gap-3">
        <a
          href="https://app.klassrun.com/signup"
          className="group w-full sm:w-auto inline-flex items-center justify-center gap-2 rounded-full bg-primary px-7 py-3.5 text-sm font-bold text-primary-foreground hover:bg-klassrun-green-dark transition-colors duration-300"
        >
          Start Free Trial
          <ArrowRight size={16} className="transition-transform duration-300 group-hover:translate-x-0.5" />
        </a>
        <a
          href="mailto:info@klassrun.com"
          className="w-full sm:w-auto inline-flex items-center justify-center rounded-full border border-soft bg-white px-7 py-3.5 text-sm font-bold text-foreground hover:bg-secondary transition-colors duration-300"
        >
          Talk to us
        </a>
      </div>
    </Section>
  )
}
H_TESTI
echo "  wrote components/Testimonials.jsx"

# ------------------------------------------------------ components/FAQ.jsx
cat > components/FAQ.jsx << 'H_FAQ'
'use client'

import { useState } from 'react'
import { ChevronDown } from 'lucide-react'
import { Section, SectionHeader } from './ui/Section'

const faqs = [
  {
    q: 'What does Klassrun do?',
    a: 'Klassrun runs your school’s academics and records from one place. Teachers generate lesson notes, schemes of work and WAEC-style exam questions; the school manages results, report cards, attendance, behaviour, promotions and fees — all under one account with separate roles for owners, teachers and bursars.',
  },
  {
    q: 'How much does Klassrun cost?',
    a: 'Plans are billed per term — Starter, Standard and Premium — because that’s how Nigerian schools budget. Final amounts are being announced soon. The 14-day free trial is open now, no card required, so you can try everything before pricing lands.',
  },
  {
    q: 'How do we get started?',
    a: 'The admin creates the school account, sets up classes and subjects, and invites teachers — it takes under ten minutes. Teachers can start generating lesson notes the same day. No training sessions, no setup fee.',
  },
  {
    q: 'Is the content aligned to the Nigerian curriculum?',
    a: 'Yes. Lesson notes and schemes follow NERDC topics for each class, subject and term, and exam questions come in WAEC, NECO and BECE style with marking guides.',
  },
  {
    q: 'Which features are live right now?',
    a: 'Live today: lesson notes, schemes of work, exam questions, the school question bank, results and report card printing, attendance and behaviour records, promotions, and fee tracking with a bursar role. Coming soon: the parent and student portal, CBT exams, online fee payments through Paystack, and WhatsApp notifications.',
  },
  {
    q: 'How is this different from just using ChatGPT?',
    a: 'A chatbot answers one person, then forgets. Klassrun is built for the whole school: the curriculum for each class and term is already loaded, every note and question is saved into a bank your school owns and reuses for years, and the same system handles results, report cards, attendance and fees — things a chatbot can’t do.',
  },
  {
    q: 'Do I need to install anything?',
    a: 'No. Klassrun runs in the browser on any device — laptop, tablet or phone — and can be installed to your home screen like an app.',
  },
  {
    q: 'Is my school’s data private?',
    a: 'Yes. Every school operates in its own isolated space — your students, results, fee records and question bank are never shared with another school. The details are in our Privacy Policy, linked in the footer.',
  },
  {
    q: 'Can my bursar use it without seeing teaching tools?',
    a: 'Yes. Klassrun has separate roles: owners and admins see the whole school, teachers see their classes and content tools, and bursars get their own login focused on fees.',
  },
  {
    q: 'What happens after the free trial?',
    a: 'You pick a plan and continue — nothing is deleted. Everything your teachers created during the trial stays in your school’s account.',
  },
]

export default function FAQ() {
  const [open, setOpen] = useState(0)

  return (
    <Section id="faq" surface="white">
      <SectionHeader title="Frequently asked questions" />
      <div className="max-w-3xl mx-auto">
        {faqs.map((f, i) => {
          const isOpen = open === i
          return (
            <div key={f.q} className="border-b border-soft">
              <button
                onClick={() => setOpen(isOpen ? -1 : i)}
                aria-expanded={isOpen}
                className="w-full flex items-center justify-between gap-4 text-left py-5"
              >
                <span className="text-base sm:text-lg font-bold text-foreground">{f.q}</span>
                <ChevronDown
                  size={20}
                  className={`flex-shrink-0 text-foreground/50 transition-transform duration-300 ${
                    isOpen ? 'rotate-180' : ''
                  }`}
                />
              </button>
              <div
                className={`overflow-hidden transition-all duration-300 ${
                  isOpen ? 'max-h-[480px] pb-5' : 'max-h-0'
                }`}
              >
                <p className="text-sm sm:text-base text-muted-foreground leading-relaxed pr-8">
                  {f.a}
                </p>
              </div>
            </div>
          )
        })}
      </div>
    </Section>
  )
}
H_FAQ
echo "  wrote components/FAQ.jsx"

# --------------------------------------------------- components/Footer.jsx
cat > components/Footer.jsx << 'H_FOOTER'
import Image from 'next/image'
import Link from 'next/link'
import { Mail, MapPin } from 'lucide-react'

function InstagramIcon({ size = 16 }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <rect width="20" height="20" x="2" y="2" rx="5" ry="5" />
      <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z" />
      <line x1="17.5" x2="17.51" y1="6.5" y2="6.5" />
    </svg>
  )
}

function LinkedInIcon({ size = 16 }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z" />
      <rect width="4" height="12" x="2" y="9" />
      <circle cx="4" cy="4" r="2" />
    </svg>
  )
}

function TikTokIcon({ size = 16 }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor">
      <path d="M19.59 6.69a4.83 4.83 0 0 1-3.77-4.25V2h-3.45v13.67a2.89 2.89 0 0 1-5.2 1.74 2.89 2.89 0 0 1 2.31-4.64c.3 0 .58.05.85.13V9.4a6.33 6.33 0 0 0-.85-.06 6.34 6.34 0 1 0 6.34 6.34V8.74a8.16 8.16 0 0 0 4.77 1.52v-3.45a4.85 4.85 0 0 1-1-.12z" />
    </svg>
  )
}

const columns = [
  {
    title: 'Product',
    links: [
      { label: 'Features', href: '#features' },
      { label: 'Pricing', href: '#pricing' },
      { label: 'FAQ', href: '#faq' },
    ],
  },
  {
    title: 'Company',
    links: [
      { label: 'Contact us', href: 'mailto:info@klassrun.com' },
      { label: 'Sign in', href: 'https://app.klassrun.com' },
      { label: 'Get started', href: 'https://app.klassrun.com/signup' },
    ],
  },
  {
    title: 'Legal',
    links: [
      { label: 'Privacy Policy', href: '/privacy', internal: true },
      { label: 'Terms of Service', href: '/terms', internal: true },
    ],
  },
]

export default function Footer() {
  const year = new Date().getFullYear()

  return (
    <footer className="bg-secondary/30 border-t border-subtle">
      <div className="mx-auto w-full max-w-6xl px-5 sm:px-6 lg:px-8 pt-14 pb-8 md:pt-16">
        {/* Centered logo + tagline */}
        <div className="text-center">
          <Image
            src="/images/logo.webp"
            alt="Klassrun"
            width={120}
            height={90}
            className="mx-auto h-14 w-auto"
            unoptimized
          />
          <p className="mt-2 text-xs text-muted-foreground">Built for Nigerian schools</p>
        </div>

        {/* Link columns + contact */}
        <div className="mt-12 grid grid-cols-2 md:grid-cols-12 gap-x-6 gap-y-10">
          {columns.map((col) => (
            <div key={col.title} className="md:col-span-2">
              <h4 className="text-sm font-bold text-foreground mb-4">{col.title}</h4>
              <ul className="space-y-3">
                {col.links.map((link) => (
                  <li key={link.label}>
                    {link.internal ? (
                      <Link
                        href={link.href}
                        className="text-sm text-muted-foreground hover:text-primary transition-colors duration-300"
                      >
                        {link.label}
                      </Link>
                    ) : (
                      <a
                        href={link.href}
                        className="text-sm text-muted-foreground hover:text-primary transition-colors duration-300"
                      >
                        {link.label}
                      </a>
                    )}
                  </li>
                ))}
              </ul>
            </div>
          ))}

          <div className="col-span-2 md:col-span-6 md:text-right">
            <div className="flex md:justify-end items-center gap-5 mb-5">
              <a
                href="https://www.instagram.com/klassrun/"
                target="_blank"
                rel="noopener noreferrer"
                aria-label="Instagram"
                className="text-foreground/40 hover:text-primary transition-colors duration-300"
              >
                <InstagramIcon size={18} />
              </a>
              <a
                href="https://www.linkedin.com/in/klassrun-ng-33013b400/"
                target="_blank"
                rel="noopener noreferrer"
                aria-label="LinkedIn"
                className="text-foreground/40 hover:text-primary transition-colors duration-300"
              >
                <LinkedInIcon size={18} />
              </a>
              <a
                href="https://www.tiktok.com/@afeez_can_code"
                target="_blank"
                rel="noopener noreferrer"
                aria-label="TikTok"
                className="text-foreground/40 hover:text-primary transition-colors duration-300"
              >
                <TikTokIcon size={18} />
              </a>
            </div>
            <p className="flex md:justify-end items-center gap-2 text-sm text-muted-foreground">
              <MapPin size={14} /> Lagos, Nigeria
            </p>
            <a
              href="mailto:info@klassrun.com"
              className="mt-2 flex md:justify-end items-center gap-2 text-sm text-muted-foreground hover:text-primary transition-colors duration-300"
            >
              <Mail size={14} /> info@klassrun.com
            </a>
            <p className="mt-2 text-xs text-muted-foreground/70">
              Klassrun Technologies Ltd · RC 9463863
            </p>
          </div>
        </div>

        {/* Copyright pill */}
        <div className="mt-12 flex justify-center">
          <div className="rounded-full bg-white shadow-soft px-6 py-3 flex flex-wrap items-center justify-center gap-x-6 gap-y-1 text-xs text-muted-foreground">
            <span>© {year} Klassrun Technologies Ltd. All rights reserved</span>
            <Link href="/privacy" className="hover:text-primary transition-colors duration-300">
              Privacy policy
            </Link>
            <Link href="/terms" className="hover:text-primary transition-colors duration-300">
              Terms of service
            </Link>
          </div>
        </div>
      </div>
    </footer>
  )
}
H_FOOTER
echo "  wrote components/Footer.jsx"

# -------------------------------------------------- app/privacy/page.jsx
cat > app/privacy/page.jsx << 'H_PRIVACY'
// DRAFT — written from how Klassrun actually works today. Have a lawyer
// review before relying on it, especially around students' records (NDPA).
import Image from 'next/image'
import Link from 'next/link'

export const metadata = {
  title: 'Privacy Policy',
  description: 'How Klassrun collects, uses and protects information for schools, staff and students.',
}

const H2 = ({ children }) => (
  <h2 className="mt-10 mb-3 text-xl font-bold text-foreground">{children}</h2>
)
const P = ({ children }) => (
  <p className="mb-4 text-sm leading-relaxed text-muted-foreground">{children}</p>
)
const LI = ({ children }) => (
  <li className="mb-2 text-sm leading-relaxed text-muted-foreground">{children}</li>
)

export default function PrivacyPage() {
  return (
    <main className="bg-white min-h-screen">
      <div className="border-b border-subtle">
        <div className="mx-auto w-full max-w-3xl px-5 h-16 flex items-center justify-between">
          <Link href="/">
            <Image src="/images/logo-nav.webp" alt="Klassrun" width={100} height={34} className="h-7 w-auto" unoptimized />
          </Link>
          <Link href="/" className="text-sm font-bold text-primary hover:underline underline-offset-4">
            Back to klassrun.com
          </Link>
        </div>
      </div>

      <article className="mx-auto w-full max-w-3xl px-5 py-12 md:py-16">
        <h1 className="text-3xl font-extrabold text-foreground">Privacy Policy</h1>
        <p className="mt-2 text-xs text-muted-foreground">Last updated: June 2026</p>

        <H2>Who we are</H2>
        <P>
          Klassrun is operated by Klassrun Technologies Ltd (RC 9463863), Lagos, Nigeria. We build
          school management software for Nigerian schools. This policy covers our website
          (klassrun.com) and the Klassrun application (app.klassrun.com).
        </P>

        <H2>Information we collect</H2>
        <P>We only hold the information needed to run the service:</P>
        <ul className="list-disc pl-5 mb-4">
          <LI>
            <strong className="text-foreground">School and staff details</strong> — the school’s
            name, and the names, email addresses and roles of staff accounts the school creates
            (owner, teacher, bursar).
          </LI>
          <LI>
            <strong className="text-foreground">Student academic records entered by the school</strong>{' '}
            — student names, classes, scores, attendance, behaviour assessments, promotion records
            and fee status. The school enters and controls this information; we process it on the
            school’s behalf.
          </LI>
          <LI>
            <strong className="text-foreground">Content the school creates</strong> — lesson notes,
            schemes of work and exam questions generated or edited in the app, stored in the
            school’s own private space.
          </LI>
          <LI>
            <strong className="text-foreground">Basic technical logs</strong> — standard records of
            requests to our servers, used for security and to keep the service running.
          </LI>
        </ul>
        <P>
          Our marketing website does not run advertising trackers or analytics cookies. The
          application uses only the cookies needed to keep you signed in.
        </P>

        <H2>How we use information</H2>
        <ul className="list-disc pl-5 mb-4">
          <LI>To provide the service: generating content, computing results, printing report cards, tracking attendance and fees.</LI>
          <LI>To support schools when they contact us.</LI>
          <LI>To keep the service secure and improve how it works.</LI>
        </ul>
        <P>We do not sell personal information, and we do not show ads.</P>

        <H2>Students’ information</H2>
        <P>
          Students’ records belong to the school. The school decides what to enter and who in the
          school can see it; Klassrun processes those records only on the school’s instructions. We
          handle personal information in line with the Nigeria Data Protection Act, 2023. Schools
          remain responsible for having the authority to enter their students’ information.
        </P>

        <H2>Where information is stored and how it is protected</H2>
        <P>
          Information is stored with reputable cloud hosting providers. Each school operates in its
          own isolated space — one school’s students, results, fee records and question bank are
          never visible to another school. Access within a school is controlled by roles set by the
          school’s owner or admin.
        </P>

        <H2>Sharing</H2>
        <P>
          We share information only with the service providers needed to run Klassrun (such as
          hosting and email providers), or where the law requires it. Nothing is shared for
          advertising.
        </P>

        <H2>Your choices</H2>
        <P>
          Staff and parents should direct requests about records to their school, which controls
          them. Schools can request access to, correction of, or deletion of their account and its
          records by emailing{' '}
          <a href="mailto:info@klassrun.com" className="text-primary font-semibold hover:underline">
            info@klassrun.com
          </a>
          . When a school’s account is deleted, its records are removed from the live service.
        </P>

        <H2>Changes to this policy</H2>
        <P>
          If we change this policy, we will update this page and the date above. Significant changes
          will be communicated to schools directly.
        </P>

        <H2>Contact</H2>
        <P>
          Questions about privacy: email{' '}
          <a href="mailto:info@klassrun.com" className="text-primary font-semibold hover:underline">
            info@klassrun.com
          </a>{' '}
          — Klassrun Technologies Ltd, Lagos, Nigeria.
        </P>
      </article>
    </main>
  )
}
H_PRIVACY
echo "  wrote app/privacy/page.jsx"

# ---------------------------------------------------- app/terms/page.jsx
cat > app/terms/page.jsx << 'H_TERMS'
// DRAFT — written from how Klassrun actually works today. Have a lawyer
// review before relying on it.
import Image from 'next/image'
import Link from 'next/link'

export const metadata = {
  title: 'Terms of Service',
  description: 'The terms that govern use of Klassrun by schools and their staff.',
}

const H2 = ({ children }) => (
  <h2 className="mt-10 mb-3 text-xl font-bold text-foreground">{children}</h2>
)
const P = ({ children }) => (
  <p className="mb-4 text-sm leading-relaxed text-muted-foreground">{children}</p>
)

export default function TermsPage() {
  return (
    <main className="bg-white min-h-screen">
      <div className="border-b border-subtle">
        <div className="mx-auto w-full max-w-3xl px-5 h-16 flex items-center justify-between">
          <Link href="/">
            <Image src="/images/logo-nav.webp" alt="Klassrun" width={100} height={34} className="h-7 w-auto" unoptimized />
          </Link>
          <Link href="/" className="text-sm font-bold text-primary hover:underline underline-offset-4">
            Back to klassrun.com
          </Link>
        </div>
      </div>

      <article className="mx-auto w-full max-w-3xl px-5 py-12 md:py-16">
        <h1 className="text-3xl font-extrabold text-foreground">Terms of Service</h1>
        <p className="mt-2 text-xs text-muted-foreground">Last updated: June 2026</p>

        <H2>1. Agreement</H2>
        <P>
          These terms are an agreement between Klassrun Technologies Ltd (RC 9463863, Lagos,
          Nigeria) and the school that creates a Klassrun account. By creating an account or using
          Klassrun, the school accepts these terms.
        </P>

        <H2>2. The service</H2>
        <P>
          Klassrun is school management software. It generates lesson notes, schemes of work and
          exam questions, and manages results, report cards, attendance, behaviour, promotions and
          fee records. Some features are marked “coming soon” and become available as they are
          released.
        </P>

        <H2>3. Accounts and roles</H2>
        <P>
          The school’s owner or admin creates the account and invites staff. Each person is
          responsible for keeping their login details private. The school is responsible for the
          actions taken under its accounts and for removing access when staff leave.
        </P>

        <H2>4. The school’s responsibilities</H2>
        <P>
          The school confirms it has the authority to enter the information it adds to Klassrun,
          including students’ records. Generated lesson notes, schemes and exam questions are
          drafts: a qualified teacher must review and approve them before they are used in a
          classroom or an examination. The school remains responsible for the accuracy of its
          records, results and report cards.
        </P>

        <H2>5. Acceptable use</H2>
        <P>
          Klassrun is for legitimate school work. Accounts may not be used to break the law, to
          attempt to access another school’s information, or to interfere with the service. We may
          suspend accounts that do.
        </P>

        <H2>6. Fees and billing</H2>
        <P>
          Plans are billed per term. Current amounts are communicated before any charge — there are
          no hidden fees. New accounts start with a 14-day free trial with no card required. If a
          school does not continue after the trial or a paid term, access is paused but records are
          not immediately deleted.
        </P>

        <H2>7. Ownership</H2>
        <P>
          The school owns its records and the content created in its account, including generated
          lesson notes and exam questions, for its own use. Klassrun Technologies Ltd owns the
          platform, its software and its design.
        </P>

        <H2>8. Availability and changes</H2>
        <P>
          We work to keep Klassrun available and reliable, but no online service can promise
          uninterrupted access. We may improve or change features over time; if a change materially
          reduces what a paid plan includes, schools will be informed in advance.
        </P>

        <H2>9. Liability</H2>
        <P>
          To the extent permitted by Nigerian law, Klassrun Technologies Ltd is not liable for
          indirect losses, and its total liability in connection with the service is limited to the
          amount the school paid for the service in the term in which the issue arose.
        </P>

        <H2>10. Ending the agreement</H2>
        <P>
          A school may stop using Klassrun and request deletion of its account at any time by
          emailing{' '}
          <a href="mailto:info@klassrun.com" className="text-primary font-semibold hover:underline">
            info@klassrun.com
          </a>
          . We may end the agreement for serious or repeated breach of these terms.
        </P>

        <H2>11. Governing law</H2>
        <P>These terms are governed by the laws of the Federal Republic of Nigeria.</P>

        <H2>12. Contact</H2>
        <P>
          Questions about these terms: email{' '}
          <a href="mailto:info@klassrun.com" className="text-primary font-semibold hover:underline">
            info@klassrun.com
          </a>
          .
        </P>
      </article>
    </main>
  )
}
H_TERMS
echo "  wrote app/terms/page.jsx"

# ---------------------------------------------------------------- deletions
say "Removing retired files"
for f in "${DELETE[@]}"; do
  rm "$f"
  echo "  removed $f"
done

# ---------------------------------------------------------------- build gate
say "Build gate: npm run build"
if ! npm run build; then
  restore_all
  die "Build FAILED. Repo restored from backup at $BACKUP — nothing was committed."
fi

# ------------------------------------------------------------- commit & push
say "Commit & push"
git add -A
git commit -m "Rebuild landing page: Afrilearn-style sections, Nunito, privacy & terms pages, framer-motion removed"
git push

say "DONE"
echo "Backup kept at: $BACKUP"
echo ""
echo "BEFORE LAUNCH, REVIEW:"
echo "  1. Testimonials + persona pull-quotes — bracketed PLACEHOLDERS render as-is"
echo "  2. Comparison table — confirm every competitor cell yourself"
echo "  3. Pricing tier feature split — I added Fees & bursar tools to Premium"
echo "  4. /privacy and /terms — drafts; get a legal review before signing schools"
