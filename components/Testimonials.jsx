import { Quote, ArrowRight } from 'lucide-react'
import { Section, SectionHeader } from './ui/Section'

// PLACEHOLDER — replace with real quotes from real schools before launch.
// These render exactly as written, so the bracketed text cannot be mistaken
// for a genuine testimonial. Do NOT invent names here.
const quotes = [
  {
    quote: '[PLACEHOLDER — real quote from a pilot school goes here]',
    name: '[Name Surname]',
    role: '[Role, School]',
  },
  {
    quote: '[PLACEHOLDER — real quote from a teacher goes here]',
    name: '[Name Surname]',
    role: '[Role, School]',
  },
  {
    quote: '[PLACEHOLDER — real quote from a school owner goes here]',
    name: '[Name Surname]',
    role: '[Role, School]',
  },
]

export default function Testimonials() {
  return (
    <Section id="testimonials" surface="mint">
      <SectionHeader title="What schools are saying" />

      <div className="flex gap-5 overflow-x-auto no-scrollbar snap-x snap-mandatory pb-2 -mx-5 px-5 sm:mx-0 sm:px-0">
        {quotes.map((q) => (
          <figure
            key={q.quote}
            className="snap-start flex-shrink-0 w-[85%] sm:w-[420px] rounded-3xl bg-white p-7 sm:p-8 shadow-soft"
          >
            <Quote size={22} className="text-primary mb-4" fill="currentColor" strokeWidth={0} />
            <blockquote className="text-sm sm:text-[15px] text-foreground/85 leading-relaxed">
              {q.quote}
            </blockquote>
            <figcaption className="mt-5 text-sm italic text-muted-foreground">
              — {q.name}, {q.role}
            </figcaption>
          </figure>
        ))}
      </div>

      <div className="mt-10 flex flex-col sm:flex-row items-center justify-center gap-3">
        <a
          href="https://app.klassrun.com/signup"
          className="group w-full sm:w-auto inline-flex items-center justify-center gap-2 rounded-full bg-primary px-7 py-3.5 text-sm font-bold text-primary-foreground hover:bg-klassrun-green-dark transition-colors duration-300"
        >
          Start Free Trial
          <ArrowRight size={16} className="transition-transform duration-300 group-hover:translate-x-0.5" />
        </a>
        <a
          href="mailto:info@klassrun.com"
          className="w-full sm:w-auto inline-flex items-center justify-center rounded-full border border-soft bg-white px-7 py-3.5 text-sm font-bold text-foreground hover:bg-secondary transition-colors duration-300"
        >
          Talk to us
        </a>
      </div>
    </Section>
  )
}
