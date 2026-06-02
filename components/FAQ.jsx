'use client'

// batch-web-os-faq
import { useState } from 'react'
import { Plus } from 'lucide-react'
import { Section, SectionHeader } from './ui/Section'

const faqs = [
  {
    q: 'How is this different from just using ChatGPT?',
    a: "ChatGPT is a general chatbot — it answers one person, then forgets. Klassrun is a school operating system. Its AI is aligned to the actual NERDC curriculum for each class, subject and term; every note, scheme and question is saved into your school's private bank and compounds over the years; and beyond the AI, Klassrun runs results, report cards, attendance, fees and a parent portal — things a chatbot simply can't do. It's also locked to school work only, so it's safe for a shared school account.",
  },
  {
    q: 'Is the content aligned to the Nigerian curriculum?',
    a: 'Yes. Klassrun grounds its generation in the NERDC framework and produces exam questions in WAEC, NECO and BECE style. You can also upload your school\u2019s own scheme of work and have lesson notes aligned week-by-week to it.',
  },
  {
    q: 'Which features are available right now?',
    a: 'The AI teaching tools — lesson notes, schemes of work, exam questions and the question bank — are live today. Curriculum alignment, results and report cards, attendance, fees, CBT and the parent portal are rolling out across 2026, and your plan includes them as they ship.',
  },
  {
    q: 'Do I need to install anything?',
    a: 'No. Klassrun runs in your browser, and each school gets its own private space. The only desktop component is the optional CBT exam app on the Premium plan.',
  },
  {
    q: 'What does the free trial include?',
    a: 'A full 14 days, no card required. You set up your classes, subjects and teachers and start generating straight away.',
  },
  {
    q: "Will my school's data be private?",
    a: 'Yes. Every school operates in its own isolated space — your students, results and question bank are never shared with another school.',
  },
]

export default function FAQ() {
  const [open, setOpen] = useState(0)
  return (
    <Section id="faq">
      <SectionHeader eyebrow="Questions principals ask" title="Frequently asked" />
      <div className="max-w-3xl mx-auto">
        {faqs.map((f, i) => {
          const isOpen = open === i
          return (
            <div key={f.q} className="border-b border-subtle">
              <button
                onClick={() => setOpen(isOpen ? -1 : i)}
                aria-expanded={isOpen}
                className="w-full flex items-center justify-between gap-4 text-left py-5"
              >
                <span className="text-base sm:text-lg font-semibold text-foreground tracking-tight">{f.q}</span>
                <span className={`flex-shrink-0 h-7 w-7 rounded-full flex items-center justify-center transition-all duration-300 ${isOpen ? 'bg-primary text-white rotate-45' : 'bg-secondary text-foreground/60'}`}>
                  <Plus size={16} />
                </span>
              </button>
              <div className={`overflow-hidden transition-all duration-300 ${isOpen ? 'max-h-[420px] pb-5' : 'max-h-0'}`}>
                <p className="text-sm sm:text-base text-muted-foreground leading-relaxed pr-10">{f.a}</p>
              </div>
            </div>
          )
        })}
      </div>
    </Section>
  )
}
