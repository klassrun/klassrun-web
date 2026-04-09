#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────
#  fix_all.sh — run from the ROOT of klassrun-web project
#  bash fix_all.sh
# ─────────────────────────────────────────────────────────────────
set -e
ROOT="$(pwd)"

if [ ! -f "$ROOT/index.html" ] || [ ! -d "$ROOT/components" ]; then
  echo "❌  Run this from the klassrun-web project root (where index.html is)"
  exit 1
fi

echo "→ Fixing all files in: $ROOT"

# ── 1. tokens.css — add --padding-x alias so old CSS still works ──────────
cat > "$ROOT/css/tokens.css" << 'EOF'
/* tokens.css */
:root {
  --green:         #3DB54A;
  --green-dark:    #2a8a35;
  --green-deeper:  #1f6b28;
  --green-light:   #eafbec;
  --green-mid:     #b8eabd;
  --charcoal:      #0f1117;
  --charcoal-2:    #181c23;
  --charcoal-3:    #1e232c;
  --muted:         #64748b;
  --muted-light:   #94a3b8;
  --off-white:     #f6f8f7;
  --white:         #ffffff;
  --border:        rgba(61,181,74,0.13);
  --border-soft:   rgba(0,0,0,0.07);
  --radius-sm:     8px;
  --radius:        14px;
  --radius-lg:     22px;
  --shadow:        0 4px 24px rgba(0,0,0,0.07);
  --shadow-green:  0 8px 32px rgba(61,181,74,0.18);
  --font-display:  'Plus Jakarta Sans', sans-serif;
  --font-body:     'Inter', sans-serif;
  --max-width:     1160px;
  --px:            clamp(1rem, 4vw, 4rem);
  --padding-x:     clamp(1rem, 4vw, 4rem); /* alias kept for old CSS */
  --transition:    all 0.22s ease;
}
EOF
echo "  ✓ css/tokens.css"

# ── 2. navbar.css ─────────────────────────────────────────────────────────
cat > "$ROOT/css/navbar.css" << 'EOF'
/* navbar.css — mobile-first */
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
  padding: 0 1.25rem;
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 60px;
}
.nav-logo {
  display: flex;
  flex-direction: row;
  align-items: center;
  gap: 0.55rem;
  text-decoration: none;
  flex-shrink: 0;
  min-width: 0;
}
.nav-logo-img {
  height: 34px;
  width: 34px;
  object-fit: contain;
  display: block;
  flex-shrink: 0;
}
.nav-logo-text {
  display: flex;
  flex-direction: column;
  gap: 2px;
  min-width: 0;
}
.nav-logo-wordmark {
  font-family: var(--font-display);
  font-weight: 800;
  font-size: 0.95rem;
  letter-spacing: -0.3px;
  line-height: 1;
  white-space: nowrap;
}
.logo-k { color: var(--charcoal); }
.logo-t { color: var(--green); }
.nav-logo-sub {
  font-family: var(--font-body);
  font-size: 0.5rem;
  color: var(--muted);
  font-weight: 400;
  letter-spacing: 0.05em;
  text-transform: uppercase;
  line-height: 1;
  white-space: nowrap;
}

/* Desktop links — hidden mobile */
.nav-links { display: none; }
.nav-links ul {
  display: flex;
  align-items: center;
  list-style: none;
  margin: 0;
  padding: 0;
}
.nav-links a {
  font-family: var(--font-body);
  font-size: 0.875rem;
  font-weight: 500;
  color: var(--muted);
  padding: 0.4rem 0.75rem;
  border-radius: var(--radius-sm);
  text-decoration: none;
  white-space: nowrap;
  display: block;
  transition: var(--transition);
}
.nav-links a:hover,
.nav-links a[aria-current="page"] { color: var(--charcoal); background: var(--off-white); }

.nav-cta { display: flex; align-items: center; gap: 0.5rem; flex-shrink: 0; }

/* Desktop CTA — hidden mobile */
.nav-cta-ghost,
.nav-cta-primary {
  display: none;
  align-items: center;
  justify-content: center;
  white-space: nowrap;
  text-decoration: none;
  font-family: var(--font-body);
  font-weight: 500;
  border-radius: var(--radius-sm);
  transition: var(--transition);
  cursor: pointer;
}
.nav-cta-ghost {
  padding: 0.48rem 0.95rem;
  border: 1.5px solid var(--border-soft);
  background: transparent;
  color: var(--charcoal);
  font-size: 0.85rem;
}
.nav-cta-ghost:hover { border-color: var(--green); color: var(--green); }
.nav-cta-primary {
  padding: 0.5rem 1rem;
  background: var(--green);
  color: #fff;
  font-size: 0.85rem;
  font-weight: 600;
  border: none;
}
.nav-cta-primary:hover { background: var(--green-dark); transform: translateY(-1px); }

/* Hamburger — visible mobile only */
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
  flex-shrink: 0;
  transition: background 0.18s;
}
.hamburger:hover { background: var(--off-white); }
.hamburger span {
  display: block;
  width: 20px;
  height: 2px;
  background: var(--charcoal);
  border-radius: 2px;
  transition: transform 0.28s cubic-bezier(0.4,0,0.2,1), opacity 0.22s ease;
  transform-origin: center;
}
.hamburger.open span:nth-child(1) { transform: translateY(7px)  rotate(45deg); }
.hamburger.open span:nth-child(2) { opacity: 0; transform: scaleX(0); }
.hamburger.open span:nth-child(3) { transform: translateY(-7px) rotate(-45deg); }

