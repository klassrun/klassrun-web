'use client'

// batch-web-os-comparison
import { Check, X } from 'lucide-react'
import { motion } from 'framer-motion'
import { Section, SectionHeader } from './ui/Section'
import { fadeUp, stagger, viewportOnce } from '@/lib/motion'

const them = [
  'Forgets your work the moment you close the tab',
  'Generic answers, not tied to the NERDC week for your class',
  'One person typing — no school, no roles, no records',
  "Can't produce a Nigerian report card or run a CBT exam",
  'Happily goes off-topic — not safe for a shared school account',
]

const us = [
  'Remembers everything — notes, schemes and questions become a multi-year school asset',
  'Aligned to the prescribed curriculum for that exact class, subject and term',
  'Runs the whole school — teachers, results, report cards, attendance, fees, parents',
  'Built-in Nigerian report cards, CBT exams, and a parent portal',
  'Education-only guardrails — safe for principals, parents and inspectors',
]

export default function Comparison() {
  return (
    <Section id="why">
      <SectionHeader
        eyebrow="The honest question"
        title={'\u201CWhy not just use ChatGPT?\u201D'}
        subtitle="Because a chatbot is one teacher typing into a box that forgets tomorrow. Klassrun is built for the way a Nigerian school actually runs."
      />

      <motion.div
        variants={stagger(0.1, 0.12)}
        initial="hidden"
        whileInView="show"
        viewport={viewportOnce}
        className="grid md:grid-cols-2 gap-5 md:gap-6 max-w-5xl mx-auto"
      >
        <motion.div
          variants={fadeUp}
          className="rounded-2xl border border-soft bg-white p-6 sm:p-8 shadow-xs"
        >
          <h3 className="text-base font-semibold text-foreground mb-6 tracking-tight">Generic chatbot</h3>
          <ul className="space-y-4">
            {them.map((t) => (
              <li key={t} className="flex items-start gap-3">
                <span className="mt-0.5 flex-shrink-0 h-5 w-5 rounded-full bg-destructive/10 flex items-center justify-center">
                  <X size={12} className="text-destructive" strokeWidth={3} />
                </span>
                <span className="text-sm text-muted-foreground leading-relaxed">{t}</span>
              </li>
            ))}
          </ul>
        </motion.div>

        <motion.div
          variants={fadeUp}
          className="rounded-2xl ring-1 ring-primary/15 bg-primary/[0.06] p-6 sm:p-8 shadow-glow"
        >
          <h3 className="text-base font-semibold text-foreground mb-6 tracking-tight flex items-center gap-2">
            <span className="h-2 w-2 rounded-full bg-primary" />
            Klassrun
          </h3>
          <ul className="space-y-4">
            {us.map((t) => (
              <li key={t} className="flex items-start gap-3">
                <span className="mt-0.5 flex-shrink-0 h-5 w-5 rounded-full bg-primary/15 flex items-center justify-center">
                  <Check size={12} className="text-primary" strokeWidth={3} />
                </span>
                <span className="text-sm text-foreground/80 leading-relaxed">{t}</span>
              </li>
            ))}
          </ul>
        </motion.div>
      </motion.div>
    </Section>
  )
}
