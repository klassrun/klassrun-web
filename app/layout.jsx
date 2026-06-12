import './globals.css'
import ServiceWorkerRegister from '@/components/ServiceWorkerRegister'
import LoadingSplash from '@/components/LoadingSplash'

const BASE_URL = 'https://klassrun.com'

// ── VIEWPORT (separated from metadata — required in Next.js 14+) ──
export const viewport = {
  width: 'device-width',
  initialScale: 1,
  maximumScale: 5,
  themeColor: '#3DB54A',
  colorScheme: 'light',
}

export const metadata = {
  title: {
    default: 'Klassrun — School Management Software for Nigerian Schools',
    template: '%s | Klassrun Technologies',
  },
  description:
    'Run your school from one place. Lesson notes, schemes of work, WAEC-style exam questions, results, report cards, attendance and fees — with AI lesson note and exam question generation. Built for Nigerian schools.',
  keywords: [
    'EdTech Nigeria',
    'lesson note generator Nigeria',
    'WAEC exam questions AI',
    'NECO exam questions',
    'school management software Nigeria',
    'AI for Nigerian schools',
    'KlassRun',
    'Klassrun Technologies',
    'Nigerian curriculum AI',
    'NERDC curriculum',
  ],
  authors: [{ name: 'Klassrun Technologies Ltd' }],
  creator: 'Klassrun Technologies Ltd',
  publisher: 'Klassrun Technologies Ltd',

  openGraph: {
    type: 'website',
    locale: 'en_NG',
    url: BASE_URL,
    siteName: 'Klassrun Technologies Ltd',
    title: 'Klassrun — School Management Software for Nigerian Schools',
    description:
      'Run your school from one place. Lesson notes, schemes of work, WAEC-style exam questions, results, report cards, attendance and fees. Built for Nigerian schools.',
    images: [
      {
        url: `${BASE_URL}/images/og-image.webp`,
        width: 1200,
        height: 630,
        alt: 'Klassrun Technologies Ltd',
        type: 'image/webp',
      },
    ],
  },

  twitter: {
    card: 'summary_large_image',
    title: 'Klassrun Technologies Ltd',
    description: 'School management software built for Nigerian schools.',
    images: [`${BASE_URL}/images/og-image.webp`],
  },

  icons: {
    icon: [
      { url: '/favicon-16x16.png', sizes: '16x16', type: 'image/png' },
      { url: '/favicon-32x32.png', sizes: '32x32', type: 'image/png' },
    ],
    apple: [
      { url: '/apple-touch-icon.png', sizes: '180x180', type: 'image/png' },
    ],
    other: [
      { rel: 'mask-icon', url: '/favicon-32x32.png', color: '#3DB54A' },
    ],
  },

  alternates: {
    canonical: BASE_URL,
  },

  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      'max-video-preview': -1,
      'max-image-preview': 'large',
      'max-snippet': -1,
    },
  },
}

const jsonLd = {
  '@context': 'https://schema.org',
  '@type': 'Organization',
  name: 'Klassrun Technologies Ltd',
  url: 'https://klassrun.com',
  logo: 'https://klassrun.com/images/logo.webp',
  description:
    'School management software for Nigerian schools — lesson notes, schemes of work, WAEC-style exam questions, results, report cards, attendance and fees in one place.',
  foundingLocation: {
    '@type': 'Place',
    name: 'Nigeria',
  },
  sameAs: [],
  contactPoint: {
    '@type': 'ContactPoint',
    contactType: 'customer support',
    email: 'info@klassrun.com',
    availableLanguage: 'English',
  },
}

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <head>
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
        />
      </head>
      <body>
        <LoadingSplash />
        <ServiceWorkerRegister />
        {children}
      </body>
    </html>
  )
}
