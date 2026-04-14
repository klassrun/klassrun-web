'use client'

import { useEffect, useState } from 'react'
import { ArrowRight, Clock, FileText, GraduationCap } from 'lucide-react'

const rotatingWords = [
  'Lesson Notes',
  'Exam Questions',
  'Schemes of Work',
  'Report Cards',
]

export default function Hero() {
  const [wordIndex, setWordIndex] = useState(0)
  const [isVisible, setIsVisible] = useState(false)

  useEffect(() => {
    setIsVisible(true)
    const interval = setInterval(() => {
      setWordIndex((prev) => (prev + 1) % rotatingWords.length)
    }, 2500)
    return () => clearInterval(interval)
  }, [])

  return (
    <section className="relative min-h-screen flex items-center pt-16 overflow-hidden">
      {/* Background decoration */}
      <div className="absolute inset-0 -z-10">
        <div className="absolute top-0 right-0 w-[600px] h-[600px] bg-primary/5 rounded-full blur-3xl -translate-y-1/2 translate-x-1/3" />
        <div className="absolute bottom-0 left-0 w-[400px] h-[400px] bg-primary/5 rounded-full blur-3xl translate-y-1/2 -translate-x-1/3" />
      </div>

      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-16 md:py-24">
        <div className="grid lg:grid-cols-2 gap-12 lg:gap-16 items-center">
          {/* Left - Copy */}
          <div
            className={`transition-all duration-700 ${
              isVisible ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-8'
            }`}
          >
            {/* Badge */}
            <div className="inline-flex items-center gap-2 rounded-full bg-primary/10 px-4 py-1.5 mb-6">
              <span className="h-1.5 w-1.5 rounded-full bg-primary animate-pulse" />
              <span className="text-xs font-semibold text-primary tracking-wide uppercase">
                Built for Nigerian Schools
              </span>
            </div>

            {/* Headline — sells the outcome */}
            <h1 className="text-4xl sm:text-5xl lg:text-[3.5rem] font-extrabold leading-[1.1] tracking-tight text-foreground">
              Generate{' '}
              <span className="relative inline-block">
                <span
                  key={wordIndex}
                  className="text-primary animate-in fade-in slide-in-from-bottom-2 duration-500"
                >
                  {rotatingWords[wordIndex]}
                </span>
              </span>{' '}
              in Seconds, Not Hours
            </h1>

            <p className="mt-6 text-lg text-muted-foreground leading-relaxed max-w-xl">
              KlassRun saves your teachers 10–15 hours every week by
              auto-generating curriculum-aligned content — NERDC topics,
              WAEC/NECO standards, school-branded PDFs. All on autopilot.
            </p>

            {/* CTA Buttons */}
            <div className="mt-8 flex flex-col sm:flex-row gap-4">
              <a
                href="https://app.klassrun.com/signup"
                className="inline-flex items-center justify-center gap-2 rounded-lg bg-primary px-7 py-3.5 text-base font-semibold text-primary-foreground shadow-lg shadow-primary/25 hover:bg-primary/90 transition-all hover:shadow-xl hover:shadow-primary/30"
              >
                Start Free Trial
                <ArrowRight size={18} />
              </a>
              <a
                href="#how-it-works"
                className="inline-flex items-center justify-center gap-2 rounded-lg border border-border bg-white px-7 py-3.5 text-base font-semibold text-foreground hover:bg-secondary transition-colors"
              >
                See How It Works
              </a>
            </div>

            {/* Outcome metrics — not feature counts */}
            <div className="mt-10 grid grid-cols-3 gap-6 pt-8 border-t border-border">
              <div>
                <div className="flex items-center gap-2 text-primary">
                  <Clock size={18} />
                  <span className="text-2xl font-bold text-foreground">4x</span>
                </div>
                <p className="text-sm text-muted-foreground mt-1">
                  Faster lesson prep
                </p>
              </div>
              <div>
                <div className="flex items-center gap-2 text-primary">
                  <FileText size={18} />
                  <span className="text-2xl font-bold text-foreground">50%</span>
                </div>
                <p className="text-sm text-muted-foreground mt-1">
                  Less admin work
                </p>
              </div>
              <div>
                <div className="flex items-center gap-2 text-primary">
                  <GraduationCap size={18} />
                  <span className="text-2xl font-bold text-foreground">100%</span>
                </div>
                <p className="text-sm text-muted-foreground mt-1">
                  NERDC aligned
                </p>
              </div>
            </div>
          </div>

          {/* Right - Product Mockup */}
          <div
            className={`relative transition-all duration-700 delay-300 ${
              isVisible ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-8'
            }`}
          >
            <div className="relative rounded-2xl bg-foreground/[0.03] border border-border p-2 shadow-2xl shadow-primary/10">
              {/* Browser chrome */}
              <div className="flex items-center gap-2 px-4 py-3 border-b border-border">
                <div className="flex gap-1.5">
                  <div className="w-3 h-3 rounded-full bg-red-400" />
                  <div className="w-3 h-3 rounded-full bg-yellow-400" />
                  <div className="w-3 h-3 rounded-full bg-green-400" />
                </div>
                <div className="flex-1 mx-4">
                  <div className="bg-secondary rounded-md px-3 py-1.5 text-xs text-muted-foreground text-center">
                    app.klassrun.com
                  </div>
                </div>
              </div>

              {/* App mockup content */}
              <div className="p-6 space-y-4">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-xs text-muted-foreground">Welcome back,</p>
                    <p className="text-sm font-semibold text-foreground">Mrs. Adeyemi</p>
                  </div>
                  <div className="text-xs bg-primary/10 text-primary px-3 py-1 rounded-full font-medium">
                    2025/2026 · Term 2
                  </div>
                </div>

                <div className="grid grid-cols-2 gap-3">
                  <div className="rounded-xl bg-primary/10 border border-primary/20 p-4 cursor-pointer hover:bg-primary/15 transition-colors">
                    <FileText size={20} className="text-primary mb-2" />
                    <p className="text-sm font-semibold text-foreground">Generate Lesson Note</p>
                    <p className="text-xs text-muted-foreground mt-1">JSS 2 · Mathematics</p>
                  </div>
                  <div className="rounded-xl bg-secondary border border-border p-4 cursor-pointer hover:bg-secondary/80 transition-colors">
                    <GraduationCap size={20} className="text-foreground/60 mb-2" />
                    <p className="text-sm font-semibold text-foreground">Create Exam Paper</p>
                    <p className="text-xs text-muted-foreground mt-1">SS 1 · English Language</p>
                  </div>
                </div>

                <div className="space-y-2">
                  <p className="text-xs font-semibold text-muted-foreground uppercase tracking-wider">Recent</p>
                  {[
                    { subject: 'Basic Science', class: 'JSS 1', type: 'Lesson Note', time: '2 mins ago' },
                    { subject: 'Mathematics', class: 'SS 2', type: 'Exam Questions', time: '1 hour ago' },
                    { subject: 'Civic Education', class: 'JSS 3', type: 'Scheme of Work', time: '3 hours ago' },
                  ].map((item, i) => (
                    <div key={i} className="flex items-center justify-between rounded-lg bg-white border border-border px-4 py-3">
                      <div>
                        <p className="text-sm font-medium text-foreground">
                          {item.subject} <span className="text-muted-foreground">· {item.class}</span>
                        </p>
                        <p className="text-xs text-muted-foreground">{item.type}</p>
                      </div>
                      <span className="text-xs text-muted-foreground">{item.time}</span>
                    </div>
                  ))}
                </div>
              </div>
            </div>

            {/* Floating badge */}
            <div className="absolute -bottom-4 -left-4 bg-white rounded-xl border border-border shadow-lg px-4 py-3 flex items-center gap-3 animate-in fade-in slide-in-from-left-4 duration-1000 delay-700">
              <div className="h-10 w-10 rounded-full bg-primary/10 flex items-center justify-center">
                <Clock size={20} className="text-primary" />
              </div>
              <div>
                <p className="text-sm font-bold text-foreground">3 hours saved</p>
                <p className="text-xs text-muted-foreground">This afternoon</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  )
}
