export default function robots() {
  return {
    rules: [
      {
        userAgent: '*',
        allow: '/',
        // disallow any private routes when you build them e.g:
        // disallow: ['/dashboard/', '/admin/'],
      },
    ],
    sitemap: 'https://klassrun.com/sitemap.xml',
  }
}
