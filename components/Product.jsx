import {
  FileText,
  ClipboardCheck,
  Award,
  Stamp,
  Download,
  Wifi,
  BarChart3,
  CalendarDays,
} from 'lucide-react'

const features = [
  {
    icon: FileText,
    title: 'AI Lesson Notes',
    description:
      'Generate structured, curriculum-aligned lesson notes per subject and class. Complete with learning objectives, activities, and evaluation.',
  },
  {
    icon: ClipboardCheck,
    title: 'Exam Question Generator',
    description:
      'Build full assessments from the active term syllabus. Objective, theory, and practical questions — all fresh, never recycled.',
  },
  {
    icon: Award,
    title: 'WAEC / NECO Alignment',
    description:
      'Every assessment automatically embeds questions matching national examination standards and style. Your students are exam-ready.',
  },
  {
    icon: Stamp,
    title: 'Session Stamping',
    description:
      'Every document shows the current academic session and term. Last year\'s notes are visibly outdated to principals and inspectors.',
  },
  {
    icon: Download,
    title: 'School-Branded PDFs',
    description:
      'Export print-ready lesson notes and exam papers with your school name, logo, and branding. Professional output every time.',
  },
  {
    icon: Wifi,
    title: 'Works Offline',
    description:
      'PWA technology means teachers can view, edit, and print notes without internet. Syncs automatically when connection returns.',
  },
  {
    icon: BarChart3,
    title: 'Admin Dashboard',
    description:
      'School owners see exactly how the platform is used: notes generated, hours saved, teacher activity, and ROI at a glance.',
  },
  {
    icon: CalendarDays,
    title: 'Scheme of Work',
    description:
      'Generate a fresh scheme of work every term. Topics, timelines, and objectives — aligned to NERDC and ready for submission.',
  },
]

export default function Product() {
  return (
    <section id="product" className="py-20 md:py-28 bg-secondary/30">
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        {/* Section header */}
        <div className="text-center max-w-3xl mx-auto mb-16">
          <p className="text-sm font-semibold text-primary uppercase tracking-wider mb-3">
            Product
          </p>
          <h2 className="text-3xl sm:text-4xl font-bold text-foreground tracking-tight">
            Everything Your School Needs to Run Smarter
          </h2>
          <p className="mt-4 text-lg text-muted-foreground leading-relaxed">
            From lesson notes to exam papers, KlassRun automates the work your
            teachers do every week — all aligned to the Nigerian curriculum.
          </p>
        </div>

        {/* Features grid */}
        <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-6">
          {features.map((feature) => (
            <div
              key={feature.title}
              className="group rounded-2xl border border-border bg-white p-6 hover:border-primary/30 hover:shadow-lg hover:shadow-primary/5 transition-all duration-300"
            >
              <div className="h-11 w-11 rounded-xl bg-primary/10 flex items-center justify-center mb-4 group-hover:bg-primary/15 transition-colors">
                <feature.icon size={22} className="text-primary" />
              </div>
              <h3 className="text-base font-bold text-foreground mb-2">
                {feature.title}
              </h3>
              <p className="text-sm text-muted-foreground leading-relaxed">
                {feature.description}
              </p>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}
