import Image from 'next/image'
import Link from 'next/link'
import { Mail, MapPin } from 'lucide-react'

function InstagramIcon({ size = 16 }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <rect width="20" height="20" x="2" y="2" rx="5" ry="5" />
      <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z" />
      <line x1="17.5" x2="17.51" y1="6.5" y2="6.5" />
    </svg>
  )
}

function LinkedInIcon({ size = 16 }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z" />
      <rect width="4" height="12" x="2" y="9" />
      <circle cx="4" cy="4" r="2" />
    </svg>
  )
}

function TikTokIcon({ size = 16 }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor">
      <path d="M19.59 6.69a4.83 4.83 0 0 1-3.77-4.25V2h-3.45v13.67a2.89 2.89 0 0 1-5.2 1.74 2.89 2.89 0 0 1 2.31-4.64c.3 0 .58.05.85.13V9.4a6.33 6.33 0 0 0-.85-.06 6.34 6.34 0 1 0 6.34 6.34V8.74a8.16 8.16 0 0 0 4.77 1.52v-3.45a4.85 4.85 0 0 1-1-.12z" />
    </svg>
  )
}

const columns = [
  {
    title: 'Product',
    links: [
      { label: 'Features', href: '#features' },
      { label: 'Pricing', href: '#pricing' },
      { label: 'FAQ', href: '#faq' },
    ],
  },
  {
    title: 'Company',
    links: [
      { label: 'Contact us', href: 'mailto:info@klassrun.com' },
      { label: 'Sign in', href: 'https://app.klassrun.com' },
      { label: 'Get started', href: 'https://app.klassrun.com/signup' },
    ],
  },
  {
    title: 'Legal',
    links: [
      { label: 'Privacy Policy', href: '/privacy', internal: true },
      { label: 'Terms of Service', href: '/terms', internal: true },
    ],
  },
]

export default function Footer() {
  const year = new Date().getFullYear()

  return (
    <footer className="bg-secondary/30 border-t border-subtle">
      <div className="mx-auto w-full max-w-6xl px-5 sm:px-6 lg:px-8 pt-14 pb-8 md:pt-16">
        {/* Centered logo + tagline */}
        <div className="text-center">
          <Image
            src="/images/logo.webp"
            alt="Klassrun"
            width={120}
            height={90}
            className="mx-auto h-14 w-auto"
            unoptimized
          />
          <p className="mt-2 text-xs text-muted-foreground">Built for Nigerian schools</p>
        </div>

        {/* Link columns + contact */}
        <div className="mt-12 grid grid-cols-2 md:grid-cols-12 gap-x-6 gap-y-10">
          {columns.map((col) => (
            <div key={col.title} className="md:col-span-2">
              <h4 className="text-sm font-bold text-foreground mb-4">{col.title}</h4>
              <ul className="space-y-3">
                {col.links.map((link) => (
                  <li key={link.label}>
                    {link.internal ? (
                      <Link
                        href={link.href}
                        className="text-sm text-muted-foreground hover:text-primary transition-colors duration-300"
                      >
                        {link.label}
                      </Link>
                    ) : (
                      <a
                        href={link.href}
                        className="text-sm text-muted-foreground hover:text-primary transition-colors duration-300"
                      >
                        {link.label}
                      </a>
                    )}
                  </li>
                ))}
              </ul>
            </div>
          ))}

          <div className="col-span-2 md:col-span-6 md:text-right">
            <div className="flex md:justify-end items-center gap-5 mb-5">
              <a
                href="https://www.instagram.com/klassrun/"
                target="_blank"
                rel="noopener noreferrer"
                aria-label="Instagram"
                className="text-foreground/40 hover:text-primary transition-colors duration-300"
              >
                <InstagramIcon size={18} />
              </a>
              <a
                href="https://www.linkedin.com/in/klassrun-ng-33013b400/"
                target="_blank"
                rel="noopener noreferrer"
                aria-label="LinkedIn"
                className="text-foreground/40 hover:text-primary transition-colors duration-300"
              >
                <LinkedInIcon size={18} />
              </a>
              <a
                href="https://www.tiktok.com/@afeez_can_code"
                target="_blank"
                rel="noopener noreferrer"
                aria-label="TikTok"
                className="text-foreground/40 hover:text-primary transition-colors duration-300"
              >
                <TikTokIcon size={18} />
              </a>
            </div>
            <p className="flex md:justify-end items-center gap-2 text-sm text-muted-foreground">
              <MapPin size={14} /> Lagos, Nigeria
            </p>
            <a
              href="mailto:info@klassrun.com"
              className="mt-2 flex md:justify-end items-center gap-2 text-sm text-muted-foreground hover:text-primary transition-colors duration-300"
            >
              <Mail size={14} /> info@klassrun.com
            </a>
            <p className="mt-2 text-xs text-muted-foreground/70">
              Klassrun Technologies Ltd · RC 9463863
            </p>
          </div>
        </div>

        {/* Copyright pill */}
        <div className="mt-12 flex justify-center">
          <div className="rounded-full bg-white shadow-soft px-6 py-3 flex flex-wrap items-center justify-center gap-x-6 gap-y-1 text-xs text-muted-foreground">
            <span>© {year} Klassrun Technologies Ltd. All rights reserved</span>
            <Link href="/privacy" className="hover:text-primary transition-colors duration-300">
              Privacy policy
            </Link>
            <Link href="/terms" className="hover:text-primary transition-colors duration-300">
              Terms of service
            </Link>
          </div>
        </div>
      </div>
    </footer>
  )
}
