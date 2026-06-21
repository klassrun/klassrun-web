import { Layers, MapPin, PenLine, MonitorSmartphone } from 'lucide-react'
import { Section, SectionHeader } from './ui/Section'

const cards = [
  {
    icon: Layers,
    title: 'Everything in one place',
    body: 'No more juggling templates, folders and WhatsApp groups. Lesson notes, exams, results, report cards, attendance and fees all sit under one login.',
  },
  {
    icon: MapPin,
    title: 'Built here, for here',
    body: 'Three-term calendar. NERDC topics. WAEC-style questions. Real Nigerian report cards. Prices in naira. This wasn’t a foreign tool bent to fit. It was built for your school from the start.',
  },
  {
    icon: PenLine,
    title: 'The writing’s already done',
    body: 'Klassrun drafts the full lesson note and the exam questions from the topic. Your teachers read, adjust and teach. The Sunday-night scramble is over.',
  },
  {
    icon: MonitorSmartphone,
    title: 'Works on whatever you’ve got',
    body: 'Any browser. Any device. Installs like an app. And it doesn’t fall over when the network is slow, because we built it knowing it wouldn’t always be fast.',
  },
]

export default function WhyKlassrun() {
  return (
    <Section id="why" surface="navy">
      <SectionHeader dark title="Why schools choose Klassrun" />
      <div className="grid sm:grid-cols-2 gap-x-12 gap-y-10 max-w-4xl mx-auto">
        {cards.map((c) => (
          <div key={c.title} className="flex items-start gap-5">
            <span className="flex-shrink-0 h-12 w-12 rounded-xl bg-white/15 ring-1 ring-white/25 flex items-center justify-center">
              <c.icon size={21} className="text-klassrun-green-light" />
            </span>
            <div>
              <h3 className="text-base sm:text-lg font-bold text-white">{c.title}</h3>
              <p className="mt-1.5 text-sm text-white/75 leading-relaxed">{c.body}</p>
            </div>
          </div>
        ))}
      </div>
    </Section>
  )
}
