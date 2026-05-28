# Klassrun Web

> The marketing site for **Klassrun** — the AI-powered school operating system for Nigerian schools.

Served at [klassrun.com](https://klassrun.com). This is what principals, journalists, investors, and the Nigerian Google index see when they discover Klassrun. The CTA leads to `app.klassrun.com/signup`.

This repo is **separate** from the application (`klassrun-app`) and the API (`klassrun-api`). It has no auth, no API calls, no per-user state — pure static marketing pages built once at deploy time.

---

## Table of contents

- [What this is](#what-this-is)
- [Tech stack](#tech-stack)
- [Project structure](#project-structure)
- [Quick start (local dev)](#quick-start-local-dev)
- [Environment variables](#environment-variables)
- [Editing content](#editing-content)
- [Brand](#brand)
- [SEO & social](#seo--social)
- [Deployment (Cloudflare Pages)](#deployment-cloudflare-pages)
- [License](#license)

---

## What this is

Klassrun ships in three independently deployable repos:

| Repo | Domain | Hosting | Role |
|---|---|---|---|
| **`klassrun-web`** _(this)_ | klassrun.com | Cloudflare Pages | Marketing site, SEO, lead capture |
| `klassrun-app` | app.klassrun.com | Vercel | School portal — login, dashboard, AI features |
| `klassrun-api` | klassrun-api.onrender.com | Render | Backend, AI, billing, email |

This repo doesn't talk to the API directly. The signup CTA is a plain `<a href="https://app.klassrun.com/signup">` link.

---

## Tech stack

- **Framework:** Next.js 16 (App Router)
- **UI:** React 19, shadcn/ui, Tailwind CSS v4
- **Animation:** framer-motion (`framer-motion@11`)
- **Icons:** lucide-react
- **Hosting:** Cloudflare Pages

---

## Project structure

```
klassrun-web/
├── app/                        # Next.js App Router pages
│   ├── layout.tsx              # Root layout, metadata, OG tags
│   ├── globals.css             # Tailwind + brand tokens
│   ├── page.tsx                # Homepage
│   └── ...                     # Marketing sub-pages
│
├── components/                 # Page sections, hero, features, footer
│
├── lib/                        # Utility helpers (cn, etc.)
│
├── public/                     # Static assets — images, logo, favicons, llms.txt, robots.txt
│
├── out/                        # Static export output (after `npm run build`)
│
├── components.json             # shadcn/ui config
├── next.config.ts
├── tsconfig.json
├── package.json
└── README.md
```

---

## Quick start (local dev)

### Prerequisites

- Node 20+, npm 10+

### 1. Install

```bash
npm install
```

### 2. Start

```bash
npm run dev
```

Open http://localhost:3000.

> If you're also running klassrun-app locally, it'll already be on port 3000. Run web on a different port:
>
> ```bash
> PORT=3002 npm run dev
> ```

### 3. Build

```bash
npm run build
```

Output is statically exported to `out/` and uploaded to Cloudflare Pages on push.

---

## Environment variables

This repo currently has **no required env vars**. It's a fully static marketing site — no API calls, no analytics integration with secrets, no auth.

If you add analytics or an embedded form, document the env var here and in a `.env.example` file at the root.

---

## Editing content

Marketing copy is hand-written into the components in `app/` and `components/`. There's no CMS — keep it that way until you have multiple non-developers needing to publish.

### Adding a page

Next.js App Router convention:

```
app/about/page.tsx       → /about
app/pricing/page.tsx     → /pricing
app/blog/[slug]/page.tsx → /blog/<slug>  (if you add blog later)
```

Each `page.tsx` is a server component by default. Add `'use client'` only if you need state or browser APIs.

### Updating the homepage hero

Find the hero in `app/page.tsx` (or wherever it currently lives). Edit copy directly. Keep it outcome-led:

- ✅ "Stop spending Sunday nights writing lesson notes for Monday"
- ❌ "AI lesson note generator"

See `Klassrun-Roadmap.md` (in the parent project knowledge) for the full positioning rules.

---

## Brand

The Klassrun palette is wired into Tailwind via CSS variables in `globals.css`:

- **Primary green:** `#3DB54A` (used for CTAs, highlights, success states)
- **Navy:** `#1A2332` (used for body text, headings, dark surfaces)

Use `text-primary`, `bg-primary`, etc. as you would normally in shadcn — the tokens are already mapped.

Fonts: Fraunces (display) + Geist (body) — loaded via `next/font`.

---

## SEO & social

- `app/layout.tsx` defines default `<title>`, `<meta>`, and Open Graph tags for the whole site. Per-page metadata overrides via `export const metadata = { ... }`.
- `public/robots.txt` lets crawlers in.
- `public/llms.txt` exists to help LLM search tools (Perplexity, ChatGPT, Claude) understand the product when users research school operating systems. Worth keeping current.
- Google Search Console is connected to klassrun.com.

---

## Deployment (Cloudflare Pages)

Production: **Cloudflare Pages**. Auto-deploys from the `main` branch on GitHub push.

### Cloudflare configuration

1. **Cloudflare dashboard** → Workers & Pages → klassrun-web
2. **Settings → Builds & deployments:**
   - Framework preset: Next.js (static export)
   - Build command: `npm run build`
   - Build output directory: `out`
3. **Settings → Custom domains:** `klassrun.com` (apex) + `www.klassrun.com` (redirect to apex)

### Why Cloudflare Pages and not Vercel

The marketing site is statically exported (`out/`) — pure HTML/CSS/JS, no Functions needed. Cloudflare Pages serves static assets faster than Vercel's edge for African traffic, and the free tier has no bandwidth cap. The app (`klassrun-app`) does need Route Handlers and runs on Vercel for that reason.

### Local build matches production

```bash
npm run build
npx serve out
```

This previews exactly what Cloudflare will serve. Useful for catching pre-render issues before pushing.

---

## License

UNLICENSED — © Klassrun Technologies Ltd. All rights reserved.

---

## Contact

- **Website:** [klassrun.com](https://klassrun.com)
- **Email:** info@klassrun.com
- **Company:** Klassrun Technologies Ltd · RC 9463863 · Lagos, Nigeria