/* Mobile drawer */
.mobile-menu {
  position: fixed;
  top: 60px;
  left: 0; right: 0; bottom: 0;
  background: var(--white);
  z-index: 998;
  padding: 0.5rem 1.25rem 3rem;
  display: flex;
  flex-direction: column;
  border-top: 1px solid var(--border-soft);
  overflow-y: auto;
  transform: translateX(100%);
  transition: transform 0.3s cubic-bezier(0.4,0,0.2,1);
}
.mobile-menu:not([hidden]) { transform: translateX(0); }
.mobile-menu ul { list-style: none; margin: 0; padding: 0; }
.mobile-link {
  display: flex;
  align-items: center;
  font-family: var(--font-body);
  font-size: 1.05rem;
  font-weight: 500;
  color: var(--charcoal);
  padding: 1rem 0;
  border-bottom: 1px solid var(--border-soft);
  text-decoration: none;
  transition: color 0.18s, padding-left 0.2s;
}
.mobile-link:hover { color: var(--green); padding-left: 0.4rem; }
.mobile-cta { margin-top: 2rem; display: flex; flex-direction: column; gap: 0.75rem; }
.mobile-cta-ghost,
.mobile-cta-primary {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  padding: 0.9rem 1rem;
  border-radius: var(--radius-sm);
  font-family: var(--font-body);
  font-size: 1rem;
  text-decoration: none;
  text-align: center;
  transition: var(--transition);
  cursor: pointer;
  box-sizing: border-box;
}
.mobile-cta-ghost {
  border: 1.5px solid rgba(0,0,0,0.15);
  background: transparent;
  color: var(--charcoal);
  font-weight: 500;
}
.mobile-cta-ghost:hover { border-color: var(--green); color: var(--green); }
.mobile-cta-primary {
  border: none;
  background: var(--green);
  color: #ffffff;
  font-weight: 600;
}
.mobile-cta-primary:hover { background: var(--green-dark); }

@media (min-width: 768px) {
  .nav-inner           { padding: 0 var(--px); height: 64px; }
  .nav-links           { display: flex; }
  .nav-cta-ghost,
  .nav-cta-primary     { display: inline-flex; }
  .hamburger           { display: none; }
  .mobile-menu         { display: none !important; }
  .nav-logo-img        { height: 38px; width: 38px; }
  .nav-logo-wordmark   { font-size: 1.1rem; }
}
@media (min-width: 1024px) {
  .nav-logo-wordmark { font-size: 1.15rem; }
  .nav-links a { font-size: 0.9rem; padding: 0.45rem 0.85rem; }
}
EOF
echo "  ✓ css/navbar.css"

# ── 3. hero.css ───────────────────────────────────────────────────────────
cat > "$ROOT/css/hero.css" << 'EOF'
/* hero.css — mobile-first */
.hero {
  padding: 2.5rem 0 2.5rem;
  position: relative;
  overflow: hidden;
  background: var(--white);
}
.hero::before {
  content: '';
  position: absolute;
  top: -10%; left: -5%;
  width: 60%; height: 80%;
  border-radius: 50%;
  background: radial-gradient(ellipse, rgba(61,181,74,0.05) 0%, transparent 70%);
  pointer-events: none;
  z-index: 0;
}
.hero .container { position: relative; z-index: 1; }

/* Single column mobile */
.hero-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 2rem;
  align-items: center;
}

.hero-content { text-align: center; }

.hero-heading {
  font-family: var(--font-display);
  font-weight: 800;
  font-size: clamp(1.75rem, 7vw, 3.5rem);
  line-height: 1.1;
  letter-spacing: -0.5px;
  color: var(--charcoal);
  margin: 0 0 1rem;
}
.hero-em {
  font-style: normal;
  color: var(--green);
  display: block;
}

.hero-sub {
  font-family: var(--font-body);
  font-size: 0.925rem;
  color: var(--muted);
  line-height: 1.8;
  margin: 0 auto 1.4rem;
  max-width: 48ch;
}
.hero-sub strong { color: var(--charcoal); font-weight: 600; }

.hero-pills {
  display: flex;
  flex-wrap: wrap;
  gap: 0.4rem;
  justify-content: center;
  margin-bottom: 1.75rem;
  list-style: none;
  padding: 0;
}
.hero-pills li {
  background: var(--off-white);
  border: 1px solid var(--border-soft);
  color: var(--muted);
  font-family: var(--font-body);
  font-size: 0.7rem;
  font-weight: 500;
  padding: 0.25rem 0.7rem;
  border-radius: 99px;
}

.hero-btns {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.75rem;
  flex-wrap: wrap;
}
.btn-hero-p {
  padding: 0.82rem 1.5rem;
  border-radius: var(--radius-sm);
  background: var(--green);
  color: #fff;
  font-family: var(--font-body);
  font-size: 0.9rem;
  font-weight: 600;
  border: none;
  cursor: pointer;
  text-decoration: none;
  display: inline-flex;
  align-items: center;
  gap: 0.4rem;
  transition: var(--transition);
  white-space: nowrap;
}
.btn-hero-p:hover { background: var(--green-dark); transform: translateY(-2px); box-shadow: var(--shadow-green); }
.btn-hero-o {
  padding: 0.82rem 1.25rem;
  border-radius: var(--radius-sm);
  border: 1.5px solid rgba(0,0,0,0.11);
  background: transparent;
  color: var(--charcoal);
  font-family: var(--font-body);
  font-size: 0.9rem;
  font-weight: 500;
  cursor: pointer;
  text-decoration: none;
  display: inline-flex;
  align-items: center;
  gap: 0.4rem;
  transition: var(--transition);
  white-space: nowrap;
}
.btn-hero-o:hover { border-color: var(--green); color: var(--green); }

/* SVG illustration — hidden on smallest screens, shown from 480px */
.hero-visual {
  display: none;
  margin: 0;
  align-items: center;
  justify-content: center;
}
.hero-svg {
  width: 100%;
  max-width: 420px;
  height: auto;
  filter: drop-shadow(0 12px 40px rgba(61,181,74,0.1));
  animation: float 5.5s ease-in-out infinite;
}

