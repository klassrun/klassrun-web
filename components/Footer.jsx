import Image from 'next/image'
import { Mail, Phone, MapPin } from 'lucide-react'

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
              Klassrun Technologies Ltd is a CAC-registered EdTech company
              building AI-powered software for Nigerian schools. Lesson notes,
              exam questions, and school management — all curriculum-aligned.
            </p>
            <p className="mt-4 text-xs text-white/40">RC 9463863 · Lagos, Nigeria</p>
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
              {/* <li>
                <a
                  href="tel:+2348000000000"
                  className="flex items-center gap-2 text-sm text-white/60 hover:text-primary transition-colors"
                >
                  <Phone size={14} />
                  +234 800 000 0000
                </a> 
              </li> */}
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