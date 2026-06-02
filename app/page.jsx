import Navbar from '@/components/Navbar'
import Hero from '@/components/Hero'
import CredStrip from '@/components/CredStrip'
import About from '@/components/About'
import Product from '@/components/Product'
import HowItWorks from '@/components/HowItWorks'
import Comparison from '@/components/Comparison'
import Pricing from '@/components/Pricing'
import FAQ from '@/components/FAQ'
import CTA from '@/components/CTA'
import Footer from '@/components/Footer'

export default function Home() {
  return (
    <main className="relative overflow-x-hidden">
      <Navbar />
      <Hero />
      <CredStrip />
      <About />
      <Product />
      <HowItWorks />
      <Comparison />
      <Pricing />
      <FAQ />
      <CTA />
      <Footer />
    </main>
  )
}