@media (min-width: 480px) {
  .hero-visual { display: flex; }
}

/* Two column layout from 900px */
@media (min-width: 900px) {
  .hero { padding: 5rem 0 4.5rem; }
  .hero-grid {
    grid-template-columns: 1fr 1fr;
    gap: 3.5rem;
  }
  .hero-content   { text-align: left; }
  .hero-sub       { margin-left: 0; margin-right: 0; }
  .hero-pills     { justify-content: flex-start; }
  .hero-btns      { justify-content: flex-start; }
  .hero-heading   { font-size: clamp(2.2rem, 4vw, 3.5rem); letter-spacing: -1px; }
}
@media (min-width: 1200px) {
  .hero-heading { font-size: 3.6rem; letter-spacing: -1.5px; }
}
EOF
echo "  ✓ css/hero.css"

# ── 4. navbar.html ────────────────────────────────────────────────────────
cat > "$ROOT/components/navbar.html" << 'EOF'
<header class="nav" role="banner">
  <div class="nav-inner">
    <a href="/" class="nav-logo" aria-label="Klassrun Technologies — home">
      <img src="/assets/images/logo.webp" alt="Klassrun Technologies"
        class="nav-logo-img" width="34" height="34" loading="eager" fetchpriority="high"/>
      <span class="nav-logo-text">
        <span class="nav-logo-wordmark">
          <span class="logo-k">Klassrun</span><span class="logo-t"> Technologies</span>
        </span>
        <span class="nav-logo-sub">Ltd · RC 9463863 · Lagos</span>
      </span>
    </a>

    <nav class="nav-links" aria-label="Main navigation">
      <ul role="list">
        <li><a href="#about">About</a></li>
        <li><a href="#products">Products</a></li>
        <li><a href="#services">Services</a></li>
        <li><a href="#team">Team</a></li>
        <li><a href="#contact">Contact</a></li>
      </ul>
    </nav>

    <div class="nav-cta">
      <a href="mailto:klassrun@gmail.com" class="nav-cta-ghost">Contact us</a>
      <a href="#products" class="nav-cta-primary">Our products &rarr;</a>
      <button class="hamburger" id="hamburger"
        aria-label="Open navigation menu" aria-expanded="false" aria-controls="mobileMenu">
        <span></span><span></span><span></span>
      </button>
    </div>
  </div>
</header>

<div class="mobile-menu" id="mobileMenu"
  role="dialog" aria-label="Navigation menu" aria-modal="true" hidden>
  <nav aria-label="Mobile navigation">
    <ul role="list">
      <li><a href="#about"    class="mobile-link">About</a></li>
      <li><a href="#products" class="mobile-link">Products</a></li>
      <li><a href="#services" class="mobile-link">Services</a></li>
      <li><a href="#team"     class="mobile-link">Team</a></li>
      <li><a href="#contact"  class="mobile-link">Contact</a></li>
    </ul>
  </nav>
  <div class="mobile-cta">
    <a href="mailto:klassrun@gmail.com" class="mobile-cta-ghost">Contact us</a>
    <a href="#products" class="mobile-cta-primary">Our products &rarr;</a>
  </div>
</div>
EOF
echo "  ✓ components/navbar.html"

