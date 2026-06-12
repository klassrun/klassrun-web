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
