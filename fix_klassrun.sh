#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────
#  fix_klassrun.sh
#  Run from the ROOT of your klassrun-refactored project:
#
#    bash fix_klassrun.sh
#
#  What it does:
#    - Rewrites navbar & hero with full semantic HTML (all sections too)
#    - Switches fonts to Inter + Plus Jakarta Sans
#    - Fixes navbar CSS (mobile-first, logo display, hamburger)
#    - Fixes hero CSS (two-column flex, left text + right SVG illustration)
#    - Adds hero capability pills + updated copy (web app, mobile app)
#    - Adds 404.html and offline.html
#    - Updates vercel.json (rewrites, headers, security)
#    - Updates tokens, base, responsive CSS
#    - Fixes navbar.js (hidden attr toggle, aria, Esc key)
#    - Commits with a clean conventional commit message
# ─────────────────────────────────────────────────────────────────
set -e

ROOT="$(pwd)"

echo "→ Running from: $ROOT"
echo ""

# Sanity check — make sure we're in the right place
if [ ! -f "$ROOT/index.html" ] || [ ! -d "$ROOT/components" ]; then
  echo "❌  Cannot find index.html or components/ folder."
  echo "    Make sure you're running this from your project root."
  exit 1
fi

# ─── css/tokens.css ──────────────────────────────────────────────
cat > "$ROOT/css/tokens.css" << 'EOF'
/* tokens.css — design tokens, single source of truth */
:root {
  /* Brand */
  --green:         #3DB54A;
  --green-dark:    #2a8a35;
  --green-deeper:  #1f6b28;
  --green-light:   #eafbec;
  --green-mid:     #b8eabd;

  /* Neutrals */
  --charcoal:      #0f1117;
  --charcoal-2:    #181c23;
  --charcoal-3:    #1e232c;
  --muted:         #64748b;
  --muted-light:   #94a3b8;
  --off-white:     #f6f8f7;
  --white:         #ffffff;

  /* Borders */
  --border:        rgba(61,181,74,0.13);
  --border-soft:   rgba(0,0,0,0.07);

  /* Radii */
  --radius-sm:     8px;
  --radius:        14px;
  --radius-lg:     22px;

  /* Shadows */
  --shadow:        0 4px 24px rgba(0,0,0,0.07);
  --shadow-green:  0 8px 32px rgba(61,181,74,0.18);

  /* Fonts — Inter (body) + Plus Jakarta Sans (display) */
  --font-display:  'Plus Jakarta Sans', sans-serif;
  --font-body:     'Inter', sans-serif;

  /* Layout */
  --max-width:     1160px;
  --px:            clamp(1.25rem, 5vw, 5rem);

  /* Motion */
  --transition:    all 0.22s ease;
}
EOF
echo "  ✓ css/tokens.css"

# ─── css/base.css ────────────────────────────────────────────────
cat > "$ROOT/css/base.css" << 'EOF'
/* base.css — body, typography, layout utilities */
body {
  font-family: var(--font-body);
  background: var(--white);
  color: var(--charcoal);
  overflow-x: hidden;
  line-height: 1.6;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

.container {
  max-width: var(--max-width);
  margin: 0 auto;
  padding: 0 var(--px);
}

.section    { padding: 4.5rem 0; }
.section-sm { padding: 3rem 0; }

.d     { font-family: var(--font-display); }
.green { color: var(--green); }

/* Section header */
.section-header { text-align: center; margin-bottom: 3rem; }

.sec-label {
  display: inline-block;
  color: var(--green);
  font-family: var(--font-body);
  font-size: 0.72rem;
  font-weight: 700;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  margin-bottom: 0.6rem;
}

.sec-title {
  font-family: var(--font-display);
  font-weight: 800;
  font-size: clamp(1.55rem, 3.5vw, 2.4rem);
  line-height: 1.15;
  letter-spacing: -0.6px;
  margin-bottom: 0.75rem;
}

.sec-sub {
  font-size: 0.975rem;
  color: var(--muted);
  max-width: 52ch;
  margin: 0 auto;
  line-height: 1.75;
}

/* Shared pill row */
.pill-row { display: flex; flex-wrap: wrap; gap: 0.5rem; margin-top: 1.25rem; }
.pill {
  background: var(--green-light);
  color: var(--green-dark);
  border: 1px solid var(--green-mid);
  font-size: 0.72rem;
  font-weight: 600;
  padding: 0.28rem 0.75rem;
  border-radius: 99px;
}

/* Shared buttons */
.btn {
  display: inline-flex;
  align-items: center;
  gap: 0.4rem;
  font-family: var(--font-body);
  font-weight: 500;
  text-decoration: none;
  cursor: pointer;
  border: none;
  transition: var(--transition);
  white-space: nowrap;
}
.btn-ghost {
  padding: 0.5rem 1rem;
  border-radius: var(--radius-sm);
  border: 1.5px solid var(--border-soft);
  background: transparent;
  color: var(--charcoal);
  font-size: 0.875rem;
}
.btn-ghost:hover { border-color: var(--green); color: var(--green); }

.btn-primary {
  padding: 0.55rem 1.15rem;
  border-radius: var(--radius-sm);
  background: var(--green);
  color: #fff;
  font-size: 0.875rem;
  font-weight: 600;
}
.btn-primary:hover { background: var(--green-dark); transform: translateY(-1px); }
EOF
echo "  ✓ css/base.css"

# ─── css/navbar.css ──────────────────────────────────────────────
cat > "$ROOT/css/navbar.css" << 'EOF'
/* navbar.css — mobile-first sticky header */

.nav {
  position: sticky;
  top: 0;
  z-index: 999;
  background: rgba(255,255,255,0.97);
  backdrop-filter: blur(14px);
  -webkit-backdrop-filter: blur(14px);
  border-bottom: 1px solid var(--border);
}

.nav-inner {
  max-width: var(--max-width);
  margin: 0 auto;
  padding: 0 var(--px);
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 64px;
  gap: 1rem;
}

/* Logo */
.nav-logo {
  display: flex;
  flex-direction: column;
  gap: 1px;
  text-decoration: none;
  flex-shrink: 0;
}
.nav-logo-img {
  height: 38px;
  width: auto;
  object-fit: contain;
  display: block;
}
.nav-logo-wordmark {
  font-family: var(--font-display);
  font-weight: 800;
  font-size: 1.05rem;
  letter-spacing: -0.3px;
  line-height: 1;
  display: flex;
  align-items: baseline;
}
.logo-k { color: var(--charcoal); }
.logo-t { color: var(--green); }

.nav-logo-sub {
  font-family: var(--font-body);
  font-size: 0.56rem;
  color: var(--muted);
  font-weight: 400;
  letter-spacing: 0.06em;
  text-transform: uppercase;
  line-height: 1;
}

/* Desktop nav links — hidden on mobile */
.nav-links { display: none; }
.nav-links ul {
  display: flex;
  align-items: center;
  gap: 0;
  list-style: none;
  margin: 0;
  padding: 0;
}
.nav-links a {
  font-family: var(--font-body);
  font-size: 0.875rem;
  font-weight: 500;
  color: var(--muted);
  padding: 0.45rem 0.8rem;
  border-radius: var(--radius-sm);
  text-decoration: none;
  transition: var(--transition);
  white-space: nowrap;
  display: block;
}
.nav-links a:hover,
.nav-links a[aria-current="page"] {
  color: var(--charcoal);
  background: var(--off-white);
}

/* CTA area */
.nav-cta { display: flex; align-items: center; gap: 0.5rem; }
.nav-cta .btn-ghost { display: none; } /* hidden on mobile */

/* Hamburger button */
.hamburger {
  display: flex;
  flex-direction: column;
  justify-content: center;
  gap: 5px;
  width: 36px;
  height: 36px;
  padding: 7px;
  border: none;
  background: none;
  cursor: pointer;
  border-radius: var(--radius-sm);
  transition: background 0.18s;
}
.hamburger:hover { background: var(--off-white); }
.hamburger span {
  display: block;
  width: 20px;
  height: 2px;
  background: var(--charcoal);
  border-radius: 2px;
  transition: transform 0.28s cubic-bezier(0.4,0,0.2,1),
              opacity   0.28s ease;
  transform-origin: center;
}
.hamburger.open span:nth-child(1) { transform: translateY(7px) rotate(45deg); }
.hamburger.open span:nth-child(2) { opacity: 0; transform: scaleX(0); }
.hamburger.open span:nth-child(3) { transform: translateY(-7px) rotate(-45deg); }

/* Mobile menu drawer */
.mobile-menu {
  position: fixed;
  inset: 64px 0 0 0;
  background: var(--white);
  z-index: 998;
  padding: 1.5rem var(--px) 2.5rem;
  display: flex;
  flex-direction: column;
  gap: 0;
  border-top: 1px solid var(--border-soft);
  overflow-y: auto;
  transform: translateX(100%);
  transition: transform 0.3s cubic-bezier(0.4,0,0.2,1);
}
/* When [hidden] removed, slide in */
.mobile-menu:not([hidden]) { transform: translateX(0); }

.mobile-menu ul { list-style: none; margin: 0; padding: 0; }

.mobile-link {
  display: block;
  font-family: var(--font-body);
  font-size: 1rem;
  font-weight: 500;
  color: var(--charcoal);
  padding: 1rem 0;
  border-bottom: 1px solid var(--border-soft);
  text-decoration: none;
  transition: color 0.18s;
}
.mobile-link:hover { color: var(--green); }

.mobile-cta {
  margin-top: 1.75rem;
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}
.mobile-cta .btn {
  justify-content: center;
  width: 100%;
  padding: 0.9rem;
  font-size: 1rem;
  border-radius: var(--radius-sm);
}

/* ── Tablet 768px+ ── */
@media (min-width: 768px) {
  .nav-links              { display: flex; }
  .nav-cta .btn-ghost     { display: inline-flex; }
  .hamburger              { display: none; }
  .mobile-menu            { display: none !important; }
  .nav-logo-wordmark      { font-size: 1.15rem; }
}
EOF
echo "  ✓ css/navbar.css"

# ─── css/hero.css ────────────────────────────────────────────────
cat > "$ROOT/css/hero.css" << 'EOF'
/* hero.css — mobile-first, two-column on desktop */

.hero {
  padding: 3.5rem 0 3rem;
  position: relative;
  overflow: hidden;
  background: var(--white);
}

/* Subtle bg glow top-left */
.hero::before {
  content: '';
  position: absolute;
  top: -20%;
  left: -10%;
  width: 70%;
  height: 90%;
  border-radius: 50%;
  background: radial-gradient(ellipse, rgba(61,181,74,0.055) 0%, transparent 70%);
  pointer-events: none;
  z-index: 0;
}

.hero .container { position: relative; z-index: 1; }

/* Grid: single column → two column */
.hero-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 2.5rem;
  align-items: center;
}

