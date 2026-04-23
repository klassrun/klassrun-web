'use client'

import { UserPlus, BookOpen, Sparkles, Download } from 'lucide-react'
import { motion } from 'framer-motion'
import { Section, SectionHeader } from './ui/Section'
import { stagger, fadeUp, viewportOnce } from '@/lib/motion'

const steps = [
  {
    step: '01',
    icon: UserPlus,
    title: 'School Signs Up',
    description:
      'The admin creates an account, sets up classes, and invites teachers. Takes under 10 minutes.',
  },
  {
    step: '02',
    icon: BookOpen,
    title: 'Teacher Selects Topic',
    description:
      'Teacher picks subject, class, and NERDC topic for the week. The curriculum is already loaded.',
  },
  {
    step: '03',
    icon: Sparkles,
    title: 'AI Generates Content',
    description:
      'KlassRun produces a complete lesson note, exam, or scheme of work — curriculum-aligned, WAEC-standard.',
  },
  {
    step: '04',
    icon: Download,
    title: 'Download & Teach',
    description:
      'Download school-branded PDFs ready for submission. Edit if needed — the content is yours.',
  },
]

export default function HowItWorks() {
  return (
    <Section id="how-it-works">
      <SectionHeader
        eyebrow="How It Works"
        title="From signup to lesson note in 4 steps"
        subtitle="No training needed. No complicated setup. Your teachers can start generating content on their first day."
      />

      <motion.div
        variants={stagger(0.05, 0.12)}
        initial="hidden"
        whileInView="show"
        viewport={viewportOnce}
        className="grid md:grid-cols-4 gap-10 md:gap-6"
      >
        {steps.map((item, i) => (
          <motion.div key={item.step} variants={fadeUp} className="relative">
            {/* Dotted connector */}
            {i < steps.length - 1 && (
              <div
                className="hidden md:block absolute top-10 left-[calc(50%+40px)] w-[calc(100%-80px)] h-px"
                style={{
                  backgroundImage:
                    'linear-gradient(to right, oklch(0.92 0.004 260) 50%, transparent 50%)',
                  backgroundSize: '8px 1px',
                }}
              />
            )}

            <div className="text-center">
              <div className="relative inline-flex">
                <div className="h-20 w-20 rounded-2xl bg-primary/8 ring-1 ring-primary/10 flex items-center justify-center mx-auto shadow-xs">
                  <item.icon size={30} className="text-primary" />
                </div>
                <span className="absolute -top-2 -right-2 h-6 w-6 rounded-full bg-primary text-primary-foreground text-[10px] font-semibold flex items-center justify-center ring-4 ring-background">
                  {item.step}
                </span>
              </div>

              <h3 className="mt-6 text-[15px] font-semibold text-foreground tracking-tight">
                {item.title}
              </h3>
              <p className="mt-2 text-sm text-muted-foreground leading-relaxed max-w-[240px] mx-auto">
                {item.description}
              </p>
            </div>
          </motion.div>
        ))}
      </motion.div>
    </Section>
  )
}
