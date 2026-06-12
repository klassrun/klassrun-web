#!/usr/bin/env bash
# ============================================================================
# KLASSRUN-WEB POLISH 1 — run AFTER install-klassrun-web-redesign.sh
# Run from Git Bash:  bash install-klassrun-web-polish-1.sh
#
# Changes (all-or-nothing):
#   1. Testimonials → infinite auto-scrolling rail: ~3 cards visible on
#      desktop, loops continuously, pauses on hover, takes up to 15 quotes
#   2. Footer → social icons and column headers in Klassrun green
#   3. Navy lightened a notch (sections + pricing card + table column)
#      and boxes on navy made clearly visible
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
grep -q '"name": "klassrun-web"' package.json 2>/dev/null || die "This is not klassrun-web"
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || die "Not a git repository"
[ -n "$(git status --porcelain)" ] && die "Working tree not clean. Commit or stash first."

TARGETS=(
  app/globals.css
  components/Testimonials.jsx
  components/Footer.jsx
  components/WhyKlassrun.jsx
)
for f in "${TARGETS[@]}"; do
  [ -f "$f" ] || die "Expected file missing: $f — run the redesign installer first."
done
grep -q "no-scrollbar::-webkit-scrollbar" app/globals.css || die "globals.css is not the redesigned version."

# ------------------------------------------------------------------- backup
say "Backing up to $BACKUP"
mkdir -p "$BACKUP"
for f in "${TARGETS[@]}"; do
  mkdir -p "$BACKUP/$(dirname "$f")"
  cp "$f" "$BACKUP/$f"
done

restore_all() {
  printf '\n\033[1;33m!! Restoring repo from backup...\033[0m\n'
  ( cd "$BACKUP" && find . -type f ) | while read -r rel; do
    rel="${rel#./}"
    cp "$BACKUP/$rel" "$REPO/$rel"
  done
  printf '\033[1;33m!! Repo restored to pre-polish state.\033[0m\n'
}

# ------------------------------------------- patch globals.css (exact match)
say "Patching app/globals.css (lighter navy + marquee keyframes)"
if ! perl - app/globals.css << 'PLEOF'
use strict; use warnings;
my $path = shift;
open my $fh, '<', $path or die "open: $!";
binmode $fh;
local $/; my $src = <$fh>; close $fh;

my @patches = (
  ["    --color-klassrun-navy: oklch(0.22 0.025 255);",
   "    --color-klassrun-navy: oklch(0.27 0.03 255);"],
  ["    .no-scrollbar::-webkit-scrollbar { display: none; }",
   "    .no-scrollbar::-webkit-scrollbar { display: none; }\n\n"
   . "    /* Continuous testimonial rail */\n"
   . "    \@keyframes marquee {\n"
   . "        from { transform: translateX(0); }\n"
   . "        to { transform: translateX(-50%); }\n"
   . "    }"],
);

# verify ALL patches match exactly once BEFORE writing anything
for my $p (@patches) {
  my $count = () = $src =~ /\Q$p->[0]\E/g;
  die "PATCH TARGET FOUND $count TIMES (need exactly 1):\n$p->[0]\n" unless $count == 1;
}

for my $p (@patches) {
  my $i = index($src, $p->[0]);
  substr($src, $i, length($p->[0])) = $p->[1];
}

open my $out, '>', $path or die "write: $!";
binmode $out;
print {$out} $src;
close $out;
print "globals.css patched: navy oklch(0.27 0.03 255) + marquee keyframes\n";
PLEOF
then
  restore_all
  die "globals.css patch failed — repo restored, nothing committed."
fi

# --------------------------------------------- components/Testimonials.jsx
say "Writing components/Testimonials.jsx (infinite rail)"
cat > components/Testimonials.jsx << 'H_TESTI'
import { Quote, ArrowRight } from 'lucide-react'
import { Section, SectionHeader } from './ui/Section'

