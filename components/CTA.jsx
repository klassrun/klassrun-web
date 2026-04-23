'use client'

import { ArrowRight } from 'lucide-react'
import { motion } from 'framer-motion'
import { fadeUp, stagger, ease, viewportOnce } from '@/lib/motion'

export default function CTA() {
  return (
    <section id="contact" className="py-20 md:py-28 lg:py-32">
      <div className="mx-auto w-full max-w-6xl px-5 sm:px-6 lg:px-8">
        <motion.div
          initial={{ opacity: 0, y: 40 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={viewportOnce}
          transition={{ duration: 0.8, ease }}
          className="relative rounded-3xl bg-foreground overflow-hidden shadow-hero"
        >
          <div className="absolute inset-0">
            <div className="absolute top-0 right-0 w-[420px] h-[420px] bg-primary/20 rounded-full blur-3xl -translate-y-1/2 translate-x-1/3" />
            <div className="absolute bottom-0 left-0 w-[320px] h-[320px] bg-primary/10 rounded-full blur-3xl translate-y-1/2 -translate-x-1/3" />
            <div
              className="absolute inset-0 opacity-30"
              style={{
                backgroundImage:
                  'radial-gradient(circle at 1px 1px, oklch(1 0 0 / 0.04) 1px, transparent 0)',
                backgroundSize: '28px 28px',
              }}
            />
          </div>

          <motion.div
            variants={stagger(0.1, 0.1)}
            initial="hidden"
            whileInView="show"
            viewport={viewportOnce}
            className="relative px-6 py-14 sm:px-12 sm:py-20 md:px-16 md:py-24 text-center"
          >
            <motion.h2
              variants={fadeUp}
              className="text-[1.875rem] sm:text-4xl lg:text-[3.25rem] font-semibold text-white tracking-[-0.035em] max-w-3xl mx-auto leading-[1.08]"
            >
              Stop writing.{' '}
              <span className="text-primary">Start teaching.</span>
            </motion.h2>
            <motion.p
              variants={fadeUp}
              className="mt-5 sm:mt-6 text-base md:text-lg text-white/65 max-w-xl mx-auto leading-relaxed"
            >
              Your teachers deserve better than spending every evening writing
              lesson notes. KlassRun gives them their time back — starting today.
            </motion.p>

            <motion.div
              variants={fadeUp}
              className="mt-8 sm:mt-10 flex flex-col sm:flex-row items-center justify-center gap-3"
            >
              <a
                href="https://app.klassrun.com/signup"
                className="group w-full sm:w-auto inline-flex items-center justify-center gap-2 rounded-xl bg-primary px-7 py-3.5 text-sm font-semibold text-primary-foreground shadow-[var(--shadow-glow)] hover:bg-klassrun-green-dark transition-all duration-300 ease-out hover:-translate-y-0.5"
              >
                Start Free Trial
                <ArrowRight size={16} className="transition-transform duration-300 group-hover:translate-x-0.5" />
              </a>
              <a
                href="mailto:info@klassrun.com"
                className="w-full sm:w-auto inline-flex items-center justify-center gap-2 rounded-xl border border-white/15 bg-white/[0.03] px-7 py-3.5 text-sm font-semibold text-white hover:bg-white/10 transition-colors duration-300 ease-out"
              >
                Talk to us
              </a>
            </motion.div>

            <motion.p
              variants={fadeUp}
              className="mt-6 sm:mt-8 text-xs text-white/45"
            >
              No credit card required · First term free for pilot schools · Cancel anytime
            </motion.p>
          </motion.div>
        </motion.div>
      </div>
    </section>
  )
}
