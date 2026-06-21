'use client'

import { useState } from 'react'
import { ChevronDown } from 'lucide-react'
import { Section, SectionHeader } from './ui/Section'

const faqs = [
  {
    q: 'What does Klassrun actually do?',
    a: 'It runs your school\'s academics and records from one place. Teachers generate lesson notes, schemes of work and WAEC-style exam questions. The school handles results, report cards, attendance, behaviour, promotions and fees. All of it sits under one account, with separate logins for owners, teachers and bursars.',
  },
  {
    q: 'What does it cost?',
    a: 'You pay per term, in one of three plans: Starter, Standard or Premium. That\'s how Nigerian schools budget, so that\'s how we priced it. Final amounts are announced soon. The 14-day free trial is open now with no card, so you can try the whole thing before a single naira changes hands.',
  },
  {
    q: 'How do we get started?',
    a: 'The admin creates the account, sets up classes and subjects, and invites the teachers. The whole thing takes under ten minutes. Teachers can generate their first lesson note the same day. No training session. No setup fee.',
  },
  {
    q: 'Is it aligned to the Nigerian curriculum?',
    a: 'Yes. Lesson notes and schemes follow NERDC topics for each class, subject and term. Exam questions come in WAEC, NECO and BECE style, with marking guides included.',
  },
  {
    q: 'What\'s live right now?',
    a: 'Live today: lesson notes, schemes of work, exam questions, the school question bank, results and report card printing, attendance and behaviour records, promotions, and fee tracking with a bursar role. Coming soon: the parent and student portal, CBT exams, online fee payments through Paystack, and WhatsApp notifications.',
  },
  {
    q: 'Why not just use ChatGPT?',
    a: 'A chatbot answers one teacher, then forgets the conversation. Klassrun was built for the whole school. The curriculum for every class and term is already loaded. Every note and question you make is saved into a bank your school owns and reuses for years. And the same system runs your results, report cards, attendance and fees. A chatbot does none of that.',
  },
  {
    q: 'Do I need to install anything?',
    a: 'No. It runs in the browser on a laptop, tablet or phone, and you can add it to your home screen like an app if you want to.',
  },
  {
    q: 'Is my school\'s data private?',
    a: 'Yes. Every school runs in its own walled-off space. Your students, results, fee records and question bank never touch another school\'s. The full details are in our Privacy Policy, linked below.',
  },
  {
    q: 'Can my bursar use it without seeing the teaching tools?',
    a: 'Yes. The roles are separate by design. Owners and admins see the whole school. Teachers see their classes and their content tools. Bursars get a login built around fees and nothing else.',
  },
  {
    q: 'What happens when the free trial ends?',
    a: 'You pick a plan and keep going. Nothing gets wiped. Everything your teachers built during the trial stays right where it is, in your school\'s account.',
  },
]

export default function FAQ() {
  const [open, setOpen] = useState(0)

  return (
    <Section id="faq" surface="white">
      <SectionHeader title="Questions schools ask us" />
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