# ── 5. hero.html ──────────────────────────────────────────────────────────
cat > "$ROOT/components/hero.html" << 'EOF'
<main id="main-content">
<section class="hero" aria-labelledby="hero-heading">
  <div class="container">
    <div class="hero-grid">

      <div class="hero-content">
        <h1 id="hero-heading" class="hero-heading fade-up delay-1">
          Building technology that
          <em class="hero-em">powers education</em>
          and businesses forward
        </h1>
        <p class="hero-sub fade-up delay-2">
          Klassrun Technologies Ltd builds <strong>AI-powered school management systems</strong>,
          <strong>mobile apps</strong>, and <strong>web apps</strong> for Nigerian schools and
          organisations — empowering educators and businesses with technology that drives growth.
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

      <figure class="hero-visual fade-up delay-2" aria-hidden="true">
        <svg class="hero-svg" viewBox="0 0 480 420" fill="none"
          xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
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
          <ellipse cx="240" cy="210" rx="195" ry="175" fill="url(#bgGlow)"/>
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
          <rect x="55" y="55" width="225" height="148" rx="16" fill="url(#cardGrad)" stroke="#3DB54A" stroke-width="1.2" stroke-opacity="0.45"/>
          <rect x="55" y="55" width="225" height="5" rx="2" fill="url(#greenBar)"/>
          <rect x="74" y="78" width="56" height="8" rx="4" fill="#3DB54A" opacity="0.85"/>
          <text x="74" y="108" font-family="Inter,sans-serif" font-size="10" fill="#94a3b8">School Management OS</text>
          <rect x="74" y="118" width="145" height="5" rx="3" fill="#2e343b"/>
          <rect x="74" y="118" width="105" height="5" rx="3" fill="#3DB54A" opacity="0.65"/>
          <text x="74" y="143" font-family="Inter,sans-serif" font-size="8.5" fill="#64748b">Notes Generated</text>
          <text x="198" y="143" font-family="Inter,sans-serif" font-size="8.5" fill="#3DB54A" font-weight="600">1,240</text>
          <text x="74" y="158" font-family="Inter,sans-serif" font-size="8.5" fill="#64748b">Teacher hrs saved/wk</text>
          <text x="198" y="158" font-family="Inter,sans-serif" font-size="8.5" fill="#3DB54A" font-weight="600">12+</text>
          <text x="74" y="173" font-family="Inter,sans-serif" font-size="8.5" fill="#64748b">WAEC alignment</text>
          <text x="198" y="173" font-family="Inter,sans-serif" font-size="8.5" fill="#3DB54A" font-weight="600">100%</text>
          <text x="74" y="190" font-family="Inter,sans-serif" font-size="7.5" fill="#3DB54A" opacity="0.7">NERDC · WAEC · NECO</text>
          <rect x="200" y="228" width="180" height="115" rx="14" fill="url(#cardGrad)" stroke="#3DB54A" stroke-width="1" stroke-opacity="0.3"/>
          <rect x="200" y="228" width="180" height="4" rx="2" fill="url(#greenBar)"/>
          <text x="218" y="254" font-family="Inter,sans-serif" font-size="9.5" fill="#94a3b8">Mobile App</text>
          <rect x="218" y="263" width="23" height="40" rx="4" fill="none" stroke="#3DB54A" stroke-width="1.4"/>
          <rect x="221" y="267" width="17" height="29" rx="2" fill="#1e232c"/>
          <circle cx="229" cy="299" r="2" fill="#3DB54A" opacity="0.55"/>
          <rect x="253" y="292" width="4" height="14" rx="2" fill="#3DB54A" opacity="0.3"/>
          <rect x="261" y="285" width="4" height="21" rx="2" fill="#3DB54A" opacity="0.55"/>
          <rect x="269" y="278" width="4" height="28" rx="2" fill="#3DB54A" opacity="0.85"/>
          <text x="280" y="300" font-family="Inter,sans-serif" font-size="8.5" fill="#64748b">iOS &amp; Android</text>
          <text x="218" y="332" font-family="Inter,sans-serif" font-size="7.5" fill="#3DB54A">React Native · Flutter</text>
          <rect x="46" y="232" width="142" height="98" rx="12" fill="url(#cardGrad)" stroke="#3DB54A" stroke-width="1" stroke-opacity="0.3"/>
          <rect x="46" y="232" width="142" height="4" rx="2" fill="url(#greenBar)"/>
          <text x="62" y="255" font-family="Inter,sans-serif" font-size="9.5" fill="#94a3b8">Web Application</text>
          <rect x="62" y="262" width="108" height="52" rx="5" fill="none" stroke="#3DB54A" stroke-width="1.1" stroke-opacity="0.45"/>
          <rect x="62" y="262" width="108" height="11" rx="5" fill="#2e343b"/>
          <circle cx="70" cy="267" r="2" fill="#ef4444" opacity="0.6"/>
          <circle cx="78" cy="267" r="2" fill="#f59e0b" opacity="0.6"/>
          <circle cx="86" cy="267" r="2" fill="#3DB54A" opacity="0.6"/>
          <rect x="90" y="264" width="70" height="5" rx="2" fill="#1e232c"/>
          <rect x="68" y="279" width="88" height="4" rx="2" fill="#2e343b"/>
          <rect x="68" y="287" width="64" height="4" rx="2" fill="#2e343b"/>
          <rect x="68" y="295" width="76" height="4" rx="2" fill="#2e343b"/>
          <text x="62" y="322" font-family="Inter,sans-serif" font-size="7.5" fill="#3DB54A">React · Next.js · Node</text>
          <line x1="168" y1="203" x2="200" y2="232" stroke="#3DB54A" stroke-width="1" stroke-dasharray="4 5" stroke-opacity="0.35"/>
          <line x1="168" y1="203" x2="140" y2="232" stroke="#3DB54A" stroke-width="1" stroke-dasharray="4 5" stroke-opacity="0.35"/>
          <circle cx="168" cy="203" r="20" fill="#3DB54A" opacity="0.07"/>
          <circle cx="168" cy="203" r="13" fill="#3DB54A" opacity="0.14"/>
          <circle cx="168" cy="203" r="7" fill="#3DB54A"/>
          <text x="161" y="207" font-family="Inter,sans-serif" font-size="7" fill="#fff" font-weight="700">AI</text>
          <circle cx="398" cy="75" r="5" fill="#3DB54A" opacity="0.75"/>
          <circle cx="420" cy="118" r="3" fill="#3DB54A" opacity="0.45"/>
          <circle cx="442" cy="88" r="4" fill="#3DB54A" opacity="0.3"/>
          <line x1="398" y1="75" x2="420" y2="118" stroke="#3DB54A" stroke-width="0.8" stroke-opacity="0.28"/>
          <line x1="420" y1="118" x2="442" y2="88" stroke="#3DB54A" stroke-width="0.8" stroke-opacity="0.28"/>
          <line x1="398" y1="75" x2="442" y2="88" stroke="#3DB54A" stroke-width="0.8" stroke-opacity="0.28"/>
          <circle cx="38" cy="328" r="4" fill="#3DB54A" opacity="0.45"/>
          <circle cx="18" cy="350" r="3" fill="#3DB54A" opacity="0.28"/>
          <circle cx="54" cy="364" r="5" fill="#3DB54A" opacity="0.38"/>
          <line x1="38" y1="328" x2="18" y2="350" stroke="#3DB54A" stroke-width="0.8" stroke-opacity="0.22"/>
          <line x1="18" y1="350" x2="54" y2="364" stroke="#3DB54A" stroke-width="0.8" stroke-opacity="0.22"/>
          <line x1="38" y1="328" x2="54" y2="364" stroke="#3DB54A" stroke-width="0.8" stroke-opacity="0.22"/>
        </svg>
      </figure>

    </div>
  </div>
</section>
</main>
EOF
echo "  ✓ components/hero.html"

# ── 6. cred-strip.html — fix unclosed comment ─────────────────────────────
cat > "$ROOT/components/cred-strip.html" << 'EOF'
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
echo "  ✓ components/cred-strip.html (fixed unclosed comment)"