/* ── Content (left) ── */
.hero-content { text-align: center; }

.hero-badge {
  display: inline-flex;
  align-items: center;
  gap: 0.45rem;
  background: var(--green-light);
  border: 1px solid var(--green-mid);
  color: var(--green-dark);
  font-family: var(--font-body);
  font-size: 0.72rem;
  font-weight: 600;
  padding: 0.3rem 0.85rem;
  border-radius: 99px;
  margin-bottom: 1.4rem;
  letter-spacing: 0.02em;
}
.badge-dot {
  width: 7px;
  height: 7px;
  background: var(--green);
  border-radius: 50%;
  flex-shrink: 0;
  animation: pulse 2s ease-in-out infinite;
}

.hero-heading {
  font-family: var(--font-display);
  font-weight: 800;
  font-size: clamp(1.9rem, 5.5vw, 3.5rem);
  line-height: 1.1;
  letter-spacing: -1px;
  color: var(--charcoal);
  margin: 0 0 1.25rem;
}
.hero-em {
  font-style: normal;
  color: var(--green);
  display: block;
}

.hero-sub {
  font-family: var(--font-body);
  font-size: clamp(0.9rem, 2vw, 1rem);
  color: var(--muted);
  line-height: 1.8;
  margin: 0 auto 1.5rem;
  max-width: 52ch;
}
.hero-sub strong {
  color: var(--charcoal);
  font-weight: 600;
}

/* Capability pills */
.hero-pills {
  display: flex;
  flex-wrap: wrap;
  gap: 0.4rem;
  justify-content: center;
  margin-bottom: 2rem;
  list-style: none;
  padding: 0;
}
.hero-pills li {
  background: var(--off-white);
  border: 1px solid var(--border-soft);
  color: var(--muted);
  font-family: var(--font-body);
  font-size: 0.72rem;
  font-weight: 500;
  padding: 0.28rem 0.75rem;
  border-radius: 99px;
}

/* CTA row */
.hero-btns {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.75rem;
  flex-wrap: wrap;
}

.btn-hero-p {
  padding: 0.82rem 1.65rem;
  border-radius: var(--radius-sm);
  background: var(--green);
  color: #fff;
  font-family: var(--font-body);
  font-size: 0.925rem;
  font-weight: 600;
  border: none;
  cursor: pointer;
  text-decoration: none;
  display: inline-flex;
  align-items: center;
  gap: 0.4rem;
  transition: var(--transition);
}
.btn-hero-p:hover {
  background: var(--green-dark);
  transform: translateY(-2px);
  box-shadow: var(--shadow-green);
}

.btn-hero-o {
  padding: 0.82rem 1.4rem;
  border-radius: var(--radius-sm);
  border: 1.5px solid rgba(0,0,0,0.11);
  background: transparent;
  color: var(--charcoal);
  font-family: var(--font-body);
  font-size: 0.925rem;
  font-weight: 500;
  cursor: pointer;
  text-decoration: none;
  display: inline-flex;
  align-items: center;
  gap: 0.4rem;
  transition: var(--transition);
}
.btn-hero-o:hover { border-color: var(--green); color: var(--green); }

/* ── Visual (right) ── */
.hero-visual {
  margin: 0;
  display: flex;
  align-items: center;
  justify-content: center;
}
.hero-svg {
  width: 100%;
  max-width: 440px;
  height: auto;
  filter: drop-shadow(0 16px 48px rgba(61,181,74,0.11));
  animation: float 5.5s ease-in-out infinite;
}

/* ── Desktop 900px+ ── */
@media (min-width: 900px) {
  .hero { padding: 5.5rem 0 4.5rem; }
  .hero-grid {
    grid-template-columns: 1fr 1fr;
    gap: 4rem;
  }
  .hero-content   { text-align: left; }
  .hero-sub       { margin-left: 0; margin-right: 0; }
  .hero-pills     { justify-content: flex-start; }
  .hero-btns      { justify-content: flex-start; }
  .hero-heading   { letter-spacing: -1.5px; }
}

