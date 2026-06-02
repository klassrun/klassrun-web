'use client'

// batch-web-os-product
import {
  FileText, CalendarDays, ClipboardCheck, Library, Target, GraduationCap,
  MessageSquare, ClipboardList, Wallet, Users, Monitor, Globe,
} from 'lucide-react'
import { motion } from 'framer-motion'
import { Section, SectionHeader } from './ui/Section'
import { MotionCard } from './ui/MotionCard'
import { gridStagger, viewportOnce } from '@/lib/motion'

const outcomes = [
  { icon: FileText, title: 'AI Lesson Notes', description: 'Complete, curriculum-aligned notes in under 60 seconds. Pick class, subject and topic — Klassrun writes the note.', soon: false },
  { icon: CalendarDays, title: 'Schemes of Work', description: 'Full termly schemes, week by week, in the format Nigerian schools must submit.', soon: false },
  { icon: ClipboardCheck, title: 'WAEC / NECO Exam Questions', description: 'Objective, theory and essay questions in national exam style — with marking guides.', soon: false },
  { icon: Library, title: 'School Question Bank', description: 'Every question saved to a private bank you build over years — so you never set the same paper twice.', soon: false },
  { icon: Target, title: 'NERDC Curriculum Alignment', description: 'AI grounded in the actual prescribed topic for that class, subject and term — not generic guesses.', soon: true },
  { icon: GraduationCap, title: 'Results & Report Cards', description: 'CA and exam scores auto-compute totals, grades and class positions into a Nigerian report card.', soon: true },
  { icon: MessageSquare, title: 'AI Report-Card Comments', description: 'Personalised class-teacher and principal remarks generated per student — the task every teacher dreads.', soon: true },
  { icon: ClipboardList, title: 'Attendance & Behaviour', description: 'Daily attendance and termly behavioural assessment, straight onto the report card.', soon: true },
  { icon: Wallet, title: 'Fees & Bursar', description: 'Track paid and unpaid fees, bulk-update by CSV, and see collection at a glance.', soon: true },
  { icon: Users, title: 'Parent & Student Portal', description: 'Parents see results, attendance, fees and events — and stop calling the office.', soon: true },
  { icon: Monitor, title: 'CBT Exams', description: 'Computer-based testing with timed papers and auto-graded objectives, from your question bank.', soon: true },
  { icon: Globe, title: 'School Website & CMS', description: 'Post news, events and galleries to a public school site — no developer needed.', soon: true },
]

export default function Product() {
  return (
    <Section id="product" surface="muted">
      <SectionHeader
        eyebrow="The whole school, one platform"
        title="More than lesson notes — your whole school, with AI"
        subtitle="Klassrun runs your academics and your operations from one place: the AI that saves teachers their Sunday nights, plus the results, report cards, attendance, fees and parent portal that run the rest of the building."
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
            className="group relative rounded-2xl border border-soft bg-white p-6 sm:p-7 shadow-xs hover:shadow-card hover:border-primary/20 transition-all duration-500"
          >
            {item.soon && (
              <span className="absolute top-4 right-4 inline-block rounded-full bg-foreground/8 text-foreground/65 px-2 py-0.5 text-[10px] font-semibold tracking-wide">
                Coming soon
              </span>
            )}
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
