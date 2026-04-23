'use client'

import { motion } from 'framer-motion'
import { fadeUp, stagger, viewportOnce } from '@/lib/motion'

export function Section({
  id,
  children,
  className = '',
  surface = 'base',
  bleed = false,
}) {
  const surfaceCls = {
    base: '',
    elevated: 'bg-secondary/40',
    floating: 'bg-white',
    muted: 'bg-secondary/30',
  }[surface]

  return (
    <section
      id={id}
      className={`relative py-20 md:py-28 lg:py-32 ${surfaceCls} ${className}`}
    >
      <div className={bleed ? '' : 'mx-auto w-full max-w-6xl px-5 sm:px-6 lg:px-8'}>
        {children}
      </div>
    </section>
  )
}

export function SectionHeader({ eyebrow, title, subtitle, align = 'center' }) {
  const alignCls = align === 'center' ? 'text-center mx-auto' : 'text-left'

  return (
    <motion.div
      variants={stagger(0, 0.1)}
      initial="hidden"
      whileInView="show"
      viewport={viewportOnce}
      className={`max-w-2xl ${alignCls} mb-14 md:mb-20`}
    >
      {eyebrow && (
        <motion.p
          variants={fadeUp}
          className="text-[11px] sm:text-xs font-semibold text-primary uppercase tracking-[0.18em] mb-4"
        >
          {eyebrow}
        </motion.p>
      )}
      <motion.h2
        variants={fadeUp}
        className="text-[1.75rem] sm:text-4xl md:text-[2.75rem] font-semibold text-foreground leading-[1.1]"
      >
        {title}
      </motion.h2>
      {subtitle && (
        <motion.p
          variants={fadeUp}
          className="mt-5 text-base sm:text-lg text-muted-foreground leading-relaxed"
        >
          {subtitle}
        </motion.p>
      )}
    </motion.div>
  )
}