@media (min-width: 1200px) {
  .hero-heading { font-size: 3.6rem; }
}
EOF
echo "  ✓ css/hero.css"

# ─── css/responsive.css ──────────────────────────────────────────
cat > "$ROOT/css/responsive.css" << 'EOF'
/* responsive.css — additive tablet/desktop overrides only */

/* Tablet 768px+ */
@media (min-width: 768px) {
  .about-grid     { grid-template-columns: 1fr 1fr; gap: 3.5rem; }
  .products-grid  { grid-template-columns: repeat(2, 1fr); }
  .services-grid  { grid-template-columns: repeat(2, 1fr); }
  .steps-grid     { grid-template-columns: repeat(2, 1fr); }
  .team-grid      { grid-template-columns: repeat(2, 1fr); max-width: none; margin-left: 0; margin-right: 0; }
  .footer-grid    { grid-template-columns: 1fr 1fr; }
  .stat-grid      { grid-template-columns: 1fr 1fr; }
}

/* Desktop 1024px+ */
@media (min-width: 1024px) {
  .products-grid  { grid-template-columns: repeat(3, 1fr); }
  .services-grid  { grid-template-columns: repeat(3, 1fr); }
  .steps-grid     { grid-template-columns: repeat(4, 1fr); }
  .team-grid      { grid-template-columns: repeat(3, 1fr); }
  .footer-grid    { grid-template-columns: 2fr 1fr 1fr 1fr; }
  .about-grid     { gap: 5rem; }
}
EOF
echo "  ✓ css/responsive.css"

# ─── index.html ──────────────────────────────────────────────────
cat > "$ROOT/index.html" << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Klassrun Technologies Ltd — AI-Powered Software for Nigerian Schools</title>
  <meta name="description" content="Klassrun Technologies builds AI-powered web apps, mobile apps, and school management software for Nigerian schools. CAC registered. Lagos, Nigeria." />

  <!-- SEO -->
  <meta name="robots"   content="index, follow" />
  <meta name="author"   content="Klassrun Technologies Ltd" />
  <meta name="keywords" content="EdTech Nigeria, AI lesson notes, school management software Nigeria, web app Lagos, mobile app Nigeria, WAEC NECO aligned, KlassRun" />
  <link rel="canonical" href="https://klassrun.com/" />

  <!-- Open Graph -->
  <meta property="og:type"         content="website" />
  <meta property="og:site_name"    content="Klassrun Technologies Ltd" />
  <meta property="og:url"          content="https://klassrun.com/" />
  <meta property="og:title"        content="Klassrun Technologies — AI-Powered Software for Nigerian Schools" />
  <meta property="og:description"  content="We build AI-powered web apps, mobile apps, and school management systems for Nigerian schools. WAEC &amp; NECO aligned. CAC registered." />
  <meta property="og:image"        content="https://klassrun.com/assets/images/og-image.webp" />
  <meta property="og:image:width"  content="1200" />
  <meta property="og:image:height" content="630" />
  <meta property="og:locale"       content="en_NG" />

  <!-- Twitter / X -->
  <meta name="twitter:card"        content="summary_large_image" />
  <meta name="twitter:site"        content="@klassruntech" />
  <meta name="twitter:title"       content="Klassrun Technologies — AI-Powered Software for Nigerian Schools" />
  <meta name="twitter:description" content="AI-powered web apps, mobile apps &amp; school management for Nigerian schools. CAC registered Lagos EdTech." />
  <meta name="twitter:image"       content="https://klassrun.com/assets/images/og-image.webp" />

  <!-- Favicons -->
  <link rel="icon" type="image/x-icon" href="/assets/icons/favicon.ico" />
  <link rel="icon" type="image/webp"   href="/assets/icons/favicon-32x32.webp" sizes="32x32" />
  <link rel="apple-touch-icon"         href="/assets/icons/apple-touch-icon.webp" />
  <link rel="manifest"                 href="/assets/icons/site.webmanifest" />
  <meta name="theme-color"             content="#3DB54A" />

  <!-- Fonts: Inter + Plus Jakarta Sans -->
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet" />

  <!-- CSS — tokens first, then per-component -->
  <link rel="stylesheet" href="/css/tokens.css" />
  <link rel="stylesheet" href="/css/reset.css" />
  <link rel="stylesheet" href="/css/base.css" />
  <link rel="stylesheet" href="/css/animations.css" />
  <link rel="stylesheet" href="/css/navbar.css" />
  <link rel="stylesheet" href="/css/hero.css" />
  <link rel="stylesheet" href="/css/cred-strip.css" />
  <link rel="stylesheet" href="/css/about.css" />
  <link rel="stylesheet" href="/css/products.css" />
  <link rel="stylesheet" href="/css/services.css" />
  <link rel="stylesheet" href="/css/how-it-works.css" />
  <link rel="stylesheet" href="/css/team.css" />
  <link rel="stylesheet" href="/css/cta.css" />
  <link rel="stylesheet" href="/css/footer.css" />
  <link rel="stylesheet" href="/css/responsive.css" />
</head>
<body>

  <div id="app">
    <div data-component="navbar"></div>
    <div data-component="hero"></div>
    <div data-component="cred-strip"></div>
    <div data-component="about"></div>
    <div data-component="products"></div>
    <div data-component="services"></div>
    <div data-component="how-it-works"></div>
    <div data-component="team"></div>
    <div data-component="cta"></div>
    <div data-component="footer"></div>
  </div>

  <!-- Component loader (synchronous so components exist before defer scripts run) -->
  <script src="/js/loader.js"></script>

  <!-- JSON-LD structured data -->
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "Organization",
    "name": "Klassrun Technologies Ltd",
    "url": "https://klassrun.com",
    "logo": "https://klassrun.com/assets/images/logo.webp",
    "foundingDate": "2026-04-03",
    "description": "Lagos-based EdTech company building AI-powered web apps, mobile apps, and school management systems for Nigerian schools.",
    "address": {
      "@type": "PostalAddress",
      "addressLocality": "Lagos",
      "addressRegion": "Lagos State",
      "addressCountry": "NG"
    },
    "contactPoint": { "@type": "ContactPoint", "email": "klassrun@gmail.com" },
    "sameAs": [
      "https://www.linkedin.com/company/klassrun",
      "https://www.instagram.com/klassruntech",
      "https://twitter.com/klassruntech"
    ]
  }
  </script>

  <script src="/js/navbar.js" defer></script>
  <script src="/js/scroll-reveal.js" defer></script>
</body>
</html>
EOF
echo "  ✓ index.html"

# ─── components/navbar.html ──────────────────────────────────────
cat > "$ROOT/components/navbar.html" << 'EOF'
<!-- navbar — semantic <header> with accessible nav -->
<header class="nav" role="banner">
  <div class="nav-inner">

    <!-- Logo: uncomment <img> once logo.webp is in assets/images/ -->
    <a href="/" class="nav-logo" aria-label="Klassrun Technologies — home">
      <!--
      <img
        src="/assets/images/logo.webp"
        alt="Klassrun Technologies"
        class="nav-logo-img"
        width="148" height="38"
        loading="eager"
        fetchpriority="high"
      />
      -->
      <span class="nav-logo-wordmark" aria-hidden="true">
        <span class="logo-k">Klassrun</span><span class="logo-t">&nbsp;Technologies</span>
      </span>
      <span class="nav-logo-sub">Ltd · RC 9463863 · Lagos</span>
    </a>

    <!-- Desktop navigation -->
    <nav class="nav-links" aria-label="Main navigation">
      <ul role="list">
        <li><a href="#about">About</a></li>
        <li><a href="#products">Products</a></li>
        <li><a href="#services">Services</a></li>
        <li><a href="#team">Team</a></li>
        <li><a href="#contact">Contact</a></li>
      </ul>
    </nav>

    <!-- CTA + hamburger -->
    <div class="nav-cta">
      <a href="mailto:klassrun@gmail.com" class="btn btn-ghost">Contact us</a>
      <a href="#products" class="btn btn-primary">Our products &rarr;</a>
      <button
        class="hamburger"
        id="hamburger"
        aria-label="Toggle navigation"
        aria-expanded="false"
        aria-controls="mobileMenu"
      >
        <span></span><span></span><span></span>
      </button>
    </div>

  </div>
