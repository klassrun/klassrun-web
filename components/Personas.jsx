'use client'

import { useState } from 'react'
import {
  LayoutDashboard, Printer, Wallet, ArrowUpDown, ClipboardList, Users,
  FileText, CalendarDays, ClipboardCheck, Calculator, Smartphone, RefreshCw,
  CheckCircle2, Eye, Table, Lock, CreditCard, BarChart3,
} from 'lucide-react'
import { Section, SectionHeader } from './ui/Section'

// PLACEHOLDER - replace each persona's `quote` with a real quote from a real
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
      { icon: Users, text: 'One school account. Owners, teachers and bursars each get their own role.' },
    ],
    quote: '[PLACEHOLDER - quote from a real school owner goes here]',
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
      { icon: Calculator, text: 'Enter CA and exam scores. Totals and grades compute themselves.' },
      { icon: Smartphone, text: 'Take attendance from your phone in seconds.' },
      { icon: RefreshCw, text: 'Reuse and edit everything you’ve made, any term, any session.' },
    ],
    quote: '[PLACEHOLDER - quote from a real teacher goes here]',
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
      { icon: CreditCard, text: 'Online payments through Paystack.', soon: true },
    ],
    quote: '[PLACEHOLDER - quote from a real bursar goes here]',
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

      {/* Pull-quote between hairlines - PLACEHOLDER until a real quote exists */}
      <div className="max-w-3xl mx-auto mt-12 md:mt-16">
        <div className="border-t border-soft" />
        <blockquote className="py-7 text-center">
          <p className="text-base sm:text-lg italic text-foreground/80 leading-relaxed">
            “{p.quote}”
          </p>
          <footer className="mt-3 text-sm text-muted-foreground">{p.attribution}</footer>
        </blockquote>
        <div className="border-t border-soft" />
      </div>
    </Section>
  )
}
