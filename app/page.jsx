import Navbar from '@/components/Navbar'
import Hero from '@/components/Hero'
import FeatureTabs from '@/components/FeatureTabs'
import Personas from '@/components/Personas'
import WhyKlassrun from '@/components/WhyKlassrun'
import Comparison from '@/components/Comparison'
import Pricing from '@/components/Pricing'
import Testimonials from '@/components/Testimonials'
import FAQ from '@/components/FAQ'
import Footer from '@/components/Footer'

export default function Home() {
  return (
    <main className="relative overflow-x-hidden">
      <Navbar />
      <Hero />
      <FeatureTabs />
      <Personas />
      <WhyKlassrun />
      <Comparison />
      <Pricing />
      <Testimonials />
      <FAQ />
      <Footer />
    </main>
  )
}
