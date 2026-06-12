'use client'

import { useEffect, useState } from 'react'
import { motion } from 'framer-motion'
import { ArrowRight, Clock, FileText, GraduationCap } from 'lucide-react'
import { fadeUp, stagger, ease } from '@/lib/motion'
import { MotionCard } from './ui/MotionCard'

const rotatingWords = ['lesson notes', 'schemes of work', 'exam prep', 'results & report cards', 'your whole school']

export default function Hero() {
  const [wordIndex, setWordIndex] = useState(0)

  useEffect(() => {
    const interval = setInterval(() => {
      setWordIndex((prev) => (prev + 1) % rotatingWords.length)
    }, 2800)
    return () => clearInterval(interval)
  }, [])

  return (
    <section className="relative min-h-[92vh] flex items-center pt-28 sm:pt-32 md:pt-28 overflow-hidden">
      {/* Background: plain white */}

      <div className="mx-auto w-full max-w-6xl px-5 sm:px-6 lg:px-8 py-12 md:py-20">
        <div className="grid lg:grid-cols-12 gap-10 lg:gap-16 items-center">
          <motion.div
            variants={stagger(0.1, 0.12)}
            initial="hidden"
            animate="show"
            className="lg:col-span-7"
          >
            <motion.div
              variants={fadeUp}
              className="inline-flex items-center gap-2 rounded-full bg-primary/10 ring-1 ring-primary/15 px-3.5 py-1.5 mb-6"
            >
              <span className="h-1.5 w-1.5 rounded-full bg-primary animate-pulse" />
              <span className="text-[11px] font-semibold text-primary tracking-[0.14em] uppercase">
                The Nigerian School Operating System
              </span>
            </motion.div>

            <motion.h1
              variants={fadeUp}
              className="text-[2.25rem] sm:text-5xl lg:text-[3.75rem] font-semibold leading-[1.05] tracking-[-0.035em] text-foreground"
            >
              One AI integrated platform to run{' '}
              <span className="relative inline-block align-baseline">
                <motion.span
                  key={wordIndex}
                  initial={{ y: 18, opacity: 0 }}
                  animate={{ y: 0, opacity: 1 }}
                  exit={{ y: -18, opacity: 0 }}
                  transition={{ duration: 0.5, ease }}
                  className="text-primary"
                >
                  {rotatingWords[wordIndex]}
                </motion.span>
              </span>.
            </motion.h1>

            <motion.p
              variants={fadeUp}
              className="mt-5 sm:mt-6 text-base sm:text-lg text-muted-foreground leading-relaxed max-w-xl"
            >
              Klassrun is the AI-powered operating system for Nigerian schools. Run your
              academics from one place, lesson notes, schemes of work, and WAEC/NECO
              exam prep, with results, attendance, and parent portal coming as you grow.
            </motion.p>

            <motion.div
              variants={fadeUp}
              className="mt-8 sm:mt-10 flex flex-col sm:flex-row gap-3"
            >
              <a
                href="https://app.klassrun.com/signup"
                className="group inline-flex items-center justify-center gap-2 rounded-xl bg-primary px-6 py-3.5 text-sm font-semibold text-primary-foreground shadow-[var(--shadow-glow)] hover:bg-klassrun-green-dark transition-all duration-300 ease-out hover:-translate-y-0.5"
              >
                Start Free Trial
                <ArrowRight size={16} className="transition-transform duration-300 group-hover:translate-x-0.5" />
              </a>
              <a
                href="#how-it-works"
                className="inline-flex items-center justify-center gap-2 rounded-xl border border-soft bg-white px-6 py-3.5 text-sm font-semibold text-foreground hover:bg-secondary transition-colors duration-300 ease-out"
              >
                See how it works
              </a>
            </motion.div>

            <motion.div
              variants={fadeUp}
              className="mt-10 sm:mt-12 grid grid-cols-3 gap-5 sm:gap-8 pt-8 border-t border-subtle"
            >
              {[
                { icon: Clock, metric: '4×', label: 'Faster lesson prep' },
                { icon: FileText, metric: '50%', label: 'Less admin work' },
                { icon: GraduationCap, metric: '100%', label: 'NERDC aligned' },
              ].map(({ icon: Icon, metric, label }) => (
                <div key={label}>
                  <div className="flex items-center gap-1.5 sm:gap-2 text-primary">
                    <Icon size={16} />
                    <span className="text-xl sm:text-2xl font-semibold text-foreground tracking-tight">
                      {metric}
                    </span>
                  </div>
                  <p className="text-xs sm:text-sm text-muted-foreground mt-1 sm:mt-1.5 leading-snug">
                    {label}
                  </p>
                </div>
              ))}
            </motion.div>
          </motion.div>

          {/* Product mockup */}
          <motion.div
            initial={{ opacity: 0, y: 40 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.9, ease, delay: 0.2 }}
            className="lg:col-span-5 relative"
          >
            <div className="rounded-2xl p-2"
            >
              <div className="flex items-center gap-2 px-4 py-3 border-b border-subtle">
                <div className="flex gap-1.5">
                  <div className="w-2.5 h-2.5 rounded-full bg-red-400/80" />
                  <div className="w-2.5 h-2.5 rounded-full bg-yellow-400/80" />
                  <div className="w-2.5 h-2.5 rounded-full bg-green-400/80" />
                </div>
                <div className="flex-1 mx-4">
                  <div className="bg-secondary rounded-md px-3 py-1.5 text-[11px] text-muted-foreground text-center font-medium">
                    app.klassrun.com
                  </div>
                </div>
              </div>

              <div className="p-5 sm:p-6 space-y-4">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-[11px] text-muted-foreground">Welcome back,</p>
                    <p className="text-sm font-semibold text-foreground tracking-tight">Mrs. Adeyemi</p>
                  </div>
                  <div className="text-[11px] bg-primary/10 text-primary px-3 py-1 rounded-full font-medium">
                    2025/2026 · Term 2
                  </div>
                </div>

                <div className="grid grid-cols-2 gap-3">
                  <div className="rounded-xl bg-primary/10 ring-1 ring-primary/15 p-4 cursor-pointer hover:bg-primary/15 transition-colors duration-300">
                    <FileText size={18} className="text-primary mb-2" />
                    <p className="text-sm font-semibold text-foreground tracking-tight">Generate Lesson Note</p>
                    <p className="text-[11px] text-muted-foreground mt-1">JSS 2 · Mathematics</p>
                  </div>
                  <div className="rounded-xl bg-secondary border border-subtle p-4 cursor-pointer hover:bg-secondary/70 transition-colors duration-300">
                    <GraduationCap size={18} className="text-foreground/60 mb-2" />
                    <p className="text-sm font-semibold text-foreground tracking-tight">Create Exam Paper</p>
                    <p className="text-[11px] text-muted-foreground mt-1">SS 1 · English Language</p>
                  </div>
                </div>

                <div className="space-y-2">
                  <p className="text-[10px] font-semibold text-muted-foreground uppercase tracking-[0.14em]">
                    Recent
                  </p>
                  {[
                    { subject: 'Basic Science', class: 'JSS 1', type: 'Lesson Note', time: '2 mins ago' },
                    { subject: 'Mathematics', class: 'SS 2', type: 'Exam Questions', time: '1 hour ago' },
                    { subject: 'Civic Education', class: 'JSS 3', type: 'Scheme of Work', time: '3 hours ago' },
                  ].map((item, i) => (
                    <motion.div
                      key={i}
                      initial={{ opacity: 0, x: -8 }}
                      animate={{ opacity: 1, x: 0 }}
                      transition={{ delay: 0.6 + i * 0.08, duration: 0.4, ease }}
                      className="flex items-center justify-between rounded-lg bg-white border border-subtle px-4 py-3"
                    >
                      <div>
                        <p className="text-sm font-medium text-foreground tracking-tight">
                          {item.subject}{' '}
                          <span className="text-muted-foreground font-normal">· {item.class}</span>
                        </p>
                        <p className="text-[11px] text-muted-foreground">{item.type}</p>
                      </div>
                      <span className="text-[11px] text-muted-foreground">{item.time}</span>
                    </motion.div>
                  ))}
                </div>
              </div>
            </div>

            <motion.div
              initial={{ opacity: 0, x: -16, y: 16 }}
              animate={{ opacity: 1, x: 0, y: 0 }}
              transition={{ delay: 0.8, duration: 0.6, ease }}
              className="absolute -bottom-4 -left-2 sm:-bottom-5 sm:-left-5 bg-white rounded-xl border border-soft shadow-lift px-3.5 py-2.5 sm:px-4 sm:py-3 flex items-center gap-3"
            >
              <div className="h-9 w-9 sm:h-10 sm:w-10 rounded-full bg-primary/10 flex items-center justify-center">
                <Clock size={16} className="text-primary sm:hidden" />
                <Clock size={18} className="text-primary hidden sm:block" />
              </div>
              <div>
                <p className="text-sm font-semibold text-foreground tracking-tight">3 hours saved</p>
                <p className="text-[11px] text-muted-foreground">This afternoon</p>
              </div>
            </motion.div>
          </motion.div>
        </div>
      </div>
    </section>
  )
}