</header>

<!-- Mobile navigation drawer -->
<div
  class="mobile-menu"
  id="mobileMenu"
  role="dialog"
  aria-label="Mobile navigation"
  aria-modal="true"
  hidden
>
  <nav aria-label="Mobile menu">
    <ul role="list">
      <li><a href="#about"    class="mobile-link">About</a></li>
      <li><a href="#products" class="mobile-link">Products</a></li>
      <li><a href="#services" class="mobile-link">Services</a></li>
      <li><a href="#team"     class="mobile-link">Team</a></li>
      <li><a href="#contact"  class="mobile-link">Contact</a></li>
    </ul>
  </nav>
  <div class="mobile-cta">
    <a href="mailto:klassrun@gmail.com" class="btn btn-ghost">Contact us</a>
    <a href="#products" class="btn btn-primary">Our products &rarr;</a>
  </div>
</div>
EOF
echo "  ✓ components/navbar.html"

# ─── components/hero.html ────────────────────────────────────────
cat > "$ROOT/components/hero.html" << 'EOF'
<!-- hero — semantic <main> wrapping the hero <section> -->
<main id="main-content">
<section class="hero" aria-labelledby="hero-heading">
  <div class="container">
    <div class="hero-grid">

      <!-- Left: copy -->
      <div class="hero-content">

        <p class="hero-badge fade-up" role="status">
          <span class="badge-dot" aria-hidden="true"></span>
          <span>CAC Registered &nbsp;&middot;&nbsp; Lagos, Nigeria &nbsp;&middot;&nbsp; Est. 2026</span>
        </p>

        <h1 id="hero-heading" class="hero-heading fade-up delay-1">
          Building technology that
          <em class="hero-em">powers education</em>
          and businesses forward
        </h1>

        <p class="hero-sub fade-up delay-2">
          Klassrun Technologies Ltd builds <strong>AI-powered web apps</strong>,
          <strong>mobile apps</strong>, and <strong>school management systems</strong>
          for Nigerian schools and organisations — aligned to WAEC, NECO &amp; NERDC standards.
        </p>

        <ul class="hero-pills fade-up delay-2" aria-label="What we build">
          <li>Web Applications</li>
          <li>Mobile Apps</li>
          <li>AI &amp; Automation</li>
          <li>School Management</li>
        </ul>

        <div class="hero-btns fade-up delay-3">
          <a href="#products" class="btn-hero-p">Explore products &rarr;</a>
          <a href="#contact"  class="btn-hero-o">Work with us</a>
        </div>

      </div>

      <!-- Right: tech illustration SVG -->
      <figure class="hero-visual fade-up delay-2" aria-hidden="true">
        <svg
          class="hero-svg"
          viewBox="0 0 480 420"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
          role="img"
          aria-hidden="true"
        >
          <defs>
            <radialGradient id="bgGlow" cx="50%" cy="50%" r="50%">
              <stop offset="0%"   stop-color="#3DB54A" stop-opacity="0.28"/>
              <stop offset="100%" stop-color="#3DB54A" stop-opacity="0"/>
            </radialGradient>
            <linearGradient id="cardGrad" x1="0" y1="0" x2="1" y2="1">
              <stop offset="0%"   stop-color="#1e232c"/>
              <stop offset="100%" stop-color="#252930"/>
            </linearGradient>
            <linearGradient id="greenBar" x1="0" y1="0" x2="1" y2="0">
              <stop offset="0%"   stop-color="#3DB54A"/>
              <stop offset="100%" stop-color="#2a8a35"/>
            </linearGradient>
          </defs>

          <!-- Background glow -->
          <ellipse cx="240" cy="210" rx="195" ry="175" fill="url(#bgGlow)"/>

          <!-- Dotted grid -->
          <g opacity="0.1" stroke="#3DB54A" stroke-width="0.6" stroke-dasharray="3 9">
            <line x1="80"  y1="0"   x2="80"  y2="420"/>
            <line x1="160" y1="0"   x2="160" y2="420"/>
            <line x1="240" y1="0"   x2="240" y2="420"/>
            <line x1="320" y1="0"   x2="320" y2="420"/>
            <line x1="400" y1="0"   x2="400" y2="420"/>
            <line x1="0"   y1="70"  x2="480" y2="70"/>
            <line x1="0"   y1="140" x2="480" y2="140"/>
            <line x1="0"   y1="210" x2="480" y2="210"/>
            <line x1="0"   y1="280" x2="480" y2="280"/>
            <line x1="0"   y1="350" x2="480" y2="350"/>
          </g>

          <!-- Card 1: School OS -->
          <rect x="55"  y="55"  width="225" height="148" rx="16" fill="url(#cardGrad)" stroke="#3DB54A" stroke-width="1.2" stroke-opacity="0.45"/>
          <rect x="55"  y="55"  width="225" height="5"   rx="2"  fill="url(#greenBar)"/>
          <rect x="74"  y="78"  width="56"  height="8"   rx="4"  fill="#3DB54A" opacity="0.85"/>
          <text x="74"  y="108" font-family="Inter,sans-serif" font-size="10" fill="#94a3b8">School Management OS</text>
          <rect x="74"  y="118" width="145" height="5"   rx="3"  fill="#2e343b"/>
          <rect x="74"  y="118" width="105" height="5"   rx="3"  fill="#3DB54A" opacity="0.65"/>
          <text x="74"  y="143" font-family="Inter,sans-serif" font-size="8.5" fill="#64748b">Notes Generated</text>
          <text x="198" y="143" font-family="Inter,sans-serif" font-size="8.5" fill="#3DB54A" font-weight="600">1,240</text>
          <text x="74"  y="158" font-family="Inter,sans-serif" font-size="8.5" fill="#64748b">Teacher hrs saved/wk</text>
          <text x="198" y="158" font-family="Inter,sans-serif" font-size="8.5" fill="#3DB54A" font-weight="600">12+</text>
          <text x="74"  y="173" font-family="Inter,sans-serif" font-size="8.5" fill="#64748b">WAEC alignment</text>
          <text x="198" y="173" font-family="Inter,sans-serif" font-size="8.5" fill="#3DB54A" font-weight="600">100%</text>
          <text x="74"  y="190" font-family="Inter,sans-serif" font-size="7.5" fill="#3DB54A" opacity="0.7">NERDC · WAEC · NECO</text>

          <!-- Card 2: Mobile App -->
          <rect x="200" y="228" width="180" height="115" rx="14" fill="url(#cardGrad)" stroke="#3DB54A" stroke-width="1" stroke-opacity="0.3"/>
          <rect x="200" y="228" width="180" height="4"   rx="2"  fill="url(#greenBar)"/>
          <text x="218" y="254" font-family="Inter,sans-serif" font-size="9.5" fill="#94a3b8">Mobile App</text>
          <!-- Phone -->
          <rect x="218" y="263" width="23" height="40" rx="4" fill="none" stroke="#3DB54A" stroke-width="1.4"/>
          <rect x="221" y="267" width="17" height="29" rx="2" fill="#1e232c"/>
          <circle cx="229" cy="299" r="2" fill="#3DB54A" opacity="0.55"/>
          <!-- Bars -->
          <rect x="253" y="292" width="4"  height="14" rx="2" fill="#3DB54A" opacity="0.3"/>
          <rect x="261" y="285" width="4"  height="21" rx="2" fill="#3DB54A" opacity="0.55"/>
          <rect x="269" y="278" width="4"  height="28" rx="2" fill="#3DB54A" opacity="0.85"/>
          <text x="280" y="300" font-family="Inter,sans-serif" font-size="8.5" fill="#64748b">iOS &amp; Android</text>
          <text x="218" y="332" font-family="Inter,sans-serif" font-size="7.5" fill="#3DB54A">React Native · Flutter</text>

          <!-- Card 3: Web App -->
          <rect x="46"  y="232" width="142" height="98" rx="12" fill="url(#cardGrad)" stroke="#3DB54A" stroke-width="1" stroke-opacity="0.3"/>
          <rect x="46"  y="232" width="142" height="4"  rx="2"  fill="url(#greenBar)"/>
          <text x="62"  y="255" font-family="Inter,sans-serif" font-size="9.5" fill="#94a3b8">Web Application</text>
          <!-- Browser -->
          <rect x="62"  y="262" width="108" height="52" rx="5" fill="none" stroke="#3DB54A" stroke-width="1.1" stroke-opacity="0.45"/>
          <rect x="62"  y="262" width="108" height="11" rx="5" fill="#2e343b"/>
          <circle cx="70"  cy="267" r="2" fill="#ef4444" opacity="0.6"/>
          <circle cx="78"  cy="267" r="2" fill="#f59e0b" opacity="0.6"/>
          <circle cx="86"  cy="267" r="2" fill="#3DB54A" opacity="0.6"/>
          <rect x="90"  y="264" width="70" height="5"  rx="2" fill="#1e232c"/>
          <rect x="68"  y="279" width="88" height="4"  rx="2" fill="#2e343b"/>
          <rect x="68"  y="287" width="64" height="4"  rx="2" fill="#2e343b"/>
          <rect x="68"  y="295" width="76" height="4"  rx="2" fill="#2e343b"/>
          <text x="62"  y="322" font-family="Inter,sans-serif" font-size="7.5" fill="#3DB54A">React · Next.js · Node</text>

          <!-- Connector lines -->
          <line x1="168" y1="203" x2="200" y2="232" stroke="#3DB54A" stroke-width="1"   stroke-dasharray="4 5" stroke-opacity="0.35"/>
          <line x1="168" y1="203" x2="140" y2="232" stroke="#3DB54A" stroke-width="1"   stroke-dasharray="4 5" stroke-opacity="0.35"/>

          <!-- AI node (centre) -->
          <circle cx="168" cy="203" r="20" fill="#3DB54A" opacity="0.07"/>
          <circle cx="168" cy="203" r="13" fill="#3DB54A" opacity="0.14"/>
          <circle cx="168" cy="203" r="7"  fill="#3DB54A"/>
          <text x="161" y="207" font-family="Inter,sans-serif" font-size="7" fill="#fff" font-weight="700">AI</text>

          <!-- Floating nodes top-right -->
          <circle cx="398" cy="75"  r="5" fill="#3DB54A" opacity="0.75"/>
          <circle cx="420" cy="118" r="3" fill="#3DB54A" opacity="0.45"/>
          <circle cx="442" cy="88"  r="4" fill="#3DB54A" opacity="0.3"/>
          <line x1="398" y1="75"  x2="420" y2="118" stroke="#3DB54A" stroke-width="0.8" stroke-opacity="0.28"/>
          <line x1="420" y1="118" x2="442" y2="88"  stroke="#3DB54A" stroke-width="0.8" stroke-opacity="0.28"/>
          <line x1="398" y1="75"  x2="442" y2="88"  stroke="#3DB54A" stroke-width="0.8" stroke-opacity="0.28"/>

          <!-- Floating nodes bottom-left -->
          <circle cx="38"  cy="328" r="4" fill="#3DB54A" opacity="0.45"/>
          <circle cx="18"  cy="350" r="3" fill="#3DB54A" opacity="0.28"/>
          <circle cx="54"  cy="364" r="5" fill="#3DB54A" opacity="0.38"/>
          <line x1="38"  y1="328" x2="18"  y2="350" stroke="#3DB54A" stroke-width="0.8" stroke-opacity="0.22"/>
          <line x1="18"  y1="350" x2="54"  y2="364" stroke="#3DB54A" stroke-width="0.8" stroke-opacity="0.22"/>
          <line x1="38"  y1="328" x2="54"  y2="364" stroke="#3DB54A" stroke-width="0.8" stroke-opacity="0.22"/>
        </svg>
      </figure>

    </div>
  </div>