# ── 7. cred-strip.css — fix --padding-x ──────────────────────────────────
cat > "$ROOT/css/cred-strip.css" << 'EOF'
/* cred-strip.css */
.cred-strip {
  background: var(--charcoal);
  padding: 1rem var(--px);
}
.cred-inner {
  max-width: var(--max-width);
  margin: 0 auto;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1.5rem;
  flex-wrap: wrap;
}
.cred-item {
  display: flex;
  align-items: center;
  gap: 0.4rem;
  color: rgba(255,255,255,0.55);
  font-size: 0.78rem;
  margin: 0;
}
.cred-item strong { color: #fff; font-weight: 600; }
.cred-sep {
  width: 4px; height: 4px;
  border-radius: 50%;
  background: var(--green);
  opacity: 0.6;
  flex-shrink: 0;
}
@media (max-width: 480px) {
  .cred-sep { display: none; }
  .cred-inner { gap: 0.5rem 1rem; justify-content: flex-start; }
}
EOF
echo "  ✓ css/cred-strip.css"

# ── 8. about.html ─────────────────────────────────────────────────────────
cat > "$ROOT/components/about.html" << 'EOF'
<section class="section" id="about" aria-labelledby="about-heading">
  <div class="container">
    <div class="about-grid">
      <div class="reveal">
        <p class="about-label" aria-hidden="true">About us</p>
        <h2 id="about-heading" class="about-title d">
          We build technology that powers schools and businesses
        </h2>
        <p class="about-body">
          Klassrun Technologies Ltd is a Lagos-based software company building
          <strong>AI-powered school management systems</strong>, <strong>web applications</strong>,
          and <strong>mobile apps</strong> for Nigerian schools and organisations across all sectors.
          We turn complex manual processes into fast, intelligent software.
        </p>
        <p class="about-body">
          Our EdTech products are aligned to the Nigerian curriculum, WAEC and NECO standards,
          and designed around real infrastructure challenges schools face — low connectivity,
          manual record-keeping, and limited IT support. Beyond education, we build custom digital
          solutions for businesses that need to move faster.
        </p>
        <ul class="pill-row" aria-label="Our focus areas">
          <li class="pill">AI-powered tools</li>
          <li class="pill">Web applications</li>
          <li class="pill">Mobile apps</li>
          <li class="pill">WAEC &amp; NECO aligned</li>
          <li class="pill">PWA &amp; offline-ready</li>
          <li class="pill">School management</li>
        </ul>
      </div>
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
          <dt class="stat-lbl">Sectors we build software for</dt>
          <dd class="stat-num">All</dd>
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

# ── 9. products.html ──────────────────────────────────────────────────────
cat > "$ROOT/components/products.html" << 'EOF'
<section class="section products-bg" id="products" aria-labelledby="products-heading">
  <div class="container">
    <header class="section-header reveal">
      <p class="sec-label" aria-hidden="true">Our products</p>
      <h2 id="products-heading" class="sec-title d">Software we're building for schools</h2>
      <p class="sec-sub">
        Each product solves a specific real problem for Nigerian schools.
        KlassRun is our flagship — more are in development.
      </p>
    </header>
    <ul class="products-grid" role="list">
      <li class="product-card flagship reveal">
        <span class="product-status status-live" aria-label="Status: Flagship product">&#9679; Flagship</span>
        <div class="product-icon" aria-hidden="true">📖</div>
        <h3>KlassRun</h3>
        <p>AI-powered lesson note and exam question generator for Nigerian schools. Automatically aligned with NERDC, WAEC &amp; NECO standards. Saves teachers 12+ hours per week.</p>
        <ul class="product-tags" aria-label="Features">
          <li class="product-tag">Lesson notes</li>
          <li class="product-tag">Exam questions</li>
          <li class="product-tag">WAEC aligned</li>
          <li class="product-tag">PWA + offline</li>
          <li class="product-tag">School OS</li>
        </ul>
        <a href="#" class="product-link">Visit KlassRun &rarr;</a>
      </li>
      <li class="product-card reveal">
        <span class="product-status status-dev" aria-label="Status: In development">&#9679; In development</span>
        <div class="product-icon" aria-hidden="true">📊</div>
        <h3>SchoolMetrics</h3>
        <p>A data analytics dashboard for school proprietors — tracking student performance, teacher activity, and school efficiency across all classes and terms.</p>
        <ul class="product-tags" aria-label="Features">
          <li class="product-tag">Analytics</li>
          <li class="product-tag">Performance data</li>
          <li class="product-tag">School insights</li>
        </ul>
        <a href="#" class="product-link product-link--disabled" aria-disabled="true">Coming soon &rarr;</a>
      </li>
      <li class="product-card reveal">
        <span class="product-status status-soon" aria-label="Status: Planned">Planned</span>
        <div class="product-icon" aria-hidden="true">👨‍👩‍👧</div>
        <h3>ParentConnect</h3>
        <p>A parent-facing portal to view attendance, assessment scores, teacher comments, and term reports in real time — connected directly to the KlassRun platform.</p>
        <ul class="product-tags" aria-label="Features">
          <li class="product-tag">Parent portal</li>
          <li class="product-tag">Real-time updates</li>
          <li class="product-tag">Report cards</li>
        </ul>
        <a href="#" class="product-link product-link--disabled" aria-disabled="true">Coming soon &rarr;</a>
      </li>
    </ul>
  </div>
</section>
EOF
echo "  ✓ components/products.html"

# ── 10. services.html ─────────────────────────────────────────────────────
cat > "$ROOT/components/services.html" << 'EOF'
<section class="section" id="services" aria-labelledby="services-heading">
  <div class="container">
    <header class="section-header reveal">
      <p class="sec-label" aria-hidden="true">What we do</p>
      <h2 id="services-heading" class="sec-title d">Our capabilities</h2>
      <p class="sec-sub">
        CAC-registered and built to deliver across education and business.
        Here's what Klassrun Technologies does best.
      </p>
    </header>
    <ul class="services-grid" role="list">
      <li class="svc-card reveal">
        <span class="svc-icon" aria-hidden="true">🤖</span>
        <h3 class="svc-title">AI Software Development</h3>
        <p>We design and build AI-powered web apps and PWAs for schools and businesses across all sectors in Nigeria.</p>
      </li>
      <li class="svc-card reveal">
        <span class="svc-icon" aria-hidden="true">📱</span>
        <h3 class="svc-title">Mobile App Development</h3>
        <p>Cross-platform iOS and Android apps built with React Native and Flutter — for schools, startups, and enterprises.</p>
      </li>
      <li class="svc-card reveal">
        <span class="svc-icon" aria-hidden="true">📝</span>
        <h3 class="svc-title">Automated Content Generation</h3>
        <p>Lesson notes, exam questions, schemes of work, and report card comments — AI-generated in seconds, curriculum-aligned.</p>
      </li>
      <li class="svc-card reveal">
        <span class="svc-icon" aria-hidden="true">🏫</span>
        <h3 class="svc-title">School Management Systems</h3>
        <p>End-to-end digital school management — attendance, grading, student records, academic calendars, and parent portals.</p>
      </li>
      <li class="svc-card reveal">
        <span class="svc-icon" aria-hidden="true">📡</span>
        <h3 class="svc-title">Cloud &amp; Offline Platforms</h3>
        <p>Cloud-based platforms with offline-first capabilities — built for Nigerian internet and power realities.</p>
      </li>
      <li class="svc-card reveal">
        <span class="svc-icon" aria-hidden="true">🛠️</span>
        <h3 class="svc-title">Tech Consultancy</h3>
        <p>We help schools and organisations plan and adopt digital tools — from staff training to full custom deployments.</p>
      </li>
    </ul>
  </div>
</section>
EOF
echo "  ✓ components/services.html"

# ── 11. how-it-works.html + css ───────────────────────────────────────────
cat > "$ROOT/components/how-it-works.html" << 'EOF'
<section class="section how-bg" aria-labelledby="how-heading">
  <div class="container">
    <header class="section-header reveal">
      <p class="sec-label" aria-hidden="true">How it works</p>
      <h2 id="how-heading" class="sec-title d">From signup to running in minutes</h2>
      <p class="sec-sub" style="color:rgba(255,255,255,0.5)">
        Any teacher can start using our tools on day one. No IT department needed.
      </p>
    </header>
    <ol class="steps-grid reveal" aria-label="Steps to get started">
      <li class="step">
        <span class="step-num" aria-hidden="true">01</span>
        <h3 class="step-title">Set up your school</h3>
        <p>Add your school name, classes, subjects, and teachers. Takes less than 10 minutes.</p>
      </li>
      <li class="step">
        <span class="step-num" aria-hidden="true">02</span>
        <h3 class="step-title">Pick your subject</h3>
        <p>Select class, subject, term, and topic from our Nigerian curriculum library — built on NERDC standards.</p>
      </li>
      <li class="step">
        <span class="step-num" aria-hidden="true">03</span>
        <h3 class="step-title">Generate instantly</h3>
        <p>Click generate. Our AI delivers a complete, curriculum-aligned lesson note or exam paper in seconds.</p>
      </li>
      <li class="step">
        <span class="step-num" aria-hidden="true">04</span>
        <h3 class="step-title">Print or share</h3>
        <p>Download a school-branded PDF, share with students, or store in your school's document library.</p>
      </li>
    </ol>
  </div>
</section>
EOF

cat > "$ROOT/css/how-it-works.css" << 'EOF'
/* how-it-works.css — mobile-first */
.how-bg { background: var(--charcoal); }
.how-bg .sec-label { color: rgba(61,181,74,0.9); }
.how-bg .sec-title { color: #fff; }
.how-bg .sec-sub   { color: rgba(255,255,255,0.5); }

/* Mobile: single column stack */
.steps-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 1.75rem;
  margin-top: 2.5rem;
  list-style: none;
  padding: 0;
}
@media (min-width: 600px) {
  .steps-grid { grid-template-columns: repeat(2, 1fr); }
}
@media (min-width: 1024px) {
  .steps-grid { grid-template-columns: repeat(4, 1fr); gap: 2rem; }
}

.step-num {
  font-family: var(--font-display);
  font-weight: 800;
  font-size: 3rem;
  color: rgba(61,181,74,0.18);
  line-height: 1;
  margin-bottom: 0.75rem;
  display: block;
}
.step-title {
  font-family: var(--font-display);
  font-weight: 700;
  font-size: 0.975rem;
  color: #fff;
  margin-bottom: 0.5rem;
}
.step p {
  font-size: 0.855rem;
  color: rgba(255,255,255,0.48);
  line-height: 1.7;
}
EOF
echo "  ✓ components/how-it-works.html + css"

# ── 12. team.html + css ───────────────────────────────────────────────────
cat > "$ROOT/components/team.html" << 'EOF'
<section class="section products-bg" id="team" aria-labelledby="team-heading">
  <div class="container">
    <header class="section-header reveal">
      <p class="sec-label" aria-hidden="true">Our team</p>
      <h2 id="team-heading" class="sec-title d">The people behind Klassrun</h2>
      <p class="sec-sub">Three founders. One mission — make Nigerian schools run smarter with technology.</p>
    </header>
    <ul class="team-grid reveal" role="list">
      <li class="team-card">
        <div class="avatar" aria-hidden="true">AM</div>
        <h3 class="team-name">Adegbite Mohammed Adedamola</h3>
        <p class="team-role">Director &amp; Co-Founder</p>
        <p class="team-meta">Based in Ibadan, Oyo State</p>
        <span class="share-badge">40% shareholding</span>
      </li>
      <li class="team-card">
        <div class="avatar" aria-hidden="true">AT</div>
        <h3 class="team-name">Bello Afeez Temitope</h3>
        <p class="team-role">Director &amp; Co-Founder</p>
        <p class="team-meta">Based in Ajegunle, Lagos State</p>
        <span class="share-badge">40% shareholding</span>
      </li>
      <li class="team-card">
        <div class="avatar" aria-hidden="true">FK</div>
        <h3 class="team-name">Fashola Omolade Kaothar</h3>
        <p class="team-role">Director &amp; Co-Founder</p>
        <p class="team-meta">Based in Iju Ishaga, Lagos State</p>
        <span class="share-badge">20% shareholding</span>
      </li>
    </ul>
  </div>
</section>
EOF

cat > "$ROOT/css/team.css" << 'EOF'
/* team.css — mobile-first */
.team-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 1.25rem;
  margin-top: 2.5rem;
  list-style: none;
  padding: 0;
}
@media (min-width: 600px) {
  .team-grid { grid-template-columns: repeat(2, 1fr); }
}
@media (min-width: 900px) {
  .team-grid { grid-template-columns: repeat(3, 1fr); gap: 1.5rem; }
}

