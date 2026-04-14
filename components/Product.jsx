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

const outcomes = [
  {
    icon: FileText,
    title: 'Lesson Notes on Autopilot',
    description:
      'Complete, curriculum-aligned notes generated in under 60 seconds. Your teachers just pick the subject, class, and topic — KlassRun handles the rest.',
  },
  {
    icon: ClipboardCheck,
    title: 'Fresh Exams Every Term',
    description:
      'AI tracks every question ever generated for your school and never duplicates. Students can\'t recycle answers. Your assessments stay credible.',
  },
  {
    icon: Award,
    title: 'WAEC/NECO Ready',
    description:
      'Every exam automatically includes questions matching national examination standards. Your students walk into WAEC prepared, not surprised.',
  },
  {
    icon: Download,
    title: 'School-Branded PDFs',
    description:
      'Print-ready documents with your school name, logo, and session stamp. Submit to inspectors with confidence — everything looks professional.',
  },
  {
    icon: BarChart3,
    title: 'Know What\'s Happening',
    description:
      'See exactly how many notes were generated, which teachers are active, and how many hours your school saved this term. ROI you can measure.',
  },
  {
    icon: Wifi,
    title: 'Works Without Internet',
    description:
      'Teachers in areas with poor connectivity can still view, edit, and print notes offline. Everything syncs when connection returns.',
  },
]

export default function Product() {
  return (
    <section id="product" className="py-20 md:py-28 bg-secondary/30">
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        {/* Section header */}
        <div className="text-center max-w-3xl mx-auto mb-16">
          <p className="text-sm font-semibold text-primary uppercase tracking-wider mb-3">
            What You Get
          </p>
          <h2 className="text-3xl sm:text-4xl font-bold text-foreground tracking-tight">
            Everything your teachers need. Nothing they don&apos;t.
          </h2>
          <p className="mt-4 text-lg text-muted-foreground leading-relaxed">
            KlassRun automates the work your teachers do every week — so they
            spend less time writing and more time teaching.
          </p>
        </div>

        {/* Outcomes grid — 3x2 instead of 4x2, gives more breathing room */}
        <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-6">
          {outcomes.map((item) => (
            <div
              key={item.title}
              className="group rounded-2xl border border-border bg-white p-7 hover:border-primary/30 hover:shadow-lg hover:shadow-primary/5 transition-all duration-300"
            >
              <div className="h-12 w-12 rounded-xl bg-primary/10 flex items-center justify-center mb-5 group-hover:bg-primary/15 transition-colors">
                <item.icon size={24} className="text-primary" />
              </div>
              <h3 className="text-base font-bold text-foreground mb-2">
                {item.title}
              </h3>
              <p className="text-sm text-muted-foreground leading-relaxed">
                {item.description}
              </p>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}