</section>
</main>
EOF
echo "  ✓ components/hero.html"

# ─── components/cred-strip.html ──────────────────────────────────
cat > "$ROOT/components/cred-strip.html" << 'EOF'
<!-- cred-strip — semantic <aside> for supplementary company info -->
<aside class="cred-strip" aria-label="Company registration details">
  <div class="cred-inner">
    <p class="cred-item">RC Number: <strong>9463863</strong></p>
    <span class="cred-sep" aria-hidden="true"></span>
    <p class="cred-item">TIN: <strong>2622403512485</strong></p>
    <span class="cred-sep" aria-hidden="true"></span>
    <p class="cred-item">Status: <strong>Active</strong></p>
    <span class="cred-sep" aria-hidden="true"></span>
    <p class="cred-item">Type: <strong>Private Limited Company</strong></p>
    <span class="cred-sep" aria-hidden="true"></span>
    <p class="cred-item">Incorporated: <strong>April 3, 2026</strong></p>
  </div>
</aside>
EOF
echo "  ✓ components/cred-strip.html"

# ─── components/about.html ───────────────────────────────────────
cat > "$ROOT/components/about.html" << 'EOF'
<!-- about — semantic <section> with aria label -->
<section class="section" id="about" aria-labelledby="about-heading">
  <div class="container">
    <div class="about-grid">

      <!-- Left: text -->
      <div class="reveal">
        <p class="about-label" aria-hidden="true">About us</p>
        <h2 id="about-heading" class="about-title d">
          We build AI tools Nigerian schools actually need
        </h2>
        <p class="about-body">
          Klassrun Technologies Ltd is a Lagos-based EdTech company building AI-powered web apps,
          mobile apps, and software products for African educational institutions. We specialise in
          automating the most time-consuming parts of school administration — so teachers can focus
          on teaching, and school owners can focus on growing.
        </p>
        <p class="about-body">
          Our products are built around the Nigerian curriculum, WAEC and NECO standards,
          and real infrastructure challenges Nigerian schools face — low connectivity, manual
          processes, and limited IT support.
        </p>
        <ul class="pill-row" aria-label="Our focus areas">
          <li class="pill">AI-powered tools</li>
          <li class="pill">Nigerian curriculum</li>
          <li class="pill">WAEC &amp; NECO aligned</li>
          <li class="pill">PWA &amp; offline-ready</li>
          <li class="pill">School management</li>
          <li class="pill">EdTech SaaS</li>
        </ul>
      </div>

      <!-- Right: stats -->
      <dl class="stat-grid reveal" aria-label="Key statistics">
        <div class="stat-card">
          <dt class="stat-lbl">Private schools in Nigeria we can serve</dt>
          <dd class="stat-num">50k+</dd>
        </div>
        <div class="stat-card">
          <dt class="stat-lbl">Saved per teacher every week with AI</dt>
          <dd class="stat-num">12hrs</dd>
        </div>
        <div class="stat-card">
          <dt class="stat-lbl">Education-only AI — no misuse possible</dt>
          <dd class="stat-num">100%</dd>
        </div>
        <div class="stat-card">
          <dt class="stat-lbl">Registered share capital — CAC certified</dt>
          <dd class="stat-num">₦1M</dd>
        </div>
      </dl>

    </div>
  </div>
