'use client'

import { useEffect, useState } from 'react'
import Image from 'next/image'
import Link from 'next/link'
import { Menu, X } from 'lucide-react'
import { motion, AnimatePresence } from 'framer-motion'
import { ease } from '@/lib/motion'

const navLinks = [
  { label: 'About', href: '#about' },
  { label: 'Product', href: '#product' },
  { label: 'How It Works', href: '#how-it-works' },
  { label: 'Pricing', href: '#pricing' },
]

export default function Navbar() {
  const [mobileOpen, setMobileOpen] = useState(false)
  const [scrolled, setScrolled] = useState(false)

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 12)
    onScroll()
    window.addEventListener('scroll', onScroll, { passive: true })
    return () => window.removeEventListener('scroll', onScroll)
  }, [])

  // Lock body scroll when mobile menu is open
  useEffect(() => {
    document.body.style.overflow = mobileOpen ? 'hidden' : ''
    return () => { document.body.style.overflow = '' }
  }, [mobileOpen])

  return (
    <>
      {/* ── Floating glass navbar ──────────────────────────────── */}
      <motion.header
        initial={{ y: -24, opacity: 0 }}
        animate={{ y: 0, opacity: 1 }}
        transition={{ duration: 0.6, ease, delay: 0.1 }}
        className="fixed top-3 sm:top-4 left-0 right-0 z-50 flex justify-center px-3 sm:px-4 pointer-events-none"
      >
        <motion.nav
          animate={{
            scale: scrolled ? 0.98 : 1,
            y: scrolled ? 2 : 0,
          }}
          transition={{ duration: 0.4, ease }}
          className={`pointer-events-auto w-full max-w-[980px] rounded-2xl sm:rounded-full glass-pill border border-white/40 transition-shadow duration-500 ${
            scrolled ? 'shadow-float' : 'shadow-soft'
          }`}
          style={{ WebkitBackdropFilter: 'saturate(180%) blur(18px)' }}
        >
          <div className="flex h-14 sm:h-16 items-center justify-between pl-4 pr-3 sm:pl-6 sm:pr-3">
            {/* Logo */}
            <Link
              href="/"
              className="flex items-center gap-2 shrink-0"
              onClick={() => setMobileOpen(false)}
            >
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
            <div className="hidden md:flex items-center gap-7 lg:gap-8">
              {navLinks.map((link) => (
                <a
                  key={link.href}
                  href={link.href}
                  className="text-sm font-medium text-foreground/75 hover:text-primary transition-colors duration-300"
                >
                  {link.label}
                </a>
              ))}
            </div>

            {/* Desktop CTA */}
            <div className="hidden md:flex items-center gap-2">
              <a
                href="#contact"
                className="hidden lg:inline-flex items-center px-3 py-2 text-sm font-medium text-foreground/75 hover:text-primary transition-colors duration-300"
              >
                Contact
              </a>
              <a
                href="https://app.klassrun.com/signup"
                className="inline-flex items-center justify-center rounded-full bg-primary px-4 py-2 text-sm font-semibold text-primary-foreground shadow-soft hover:bg-klassrun-green-dark hover:-translate-y-0.5 transition-all duration-300 ease-out"
              >
                Get Started
              </a>
            </div>

            {/* Mobile menu button */}
            <button
              onClick={() => setMobileOpen(!mobileOpen)}
              className="md:hidden inline-flex items-center justify-center h-10 w-10 rounded-full text-foreground/80 hover:bg-foreground/5 active:bg-foreground/10 transition-colors duration-200"
              aria-label={mobileOpen ? 'Close menu' : 'Open menu'}
              aria-expanded={mobileOpen}
            >
              <AnimatePresence initial={false} mode="wait">
                {mobileOpen ? (
                  <motion.span
                    key="x"
                    initial={{ rotate: -90, opacity: 0 }}
                    animate={{ rotate: 0, opacity: 1 }}
                    exit={{ rotate: 90, opacity: 0 }}
                    transition={{ duration: 0.2, ease }}
                  >
                    <X size={20} />
                  </motion.span>
                ) : (
                  <motion.span
                    key="menu"
                    initial={{ rotate: 90, opacity: 0 }}
                    animate={{ rotate: 0, opacity: 1 }}
                    exit={{ rotate: -90, opacity: 0 }}
                    transition={{ duration: 0.2, ease }}
                  >
                    <Menu size={20} />
                  </motion.span>
                )}
              </AnimatePresence>
            </button>
          </div>
        </motion.nav>
      </motion.header>

      {/* ── Mobile drawer (separate from the pill) ─────────────── */}
      <AnimatePresence>
        {mobileOpen && (
          <>
            {/* Backdrop */}
            <motion.div
              key="backdrop"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              transition={{ duration: 0.25, ease }}
              onClick={() => setMobileOpen(false)}
              className="md:hidden fixed inset-0 z-40 bg-foreground/20 backdrop-blur-sm"
            />

            {/* Drawer card */}
            <motion.div
              key="drawer"
              initial={{ opacity: 0, y: -12, scale: 0.98 }}
              animate={{ opacity: 1, y: 0, scale: 1 }}
              exit={{ opacity: 0, y: -8, scale: 0.98 }}
              transition={{ duration: 0.3, ease }}
              className="md:hidden fixed top-[72px] left-3 right-3 z-50 rounded-2xl glass-strong border border-white/50 shadow-float overflow-hidden"
            >
              <div className="p-3">
                <nav className="flex flex-col">
                  {navLinks.map((link, i) => (
                    <motion.a
                      key={link.href}
                      href={link.href}
                      onClick={() => setMobileOpen(false)}
                      initial={{ opacity: 0, x: -8 }}
                      animate={{ opacity: 1, x: 0 }}
                      transition={{ delay: 0.05 + i * 0.04, duration: 0.3, ease }}
                      className="px-4 py-3.5 rounded-xl text-base font-medium text-foreground/80 hover:bg-primary/8 hover:text-primary active:bg-primary/12 transition-colors"
                    >
                      {link.label}
                    </motion.a>
                  ))}
                  <motion.a
                    href="#contact"
                    onClick={() => setMobileOpen(false)}
                    initial={{ opacity: 0, x: -8 }}
                    animate={{ opacity: 1, x: 0 }}
                    transition={{ delay: 0.05 + navLinks.length * 0.04, duration: 0.3, ease }}
                    className="px-4 py-3.5 rounded-xl text-base font-medium text-foreground/80 hover:bg-primary/8 hover:text-primary active:bg-primary/12 transition-colors"
                  >
                    Contact
                  </motion.a>
                </nav>

                <motion.div
                  initial={{ opacity: 0, y: 8 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ delay: 0.25, duration: 0.3, ease }}
                  className="pt-3 mt-2 border-t border-subtle"
                >
                  <a
                    href="https://app.klassrun.com/signup"
                    onClick={() => setMobileOpen(false)}
                    className="block w-full text-center rounded-xl bg-primary px-5 py-3.5 text-sm font-semibold text-primary-foreground shadow-[var(--shadow-glow)] active:translate-y-0.5 transition-transform"
                  >
                    Get Started
                  </a>
                </motion.div>
              </div>
            </motion.div>
          </>
        )}
      </AnimatePresence>
    </>
  )
}
