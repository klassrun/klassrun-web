'use client'

import { BookOpen, Award, Laptop } from 'lucide-react'
import { motion } from 'framer-motion'
import { stagger, fadeUp, viewportOnce } from '@/lib/motion'

const credentials = [
  { icon: BookOpen, label: 'NERDC Aligned', detail: 'Full Curriculum' },
  { icon: Award,    label: 'WAEC / NECO',   detail: 'Exam Standards' },
  { icon: Laptop,   label: 'Works Offline', detail: 'PWA Enabled'    },
]

export default function CredStrip() {
  return (
    <section className="border-y border-subtle bg-secondary/40">
      <div className="mx-auto w-full max-w-6xl px-6 sm:px-8 py-8">
        <motion.div
          variants={stagger(0, 0.1)}
          initial="hidden"
          whileInView="show"
          viewport={viewportOnce}
          className="grid grid-cols-1 sm:grid-cols-3 gap-8 place-items-center"
        >
          {credentials.map((cred) => (
            <motion.div
              key={cred.label}
              variants={fadeUp}
              className="flex items-center gap-3 text-center sm:text-left"
            >
              <div className="h-10 w-10 rounded-lg bg-primary/10 ring-1 ring-primary/10 flex items-center justify-center shrink-0">
                <cred.icon size={18} className="text-primary" />
              </div>
              <div>
                <p className="text-sm font-semibold text-foreground tracking-tight leading-tight">
                  {cred.label}
                </p>
                <p className="text-[11px] text-muted-foreground leading-tight mt-0.5">
                  {cred.detail}
                </p>
              </div>
            </motion.div>
          ))}
        </motion.div>
      </div>
    </section>
  )
}