.team-card {
  background: var(--white);
  border: 1px solid var(--border-soft);
  border-radius: var(--radius);
  padding: 1.75rem 1.5rem;
  text-align: center;
  transition: var(--transition);
}
.team-card:hover {
  border-color: var(--green);
  transform: translateY(-3px);
  box-shadow: var(--shadow);
}
.avatar {
  width: 68px; height: 68px;
  border-radius: 50%;
  background: var(--green-light);
  display: flex; align-items: center; justify-content: center;
  font-family: var(--font-display);
  font-weight: 800; font-size: 1.1rem;
  color: var(--green-dark);
  margin: 0 auto 1.1rem;
  border: 2px solid var(--green-mid);
  overflow: hidden;
}
.avatar img { width: 100%; height: 100%; object-fit: cover; border-radius: 50%; }
.team-name {
  font-family: var(--font-display);
  font-weight: 700;
  font-size: 0.9rem;
  margin-bottom: 0.3rem;
  color: var(--charcoal);
}
.team-role {
  font-size: 0.78rem;
  color: var(--green);
  font-weight: 600;
  margin-bottom: 0.35rem;
}
.team-meta {
  font-size: 0.75rem;
  color: var(--muted-light);
  line-height: 1.5;
  margin: 0;
}
.share-badge {
  display: inline-block;
  margin-top: 0.65rem;
  background: var(--off-white);
  border: 1px solid var(--border-soft);
  font-size: 0.7rem;
  font-weight: 600;
  color: var(--muted);
  padding: 0.22rem 0.65rem;
  border-radius: 99px;
}
EOF
echo "  ✓ components/team.html + css"

