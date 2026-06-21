import Image from 'next/image'
import { Section, SectionHeader } from './ui/Section'

export default function Comparison() {
  return (
    <Section id="compare" surface="mint">
      <SectionHeader title="How we compare" subtitle="Klassrun vs a chatbot vs a stack of paper" />

      <div className="mx-auto max-w-5xl">
        <Image
          src="/images/comparison-v1.webp"
          alt="How Klassrun compares to generic AI chatbots (like ChatGPT) and a manual paper process. Klassrun writes lesson notes, schemes and exam questions as drafts the teacher reviews; ties them to NERDC topics per class and term; keeps a school-owned question bank reusable for years; computes and prints Nigerian report cards with totals, grades and positions; brings attendance, behaviour, promotions and fees together in one system; and runs one school account with owner, teacher and bursar roles. Generic AI chatbots only help write the drafts; the manual paper process does none of these."
          width={1455}
          height={1081}
          className="w-full h-auto rounded-xl shadow-card"
          unoptimized
        />
      </div>
    </Section>
  )
}
