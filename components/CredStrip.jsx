import { Shield, BookOpen, Award, Laptop } from 'lucide-react'

const credentials = [
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
        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6 md:gap-8 place-items-center">
          {credentials.map((cred) => (
            <div
              key={cred.label}
              className="flex flex-col items-center justify-center text-center gap-2"
            >
              <div className="h-12 w-12 rounded-lg bg-primary/10 flex items-center justify-center">
                <cred.icon size={24} className="text-primary" />
              </div>
              <p className="text-sm font-semibold text-foreground">{cred.label}</p>
              <p className="text-xs text-muted-foreground">{cred.detail}</p>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}
