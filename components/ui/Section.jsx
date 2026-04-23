'use client'

import { motion } from 'framer-motion'
import { fadeUp, stagger, viewportOnce } from '@/lib/motion'

/**
 * Section — the single structural primitive for landing sections.
 * Handles: max width, padding, spacing rhythm, scroll reveal.
 */
export function Section({
  id,
  children,
  className = '',
  surface = 'base',       // 'base' | 'elevated' | 'floating' | 'muted'
  bleed = false,          // removes horizontal padding — full-bleed layouts
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
      className={`relative py-24 md:py-32 ${surfaceCls} ${className}`}
    >
      <div className={bleed ? '' : 'mx-auto w-full max-w-6xl px-6 sm:px-8'}>
        {children}
      </div>
    </section>
  )
}

/**
 * SectionHeader — eyebrow + title + subtitle with consistent rhythm.
 */
export function SectionHeader({ eyebrow, title, subtitle, align = 'center' }) {
  const alignCls =
    align === 'center' ? 'text-center mx-auto' : 'text-left'

  return (
    <motion.div
      variants={stagger(0, 0.1)}
      initial="hidden"
      whileInView="show"
      viewport={viewportOnce}
      className={`max-w-2xl ${alignCls} mb-16 md:mb-20`}
    >
      {eyebrow && (
        <motion.p
          variants={fadeUp}
          className="text-xs font-semibold text-primary uppercase tracking-[0.18em] mb-4"
        >
          {eyebrow}
        </motion.p>
      )}
      <motion.h2
        variants={fadeUp}
        className="text-3xl sm:text-4xl md:text-[2.75rem] font-semibold text-foreground leading-[1.1]"
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
