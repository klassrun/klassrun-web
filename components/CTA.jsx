import { ArrowRight } from 'lucide-react'

export default function CTA() {
  return (
    <section id="contact" className="py-20 md:py-28">
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div className="relative rounded-3xl bg-foreground overflow-hidden">
          {/* Background decoration */}
          <div className="absolute inset-0">
            <div className="absolute top-0 right-0 w-[400px] h-[400px] bg-primary/20 rounded-full blur-3xl -translate-y-1/2 translate-x-1/3" />
            <div className="absolute bottom-0 left-0 w-[300px] h-[300px] bg-primary/10 rounded-full blur-3xl translate-y-1/2 -translate-x-1/3" />
          </div>

          <div className="relative px-8 py-16 md:px-16 md:py-20 text-center">
            <h2 className="text-3xl sm:text-4xl lg:text-5xl font-extrabold text-white tracking-tight max-w-3xl mx-auto leading-tight">
              Stop Writing Lesson Notes.{' '}
              <span className="text-primary">Start Teaching.</span>
            </h2>
            <p className="mt-5 text-lg text-white/70 max-w-xl mx-auto leading-relaxed">
              Join the schools that are saving 200+ hours per term with
              KlassRun. Start your free trial today — no credit card needed.
            </p>

            <div className="mt-10 flex flex-col sm:flex-row items-center justify-center gap-4">
              <a
                href="mailto:info@klassrun.com"
                className="inline-flex items-center justify-center gap-2 rounded-lg bg-primary px-8 py-4 text-base font-semibold text-primary-foreground shadow-lg shadow-primary/30 hover:bg-klassrun-green-dark transition-all"
              >
                Start Free Trial
                <ArrowRight size={18} />
              </a>
              {/* <a
                href="https://wa.me/2348000000000"
                target="_blank"
                rel="noopener noreferrer"
                className="inline-flex items-center justify-center gap-2 rounded-lg border border-white/20 px-8 py-4 text-base font-semibold text-white hover:bg-white/10 transition-colors"
              >
                Chat on WhatsApp
              </a> */}
            </div>

            <p className="mt-6 text-sm text-white/50">
              First term free for pilot schools · No setup fees · Cancel
              anytime
            </p>
          </div>
        </div>
      </div>
    </section>
  )
}
