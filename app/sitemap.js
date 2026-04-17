export const dynamic = 'force-static'

export default function sitemap() {
  return [
    {
      url: 'https://klassrun.com',
      lastModified: new Date(),
      changeFrequency: 'monthly',
      priority: 1,
    },
  ]
}
