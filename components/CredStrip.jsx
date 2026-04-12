import { Shield, BookOpen, Award, Laptop } from 'lucide-react'

const credentials = [
  {
    icon: Shield,
    label: 'CAC Registered',
    detail: 'RC 9463863',
  },
  {
    icon: BookOpen,
    label: 'NERDC Aligned',
    detail: 'Full Curriculum',
  },
  {
    icon: Award,
    label: 'WAEC / NECO',
    detail: 'Exam Standards',
  },
  {
    icon: Laptop,
    label: 'Works Offline',
    detail: 'PWA Enabled',
  },
]

export default function CredStrip() {
  return (
    <section className="border-y border-border bg-secondary/50">
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-6">
        <div className="grid grid-cols-2 md:grid-cols-4 gap-6 md:gap-8">
          {credentials.map((cred) => (
            <div key={cred.label} className="flex items-center gap-3">
              <div className="flex-shrink-0 h-10 w-10 rounded-lg bg-primary/10 flex items-center justify-center">
                <cred.icon size={20} className="text-primary" />
              </div>
              <div>
                <p className="text-sm font-semibold text-foreground">
                  {cred.label}
                </p>
                <p className="text-xs text-muted-foreground">{cred.detail}</p>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}
