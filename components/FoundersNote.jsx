'use client'

// components/FoundersNote.jsx
// leads-founders-note
import { ArrowRight } from 'lucide-react'
import { Section } from './ui/Section'
import { openLeadForm } from './LeadModal'

export default function FoundersNote() {
  return (
    <Section id="founders" surface="mint">
      <div className="mx-auto max-w-3xl">
        <p className="mb-4 text-xs font-bold uppercase tracking-[0.18em] text-primary">
          A note from the founders
        </p>
        <div className="space-y-5 text-base leading-relaxed text-foreground/85 sm:text-lg">
          <p>
            We built Klassrun after years of watching Nigerian schools run on paper and late nights.
            Teachers giving up whole weekends to write lesson notes by hand. Results compiled in
            exercise books, term after term. Proprietors chasing school fees on WhatsApp, one parent
            at a time.
          </p>
          <p>
            So we built the system we wished existed: report cards ready in minutes, lesson notes
            aligned to the curriculum, WAEC-style exam questions, and fee tracking that actually
            works. Priced per term, because that&apos;s how schools here budget.
          </p>
          <p>
            We&apos;re a young company. We won&apos;t pretend otherwise. What you get in exchange for
            taking a chance on us is simple: our full attention. Every school we onboard right now,
            we know by name. When you call, a founder picks up.
          </p>
          <p className="font-bold text-foreground">
            If that sounds like the kind of partner you want, come see the product. It&apos;ll take
            fifteen minutes.
          </p>
        </div>

        <div className="mt-8 flex flex-col gap-3 sm:flex-row">
          <button
            onClick={() => openLeadForm('demo')}
            className="group inline-flex items-center justify-center gap-2 rounded-full bg-primary px-7 py-3.5 text-sm font-bold text-primary-foreground hover:bg-klassrun-green-dark transition-colors"
          >
            Book a demo
            <ArrowRight size={16} className="transition-transform group-hover:translate-x-0.5" />
          </button>
          <a
            href="mailto:info@klassrun.com"
            className="inline-flex items-center justify-center gap-2 rounded-full border border-soft bg-white px-7 py-3.5 text-sm font-bold text-foreground hover:bg-secondary transition-colors"
          >
            Or email info@klassrun.com
          </a>
        </div>
      </div>
    </Section>
  )
}
