#!/usr/bin/env bash
# =============================================================================
#  klassrun-reposition.sh
#  ----------------------
#  Repositions klassrun-web from "AI lesson note generator" to
#  "AI-powered school operating system for Nigerian schools."
#
#  - Run from the ROOT of the klassrun-web repo
#  - Idempotent: safe to run multiple times
#  - Creates a timestamped backup before any change
#  - Logs every file touched and what changed
#  - No external dependencies beyond bash + sed + grep
#
#  Usage:
#     chmod +x klassrun-reposition.sh
#     ./klassrun-reposition.sh
#
#  Then review with:
#     git diff
# =============================================================================

set -euo pipefail

# -----------------------------------------------------------------------------
#  Pretty output
# -----------------------------------------------------------------------------
GREEN="\033[0;32m"
BLUE="\033[0;34m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
BOLD="\033[1m"
RESET="\033[0m"

log()    { echo -e "${BLUE}›${RESET}  $*"; }
ok()     { echo -e "${GREEN}✓${RESET}  $*"; }
warn()   { echo -e "${YELLOW}!${RESET}  $*"; }
err()    { echo -e "${RED}✗${RESET}  $*" >&2; }
hdr()    { echo -e "\n${BOLD}━━━ $* ━━━${RESET}"; }

# -----------------------------------------------------------------------------
#  Sanity check — must be run from the klassrun-web root
# -----------------------------------------------------------------------------
hdr "Pre-flight checks"

if [[ ! -f "package.json" ]]; then
  err "package.json not found. Run this script from the klassrun-web root."
  exit 1
fi

if ! grep -q '"name": *"klassrun-web"' package.json 2>/dev/null && \
   ! grep -q "klassrun" package.json 2>/dev/null; then
  warn "This doesn't look like the klassrun-web repo. Continue anyway? (y/N)"
  read -r reply
  [[ "$reply" =~ ^[Yy]$ ]] || exit 1
fi

ok "Running from klassrun-web root"

# -----------------------------------------------------------------------------
#  Backup
# -----------------------------------------------------------------------------
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_DIR=".reposition-backup-${TIMESTAMP}"
mkdir -p "$BACKUP_DIR"

backup() {
  local file="$1"
  if [[ -f "$file" ]]; then
    local target_dir
    target_dir="$BACKUP_DIR/$(dirname "$file")"
    mkdir -p "$target_dir"
    cp "$file" "$BACKUP_DIR/$file"
  fi
}

# Cross-platform sed -i (macOS vs Linux)
sedi() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i "" "$@"
  else
    sed -i "$@"
  fi
}

CHANGED_FILES=()
record_change() {
  CHANGED_FILES+=("$1")
}

# -----------------------------------------------------------------------------
#  1. app/layout.jsx — metadata, OG, JSON-LD
# -----------------------------------------------------------------------------
hdr "1/7  Updating SEO metadata (app/layout.jsx)"

LAYOUT="app/layout.jsx"
if [[ -f "$LAYOUT" ]]; then
  backup "$LAYOUT"

  # Title
  sedi "s|Klassrun Technologies Ltd — AI-Powered EdTech for Nigerian Schools|Klassrun — The AI-powered School Operating System for Nigerian Schools|g" "$LAYOUT"

  # Main description
  sedi "s|Klassrun Technologies Ltd is a CAC-registered EdTech company building AI-powered software for Nigerian schools — automated lesson notes, WAEC/NECO exam questions, and school management systems.|Klassrun is the AI-powered school operating system for Nigerian private schools. One platform for lesson notes, schemes of work, WAEC/NECO-style exam preparation, results, parents, and school operations — built for the Nigerian curriculum.|g" "$LAYOUT"

  # OG title
  sedi "s|title: 'Klassrun Technologies Ltd — AI-Powered EdTech for Nigerian Schools'|title: 'Klassrun — The AI-powered School Operating System for Nigerian Schools'|g" "$LAYOUT"

  # OG description
  sedi "s|CAC-registered EdTech company building AI-powered software for Nigerian schools. Lesson notes, exam questions, and school management — all curriculum-aligned.|Run your school's academics from one place. AI-powered lesson notes, schemes of work, WAEC/NECO exam prep, results, and parent portal — built for Nigerian schools.|g" "$LAYOUT"

  # Twitter description
  sedi "s|description: 'AI-powered EdTech software for Nigerian schools.',|description: 'The AI-powered school operating system for Nigerian schools.',|g" "$LAYOUT"

  # JSON-LD description
  sedi "s|'AI-powered EdTech software for Nigerian schools — lesson notes, exam questions, and school management systems.'|'The AI-powered school operating system for Nigerian schools — lesson notes, schemes of work, WAEC/NECO exam preparation, results, and parent portal, all built for the Nigerian curriculum.'|g" "$LAYOUT"

  # Keywords — replace the array with a stronger one
  python3 - <<'PY' || true
