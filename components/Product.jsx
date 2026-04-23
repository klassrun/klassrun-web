'use client'

import {
  FileText,
  ClipboardCheck,
  Award,
  Download,
  Wifi,
  BarChart3,
} from 'lucide-react'
import { motion } from 'framer-motion'
import { Section, SectionHeader } from './ui/Section'
import { MotionCard } from './ui/MotionCard'
import { gridStagger, viewportOnce } from '@/lib/motion'

const outcomes = [
  {
    icon: FileText,
    title: 'Lesson Notes on Autopilot',
    description:
      'Complete, curriculum-aligned notes generated in under 60 seconds. Teachers pick subject, class, and topic — KlassRun handles the rest.',
  },
  {
    icon: ClipboardCheck,
    title: 'Fresh Exams Every Term',
    description:
      "AI tracks every question generated for your school and never duplicates. Students can't recycle answers. Assessments stay credible.",
  },
  {
    icon: Award,
    title: 'WAEC/NECO Ready',
    description:
      'Every exam automatically includes questions matching national examination standards. Students walk in prepared, not surprised.',
  },
  {
    icon: Download,
    title: 'School-Branded PDFs',
    description:
      'Print-ready documents with your school name, logo, and session stamp. Submit to inspectors with confidence.',
  },
  {
    icon: BarChart3,
    title: "Know What's Happening",
    description:
      'See how many notes were generated, which teachers are active, and how many hours your school saved this term. ROI you can measure.',
  },
  {
    icon: Wifi,
    title: 'Works Without Internet',
    description:
      'Teachers in low-connectivity areas can still view, edit, and print notes offline. Everything syncs when connection returns.',
  },
]

export default function Product() {
  return (
    <Section id="product" surface="muted">
      <SectionHeader
        eyebrow="What You Get"
        title="Everything your teachers need. Nothing they don't."
        subtitle="KlassRun automates the work your teachers do every week — so they spend less time writing and more time teaching."
      />

      <motion.div
        variants={gridStagger}
        initial="hidden"
        whileInView="show"
        viewport={viewportOnce}
        className="grid sm:grid-cols-2 lg:grid-cols-3 gap-5 md:gap-6 perspective-card"
      >
        {outcomes.map((item, i) => (
          <MotionCard
            key={item.title}
            entrance="lift"
            index={i % 3}
            intensity={8}
            lift={8}
            className="group rounded-2xl border border-soft bg-white p-6 sm:p-7 shadow-xs hover:shadow-card hover:border-primary/20 transition-all duration-500"
          >
            <div className="h-11 w-11 rounded-xl bg-primary/10 ring-1 ring-primary/10 flex items-center justify-center mb-5 sm:mb-6 group-hover:bg-primary/15 group-hover:ring-primary/20 transition-all duration-500">
              <item.icon size={20} className="text-primary" />
            </div>
            <h3 className="text-[15px] font-semibold text-foreground mb-2.5 tracking-tight">
              {item.title}
            </h3>
            <p className="text-sm text-muted-foreground leading-relaxed">
              {item.description}
            </p>
          </MotionCard>
        ))}
      </motion.div>
    </Section>
  )
}
