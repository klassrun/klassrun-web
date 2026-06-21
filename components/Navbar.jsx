'use client'

import { useEffect, useState } from 'react'
import Image from 'next/image'
import Link from 'next/link'
import { Menu, X } from 'lucide-react'

const navLinks = [
  { label: 'Features', href: '#features' },
  { label: 'Pricing', href: '#pricing' },
  { label: 'FAQ', href: '#faq' },
]

export default function Navbar() {
  const [mobileOpen, setMobileOpen] = useState(false)
  const [scrolled, setScrolled] = useState(false)

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 8)
    onScroll()
    window.addEventListener('scroll', onScroll, { passive: true })
    return () => window.removeEventListener('scroll', onScroll)
  }, [])

  useEffect(() => {
    document.body.style.overflow = mobileOpen ? 'hidden' : ''
    return () => { document.body.style.overflow = '' }
  }, [mobileOpen])

  return (
    <header
      className={`fixed top-0 left-0 right-0 z-50 bg-white border-b border-subtle transition-shadow duration-300 ${
        scrolled ? 'shadow-soft' : ''
      }`}
    >
      <nav className="mx-auto w-full max-w-6xl px-5 sm:px-6 lg:px-8">
        <div className="flex h-16 items-center justify-between gap-3">
          {/* Logo */}
          <Link href="/" className="flex items-center shrink-0" onClick={() => setMobileOpen(false)}>
            <Image
              src="/images/logo-nav.webp"
              alt="Klassrun"
              width={100}
              height={34}
              className="h-7 sm:h-8 w-auto object-contain"
              priority
              unoptimized
            />
          </Link>

          {/* Desktop links */}
          <div className="hidden md:flex items-center gap-8">
            {navLinks.map((link) => (
              <a
                key={link.href}
                href={link.href}
                className="text-sm font-semibold text-foreground/70 hover:text-primary transition-colors duration-300"
              >
                {link.label}
              </a>
            ))}
          </div>

          {/* Right side - Get Started stays visible on every screen size */}
          <div className="flex items-center gap-2 sm:gap-3">
            <a
              href="https://app.klassrun.com"
              className="hidden md:inline-flex items-center text-sm font-semibold text-foreground/70 hover:text-primary transition-colors duration-300 px-2 py-2"
            >
              Login
            </a>
            <a
              href="https://app.klassrun.com/signup"
              className="inline-flex items-center justify-center rounded-full bg-primary px-4 sm:px-5 py-2 text-sm font-bold text-primary-foreground hover:bg-klassrun-green-dark transition-colors duration-300"
            >
              Get Started
            </a>
            <button
              onClick={() => setMobileOpen(!mobileOpen)}
              className="md:hidden inline-flex items-center justify-center h-10 w-10 rounded-full text-foreground/80 hover:bg-foreground/5 active:bg-foreground/10 transition-colors duration-200"
              aria-label={mobileOpen ? 'Close menu' : 'Open menu'}
              aria-expanded={mobileOpen}
            >
              {mobileOpen ? <X size={20} /> : <Menu size={20} />}
            </button>
          </div>
        </div>
      </nav>

      {/* Mobile menu */}
      {mobileOpen && (
        <div className="md:hidden border-t border-subtle bg-white">
          <nav className="mx-auto w-full max-w-6xl px-5 py-3 flex flex-col">
            {navLinks.map((link) => (
              <a
                key={link.href}
                href={link.href}
                onClick={() => setMobileOpen(false)}
                className="px-2 py-3.5 text-base font-semibold text-foreground/80 hover:text-primary transition-colors border-b border-subtle last:border-0"
              >
                {link.label}
              </a>
            ))}
            <a
              href="https://app.klassrun.com"
              onClick={() => setMobileOpen(false)}
              className="px-2 py-3.5 text-base font-semibold text-foreground/80 hover:text-primary transition-colors"
            >
              Login
            </a>
          </nav>
        </div>
      )}
    </header>
  )
}
