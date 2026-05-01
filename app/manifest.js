export const dynamic = 'force-static'

export default function manifest() {
  return {
    name: 'Klassrun Technologies Ltd',
    short_name: 'Klassrun',
    description:
      'The AI-powered school operating system for Nigerian schools. Lesson notes, exam prep, schemes of work, results, and parent portal — built for the Nigerian curriculum.',
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
