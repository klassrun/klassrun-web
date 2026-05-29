'use client'

import { Check } from 'lucide-react'
import { motion } from 'framer-motion'
import { Section, SectionHeader } from './ui/Section'
import { MotionCard } from './ui/MotionCard'
import { gridStagger, viewportOnce } from '@/lib/motion'

const plans = [
  {
    name: 'Starter',
    price: 40000,
    period: '/term',
    description: 'For schools getting started with AI lesson planning.',
    features: [
      { text: 'AI Lesson Note Generator', soon: false },
      { text: 'AI Scheme of Work Generator', soon: false },
      { text: 'Session & Term management', soon: false },
      { text: 'Up to 10 teachers', soon: false },
    ],
    cta: 'Start Free Trial',
    ctaHref: 'https://app.klassrun.com/signup',
    highlighted: false,
  },
  {
    name: 'Standard',
    price: 60000,
    period: '/term',
    description: 'For schools running their whole term inside Klassrun.',
    features: [
      { text: 'Everything in Starter', soon: false },
      { text: 'Upload your scheme → generate aligned lesson notes', soon: true },
      { text: 'AI Exam Question Generator', soon: true },
      { text: 'School Question Bank (never repeat questions)', soon: true },
      { text: 'PDF Export with school branding', soon: true },
      { text: 'Usage analytics', soon: true },
      { text: 'Up to 30 teachers', soon: false },
    ],
    cta: 'Start Free Trial',
    ctaHref: 'https://app.klassrun.com/signup',
    highlighted: true,
    badge: 'Most Popular',
  },
  {
    name: 'Premium',
    price: 150000,
    period: '/term',
    description: 'The full school operations platform.',
    features: [
      { text: 'Everything in Standard', soon: false },
      { text: 'Results & Report Cards', soon: true },
      { text: 'AI Report Card Comments', soon: true },
      { text: 'Attendance Tracking', soon: true },
      { text: 'Parent Portal', soon: true },
      { text: 'Unlimited teachers', soon: false },
      { text: 'Priority support', soon: false },
    ],
    cta: 'Contact Sales',
    ctaHref: '#contact',
    highlighted: false,
  },
]

function formatPrice(price) {
  if (typeof price === 'number') {
    return `₦${price.toLocaleString('en-NG')}`
  }
  return price
}

export default function Pricing() {
  return (
    <Section id="pricing" surface="muted">
      <SectionHeader
        eyebrow="Pricing"
        title="Simple, termly pricing"
        subtitle="Pay per term — the way Nigerian schools budget. No hidden fees, no per-teacher charges. Save 10% with annual billing."
      />

      <div className="text-center mb-10 sm:mb-12">
        <div className="inline-flex items-center gap-2 rounded-full bg-primary/10 ring-1 ring-primary/15 px-4 py-2">
          <Check size={14} className="text-primary" strokeWidth={3} />
          <span className="text-xs sm:text-sm font-medium text-foreground">
            All plans start with a 14-day free trial. No card required.
          </span>
        </div>
      </div>

      <motion.div
        variants={gridStagger}
        initial="hidden"
        whileInView="show"
        viewport={viewportOnce}
        className="grid md:grid-cols-3 gap-6 md:gap-8 max-w-5xl mx-auto perspective-card"
      >
        {plans.map((plan, i) => (
          <MotionCard
            key={plan.name}
            entrance="flip"
            index={i}
            intensity={plan.highlighted ? 6 : 9}
            lift={plan.highlighted ? 6 : 10}
            className={`relative rounded-2xl p-7 sm:p-8 ${
              plan.highlighted
                ? 'bg-foreground text-white ring-1 ring-foreground shadow-hero md:scale-[1.03]'
                : 'bg-white border border-soft shadow-xs hover:shadow-card transition-shadow duration-500'
            }`}
          >
            {plan.badge && (
              <div className="absolute -top-3 left-1/2 -translate-x-1/2">
                <span className="inline-block rounded-full bg-primary px-3.5 py-1 text-[11px] font-semibold text-primary-foreground tracking-wide shadow-soft">
                  {plan.badge}
                </span>
              </div>
            )}

            <div className="mb-6">
              <h3
                className={`text-base font-semibold tracking-tight ${
                  plan.highlighted ? 'text-white' : 'text-foreground'
                }`}
              >
                {plan.name}
              </h3>
              <p
                className={`mt-1.5 text-sm leading-relaxed ${
                  plan.highlighted ? 'text-white/65' : 'text-muted-foreground'
                }`}
              >
                {plan.description}
              </p>
            </div>

            <div className="mb-8 flex items-baseline gap-1">
              <span
                className={`text-4xl font-semibold tracking-[-0.03em] ${
                  plan.highlighted ? 'text-white' : 'text-foreground'
                }`}
              >
                {formatPrice(plan.price)}
              </span>
              <span
                className={`text-sm ${
                  plan.highlighted ? 'text-white/55' : 'text-muted-foreground'
                }`}
              >
                {plan.period}
              </span>
            </div>

            <ul className="space-y-3 mb-8">
              {plan.features.map((feature) => (
                <li key={feature.text} className="flex items-start gap-3">
                  <span
                    className={`mt-0.5 flex-shrink-0 h-4 w-4 rounded-full flex items-center justify-center ${
                      plan.highlighted ? 'bg-primary/20' : 'bg-primary/10'
                    }`}
                  >
                    <Check size={10} className="text-primary" strokeWidth={3} />
                  </span>
                  <span
                    className={`text-sm leading-relaxed flex-1 ${
                      plan.highlighted ? 'text-white/80' : 'text-muted-foreground'
                    }`}
                  >
                    {feature.text}
                    {feature.soon && (
                      <span
                        className={`ml-2 inline-block rounded-full px-2 py-0.5 text-[10px] font-semibold tracking-wide ${
                          plan.highlighted
                            ? 'bg-white/15 text-white/80'
                            : 'bg-foreground/8 text-foreground/65'
                        }`}
                      >
                        Soon
                      </span>
                    )}
                  </span>
                </li>
              ))}
            </ul>

            <a
              href={plan.ctaHref}
              className={`block w-full text-center rounded-xl px-6 py-3 text-sm font-semibold transition-all duration-300 ease-out hover:-translate-y-0.5 ${
                plan.highlighted
                  ? 'bg-primary text-primary-foreground hover:bg-klassrun-green-dark shadow-[var(--shadow-glow)]'
                  : 'bg-foreground text-white hover:bg-klassrun-navy-light'
              }`}
            >
              {plan.cta}
            </a>
          </MotionCard>
        ))}
      </motion.div>

      <div className="mt-12 sm:mt-16 text-center max-w-2xl mx-auto">
        <p className="text-sm text-muted-foreground leading-relaxed">
          Larger school, multi-campus group, or need fee management, CBT, or bursar workflows?{' '}
          <a href="#contact" className="text-primary font-semibold hover:underline underline-offset-4">
            Contact us
          </a>{' '}
          — we'll quote and roadmap with you directly.
        </p>
      </div>
    </Section>
  )
}
