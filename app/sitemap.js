export const dynamic = 'force-static'
export default function sitemap() {
  const baseUrl = 'https://klassrun.com'

  // Static pages — add more as you build them
  const staticPages = [
    {
      url: baseUrl,
      lastModified: new Date(),
      changeFrequency: 'monthly',
      priority: 1.0,
    },
    // When you build these pages, uncomment and add them:
    // {
    //   url: `${baseUrl}/products/klassrun`,
    //   lastModified: new Date(),
    //   changeFrequency: 'monthly',
    //   priority: 0.9,
    // },
    // {
    //   url: `${baseUrl}/about`,
    //   lastModified: new Date(),
    //   changeFrequency: 'yearly',
    //   priority: 0.7,
    // },
    // {
    //   url: `${baseUrl}/contact`,
    //   lastModified: new Date(),
    //   changeFrequency: 'yearly',
    //   priority: 0.6,
    // },
  ]

  return staticPages
}