import re, pathlib
p = pathlib.Path("app/layout.jsx")
s = p.read_text()
new_keywords = """  keywords: [
    'School operating system Nigeria',
    'AI for Nigerian schools',
    'school management software Nigeria',
    'EdTech Nigeria',
    'AI lesson note generator Nigeria',
    'WAEC exam questions AI',
    'NECO exam questions',
    'NERDC curriculum software',
    'Nigerian private school SaaS',
    'school portal Nigeria',
    'Klassrun',
    'Klassrun Technologies',
  ],"""
s2 = re.sub(
    r"  keywords:\s*\[[^\]]*\],",
    new_keywords,
    s,
    count=1,
    flags=re.DOTALL,
)
if s != s2:
    p.write_text(s2)
PY

  ok "Updated $LAYOUT"
  record_change "$LAYOUT"
else
  warn "$LAYOUT not found — skipping"
fi

# -----------------------------------------------------------------------------
#  2. components/Hero.jsx — hero headline + subline
# -----------------------------------------------------------------------------
hdr "2/7  Updating hero headline (components/Hero.jsx)"

HERO="components/Hero.jsx"
if [[ -f "$HERO" ]]; then
  backup "$HERO"

  # Pill text
  sedi "s|Built for Nigerian Schools|The Nigerian School Operating System|g" "$HERO"

  # Subhead
  sedi "s|KlassRun saves your teachers 10–15 hours every week by|Klassrun is the AI-powered operating system for Nigerian schools. Run your|g" "$HERO"

  sedi "s|auto-generating curriculum-aligned content — NERDC topics,|academics from one place — lesson notes, schemes of work,|g" "$HERO"

  sedi "s|WAEC/NECO standards, school-branded PDFs. All on autopilot.|WAEC/NECO exam prep, results, and parent portal. Built for the Nigerian curriculum.|g" "$HERO"

  ok "Updated $HERO"
  record_change "$HERO"
else
  warn "$HERO not found — skipping"
fi

# -----------------------------------------------------------------------------
#  3. components/About.jsx — pain framing (broaden beyond lesson notes)
# -----------------------------------------------------------------------------
hdr "3/7  Broadening pain framing (components/About.jsx)"

ABOUT="components/About.jsx"
if [[ -f "$ABOUT" ]]; then
  backup "$ABOUT"

  sedi "s|Your school deserves better than manual processes|Run your entire school from one place|g" "$ABOUT"

  sedi "s|KlassRun eliminates the repetitive admin work that burns teachers out, so they can focus on what actually matters — teaching.|Klassrun replaces lesson plan templates, exam prep folders, scheme of work files, and supervisor checklists with one AI-powered system that runs your school's academics end to end.|g" "$ABOUT"

  ok "Updated $ABOUT"
  record_change "$ABOUT"
else
  warn "$ABOUT not found — skipping"
fi

# -----------------------------------------------------------------------------
#  4. components/Product.jsx — section header (broaden scope)
# -----------------------------------------------------------------------------
hdr "4/7  Broadening product framing (components/Product.jsx)"

PRODUCT="components/Product.jsx"
if [[ -f "$PRODUCT" ]]; then
  backup "$PRODUCT"

  sedi "s|Everything your teachers need. Nothing they don't.|Everything your school needs. Nothing it doesn't.|g" "$PRODUCT"

  sedi "s|KlassRun automates the work your teachers do every week — so they spend less time writing and more time teaching.|Klassrun gives Nigerian schools one platform for academics, exam preparation, and academic oversight — with AI built specifically for the Nigerian curriculum.|g" "$PRODUCT"

  ok "Updated $PRODUCT"
  record_change "$PRODUCT"
else
  warn "$PRODUCT not found — skipping"
fi

