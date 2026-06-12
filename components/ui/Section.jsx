// Layout primitives — motion-free. Surfaces map to the Afrilearn-style
// alternating backgrounds: white → mint → navy → white.
export function Section({ id, children, className = '', surface = 'base', bleed = false }) {
  const surfaceCls = {
    base: '',
    white: 'bg-white',
    muted: 'bg-secondary/30',
    mint: 'bg-klassrun-mint',
    navy: 'bg-klassrun-navy',
  }[surface] ?? ''

  return (
    <section id={id} className={`relative py-16 md:py-24 ${surfaceCls} ${className}`}>
      <div className={bleed ? '' : 'mx-auto w-full max-w-6xl px-5 sm:px-6 lg:px-8'}>
        {children}
      </div>
    </section>
  )
}

export function SectionHeader({ title, subtitle, dark = false, className = '' }) {
  return (
    <div className={`max-w-2xl mx-auto text-center mb-10 md:mb-14 ${className}`}>
      <h2
        className={`text-[1.75rem] sm:text-4xl md:text-[2.5rem] font-bold leading-[1.12] ${
          dark ? 'text-white' : 'text-foreground'
        }`}
      >
        {title}
      </h2>
      {subtitle && (
        <p
          className={`mt-4 text-base sm:text-lg leading-relaxed ${
            dark ? 'text-white/70' : 'text-muted-foreground'
          }`}
        >
          {subtitle}
        </p>
      )}
    </div>
  )
}