</section>
EOF
echo "  ✓ components/about.html"

# ─── components/products.html ────────────────────────────────────
cat > "$ROOT/components/products.html" << 'EOF'
<!-- products — <section> with role="list" on product grid -->
<section class="section products-bg" id="products" aria-labelledby="products-heading">
  <div class="container">

    <header class="section-header reveal">
      <p class="sec-label" aria-hidden="true">Our products</p>
      <h2 id="products-heading" class="sec-title d">Software we're building for schools</h2>
      <p class="sec-sub">
        Each product solves a specific, real problem for Nigerian schools.
        KlassRun is our flagship — more are actively in development.
      </p>
    </header>

    <ul class="products-grid" role="list">

      <!-- KlassRun — FLAGSHIP -->
      <li class="product-card flagship reveal">
        <span class="product-status status-live" aria-label="Status: Flagship product">&#9679; Flagship product</span>
        <div class="product-icon" aria-hidden="true">📖</div>
        <h3>KlassRun</h3>
        <p>
          AI-powered lesson note and exam question generator for Nigerian primary and secondary schools.
          Automatically aligned with NERDC curriculum and WAEC/NECO standards. Saves teachers 12+ hours per week.
        </p>
        <ul class="product-tags" aria-label="Features">
          <li class="product-tag">Lesson notes</li>
          <li class="product-tag">Exam questions</li>
          <li class="product-tag">WAEC aligned</li>
          <li class="product-tag">PWA + offline</li>
          <li class="product-tag">School OS</li>
        </ul>
        <!-- UPDATE href when KlassRun is live -->
        <a href="#" class="product-link">Visit KlassRun &rarr;</a>
      </li>

      <!-- SchoolMetrics — IN DEV -->
      <li class="product-card reveal">
        <span class="product-status status-dev" aria-label="Status: In development">&#9679; In development</span>
        <div class="product-icon" aria-hidden="true">📊</div>
        <h3>SchoolMetrics</h3>
        <p>
          A data analytics dashboard for school proprietors and administrators — tracking student
          performance, teacher activity, and school efficiency across all classes and terms in one place.
        </p>
        <ul class="product-tags" aria-label="Features">
          <li class="product-tag">Analytics</li>
          <li class="product-tag">Performance data</li>
          <li class="product-tag">School insights</li>
        </ul>
        <a href="#" class="product-link" aria-disabled="true" style="opacity:.45;pointer-events:none">Coming soon &rarr;</a>
      </li>

      <!-- ParentConnect — PLANNED -->
      <li class="product-card reveal">
        <span class="product-status status-soon" aria-label="Status: Planned">Planned</span>
        <div class="product-icon" aria-hidden="true">👨‍👩‍👧</div>
        <h3>ParentConnect</h3>
        <p>
          A parent-facing portal where parents can view their child's attendance, assessment scores,
          teacher comments, and term reports in real time — directly from the school's KlassRun platform.
        </p>
        <ul class="product-tags" aria-label="Features">
          <li class="product-tag">Parent portal</li>
          <li class="product-tag">Real-time updates</li>
          <li class="product-tag">Report cards</li>
        </ul>
        <a href="#" class="product-link" aria-disabled="true" style="opacity:.45;pointer-events:none">Coming soon &rarr;</a>
      </li>

    </ul>
  </div>
</section>
EOF
echo "  ✓ components/products.html"

# ─── components/services.html ────────────────────────────────────
cat > "$ROOT/components/services.html" << 'EOF'
<!-- services — <section> with service cards as <article> elements -->
<section class="section" id="services" aria-labelledby="services-heading">
  <div class="container">

    <header class="section-header reveal">
      <p class="sec-label" aria-hidden="true">What we do</p>
      <h2 id="services-heading" class="sec-title d">Our capabilities</h2>
      <p class="sec-sub">
        As a CAC-registered EdTech company, here is what Klassrun Technologies is licensed and built to deliver.
      </p>
    </header>

    <ul class="services-grid" role="list">
      <li class="svc-card reveal">
        <span class="svc-icon" aria-hidden="true">🤖</span>
        <h3 class="svc-title">AI Software Development</h3>
        <p>We design and build AI-powered web applications and PWAs tailored to the needs of educational institutions across Nigeria.</p>
      </li>
      <li class="svc-card reveal">
        <span class="svc-icon" aria-hidden="true">📱</span>
        <h3 class="svc-title">Mobile App Development</h3>
        <p>Cross-platform mobile apps for iOS and Android — built with React Native and Flutter for schools and businesses across all sectors.</p>
      </li>
      <li class="svc-card reveal">
        <span class="svc-icon" aria-hidden="true">📝</span>
        <h3 class="svc-title">Automated Content Generation</h3>
        <p>Lesson notes, exam questions, schemes of work, and report card comments — generated by AI in seconds, curriculum-aligned.</p>
      </li>
      <li class="svc-card reveal">
        <span class="svc-icon" aria-hidden="true">🏫</span>
        <h3 class="svc-title">School Management Systems</h3>
        <p>End-to-end digital school management — attendance, grading, student records, academic calendars, and parent portals.</p>
      </li>
      <li class="svc-card reveal">
        <span class="svc-icon" aria-hidden="true">📡</span>
        <h3 class="svc-title">Cloud &amp; Offline Platforms</h3>
        <p>We build cloud-based platforms with offline capabilities — designed for Nigerian internet and power realities in the classroom.</p>
      </li>
      <li class="svc-card reveal">
        <span class="svc-icon" aria-hidden="true">🛠️</span>
        <h3 class="svc-title">Tech Consultancy</h3>
        <p>We help schools and organisations plan and adopt digital tools — from staff training to deploying custom technology solutions.</p>
      </li>
    </ul>

  </div>
</section>
EOF
echo "  ✓ components/services.html"

