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
    <footer className="border-t border-border bg-foreground">
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-12 md:py-16">
        <div className="grid md:grid-cols-4 gap-10">
          {/* Brand */}
          <div className="md:col-span-2">
            <Image
              src="/images/logo-nav.webp"
              alt="Klassrun"
              width={120}
              height={36}
              className="h-10 w-auto brightness-0 invert"
              unoptimized
            />
            <p className="mt-4 text-sm text-white/60 leading-relaxed max-w-sm">
              AI-powered lesson notes, exam questions, and school management —
              built exclusively for Nigerian schools. Save your teachers 10+
              hours every week.
            </p>
            <p className="mt-4 text-xs text-white/40">
              Klassrun Technologies Ltd · RC 9463863 · Lagos, Nigeria
            </p>

            {/* Social links */}
            <div className="mt-5 flex items-center gap-4">
              <a
                href="https://www.instagram.com/klassrun/"
                target="_blank"
                rel="noopener noreferrer"
                className="text-white/40 hover:text-primary transition-colors"
                aria-label="Instagram"
              >
                <InstagramIcon size={18} />
              </a>
              <a
                href="https://www.linkedin.com/in/klassrun-ng-33013b400/"
                target="_blank"
                rel="noopener noreferrer"
                className="text-white/40 hover:text-primary transition-colors"
                aria-label="LinkedIn"
              >
                <LinkedInIcon size={18} />
              </a>
            </div>
          </div>

          {/* Product */}
          <div>
            <h4 className="text-sm font-semibold text-white mb-4">Product</h4>
            <ul className="space-y-2.5">
              {[
                { label: 'Lesson Notes', href: '#product' },
                { label: 'Exam Questions', href: '#product' },
                { label: 'Pricing', href: '#pricing' },
                { label: 'How It Works', href: '#how-it-works' },
              ].map((link) => (
                <li key={link.label}>
                  <a
                    href={link.href}
                    className="text-sm text-white/60 hover:text-primary transition-colors"
                  >
                    {link.label}
                  </a>
                </li>
              ))}
            </ul>
          </div>

          {/* Contact */}
          <div>
            <h4 className="text-sm font-semibold text-white mb-4">Contact</h4>
            <ul className="space-y-3">
              <li>
                <a
                  href={`mailto:${EMAIL_ADDRESS}`}
                  className="flex items-center gap-2 text-sm text-white/60 hover:text-primary transition-colors"
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

        {/* Bottom bar */}
        <div className="mt-12 pt-8 border-t border-white/10 flex flex-col sm:flex-row items-center justify-between gap-4">
          <p className="text-xs text-white/40">
            © {new Date().getFullYear()} Klassrun Technologies Ltd. All rights
            reserved.
          </p>
          <div className="flex gap-6">
            <a
              href="#"
              className="text-xs text-white/40 hover:text-white/60 transition-colors"
            >
              Privacy Policy
            </a>
            <a
              href="#"
              className="text-xs text-white/40 hover:text-white/60 transition-colors"
            >
              Terms of Service
            </a>
          </div>
        </div>
      </div>
    </footer>
  )
}