# -----------------------------------------------------------------------------
#  5. components/CTA.jsx — closing pitch
# -----------------------------------------------------------------------------
hdr "5/7  Updating CTA copy (components/CTA.jsx)"

CTA="components/CTA.jsx"
if [[ -f "$CTA" ]]; then
  backup "$CTA"

  sedi "s|Your teachers deserve better than spending every evening writing|Stop juggling templates, WhatsApp groups, and last-minute exam prep.|g" "$CTA"

  sedi "s|lesson notes. KlassRun gives them their time back — starting today.|Klassrun runs your school — starting today.|g" "$CTA"

  ok "Updated $CTA"
  record_change "$CTA"
else
  warn "$CTA not found — skipping"
fi

# -----------------------------------------------------------------------------
#  6. components/Footer.jsx — tagline
# -----------------------------------------------------------------------------
hdr "6/7  Updating footer tagline (components/Footer.jsx)"

FOOTER="components/Footer.jsx"
if [[ -f "$FOOTER" ]]; then
  backup "$FOOTER"

  sedi "s|AI-powered lesson notes, exam questions, and school management —|The AI-powered school operating system for Nigerian schools. Lesson notes,|g" "$FOOTER"

  sedi "s|built exclusively for Nigerian schools. Save your teachers 10+|exam prep, schemes of work, and academic oversight — built for the|g" "$FOOTER"

  sedi "s|hours every week.|Nigerian curriculum.|g" "$FOOTER"

  ok "Updated $FOOTER"
  record_change "$FOOTER"
else
  warn "$FOOTER not found — skipping"
fi

# -----------------------------------------------------------------------------
#  7. public/llms.txt — AI discovery file (rewrite cleanly)
# -----------------------------------------------------------------------------
hdr "7/7  Rewriting AI discovery file (public/llms.txt)"

LLMS="public/llms.txt"
if [[ -f "$LLMS" ]]; then
  backup "$LLMS"

  cat > "$LLMS" <<'EOF'
# Klassrun Technologies Ltd

> The AI-powered school operating system for Nigerian schools. One platform for lesson notes, schemes of work, WAEC/NECO exam preparation, results, parent portal, and academic oversight — built for the Nigerian curriculum.

## About

Klassrun Technologies Ltd is a CAC-registered EdTech company (RC 9463863) incorporated in Lagos, Nigeria on April 3, 2026. The company builds Klassrun, an AI-powered school operating system for Nigerian private primary and secondary schools.

Klassrun is positioned as a complete School OS — not a lesson note generator. The AI-powered academic engine (lesson notes, schemes of work, exam questions) is the wedge; results management, parent portal, attendance, fees, and school operations follow as schools adopt the platform.

## Positioning

Klassrun is the AI-powered school operating system for Nigerian schools. Each school operates on their own subdomain (school-name.klassrun.com) with isolated data, branded portals, and a unified academic workflow.

We are not "AI for lesson notes." We are a school operating system, with AI as the engine.

## The Problem Klassrun Solves

Nigerian private schools currently juggle Word templates for lesson notes, Excel spreadsheets for results, WhatsApp groups for parent communication, paper folders for schemes of work, and last-minute scrambles to prepare WAEC/NECO-standard exam questions. There is no single system that runs school academics end to end while being aligned to the Nigerian curriculum (NERDC) and examination standards (WAEC, NECO).

Klassrun replaces all of this with one AI-powered platform.

## Product Capabilities

### Tier S — AI Academic Core (Phase 1)
- AI Lesson Note Generator — curriculum-aligned, generated in under 60 seconds
- Scheme of Work Generator — full 12-week termly schemes per subject and class
- Exam Question Generator — WAEC, NECO, GCE, BECE style with configurable difficulty
- School Question Bank with deduplication — never repeat exam questions
- Education-only AI guardrails — restricted to academic tasks only
- Curriculum alignment to NERDC, WAEC, NECO standards

### Tier A — Platform Foundation (Phase 1)
- Multi-tenant SaaS architecture — each school on their own subdomain
- Per-school branding (logo, color, letterhead on PDFs)
- Subscription billing via Paystack (14-day free trial)
- Roles: Super Admin, School Admin, Teacher

### Tier B — Sticky Operations (Phase 2)
- Results and grading system with PDF report cards
- AI-generated report card comments
- Parent portal with magic-link auth
- Attendance management
- Student management (admissions, profiles, transfers)

