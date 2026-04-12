import Navbar from '@/components/Navbar'
import Hero from '@/components/Hero'
import CredStrip from '@/components/CredStrip'
import About from '@/components/About'
import Product from '@/components/Product'
import HowItWorks from '@/components/HowItWorks'
import Pricing from '@/components/Pricing'
import CTA from '@/components/CTA'
import Footer from '@/components/Footer'

export default function Home() {
  return (
    <>
      <Navbar />
      <Hero />
      <CredStrip />
      <About />
      <Product />
      <HowItWorks />
      <Pricing />
      <CTA />
      <Footer />
    </>
  )
}