// PLACEHOLDER — replace with real quotes from real schools before launch.
// Add up to 15 entries; the rail scrolls continuously and loops on its own,
// showing about 3 cards at a time on desktop. Do NOT invent names here.
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
  // slower with more quotes so reading speed stays comfortable
  const duration = Math.max(30, quotes.length * 12)

  return (
    <Section id="testimonials" surface="mint" bleed>
      <div className="mx-auto w-full max-w-6xl px-5 sm:px-6 lg:px-8">
        <SectionHeader title="What schools are saying" />
      </div>

      {/* Full-width rail: two identical halves animate -50% for a seamless loop */}
      <div className="overflow-hidden" style={{ '--marquee-duration': `${duration}s` }}>
        <div className="flex w-max animate-[marquee_var(--marquee-duration)_linear_infinite] hover:[animation-play-state:paused]">
          {[0, 1].map((half) => (
            <div key={half} aria-hidden={half === 1} className="flex gap-5 pr-5">
              {quotes.map((q, i) => (
                <figure
                  key={`${half}-${i}`}
                  className="w-[300px] sm:w-[400px] flex-shrink-0 rounded-3xl bg-white p-7 sm:p-8 shadow-soft"
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
          ))}
        </div>
      </div>

      <div className="mx-auto w-full max-w-6xl px-5 sm:px-6 lg:px-8">
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
      </div>
    </Section>
  )
}
H_TESTI
echo "  wrote components/Testimonials.jsx"

# --------------------------------------------------- components/Footer.jsx
say "Writing components/Footer.jsx (green icons + headers)"
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
              <h4 className="text-sm font-bold text-primary mb-4">{col.title}</h4>
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
                className="text-primary hover:text-klassrun-green-dark transition-colors duration-300"
              >
                <InstagramIcon size={18} />
              </a>
              <a
                href="https://www.linkedin.com/in/klassrun-ng-33013b400/"
                target="_blank"
                rel="noopener noreferrer"
                aria-label="LinkedIn"
                className="text-primary hover:text-klassrun-green-dark transition-colors duration-300"
              >
                <LinkedInIcon size={18} />
              </a>
              <a
                href="https://www.tiktok.com/@afeez_can_code"
                target="_blank"
                rel="noopener noreferrer"
                aria-label="TikTok"
                className="text-primary hover:text-klassrun-green-dark transition-colors duration-300"
              >
                <TikTokIcon size={18} />
              </a>
            </div>
            <p className="flex md:justify-end items-center gap-2 text-sm text-muted-foreground">
              <MapPin size={14} className="text-primary" /> Lagos, Nigeria
            </p>
            <a
              href="mailto:info@klassrun.com"
              className="mt-2 flex md:justify-end items-center gap-2 text-sm text-muted-foreground hover:text-primary transition-colors duration-300"
            >
              <Mail size={14} className="text-primary" /> info@klassrun.com
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

# ------------------------------------------------ components/WhyKlassrun.jsx
say "Writing components/WhyKlassrun.jsx (visible boxes on navy)"
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
            <span className="flex-shrink-0 h-12 w-12 rounded-xl bg-white/15 ring-1 ring-white/25 flex items-center justify-center">
              <c.icon size={21} className="text-klassrun-green-light" />
            </span>
            <div>
              <h3 className="text-base sm:text-lg font-bold text-white">{c.title}</h3>
              <p className="mt-1.5 text-sm text-white/75 leading-relaxed">{c.body}</p>
            </div>
          </div>
        ))}
      </div>
    </Section>
  )
}
H_WHY
echo "  wrote components/WhyKlassrun.jsx"

# ---------------------------------------------------------------- build gate
say "Build gate: npm run build"
if ! npm run build; then
  restore_all
  die "Build FAILED. Repo restored from backup at $BACKUP — nothing was committed."
fi

# ------------------------------------------------------------- commit & push
say "Commit & push"
git add -A
git commit -m "Polish: infinite testimonial rail, green footer accents, lighter navy with visible boxes"
git push

say "DONE"
echo "Backup kept at: $BACKUP"
