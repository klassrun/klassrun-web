'use client'

// components/FoundingSchools.jsx
// leads-founding-schools
import { Lock, MessageCircle, ListChecks, Wrench, ArrowRight } from 'lucide-react'
import { Section } from './ui/Section'
import { openLeadForm } from './LeadModal'

const PERKS = [
  {
    icon: Lock,
    title: 'Founding price, locked for life',
    body: '20% off the standard per-term rate, permanently. Our prices will rise as we grow. Yours stay frozen at today\u2019s rate for as long as you\u2019re with us.',
  },
  {
    icon: MessageCircle,
    title: 'The founders\u2019 WhatsApp',
    body: 'No support inbox, no ticket queue. You message us, we fix it \u2014 usually the same day.',
  },
  {
    icon: ListChecks,
    title: 'A say in what we build',
    body: 'If your school needs a feature, tell us. Founding Schools go to the front of the queue.',
  },
  {
    icon: Wrench,
    title: 'We set everything up, free',
    body: 'Student records, classes, subjects, fee structures \u2014 loaded by us, not dumped on your staff. Then we train your teachers and bursar, in person or on a call.',
  },
]

export default function FoundingSchools() {
  return (
    <Section id="founding" surface="navy">
      <div className="mx-auto max-w-4xl text-center">
        <p className="mb-3 text-xs font-bold uppercase tracking-[0.18em] text-primary">
          10 spots only
        </p>
        <h2 className="font-display text-[1.75rem] font-bold leading-[1.12] text-white sm:text-4xl md:text-[2.5rem]">
          Become a Founding School
        </h2>
        <p className="mx-auto mt-4 max-w-2xl text-base leading-relaxed text-white/70 sm:text-lg">
          We&apos;re taking on our first 10 schools and giving them a deal that will never come back.
          Klassrun is new. Instead of hiding that, we&apos;re making it the best reason to join now.
        </p>
      </div>

      <div className="mx-auto mt-12 grid max-w-4xl gap-x-8 gap-y-8 sm:grid-cols-2">
        {PERKS.map((perk) => (
          <div key={perk.title} className="flex items-start gap-4">
            <span className="flex h-11 w-11 flex-shrink-0 items-center justify-center rounded-full bg-primary/15">
              <perk.icon size={20} className="text-primary" />
            </span>
            <div>
              <h3 className="font-display text-lg font-bold text-white">{perk.title}</h3>
              <p className="mt-1.5 text-sm leading-relaxed text-white/65">{perk.body}</p>
            </div>
          </div>
        ))}
      </div>

      <div className="mx-auto mt-12 flex max-w-4xl flex-col items-center justify-center gap-3 sm:flex-row">
        <button
          onClick={() => openLeadForm('founding')}
          className="group inline-flex items-center justify-center gap-2 rounded-full bg-primary px-7 py-3.5 text-sm font-bold text-primary-foreground hover:bg-klassrun-green-dark transition-colors"
        >
          Claim a Founding School spot
          <ArrowRight size={16} className="transition-transform group-hover:translate-x-0.5" />
        </button>
        <button
          onClick={() => openLeadForm('demo')}
          className="inline-flex items-center justify-center gap-2 rounded-full border border-white/20 bg-transparent px-7 py-3.5 text-sm font-bold text-white hover:bg-white/10 transition-colors"
        >
          Book a 15-minute demo first
        </button>
      </div>
    </Section>
  )
}
