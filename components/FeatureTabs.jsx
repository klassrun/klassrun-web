'use client'

import { useState } from 'react'
import {
  FileText, CalendarDays, ClipboardCheck, GraduationCap,
  ClipboardList, Wallet, Sparkles, Check, ArrowRight,
} from 'lucide-react'
import { Section, SectionHeader } from './ui/Section'

const TABS = [
  {
    id: 'lesson-notes',
    label: 'Lesson Notes',
    icon: FileText,
    title: 'Complete lesson notes in minutes',
    body:
      'Pick the class, subject and topic. Klassrun’s AI writes a full lesson note in the format Nigerian schools submit — objectives, content, evaluation. The teacher reviews, edits and prints.',
    points: ['NERDC topics built in', 'Edit everything before you print', 'Export as PDF'],
    rows: [
      { a: 'Basic Science · JSS 1', b: 'Lesson Note', chip: 'Ready' },
      { a: 'Mathematics · SS 2', b: 'Lesson Note', chip: 'Ready' },
      { a: 'English · JSS 3', b: 'Draft', chip: 'Editing' },
    ],
  },
  {
    id: 'schemes',
    label: 'Schemes of Work',
    icon: CalendarDays,
    title: 'A full scheme of work for the term',
    body:
      'Generate the whole term week by week, matched to the three-term calendar. Submit it once, reuse it next session, and keep every class on the same page.',
    points: ['Week-by-week breakdown', 'Matches the three-term calendar', 'Reuse next session'],
    rows: [
      { a: 'First Term · Week 1–13', b: 'Mathematics, JSS 2', chip: 'Complete' },
      { a: 'Second Term · Week 1–12', b: 'Basic Science, JSS 1', chip: 'Complete' },
      { a: 'Third Term · Week 1–11', b: 'English, SS 1', chip: 'In use' },
    ],
  },
  {
    id: 'exams',
    label: 'Exam Questions',
    icon: ClipboardCheck,
    title: 'WAEC-style questions, saved to your bank',
    body:
      'Generate objective and theory questions in WAEC style, with marking guides. Every question goes into a private bank your school owns — so you never set the same paper twice.',
    points: ['Objective and theory formats', 'Marking guides included', 'School-owned question bank'],
    rows: [
      { a: 'SS 1 English · 50 objectives', b: 'First C.A.', chip: 'In bank' },
      { a: 'JSS 2 Maths · Theory ×6', b: 'Terminal exam', chip: 'In bank' },
      { a: 'JSS 3 Basic Sci · Mixed', b: 'Mock exam', chip: 'In bank' },
    ],
  },
  {
    id: 'results',
    label: 'Results & Report Cards',
    icon: GraduationCap,
    title: 'From scores to printed report cards',
    body:
      'Teachers enter CA and exam scores; totals, grades and class positions compute themselves. Print proper Nigerian report cards as PDF, with behaviour records included.',
    points: ['Totals and grades computed for you', 'Class positions worked out automatically', 'Report cards print as PDF'],
    rows: [
      { a: 'JSS 2 · 38 students', b: 'Second Term results', chip: 'Compiled' },
      { a: 'SS 1 · 41 students', b: 'Report cards', chip: 'Printed' },
      { a: 'JSS 3 · 35 students', b: 'Positions', chip: 'Ranked' },
    ],
  },
  {
    id: 'attendance',
    label: 'Attendance',
    icon: ClipboardList,
    title: 'Attendance and behaviour, on the record',
    body:
      'Take daily attendance per class, record termly behaviour assessments, and carry it all onto the report card. Promotion decisions at term end happen in the same place.',
    points: ['Daily attendance per class', 'Termly behaviour assessment', 'Promotions handled at term end'],
    rows: [
      { a: 'JSS 1A · Today', b: '36 present · 2 absent', chip: 'Taken' },
      { a: 'SS 2B · Today', b: '39 present · 1 absent', chip: 'Taken' },
      { a: 'Term 2 promotions', b: 'JSS 3 → SS 1', chip: 'Done' },
    ],
  },
  {
    id: 'fees',
    label: 'Fees',
    icon: Wallet,
    title: 'Know who has paid at a glance',
    body:
      'Your bursar marks fees paid or unpaid per student and sees collection status for every class. A separate bursar login keeps money matters away from teaching tools.',
    points: ['Paid / unpaid per student', 'Collection view per class', 'Separate bursar role'],
    rows: [
      { a: 'Adaeze O. · JSS 2', b: 'Second Term fees', chip: 'PAID' },
      { a: 'Tunde A. · SS 1', b: 'Second Term fees', chip: 'UNPAID' },
      { a: 'JSS 2 class', b: '31 of 38 paid', chip: '82%' },
    ],
  },
  {
    id: 'next',
    label: 'What’s Next',
    icon: Sparkles,
    title: 'On the roadmap',
    body:
      'These ship next, and your plan includes them as they land. No upgrade gymnastics — they appear in your school’s account when ready.',
    points: [],
    roadmap: [
      { title: 'Parent & Student Portal', body: 'Parents see results, attendance and fees from home.' },
      { title: 'CBT Exams', body: 'Timed, computer-based papers from your question bank.' },
      { title: 'Online Fee Payments', body: 'Parents pay school fees directly through Paystack.' },
      { title: 'WhatsApp Notifications', body: 'Results and fee reminders straight to parents’ phones.' },
    ],
  },
]

