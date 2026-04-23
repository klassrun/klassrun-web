'use client'

import { Check } from 'lucide-react'
import { motion } from 'framer-motion'
import { Section, SectionHeader } from './ui/Section'
import { MotionCard } from './ui/MotionCard'
import { stagger, viewportOnce } from '@/lib/motion'

const plans = [
  {
    name: 'Starter',
    price: '30,000',
    period: '/term',
    description: 'For schools under 200 students getting started with AI.',
    features: [
      'AI Lesson Note Generator',
      'Exam Question Generator',
      'Session Stamping',
      'PDF Export (school-branded)',
      'Offline Access (PWA)',
      'Up to 10 teachers',
    ],
    cta: 'Start Free Trial',
    highlighted: false,
  },
  {
    name: 'Standard',
    price: '60,000',
    period: '/term',
    description: 'For growing schools that want data-driven operations.',
    features: [
      'Everything in Starter',
      'School Question Bank',
      'Student Performance Tracking',
      'Report Card Comments (AI)',
      'Usage Analytics Dashboard',
      'Scheme of Work Generator',
      'Up to 30 teachers',
    ],
    cta: 'Start Free Trial',
    highlighted: true,
    badge: 'Most Popular',
  },
  {
    name: 'Premium',
    price: '100,000',
    period: '/term',
    description: 'The full School OS for serious institutions.',
    features: [
      'Everything in Standard',
      'Parent Portal',
      'Attendance Tracking',
      'Grading & Report Cards',
      'Curriculum Update Alerts',
      'Priority Support',
      'Unlimited teachers',
    ],
    cta: 'Contact Sales',
    highlighted: false,
  },
]

export default function Pricing() {
  return (
    <Section id="pricing" surface="muted">
      <SectionHeader
        eyebrow="Pricing"
        title="Simple, termly pricing"
        subtitle="Pay per term — the way Nigerian schools budget. No hidden fees, no per-teacher charges. Save 10% with annual billing."
      />

      <motion.div
        variants={stagger(0.05, 0.1)}
        initial="hidden"
        whileInView="show"
        viewport={viewportOnce}
        className="grid md:grid-cols-3 gap-6 md:gap-8 max-w-5xl mx-auto perspective-card"
      >
        {plans.map((plan) => (
          <MotionCard
            key={plan.name}
            intensity={plan.highlighted ? 4 : 6}
            lift={plan.highlighted ? 4 : 8}
            className={`relative rounded-2xl p-8 ${
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
                ₦{plan.price}
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
                <li key={feature} className="flex items-start gap-3">
                  <span
                    className={`mt-0.5 flex-shrink-0 h-4 w-4 rounded-full flex items-center justify-center ${
                      plan.highlighted
                        ? 'bg-primary/20'
                        : 'bg-primary/10'
                    }`}
                  >
                    <Check size={10} className="text-primary" strokeWidth={3} />
                  </span>
                  <span
                    className={`text-sm leading-relaxed ${
                      plan.highlighted ? 'text-white/80' : 'text-muted-foreground'
                    }`}
                  >
                    {feature}
                  </span>
                </li>
              ))}
            </ul>

            <a
              href="#contact"
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

      <div className="mt-16 text-center">
        <p className="text-sm text-muted-foreground">
          Running 3+ schools?{' '}
          <a href="#contact" className="text-primary font-semibold hover:underline underline-offset-4">
            Contact us for Enterprise pricing
          </a>{' '}
          — custom branding, multi-school management, dedicated support.
        </p>
      </div>
    </Section>
  )
}
