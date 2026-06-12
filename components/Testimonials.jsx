import { Quote, ArrowRight } from 'lucide-react'
import { Section, SectionHeader } from './ui/Section'

// PLACEHOLDER — replace with real quotes from real schools before launch.
// Add up to 15 entries; the rail scrolls continuously and loops on its own,
// showing about 3 cards at a time on desktop. Do NOT invent names here.
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
  // slower with more quotes so reading speed stays comfortable
  const duration = Math.max(30, quotes.length * 12)

  return (
    <Section id="testimonials" surface="mint" bleed>
      <div className="mx-auto w-full max-w-6xl px-5 sm:px-6 lg:px-8">
        <SectionHeader title="What schools are saying" />
      </div>

      {/* Full-width rail: two identical halves animate -50% for a seamless loop */}
      <div className="overflow-hidden" style={{ '--marquee-duration': `${duration}s` }}>
        <div className="flex w-max animate-[marquee_var(--marquee-duration)_linear_infinite] hover:[animation-play-state:paused]">
          {[0, 1].map((half) => (
            <div key={half} aria-hidden={half === 1} className="flex gap-5 pr-5">
              {quotes.map((q, i) => (
                <figure
                  key={`${half}-${i}`}
                  className="w-[300px] sm:w-[400px] flex-shrink-0 rounded-3xl bg-white p-7 sm:p-8 shadow-soft"
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
          ))}
        </div>
      </div>

      <div className="mx-auto w-full max-w-6xl px-5 sm:px-6 lg:px-8">
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
      </div>
    </Section>
  )
}