# ─── components/how-it-works.html ────────────────────────────────
cat > "$ROOT/components/how-it-works.html" << 'EOF'
<!-- how-it-works — ordered list of steps -->
<section class="section how-bg" aria-labelledby="how-heading">
  <div class="container">

    <header class="section-header reveal">
      <p class="sec-label" aria-hidden="true">How it works</p>
      <h2 id="how-heading" class="sec-title d">From signup to running in minutes</h2>
      <p class="sec-sub" style="color:rgba(255,255,255,0.5)">
        Any teacher can start using our tools on day one. No IT department needed.
      </p>
    </header>

    <ol class="steps-grid reveal" role="list" aria-label="Steps to get started">
      <li class="step">
        <span class="step-num" aria-hidden="true">01</span>
        <h3>Set up your school</h3>
        <p>Add your school name, classes, subjects, and teachers. Takes less than 10 minutes from sign up to ready.</p>
      </li>
      <li class="step">
        <span class="step-num" aria-hidden="true">02</span>
        <h3>Pick your subject</h3>
        <p>Select class, subject, term, and topic from our Nigerian curriculum library — built on NERDC standards.</p>
      </li>
      <li class="step">
        <span class="step-num" aria-hidden="true">03</span>
        <h3>Generate instantly</h3>
        <p>Click generate. Our AI delivers a complete, curriculum-aligned lesson note or exam paper in seconds.</p>
      </li>
      <li class="step">
        <span class="step-num" aria-hidden="true">04</span>
        <h3>Print or share</h3>
        <p>Download a school-branded PDF, share with students, or store in your school's document library.</p>
      </li>
    </ol>

  </div>
</section>
EOF
echo "  ✓ components/how-it-works.html"

# ─── components/team.html ────────────────────────────────────────
cat > "$ROOT/components/team.html" << 'EOF'
<!-- team — <section> with team cards -->
<section class="section products-bg" id="team" aria-labelledby="team-heading">
  <div class="container">

    <header class="section-header reveal">
      <p class="sec-label" aria-hidden="true">Our team</p>
      <h2 id="team-heading" class="sec-title d">The people behind Klassrun</h2>
      <p class="sec-sub">Three founders. One mission — make Nigerian schools run smarter with technology.</p>
    </header>

    <ul class="team-grid reveal" role="list">

      <li class="team-card">
        <div class="avatar" aria-hidden="true">
          <!--
            Replace initials with photo when ready:
            <img src="/assets/images/team-adegbite.webp" alt="" width="72" height="72" loading="lazy" />
          -->
          AM
        </div>
        <h3>Adegbite Mohammed Adedamola</h3>
        <p class="team-role">Director &amp; Co-Founder</p>
        <p class="team-meta">Based in Ibadan, Oyo State</p>
        <span class="share-badge">40% shareholding</span>
      </li>

      <li class="team-card">
        <div class="avatar" aria-hidden="true">AT</div>
        <h3>Bello Afeez Temitope</h3>
        <p class="team-role">Director &amp; Co-Founder</p>
        <p class="team-meta">Based in Ajegunle, Lagos State</p>
        <span class="share-badge">40% shareholding</span>
      </li>

      <li class="team-card">
        <div class="avatar" aria-hidden="true">FK</div>
        <h3>Fashola Omolade Kaothar</h3>
        <p class="team-role">Director &amp; Co-Founder</p>
        <p class="team-meta">Based in Iju Ishaga, Lagos State</p>
        <span class="share-badge">20% shareholding</span>
      </li>

    </ul>
  </div>
</section>
EOF
echo "  ✓ components/team.html"

# ─── components/cta.html ─────────────────────────────────────────
cat > "$ROOT/components/cta.html" << 'EOF'
<!-- cta — <section> with contact id for nav anchor -->
<section class="cta-section" id="contact" aria-labelledby="cta-heading">
  <div class="cta-box reveal">
    <h2 id="cta-heading" class="d">Ready to work with us or use our products?</h2>
    <p>
      Whether you're a school looking to subscribe to KlassRun, or a partner looking to collaborate
      with Klassrun Technologies — we'd love to hear from you.
    </p>
    <div class="cta-btns">
      <!-- UPDATE href to KlassRun URL when live -->
      <a href="#products" class="btn-cta-w">Try KlassRun free</a>
      <a href="https://wa.me/2349014465194" target="_blank" rel="noopener noreferrer" class="btn-cta-t">
        💬 WhatsApp us
      </a>
    </div>
  </div>
</section>
EOF
echo "  ✓ components/cta.html"

# ─── components/footer.html ──────────────────────────────────────
cat > "$ROOT/components/footer.html" << 'EOF'
<!-- footer — semantic <footer> with <nav> for footer links -->
<footer role="contentinfo">
  <div class="footer-grid">

    <!-- Brand -->
    <div class="footer-brand">
      <!--
        Logo white version — uncomment when ready:
        <img src="/assets/images/logo-white.webp" alt="Klassrun Technologies" class="footer-logo-img" width="140" height="32" loading="lazy" />
      -->
      <p class="footer-logo-main">
        <span class="k">KLASSRUN</span><span class="r"> TECHNOLOGIES</span>
      </p>
      <p class="footer-desc">
        AI-powered web apps, mobile apps, and EdTech solutions for Nigerian schools and businesses.
        Building the future of African education, one classroom at a time.
      </p>
      <address class="footer-reg" aria-label="Company registration details">
        <span>RC Number: <strong>9463863</strong></span>
        <span>TIN: <strong>2622403512485</strong></span>
        <span>Email: <a href="mailto:klassrun@gmail.com"><strong>klassrun@gmail.com</strong></a></span>
        <span>Address: <strong>Ajegunle, Apapa, Lagos State, Nigeria</strong></span>
      </address>
    </div>

    <!-- Products nav -->
    <nav class="footer-col" aria-label="Products">
      <h3>Products</h3>
      <ul role="list">
        <li><a href="#">KlassRun</a></li>
        <li><a href="#" aria-disabled="true" class="disabled">SchoolMetrics (soon)</a></li>
        <li><a href="#" aria-disabled="true" class="disabled">ParentConnect (soon)</a></li>
      </ul>
    </nav>

    <!-- Company nav -->
    <nav class="footer-col" aria-label="Company">
      <h3>Company</h3>
      <ul role="list">
        <li><a href="#about">About us</a></li>
        <li><a href="#services">Services</a></li>
        <li><a href="#team">Our team</a></li>
        <li><a href="#contact">Contact</a></li>
      </ul>
    </nav>

    <!-- Legal nav -->
    <nav class="footer-col" aria-label="Legal">
      <h3>Legal</h3>
      <ul role="list">
        <li><a href="#">Privacy policy</a></li>
        <li><a href="#">Terms of service</a></li>
        <li><a href="https://search.cac.gov.ng" target="_blank" rel="noopener noreferrer">Verify on CAC ↗</a></li>
      </ul>
    </nav>

  </div>

  <div class="footer-bottom">
    <small>&copy; 2026 Klassrun Technologies Ltd. All rights reserved.</small>
    <small>Registered under CAMA 2020 &middot; Corporate Affairs Commission</small>
  </div>
</footer>
EOF
echo "  ✓ components/footer.html"

# ─── js/navbar.js ────────────────────────────────────────────────
cat > "$ROOT/js/navbar.js" << 'EOF'
/**
 * navbar.js
 * Hamburger toggle using the HTML `hidden` attribute (matches CSS :not([hidden])).
 * Accessible: aria-expanded, Esc key, active nav highlighting.
 */
