import { Target, Lightbulb } from 'lucide-react'

export default function About() {
  return (
    <section id="about" className="py-20 md:py-28">
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        {/* Section header */}
        <div className="text-center max-w-3xl mx-auto mb-16">
          <p className="text-sm font-semibold text-primary uppercase tracking-wider mb-3">
            About Klassrun
          </p>
          <h2 className="text-3xl sm:text-4xl font-bold text-foreground tracking-tight">
            We&apos;re Building the Operating System for Nigerian Schools
          </h2>
          <p className="mt-4 text-lg text-muted-foreground leading-relaxed">
            Klassrun Technologies Ltd is a CAC-registered EdTech company on a
            mission to eliminate the repetitive administrative work that burns
            Nigerian teachers out — starting with lesson notes and exams.
          </p>
        </div>

        {/* Two column content */}
        <div className="grid md:grid-cols-2 gap-8 lg:gap-12">
          {/* The Problem */}
          <div className="rounded-2xl border border-border bg-white p-8 lg:p-10">
            <div className="h-12 w-12 rounded-xl bg-destructive/10 flex items-center justify-center mb-6">
              <Target size={24} className="text-destructive" />
            </div>
            <h3 className="text-xl font-bold text-foreground mb-4">
              The Problem
            </h3>
            <ul className="space-y-3">
              {[
                'Teachers spend 10–15 hours weekly writing lesson notes by hand',
                'Exam questions are recycled year after year — students share old answers',
                'No existing tool aligns with NERDC curriculum and WAEC/NECO standards',
                'School owners have zero visibility into teacher productivity',
                'Manual processes leave teachers burned out with no time for actual teaching',
              ].map((point, i) => (
                <li key={i} className="flex items-start gap-3">
                  <span className="mt-1.5 h-1.5 w-1.5 rounded-full bg-destructive flex-shrink-0" />
                  <span className="text-sm text-muted-foreground leading-relaxed">
                    {point}
                  </span>
                </li>
              ))}
            </ul>
          </div>

          {/* The Solution */}
          <div className="rounded-2xl border border-primary/20 bg-primary/[0.03] p-8 lg:p-10">
            <div className="h-12 w-12 rounded-xl bg-primary/10 flex items-center justify-center mb-6">
              <Lightbulb size={24} className="text-primary" />
            </div>
            <h3 className="text-xl font-bold text-foreground mb-4">
              Our Solution
            </h3>
            <ul className="space-y-3">
              {[
                'AI generates complete, curriculum-aligned lesson notes in under 60 seconds',
                'Every exam question is fresh — AI tracks and never duplicates questions per school',
                'Built exclusively for Nigerian curriculum: NERDC topics, WAEC/NECO style',
                'Admin dashboard shows hours saved, notes generated, and teacher activity',
                'Works offline on any device — teachers generate notes even without internet',
              ].map((point, i) => (
                <li key={i} className="flex items-start gap-3">
                  <span className="mt-1.5 h-1.5 w-1.5 rounded-full bg-primary flex-shrink-0" />
                  <span className="text-sm text-muted-foreground leading-relaxed">
                    {point}
                  </span>
                </li>
              ))}
            </ul>
          </div>
        </div>
      </div>
    </section>
  )
}