# ── 13. footer.html + css ─────────────────────────────────────────────────
cat > "$ROOT/components/footer.html" << 'EOF'
<footer role="contentinfo">
  <div class="footer-grid">
    <div class="footer-brand">
      <img src="/assets/images/logo-white.webp" alt="Klassrun Technologies"
        class="footer-logo-img" width="120" height="32" loading="lazy"/>
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
    <nav class="footer-col" aria-label="Products">
      <h4 class="footer-col-heading">Products</h4>
      <ul role="list">
        <li><a href="#">KlassRun</a></li>
        <li><a href="#" class="disabled" aria-disabled="true">SchoolMetrics (soon)</a></li>
        <li><a href="#" class="disabled" aria-disabled="true">ParentConnect (soon)</a></li>
      </ul>
    </nav>
    <nav class="footer-col" aria-label="Company">
      <h4 class="footer-col-heading">Company</h4>
      <ul role="list">
        <li><a href="#about">About us</a></li>
        <li><a href="#services">Services</a></li>
        <li><a href="#team">Our team</a></li>
        <li><a href="#contact">Contact</a></li>
      </ul>
    </nav>
    <nav class="footer-col" aria-label="Legal">
      <h4 class="footer-col-heading">Legal</h4>
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

cat > "$ROOT/css/footer.css" << 'EOF'
/* footer.css — mobile-first */
footer {
  background: var(--charcoal-2);
  border-top: 1px solid rgba(255,255,255,0.05);
  padding: 3rem var(--px) 1.5rem;
}
/* Mobile: single column */
.footer-grid {
  max-width: var(--max-width);
  margin: 0 auto;
  display: grid;
  grid-template-columns: 1fr;
  gap: 2rem;
  padding-bottom: 2rem;
  border-bottom: 1px solid rgba(255,255,255,0.06);
}
@media (min-width: 600px) {
  .footer-grid { grid-template-columns: 1fr 1fr; }
  .footer-brand { grid-column: span 2; }
}
@media (min-width: 1024px) {
  .footer-grid { grid-template-columns: 2fr 1fr 1fr 1fr; gap: 3rem; }
  .footer-brand { grid-column: span 1; }
}

.footer-logo-img {
  height: 32px; width: auto;
  object-fit: contain;
  margin-bottom: 0.75rem;
  display: block;
}
.footer-desc {
  color: rgba(255,255,255,0.4);
  font-size: 0.82rem;
  line-height: 1.7;
  margin: 0.5rem 0 0;
}
.footer-reg {
  margin-top: 1.1rem;
  display: flex;
  flex-direction: column;
  gap: 0.28rem;
  font-style: normal;
}
.footer-reg span { color: rgba(255,255,255,0.35); font-size: 0.73rem; }
.footer-reg strong { color: rgba(255,255,255,0.7); }
.footer-reg a { color: rgba(255,255,255,0.7); text-decoration: none; }
.footer-reg a:hover { color: var(--green); }

