import { Clock, AlertTriangle, EyeOff } from 'lucide-react'

const painPoints = [
  {
    icon: Clock,
    title: 'Wasted Teacher Hours',
    description:
      'Your teachers spend 10–15 hours every week writing lesson notes and preparing exams by hand. That\'s time stolen from actual teaching.',
  },
  {
    icon: AlertTriangle,
    title: 'Recycled Exam Questions',
    description:
      'Students share old exam answers every year. Recycled questions mean your assessments are compromised before they even begin.',
  },
  {
    icon: EyeOff,
    title: 'Zero Visibility',
    description:
      'School owners have no way to see what teachers are actually producing, when, or whether it meets curriculum standards.',
  },
]

export default function About() {
  return (
    <section id="about" className="py-20 md:py-28">
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        {/* Section header — sell the transformation */}
        <div className="text-center max-w-3xl mx-auto mb-16">
          <p className="text-sm font-semibold text-primary uppercase tracking-wider mb-3">
            Why KlassRun
          </p>
          <h2 className="text-3xl sm:text-4xl font-bold text-foreground tracking-tight">
            Your school deserves better than manual processes
          </h2>
          <p className="mt-4 text-lg text-muted-foreground leading-relaxed">
            KlassRun eliminates the repetitive admin work that burns teachers
            out, so they can focus on what actually matters — teaching.
          </p>
        </div>

        {/* Pain points — like Chargezoom's "Delayed Cash Flow / Wasted Time / Runaway Fees" */}
        <div className="grid md:grid-cols-3 gap-8">
          {painPoints.map((point) => (
            <div
              key={point.title}
              className="text-center px-6 py-8 rounded-2xl border border-border bg-white"
            >
              <div className="h-14 w-14 rounded-2xl bg-destructive/10 flex items-center justify-center mx-auto mb-5">
                <point.icon size={28} className="text-destructive" />
              </div>
              <h3 className="text-lg font-bold text-foreground mb-3">
                {point.title}
              </h3>
              <p className="text-sm text-muted-foreground leading-relaxed">
                {point.description}
              </p>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}