export default function FeatureTabs() {
  const [active, setActive] = useState(0)
  const tab = TABS[active]
  const Icon = tab.icon

  return (
    <Section id="features" surface="white">
      <SectionHeader
        title="Everything your school runs on, in one place"
        subtitle="Lesson notes, exams, results, fees and attendance — one login for the whole school."
      />

      {/* Pill tab row */}
      <div className="flex justify-center">
        <div className="flex gap-1.5 overflow-x-auto no-scrollbar rounded-full bg-secondary/70 p-1.5 max-w-full">
          {TABS.map((t, i) => (
            <button
              key={t.id}
              onClick={() => setActive(i)}
              className={`whitespace-nowrap rounded-full px-4 py-2 text-sm font-bold transition-colors duration-200 ${
                i === active
                  ? 'bg-klassrun-navy text-white'
                  : 'text-foreground/65 hover:text-foreground'
              }`}
            >
              {t.label}
            </button>
          ))}
        </div>
      </div>

      {/* Active panel */}
      <div className="mt-10 md:mt-14 grid lg:grid-cols-2 gap-10 lg:gap-14 items-center">
        <div>
          <h3 className="text-2xl sm:text-3xl font-bold text-foreground leading-tight">
            {tab.title}
          </h3>
          <p className="mt-4 text-base text-muted-foreground leading-relaxed">{tab.body}</p>

          {tab.points.length > 0 && (
            <ul className="mt-6 space-y-3">
              {tab.points.map((p) => (
                <li key={p} className="flex items-start gap-3">
                  <span className="mt-0.5 flex-shrink-0 h-5 w-5 rounded-full bg-primary/12 flex items-center justify-center">
                    <Check size={12} className="text-primary" strokeWidth={3.5} />
                  </span>
                  <span className="text-sm text-foreground/85">{p}</span>
                </li>
              ))}
            </ul>
          )}

          <div className="mt-8 flex flex-col sm:flex-row gap-3">
            <a
              href="https://app.klassrun.com/signup"
              className="group inline-flex items-center justify-center gap-2 rounded-full bg-primary px-6 py-3 text-sm font-bold text-primary-foreground hover:bg-klassrun-green-dark transition-colors duration-300"
            >
              Get Started
              <ArrowRight size={15} className="transition-transform duration-300 group-hover:translate-x-0.5" />
            </a>
            <a
              href="mailto:info@klassrun.com"
              className="inline-flex items-center justify-center rounded-full border border-soft bg-white px-6 py-3 text-sm font-bold text-foreground hover:bg-secondary transition-colors duration-300"
            >
              Talk to us
            </a>
          </div>
        </div>

        {/* Visual side */}
        <div className="rounded-3xl bg-secondary/40 border border-subtle p-6 sm:p-8">
          {tab.roadmap ? (
            <div className="grid sm:grid-cols-2 gap-4">
              {tab.roadmap.map((r) => (
                <div key={r.title} className="rounded-2xl bg-white border border-subtle p-5">
                  <span className="inline-block rounded-full bg-foreground/8 text-foreground/65 px-2.5 py-0.5 text-[10px] font-bold tracking-wide mb-3">
                    Coming soon
                  </span>
                  <p className="text-sm font-bold text-foreground">{r.title}</p>
                  <p className="mt-1.5 text-xs text-muted-foreground leading-relaxed">{r.body}</p>
                </div>
              ))}
            </div>
          ) : (
            <div>
              <div className="h-12 w-12 rounded-xl bg-primary/12 ring-1 ring-primary/15 flex items-center justify-center mb-5">
                <Icon size={22} className="text-primary" />
              </div>
              <div className="space-y-2.5">
                {tab.rows.map((row) => (
                  <div
                    key={row.a}
                    className="flex items-center justify-between gap-3 rounded-xl bg-white border border-subtle px-4 py-3.5"
                  >
                    <div className="min-w-0">
                      <p className="text-sm font-semibold text-foreground truncate">{row.a}</p>
                      <p className="text-[11px] text-muted-foreground">{row.b}</p>
                    </div>
                    <span
                      className={`flex-shrink-0 rounded-full px-2.5 py-1 text-[10px] font-bold tracking-wide ${
                        row.chip === 'UNPAID'
                          ? 'bg-destructive/10 text-destructive'
                          : 'bg-primary/10 text-primary'
                      }`}
                    >
                      {row.chip}
                    </span>
                  </div>
                ))}
              </div>
            </div>
          )}
        </div>
      </div>
    </Section>
  )
}