.footer-col-heading {
  color: rgba(255,255,255,0.6);
  font-family: var(--font-body);
  font-size: 0.72rem;
  font-weight: 700;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  margin-bottom: 0.9rem;
}
.footer-col ul {
  list-style: none;
  padding: 0; margin: 0;
  display: flex; flex-direction: column; gap: 0.55rem;
}
.footer-col ul li a {
  color: rgba(255,255,255,0.5);
  font-size: 0.845rem;
  text-decoration: none;
  transition: color 0.2s;
}
.footer-col ul li a:hover { color: var(--green); }
.footer-col ul li a.disabled { pointer-events: none; opacity: 0.35; }

.footer-bottom {
  max-width: var(--max-width);
  margin: 1.5rem auto 0;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 0.5rem;
}
.footer-bottom small { color: rgba(255,255,255,0.28); font-size: 0.75rem; }
EOF
echo "  ✓ components/footer.html + css"

# ── 14. cta.css — fix --padding-x ────────────────────────────────────────
cat > "$ROOT/css/cta.css" << 'EOF'
/* cta.css */
.cta-section { padding: 4rem var(--px) 5rem; }
.cta-box {
  max-width: var(--max-width);
  margin: 0 auto;
  background: var(--green);
  border-radius: var(--radius-lg);
  padding: 3rem 1.5rem;
  text-align: center;
  position: relative;
  overflow: hidden;
}
@media (min-width: 768px) {
  .cta-box { padding: 5rem 3rem; }
}
.cta-box::before {
  content: ''; position: absolute;
  top: -100px; right: -100px;
  width: 400px; height: 400px;
  border-radius: 50%;
  background: rgba(255,255,255,0.06);
  pointer-events: none;
}
.cta-box::after {
  content: ''; position: absolute;
  bottom: -80px; left: -80px;
  width: 280px; height: 280px;
  border-radius: 50%;
  background: rgba(255,255,255,0.04);
  pointer-events: none;
}
.cta-box h2 {
  font-family: var(--font-display);
  font-weight: 800;
  color: #fff;
  font-size: clamp(1.5rem, 4vw, 2.4rem);
  letter-spacing: -0.8px;
  margin-bottom: 0.9rem;
}
.cta-box p {
  color: rgba(255,255,255,0.75);
  font-size: 0.975rem;
  max-width: 480px;
  margin: 0 auto 2rem;
  line-height: 1.75;
}
.cta-btns { display: flex; gap: 0.9rem; justify-content: center; flex-wrap: wrap; }
.btn-cta-w {
  padding: 0.85rem 2rem;
  background: #fff;
  color: var(--green-dark);
  border: none;
  border-radius: 10px;
  font-family: var(--font-body);
  font-size: 0.925rem;
  font-weight: 700;
  cursor: pointer;
  transition: var(--transition);
  display: inline-flex;
  align-items: center;
  gap: 0.4rem;
  text-decoration: none;
}
.btn-cta-w:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(0,0,0,0.15); }
.btn-cta-t {
  padding: 0.85rem 1.75rem;
  background: rgba(255,255,255,0.15);
  color: #fff;
  border: 1.5px solid rgba(255,255,255,0.3);
  border-radius: 10px;
  font-family: var(--font-body);
  font-size: 0.925rem;
  font-weight: 500;
  cursor: pointer;
  transition: var(--transition);
  display: inline-flex;
  align-items: center;
  gap: 0.4rem;
  text-decoration: none;
}
.btn-cta-t:hover { background: rgba(255,255,255,0.22); }
EOF
echo "  ✓ css/cta.css"

# ── 15. responsive.css — clean, no conflicts ─────────────────────────────
cat > "$ROOT/css/responsive.css" << 'EOF'
/* responsive.css — only overrides not already in component CSS */
/* products, services, team, steps all handle their own breakpoints */
/* This file handles about-grid and footer-grid at tablet+ */

@media (min-width: 768px) {
  .about-grid {
    grid-template-columns: 1fr 1fr;
    gap: 4rem;
    align-items: center;
  }
  .stat-num { font-size: 2rem; }
}
@media (min-width: 1024px) {
  .about-grid { gap: 5rem; }
  .stat-num   { font-size: 2.2rem; }
}
EOF
echo "  ✓ css/responsive.css"

# ── 16. Git commit ────────────────────────────────────────────────────────
echo ""
echo "→ Staging all changes..."
git add -A
git commit -m "fix: complete mobile-first overhaul — all sections, navbar, CSS bugs

Bugs fixed:
- cred-strip.html: unclosed HTML comment made the entire aside invisible
- tokens.css: added --padding-x alias (footer/cta used it, only --px existed)
- footer.css: was using --padding-x (undefined) + h5 selector but HTML had h3
- footer.html: changed h3 → h4.footer-col-heading, added logo-white.webp img
- footer.css: mobile-first grid (1col → 2col at 600px → 4col at 1024px)
- how-it-works.css: grid was repeat(4,1fr) with no mobile base; fixed to 1fr→2col→4col
- how-it-works.html: step headings h4→h3.step-title to match CSS
- team.css: grid was repeat(3,1fr) with no mobile base; fixed to 1fr→2col→3col
- team.html: h4→h3.team-name for heading hierarchy
- responsive.css: removed duplicate grid overrides that fought component CSS
- hero.css: hero-visual hidden on mobile (display:none), shown from 480px
  so text has full width and doesnt overflow at 504px
- cta.css: padding used --padding-x (undefined); switched to --px
- cred-strip.css: padding used --padding-x; switched to --px
- navbar: nav-cta-ghost/primary are display:none mobile, inline-flex 768px+
  completely isolated from base.css .btn class (zero specificity conflict)
- All grids now mobile-first: 1 column base, additive breakpoints at 600/768/1024px"

echo ""
echo "✅  All done. Run: cd klassrun-web && bash fix_all.sh"
