'use client'

import { Clock, AlertTriangle, EyeOff } from 'lucide-react'
import { motion } from 'framer-motion'
import { Section, SectionHeader } from './ui/Section'
import { MotionCard } from './ui/MotionCard'
import { gridStagger, viewportOnce } from '@/lib/motion'

const painPoints = [
  {
    icon: Clock,
    title: 'Wasted Teacher Hours',
    description:
      "Teachers spend 10–15 hours every week writing lesson notes and preparing exams by hand. That's time stolen from actual teaching.",
  },
  {
    icon: AlertTriangle,
    title: 'Recycled Exam Questions',
    description:
      'Students share old answers every year. Recycled questions mean your assessments are compromised before they even begin.',
  },
  {
    icon: EyeOff,
    title: 'Zero Visibility',
    description:
      'School owners have no way to see what teachers are producing, when, or whether it meets curriculum standards.',
  },
]

export default function About() {
  return (
    <Section id="about">
      <SectionHeader
        eyebrow="Why KlassRun"
        title="Your school deserves better than manual processes"
        subtitle="KlassRun eliminates the repetitive admin work that burns teachers out, so they can focus on what actually matters — teaching."
      />

      <motion.div
        variants={gridStagger}
        initial="hidden"
        whileInView="show"
        viewport={viewportOnce}
        className="grid md:grid-cols-3 gap-5 md:gap-8 perspective-card"
      >
        {painPoints.map((point, i) => (
          <MotionCard
            key={point.title}
            entrance="flip"
            index={i}
            intensity={10}
            lift={10}
            className="rounded-2xl border border-soft bg-white px-6 py-8 md:px-8 md:py-10 text-center shadow-xs hover:shadow-card transition-shadow duration-500"
          >
            <div className="h-12 w-12 rounded-xl bg-destructive/10 ring-1 ring-destructive/10 flex items-center justify-center mx-auto mb-6">
              <point.icon size={22} className="text-destructive" />
            </div>
            <h3 className="text-base font-semibold text-foreground mb-3 tracking-tight">
              {point.title}
            </h3>
            <p className="text-sm text-muted-foreground leading-relaxed">
              {point.description}
            </p>
          </MotionCard>
        ))}
      </motion.div>
    </Section>
  )
}
