import { Check } from 'lucide-react'

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
    <section id="pricing" className="py-20 md:py-28 bg-secondary/30">
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        {/* Section header */}
        <div className="text-center max-w-3xl mx-auto mb-16">
          <p className="text-sm font-semibold text-primary uppercase tracking-wider mb-3">
            Pricing
          </p>
          <h2 className="text-3xl sm:text-4xl font-bold text-foreground tracking-tight">
            Simple, Termly Pricing
          </h2>
          <p className="mt-4 text-lg text-muted-foreground leading-relaxed">
            Pay per term — the way Nigerian schools budget. No hidden fees, no
            per-teacher charges. Save 10% with annual billing.
          </p>
        </div>

        {/* Pricing cards */}
        <div className="grid md:grid-cols-3 gap-8 max-w-5xl mx-auto">
          {plans.map((plan) => (
            <div
              key={plan.name}
              className={`relative rounded-2xl p-8 ${
                plan.highlighted
                  ? 'bg-foreground text-white border-2 border-foreground shadow-2xl scale-[1.03]'
                  : 'bg-white border border-border'
              }`}
            >
              {/* Badge */}
              {plan.badge && (
                <div className="absolute -top-3 left-1/2 -translate-x-1/2">
                  <span className="inline-block rounded-full bg-primary px-4 py-1 text-xs font-semibold text-primary-foreground">
                    {plan.badge}
                  </span>
                </div>
              )}

              <div className="mb-6">
                <h3
                  className={`text-lg font-bold ${
                    plan.highlighted ? 'text-white' : 'text-foreground'
                  }`}
                >
                  {plan.name}
                </h3>
                <p
                  className={`mt-1 text-sm ${
                    plan.highlighted ? 'text-white/70' : 'text-muted-foreground'
                  }`}
                >
                  {plan.description}
                </p>
              </div>

              <div className="mb-6">
                <span
                  className={`text-4xl font-extrabold ${
                    plan.highlighted ? 'text-white' : 'text-foreground'
                  }`}
                >
                  ₦{plan.price}
                </span>
                <span
                  className={`text-sm ${
                    plan.highlighted ? 'text-white/60' : 'text-muted-foreground'
                  }`}
                >
                  {plan.period}
                </span>
              </div>

              <ul className="space-y-3 mb-8">
                {plan.features.map((feature) => (
                  <li key={feature} className="flex items-start gap-3">
                    <Check
                      size={16}
                      className={`mt-0.5 flex-shrink-0 ${
                        plan.highlighted ? 'text-primary' : 'text-primary'
                      }`}
                    />
                    <span
                      className={`text-sm ${
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
                className={`block w-full text-center rounded-lg px-6 py-3 text-sm font-semibold transition-colors ${
                  plan.highlighted
                    ? 'bg-primary text-primary-foreground hover:bg-klassrun-green-dark'
                    : 'bg-foreground text-white hover:bg-foreground/90'
                }`}
              >
                {plan.cta}
              </a>
            </div>
          ))}
        </div>

        {/* Enterprise callout */}
        <div className="mt-12 text-center">
          <p className="text-muted-foreground">
            Running 3+ schools?{' '}
            <a
              href="#contact"
              className="text-primary font-semibold hover:underline"
            >
              Contact us for Enterprise pricing
            </a>{' '}
            — custom branding, multi-school management, and dedicated support.
          </p>
        </div>
      </div>
    </section>
  )
}
