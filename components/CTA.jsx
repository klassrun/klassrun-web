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
          className="relative rounded-3xl overflow-hidden"
        >
          <motion.div
            variants={stagger(0.1, 0.1)}
            initial="hidden"
            whileInView="show"
            viewport={viewportOnce}
            className="relative px-6 py-14 sm:px-12 sm:py-20 md:px-16 md:py-24 text-center"
          >
            <motion.h2
              variants={fadeUp}
              className="text-[1.875rem] sm:text-4xl lg:text-[3.25rem] font-semibold text-foreground tracking-[-0.035em] max-w-3xl mx-auto leading-[1.08]"
            >
              Stop writing.{' '}
              <span className="text-primary">Start teaching.</span>
            </motion.h2>
            <motion.p
              variants={fadeUp}
              className="mt-5 sm:mt-6 text-base md:text-lg text-muted-foreground max-w-xl mx-auto leading-relaxed"
            >
              Stop juggling templates, WhatsApp groups, and last-minute exam prep.
              Klassrun runs your school — starting today.
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
                className="w-full sm:w-auto inline-flex items-center justify-center gap-2 rounded-xl border border-soft px-7 py-3.5 text-sm font-semibold text-foreground hover:bg-secondary transition-colors duration-300 ease-out"
              >
                Talk to us
              </a>
            </motion.div>
            <motion.p
              variants={fadeUp}
              className="mt-6 sm:mt-8 text-xs text-muted-foreground"
            >
              No credit card required · First term free for pilot schools · Cancel anytime
            </motion.p>
          </motion.div>
        </motion.div>
      </div>
    </section>
  )
}
