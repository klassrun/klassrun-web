import { Layers, MapPin, PenLine, MonitorSmartphone } from 'lucide-react'
import { Section, SectionHeader } from './ui/Section'

const cards = [
  {
    icon: Layers,
    title: 'Everything in one place',
    body: 'Lesson notes, exams, results, report cards, attendance and fees under one login. No more juggling templates, folders and WhatsApp groups.',
  },
  {
    icon: MapPin,
    title: 'Built for Nigerian schools',
    body: 'Three-term calendar, NERDC topics, WAEC-style questions, proper Nigerian report cards and naira pricing. Not a foreign tool squeezed to fit.',
  },
  {
    icon: PenLine,
    title: 'Notes and exams, written for you',
    body: 'Klassrun’s AI drafts complete lesson notes and exam questions from the curriculum topic. Teachers review, edit and teach — Sunday nights belong to them again.',
  },
  {
    icon: MonitorSmartphone,
    title: 'Works where schools work',
    body: 'Runs in the browser on any device, installs like an app, and is built to cope with slow connections.',
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