document.addEventListener('components:loaded', () => {
  const hamburger   = document.getElementById('hamburger');
  const mobileMenu  = document.getElementById('mobileMenu');
  const mobileLinks = document.querySelectorAll('.mobile-link');
  const navLinks    = document.querySelectorAll('.nav-links a');
  const sections    = document.querySelectorAll('section[id]');

  if (!hamburger || !mobileMenu) return;

  const openMenu = () => {
    mobileMenu.removeAttribute('hidden');
    hamburger.classList.add('open');
    hamburger.setAttribute('aria-expanded', 'true');
    document.body.style.overflow = 'hidden';
  };

  const closeMenu = () => {
    mobileMenu.setAttribute('hidden', '');
    hamburger.classList.remove('open');
    hamburger.setAttribute('aria-expanded', 'false');
    document.body.style.overflow = '';
  };

  hamburger.addEventListener('click', () => {
    mobileMenu.hasAttribute('hidden') ? openMenu() : closeMenu();
  });

  mobileLinks.forEach(link => link.addEventListener('click', closeMenu));
  document.addEventListener('keydown', e => { if (e.key === 'Escape') closeMenu(); });
  window.addEventListener('resize', () => { if (window.innerWidth >= 768) closeMenu(); });

  // Active link highlight on scroll
  const highlightNav = () => {
    let current = '';
    sections.forEach(sec => {
      if (window.scrollY >= sec.offsetTop - 120) current = sec.id;
    });
    navLinks.forEach(link => {
      if (link.getAttribute('href') === '#' + current) {
        link.setAttribute('aria-current', 'page');
      } else {
        link.removeAttribute('aria-current');
      }
    });
  };

  window.addEventListener('scroll', highlightNav, { passive: true });
});
EOF
echo "  ✓ js/navbar.js"

# ─── vercel.json ─────────────────────────────────────────────────
cat > "$ROOT/vercel.json" << 'EOF'
{
  "cleanUrls": true,
  "trailingSlash": false,
  "rewrites": [
    {
      "source": "/((?!assets|css|js|components|robots.txt|sitemap.xml|favicon.ico).*)",
      "destination": "/index.html"
    }
  ],
  "headers": [
    {
      "source": "/assets/(.*)",
      "headers": [
        { "key": "Cache-Control", "value": "public, max-age=31536000, immutable" }
      ]
    },
    {
      "source": "/(css|js|components)/(.*)",
      "headers": [
        { "key": "Cache-Control", "value": "public, max-age=86400, stale-while-revalidate=604800" }
      ]
    },
    {
      "source": "/(.*)",
      "headers": [
        { "key": "X-Content-Type-Options",  "value": "nosniff" },
        { "key": "X-Frame-Options",         "value": "DENY" },
        { "key": "Referrer-Policy",         "value": "strict-origin-when-cross-origin" }
      ]
    }
  ]
}
EOF
echo "  ✓ vercel.json"

# ─── 404.html ────────────────────────────────────────────────────
cat > "$ROOT/404.html" << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Page Not Found — Klassrun Technologies</title>
  <link rel="icon" href="/assets/icons/favicon.ico"/>
  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
  <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;700;800&family=Inter:wght@400;500&display=swap" rel="stylesheet"/>
  <style>
    *,*::before,*::after{margin:0;padding:0;box-sizing:border-box}
    body{font-family:'Inter',sans-serif;background:#0f1117;color:#fff;min-height:100vh;display:grid;place-items:center;text-align:center;padding:2rem}
    .wrap{max-width:440px}
    .code{font-family:'Plus Jakarta Sans',sans-serif;font-size:8rem;font-weight:800;line-height:1;color:#3DB54A;opacity:.12;letter-spacing:-6px;user-select:none}
    h1{font-family:'Plus Jakarta Sans',sans-serif;font-size:1.6rem;font-weight:800;margin:-2rem 0 1rem;letter-spacing:-0.5px}
    p{color:#64748b;line-height:1.7;margin-bottom:2rem;font-size:0.9rem}
    a{display:inline-flex;align-items:center;gap:.4rem;padding:.75rem 1.6rem;background:#3DB54A;color:#fff;border-radius:8px;font-weight:600;font-size:.875rem;text-decoration:none;transition:background .2s,transform .2s}
    a:hover{background:#2a8a35;transform:translateY(-2px)}
  </style>
</head>
<body>
  <div class="wrap">
    <p class="code" aria-hidden="true">404</p>
    <h1>Page not found</h1>
    <p>The page you're looking for doesn't exist or has been moved.</p>
    <a href="/">← Back to home</a>
  </div>
</body>
</html>
EOF
echo "  ✓ 404.html"

# ─── offline.html ────────────────────────────────────────────────
cat > "$ROOT/offline.html" << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>You're Offline — Klassrun Technologies</title>
  <link rel="icon" href="/assets/icons/favicon.ico"/>
  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
  <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;700;800&family=Inter:wght@400;500&display=swap" rel="stylesheet"/>
  <style>
    *,*::before,*::after{margin:0;padding:0;box-sizing:border-box}
    body{font-family:'Inter',sans-serif;background:#0f1117;color:#fff;min-height:100vh;display:grid;place-items:center;text-align:center;padding:2rem}
    .wrap{max-width:400px}
    .icon{font-size:3.5rem;margin-bottom:1.25rem;display:block;opacity:.5}
    h1{font-family:'Plus Jakarta Sans',sans-serif;font-size:1.5rem;font-weight:800;margin-bottom:.85rem;letter-spacing:-0.4px}
    p{color:#64748b;line-height:1.75;margin-bottom:2rem;font-size:.9rem}
    button{display:inline-flex;align-items:center;gap:.4rem;padding:.75rem 1.6rem;background:#3DB54A;color:#fff;border-radius:8px;font-weight:600;font-size:.875rem;border:none;cursor:pointer;transition:background .2s}
    button:hover{background:#2a8a35}
  </style>
</head>
<body>
  <div class="wrap">
    <span class="icon" aria-hidden="true">📡</span>
    <h1>You're offline</h1>
    <p>Check your internet connection and try again.</p>
    <button onclick="window.location.reload()">Try again</button>
  </div>
</body>
</html>
EOF
echo "  ✓ offline.html"

# ─── Git commit ───────────────────────────────────────────────────
echo ""
echo "→ Staging all changes..."
git add -A

echo "→ Committing..."
git commit -m "refactor(web): semantic HTML, mobile-first CSS, new fonts, hero illustration

- Convert all components to semantic HTML5 elements:
    <header>, <main>, <section>, <aside>, <footer>, <nav>, <address>
    aria-label, aria-labelledby, role attributes throughout
    <dl> for stats, <ol> for steps, <ul role=list> for grids

- Swap Syne/DM Sans → Plus Jakarta Sans (display) + Inter (body)
  cleaner, more legible at all sizes, especially mobile

- Hero redesigned (mobile-first two-column):
    Left: badge, h1, sub copy, capability pills, CTA buttons
    Right: custom inline SVG tech illustration (dark cards, green nodes)
    Copy updated to include web apps + mobile apps across all sectors
    grid-template-columns: 1fr → 1fr 1fr at 900px breakpoint

- Navbar (mobile-first):
    Logo <img> pre-wired with commented toggle instructions
    Desktop links hidden on mobile, shown 768px+
    Hamburger uses HTML hidden attr + CSS :not([hidden]) slide-in
    aria-expanded, aria-controls, aria-current on active link
    Esc key closes mobile menu

- cred-strip → <aside> with aria-label
- about stats → <dl> (dt + dd) for accessibility
- products/services/team → <ul role=list> with li cards
- how-it-works steps → <ol role=list>
- footer links → <nav aria-label> per column, <address> for contact

- vercel.json: rewrites for SPA routing, immutable asset cache,
    security headers (X-Frame-Options, X-Content-Type-Options, Referrer-Policy)
- Add 404.html and offline.html (branded, on-theme dark pages)
- responsive.css: pure additive mobile-first breakpoints (768, 1024px)
- tokens.css: --px clamp for fluid horizontal padding"

echo ""
echo "✅  Done. All files updated and committed."
BASHEOF