### Tier C — Full School Operations (Phase 3)
- Fees and payment management with Account Officer role
- SMS, WhatsApp, email notifications
- Staff management (HR)
- CBT / online examinations
- Timetable management with conflict detection
- Document management
- Reporting and analytics

### Tier D / E — On-Demand Modules (Phase 4)
- Hostel, transport, library, inventory, accounting modules
- Advanced AI: performance analysis, dropout prediction, smart admission ranking

## Target Market

- Primary: Private primary and secondary schools in Nigeria (50,000+ registered)
- Initial focus: Lagos and Abuja
- Secondary: Mission and church school networks
- Future: Government schools via ministry procurement

## Architecture

- klassrun.com — marketing site (this site)
- app.klassrun.com — authentication, super admin, school portal entry
- {school-slug}.klassrun.com — individual school portals
- api.klassrun.com — backend API (Node.js, Express, PostgreSQL, Prisma)

Multi-tenancy is enforced at the data layer via scoped Prisma client. Each school's data is isolated by schoolId in every query.

## Curriculum Alignment

Klassrun content aligns to:
- NERDC (Nigerian Educational Research and Development Council) national curriculum
- WAEC (West African Examinations Council) examination standards
- NECO (National Examinations Council) examination standards

Note: We generate content in WAEC/NECO style. There is no public WAEC/NECO API.

## Pricing

Subscription-based, billed per term (the way Nigerian schools budget). Three tiers: Starter, Standard, and Premium. Annual billing available at a discount. Enterprise pricing for school networks with 3+ schools. 14-day free trial, no credit card required.

## Product Status

Phase 1 in active build. Multi-tenant foundation, schema, and AI integration in progress. Landing page live at klassrun.com. Application platform at app.klassrun.com.

## Leadership

- Adegbite Muhammed Adedamola — Co-founder & CEO
- Afeez Temitope Bello — Co-founder & CTO

## Company Details

- Company: Klassrun Technologies Ltd
- Registration: CAC RC 9463863
- Location: Lagos, Nigeria
- Website: https://klassrun.com
- App: https://app.klassrun.com
- Email: info@klassrun.com
- LinkedIn: https://www.linkedin.com/in/klassrun-ng-33013b400/
- Instagram: https://www.instagram.com/klassrun/

## Links

- [Homepage](https://klassrun.com)
- [App Platform](https://app.klassrun.com)
EOF

  ok "Rewrote $LLMS"
  record_change "$LLMS"
else
  warn "$LLMS not found — skipping"
fi

# -----------------------------------------------------------------------------
#  Optional: app/manifest.js — PWA description
# -----------------------------------------------------------------------------
MANIFEST="app/manifest.js"
if [[ -f "$MANIFEST" ]]; then
  backup "$MANIFEST"
  if grep -q "AI-powered EdTech software solutions for Nigerian schools" "$MANIFEST"; then
    sedi "s|AI-powered EdTech software solutions for Nigerian schools — lesson notes, exam questions, and school management.|The AI-powered school operating system for Nigerian schools. Lesson notes, exam prep, schemes of work, results, and parent portal — built for the Nigerian curriculum.|g" "$MANIFEST"
    ok "Updated $MANIFEST"
    record_change "$MANIFEST"
  fi
fi

# -----------------------------------------------------------------------------
#  Summary
# -----------------------------------------------------------------------------
hdr "Done"

echo
echo "Files modified:"
for f in "${CHANGED_FILES[@]}"; do
  echo "   • $f"
done

echo
ok "Backup saved to: $BACKUP_DIR"
echo
log "Review changes with:"
echo "     git diff"
echo
log "Restore from backup if needed:"
echo "     cp -r $BACKUP_DIR/* ."
echo
log "Then test locally:"
echo "     npm run dev"
echo
log "When ready, commit and push:"
echo "     git add -A && git commit -m 'reposition: school OS messaging' && git push"
echo
warn "Manual follow-ups (script can't reliably do these):"
echo "   • Update OG image (public/images/og-image.webp) to reflect new tagline"
echo "   • Re-submit sitemap to Google Search Console"
echo "   • Refresh LinkedIn / Instagram bios with new positioning"
echo "   • Consider adding a /pricing meta description in your specific page metadata"
echo
