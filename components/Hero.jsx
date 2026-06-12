import { Check, Clock, FileText, ClipboardCheck, ArrowRight } from 'lucide-react'

const bullets = [
  { verb: 'Generate', rest: ' lesson notes and schemes of work with AI, aligned to the NERDC curriculum' },
  { verb: 'Set', rest: ' WAEC-style exam questions from a question bank your school owns' },
  { verb: 'Compute', rest: ' results and print proper Nigerian report cards' },
  { verb: 'Track', rest: ' attendance, behaviour and promotions in one place' },
  { verb: 'Mark', rest: ' fees paid or unpaid — your bursar sees everything at a glance' },
]

export default function Hero() {
  return (
    <section className="relative pt-28 sm:pt-32 pb-12 md:pb-20 overflow-hidden bg-white">
      <div className="mx-auto w-full max-w-6xl px-5 sm:px-6 lg:px-8">
        <div className="grid lg:grid-cols-12 gap-12 lg:gap-14 items-center">
          {/* Left — copy */}
          <div className="lg:col-span-7">
            <h1 className="text-[2.25rem] sm:text-5xl lg:text-[3.5rem] font-extrabold leading-[1.06] text-foreground">
              Run your whole school{' '}
              <span className="text-primary">from one place</span>
            </h1>

            <ul className="mt-7 sm:mt-9 space-y-3.5">
              {bullets.map((b) => (
                <li key={b.verb} className="flex items-start gap-3">
                  <span className="mt-0.5 flex-shrink-0 h-5 w-5 rounded-full bg-primary/12 flex items-center justify-center">
                    <Check size={12} className="text-primary" strokeWidth={3.5} />
                  </span>
                  <span className="text-[15px] sm:text-base text-foreground/85 leading-snug">
                    <strong className="font-bold text-foreground">{b.verb}</strong>
                    {b.rest}
                  </span>
                </li>
              ))}
            </ul>

            <div className="mt-9 flex flex-col sm:flex-row gap-3">
              <a
                href="https://app.klassrun.com/signup"
                className="group inline-flex items-center justify-center gap-2 rounded-full bg-primary px-7 py-3.5 text-sm font-bold text-primary-foreground hover:bg-klassrun-green-dark transition-colors duration-300"
              >
                Start Free Trial
                <ArrowRight size={16} className="transition-transform duration-300 group-hover:translate-x-0.5" />
              </a>
              <a
                href="mailto:info@klassrun.com"
                className="inline-flex items-center justify-center gap-2 rounded-full border border-soft bg-white px-7 py-3.5 text-sm font-bold text-foreground hover:bg-secondary transition-colors duration-300"
              >
                Talk to us
              </a>
            </div>

            <p className="mt-5 text-xs text-muted-foreground">
              14-day free trial · No card required
            </p>
          </div>

          {/* Right — static product mockup (illustration, no live data) */}
          <div className="lg:col-span-5 relative">
            <div className="rounded-2xl border border-soft bg-white shadow-lift overflow-hidden">
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
                    <p className="text-sm font-bold text-foreground">Mrs. Adeyemi</p>
                  </div>
                  <div className="text-[11px] bg-primary/10 text-primary px-3 py-1 rounded-full font-semibold">
                    2025/2026 · Term 2
                  </div>
                </div>

                <div className="grid grid-cols-2 gap-3">
                  <div className="rounded-xl bg-primary/10 ring-1 ring-primary/15 p-4">
                    <FileText size={18} className="text-primary mb-2" />
                    <p className="text-sm font-bold text-foreground">Generate Lesson Note</p>
                    <p className="text-[11px] text-muted-foreground mt-1">JSS 2 · Mathematics</p>
                  </div>
                  <div className="rounded-xl bg-secondary border border-subtle p-4">
                    <ClipboardCheck size={18} className="text-foreground/60 mb-2" />
                    <p className="text-sm font-bold text-foreground">Set Exam Questions</p>
                    <p className="text-[11px] text-muted-foreground mt-1">SS 1 · English Language</p>
                  </div>
                </div>

                <div className="space-y-2">
                  <p className="text-[10px] font-bold text-muted-foreground uppercase tracking-[0.14em]">
                    Recent
                  </p>
                  {[
                    { subject: 'Basic Science', cls: 'JSS 1', type: 'Lesson Note', time: '2 mins ago' },
                    { subject: 'Mathematics', cls: 'SS 2', type: 'Exam Questions', time: '1 hour ago' },
                    { subject: 'Civic Education', cls: 'JSS 3', type: 'Scheme of Work', time: '3 hours ago' },
                  ].map((item) => (
                    <div
                      key={item.subject}
                      className="flex items-center justify-between rounded-lg bg-white border border-subtle px-4 py-3"
                    >
                      <div>
                        <p className="text-sm font-semibold text-foreground">
                          {item.subject}{' '}
                          <span className="text-muted-foreground font-normal">· {item.cls}</span>
                        </p>
                        <p className="text-[11px] text-muted-foreground">{item.type}</p>
                      </div>
                      <span className="text-[11px] text-muted-foreground">{item.time}</span>
                    </div>
                  ))}
                </div>
              </div>
            </div>

            <div className="absolute -bottom-4 -left-2 sm:-bottom-5 sm:-left-5 bg-white rounded-xl border border-soft shadow-lift px-3.5 py-2.5 sm:px-4 sm:py-3 flex items-center gap-3">
              <div className="h-9 w-9 sm:h-10 sm:w-10 rounded-full bg-primary/10 flex items-center justify-center">
                <Clock size={17} className="text-primary" />
              </div>
              <div>
                <p className="text-sm font-bold text-foreground">3 hours saved</p>
                <p className="text-[11px] text-muted-foreground">This afternoon</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  )
}
