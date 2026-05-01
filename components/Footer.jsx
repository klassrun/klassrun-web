import Image from 'next/image'
import { Mail, MapPin } from 'lucide-react'

function InstagramIcon({ size = 14 }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <rect width="20" height="20" x="2" y="2" rx="5" ry="5" />
      <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z" />
      <line x1="17.5" x2="17.51" y1="6.5" y2="6.5" />
    </svg>
  )
}

function LinkedInIcon({ size = 14 }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z" />
      <rect width="4" height="12" x="2" y="9" />
      <circle cx="4" cy="4" r="2" />
    </svg>
  )
}

export default function Footer() {
  const EMAIL_ADDRESS = 'info@klassrun.com'

  return (
    <footer className="border-t border-subtle bg-foreground">
      <div className="mx-auto w-full max-w-6xl px-5 sm:px-6 lg:px-8 py-14 md:py-20">
        <div className="grid md:grid-cols-12 gap-10 md:gap-12">
          <div className="md:col-span-6">
            <Image
              src="/images/logo-nav.webp"
              alt="Klassrun"
              width={120}
              height={36}
              className="h-9 w-auto brightness-0 invert"
              unoptimized
            />
            <p className="mt-5 text-sm text-white/60 leading-relaxed max-w-sm">
              The AI-powered school operating system for Nigerian schools. Lesson notes,
              exam prep, schemes of work, and academic oversight — built for the
              Nigerian curriculum.
            </p>
            <p className="mt-5 text-xs text-white/40 tracking-wide">
              Klassrun Technologies Ltd · RC 9463863 · Lagos, Nigeria
            </p>

            <div className="mt-6 flex items-center gap-5">
              <a
                href="https://www.instagram.com/klassrun/"
                target="_blank"
                rel="noopener noreferrer"
                className="text-white/45 hover:text-primary transition-colors duration-300"
                aria-label="Instagram"
              >
                <InstagramIcon size={18} />
              </a>
              <a
                href="https://www.linkedin.com/in/klassrun-ng-33013b400/"
                target="_blank"
                rel="noopener noreferrer"
                className="text-white/45 hover:text-primary transition-colors duration-300"
                aria-label="LinkedIn"
              >
                <LinkedInIcon size={18} />
              </a>
            </div>
          </div>

          <div className="md:col-span-3">
            <h4 className="text-sm font-semibold text-white mb-5 tracking-tight">Product</h4>
            <ul className="space-y-3">
              {[
                { label: 'Lesson Notes', href: '#product' },
                { label: 'Exam Questions', href: '#product' },
                { label: 'Pricing', href: '#pricing' },
                { label: 'How It Works', href: '#how-it-works' },
              ].map((link) => (
                <li key={link.label}>
                  <a
                    href={link.href}
                    className="text-sm text-white/60 hover:text-primary transition-colors duration-300"
                  >
                    {link.label}
                  </a>
                </li>
              ))}
            </ul>
          </div>

          <div className="md:col-span-3">
            <h4 className="text-sm font-semibold text-white mb-5 tracking-tight">Contact</h4>
            <ul className="space-y-3">
              <li>
                <a
                  href={`mailto:${EMAIL_ADDRESS}`}
                  className="flex items-center gap-2 text-sm text-white/60 hover:text-primary transition-colors duration-300"
                >
                  <Mail size={14} />
                  {EMAIL_ADDRESS}
                </a>
              </li>
              <li>
                <span className="flex items-center gap-2 text-sm text-white/60">
                  <MapPin size={14} />
                  Lagos, Nigeria
                </span>
              </li>
            </ul>
          </div>
        </div>

        <div className="mt-12 sm:mt-14 pt-8 border-t border-white/10 flex flex-col sm:flex-row items-center justify-between gap-4">
          <p className="text-xs text-white/40 text-center sm:text-left">
            © {new Date().getFullYear()} Klassrun Technologies Ltd. All rights reserved.
          </p>
          <div className="flex gap-6">
            <a href="#" className="text-xs text-white/40 hover:text-white/70 transition-colors duration-300">
              Privacy Policy
            </a>
            <a href="#" className="text-xs text-white/40 hover:text-white/70 transition-colors duration-300">
              Terms of Service
            </a>
          </div>
        </div>
      </div>
    </footer>
  )
}
