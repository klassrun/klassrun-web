import { Check } from 'lucide-react'
import { Section, SectionHeader } from './ui/Section'

// Final amounts are not announced yet - every tier shows "Coming soon".
// REVIEW the feature split across tiers before launch.
const plans = [
  {
    name: 'Starter',
    description: 'For schools that just want lesson planning off their plate.',
    features: [
      { text: 'Lesson note generation', soon: false },
      { text: 'Scheme of work generation', soon: false },
      { text: 'Session & term management', soon: false },
      { text: 'Up to 10 teachers', soon: false },
    ],
    cta: 'Start Free Trial',
    ctaHref: 'https://app.klassrun.com/signup',
    highlighted: false,
  },
  {
    name: 'Standard',
    description: 'For schools ready to run the whole term inside Klassrun.',
    features: [
      { text: 'Everything in Starter', soon: false },
      { text: 'Exam question generation', soon: false },
      { text: 'School question bank (never repeat questions)', soon: false },
      { text: 'Upload your scheme and get matching lesson notes', soon: true },
      { text: 'PDF export with school branding', soon: true },
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
    description: 'The whole school, end to end.',
    features: [
      { text: 'Everything in Standard', soon: false },
      { text: 'Results & report cards', soon: false },
      { text: 'Attendance & behaviour tracking', soon: false },
      { text: 'Fees & bursar tools', soon: false },
      { text: 'Report card comments, written for you', soon: true },
      { text: 'Parent portal', soon: true },
      { text: 'Unlimited teachers', soon: false },
      { text: 'Priority support', soon: false },
    ],
    cta: 'Contact Sales',
    ctaHref: 'mailto:info@klassrun.com',
    highlighted: false,
  },
]

export default function Pricing() {
  return (
    <Section id="pricing" surface="white">
      <SectionHeader
        title="Simple, termly pricing"
        subtitle="Pay per term, the way Nigerian schools budget. Final amounts are coming soon, and the free trial is open now."
      />

      <div className="text-center mb-10 sm:mb-12">
        <div className="inline-flex items-center gap-2 rounded-full bg-primary/10 ring-1 ring-primary/15 px-4 py-2">
          <Check size={14} className="text-primary" strokeWidth={3} />
          <span className="text-xs sm:text-sm font-semibold text-foreground">
            All plans start with a 14-day free trial. No card required.
          </span>
        </div>
      </div>

      <div className="grid md:grid-cols-3 gap-6 md:gap-7 max-w-5xl mx-auto">
        {plans.map((plan) => (
          <div
            key={plan.name}
            className={`relative rounded-3xl p-7 sm:p-8 ${
              plan.highlighted
                ? 'bg-klassrun-navy text-white shadow-hero md:scale-[1.03]'
                : 'bg-white border border-soft shadow-xs'
            }`}
          >
            {plan.badge && (
              <div className="absolute -top-3 left-1/2 -translate-x-1/2">
                <span className="inline-block rounded-full bg-primary px-3.5 py-1 text-[11px] font-bold text-primary-foreground tracking-wide shadow-soft">
                  {plan.badge}
                </span>
              </div>
            )}

            <div className="mb-6">
              <h3 className={`text-base font-bold ${plan.highlighted ? 'text-white' : 'text-foreground'}`}>
                {plan.name}
              </h3>
              <p className={`mt-1.5 text-sm leading-relaxed ${plan.highlighted ? 'text-white/65' : 'text-muted-foreground'}`}>
                {plan.description}
              </p>
            </div>

            <div className="mb-8 flex items-baseline gap-2">
              <span className={`text-2xl font-bold ${plan.highlighted ? 'text-white' : 'text-foreground'}`}>
                Coming soon
              </span>
              <span className={`text-sm ${plan.highlighted ? 'text-white/55' : 'text-muted-foreground'}`}>
                per term
              </span>
            </div>

            <ul className="space-y-3 mb-8">
              {plan.features.map((feature) => (
                <li key={feature.text} className="flex items-start gap-3">
                  <span
                    className={`mt-0.5 flex-shrink-0 h-4 w-4 rounded-full flex items-center justify-center ${
                      plan.highlighted ? 'bg-primary/25' : 'bg-primary/10'
                    }`}
                  >
                    <Check size={10} className={plan.highlighted ? 'text-klassrun-green-light' : 'text-primary'} strokeWidth={3.5} />
                  </span>
                  <span className={`text-sm leading-relaxed flex-1 ${plan.highlighted ? 'text-white/80' : 'text-muted-foreground'}`}>
                    {feature.text}
                    {feature.soon && (
                      <span
                        className={`ml-2 inline-block rounded-full px-2 py-0.5 text-[10px] font-bold tracking-wide ${
                          plan.highlighted ? 'bg-white/15 text-white/80' : 'bg-foreground/8 text-foreground/65'
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
              className={`block w-full text-center rounded-full px-6 py-3 text-sm font-bold transition-colors duration-300 ${
                plan.highlighted
                  ? 'bg-primary text-primary-foreground hover:bg-klassrun-green-dark'
                  : 'bg-klassrun-navy text-white hover:bg-klassrun-navy-light'
              }`}
            >
              {plan.cta}
            </a>
          </div>
        ))}
      </div>

      <div className="mt-12 sm:mt-14 text-center max-w-2xl mx-auto">
        <p className="text-sm text-muted-foreground leading-relaxed">
          Larger school or multi-campus group?{' '}
          <a href="mailto:info@klassrun.com" className="text-primary font-bold hover:underline underline-offset-4">
            Contact us
          </a>{' '}
          and we’ll quote and plan with you directly.
        </p>
      </div>
    </Section>
  )
}
