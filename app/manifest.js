export const dynamic = 'force-static'

export default function manifest() {
  return {
    name: 'Klassrun Technologies Ltd',
    short_name: 'Klassrun',
    description:
      'AI-powered EdTech software solutions for Nigerian schools — lesson notes, exam questions, and school management.',
    start_url: '/',
    display: 'standalone',
    background_color: '#ffffff',
    theme_color: '#3DB54A',
    orientation: 'portrait',
    scope: '/',
    lang: 'en',
    icons: [
      {
        src: '/icon-192x192.png',
        sizes: '192x192',
        type: 'image/png',
        purpose: 'any maskable',
      },
      {
        src: '/icon-512x512.png',
        sizes: '512x512',
        type: 'image/png',
        purpose: 'any',
      },
    ],
    categories: ['education', 'productivity', 'business'],
  }
}
