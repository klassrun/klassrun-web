import { UserPlus, BookOpen, Sparkles, Download } from 'lucide-react'

const steps = [
  {
    step: '01',
    icon: UserPlus,
    title: 'School Signs Up',
    description:
      'The school admin creates an account, sets up classes, and invites teachers. Takes less than 10 minutes.',
  },
  {
    step: '02',
    icon: BookOpen,
    title: 'Teacher Selects Subject & Topic',
    description:
      'Teacher picks their subject, class, and the NERDC topic for the week. The curriculum data is already loaded.',
  },
  {
    step: '03',
    icon: Sparkles,
    title: 'AI Generates Content',
    description:
      'KlassRun generates a complete lesson note, exam questions, or scheme of work — curriculum-aligned and WAEC-standard.',
  },
  {
    step: '04',
    icon: Download,
    title: 'Download & Teach',
    description:
      'Teachers download school-branded PDFs ready for submission and classroom use. Edit if needed — the content is yours.',
  },
]

export default function HowItWorks() {
  return (
    <section id="how-it-works" className="py-20 md:py-28">
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        {/* Section header */}
        <div className="text-center max-w-3xl mx-auto mb-16">
          <p className="text-sm font-semibold text-primary uppercase tracking-wider mb-3">
            How It Works
          </p>
          <h2 className="text-3xl sm:text-4xl font-bold text-foreground tracking-tight">
            From Signup to Lesson Note in 4 Steps
          </h2>
          <p className="mt-4 text-lg text-muted-foreground leading-relaxed">
            No training needed. No complicated setup. Your teachers can start
            generating content on their first day.
          </p>
        </div>

        {/* Steps */}
        <div className="grid md:grid-cols-4 gap-8">
          {steps.map((item, i) => (
            <div key={item.step} className="relative">
              {/* Connector line */}
              {i < steps.length - 1 && (
                <div className="hidden md:block absolute top-12 left-[calc(50%+32px)] w-[calc(100%-64px)] h-px bg-border" />
              )}

              <div className="text-center">
                {/* Step number + icon */}
                <div className="relative inline-flex">
                  <div className="h-24 w-24 rounded-2xl bg-primary/10 flex items-center justify-center mx-auto">
                    <item.icon size={36} className="text-primary" />
                  </div>
                  <span className="absolute -top-2 -right-2 h-7 w-7 rounded-full bg-primary text-primary-foreground text-xs font-bold flex items-center justify-center">
                    {item.step}
                  </span>
                </div>

                <h3 className="mt-6 text-lg font-bold text-foreground">
                  {item.title}
                </h3>
                <p className="mt-2 text-sm text-muted-foreground leading-relaxed max-w-xs mx-auto">
                  {item.description}
                </p>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}
