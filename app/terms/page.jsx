// DRAFT — written from how Klassrun actually works today. Have a lawyer
// review before relying on it.
import Image from 'next/image'
import Link from 'next/link'

export const metadata = {
  title: 'Terms of Service',
  description: 'The terms that govern use of Klassrun by schools and their staff.',
}

const H2 = ({ children }) => (
  <h2 className="mt-10 mb-3 text-xl font-bold text-foreground">{children}</h2>
)
const P = ({ children }) => (
  <p className="mb-4 text-sm leading-relaxed text-muted-foreground">{children}</p>
)

export default function TermsPage() {
  return (
    <main className="bg-white min-h-screen">
      <div className="border-b border-subtle">
        <div className="mx-auto w-full max-w-3xl px-5 h-16 flex items-center justify-between">
          <Link href="/">
            <Image src="/images/logo-nav.webp" alt="Klassrun" width={100} height={34} className="h-7 w-auto" unoptimized />
          </Link>
          <Link href="/" className="text-sm font-bold text-primary hover:underline underline-offset-4">
            Back to klassrun.com
          </Link>
        </div>
      </div>

      <article className="mx-auto w-full max-w-3xl px-5 py-12 md:py-16">
        <h1 className="text-3xl font-extrabold text-foreground">Terms of Service</h1>
        <p className="mt-2 text-xs text-muted-foreground">Last updated: June 2026</p>

        <H2>1. Agreement</H2>
        <P>
          These terms are an agreement between Klassrun Technologies Ltd (RC 9463863, Lagos,
          Nigeria) and the school that creates a Klassrun account. By creating an account or using
          Klassrun, the school accepts these terms.
        </P>

        <H2>2. The service</H2>
        <P>
          Klassrun is school management software. It generates lesson notes, schemes of work and
          exam questions, and manages results, report cards, attendance, behaviour, promotions and
          fee records. Some features are marked “coming soon” and become available as they are
          released.
        </P>

        <H2>3. Accounts and roles</H2>
        <P>
          The school’s owner or admin creates the account and invites staff. Each person is
          responsible for keeping their login details private. The school is responsible for the
          actions taken under its accounts and for removing access when staff leave.
        </P>

        <H2>4. The school’s responsibilities</H2>
        <P>
          The school confirms it has the authority to enter the information it adds to Klassrun,
          including students’ records. Generated lesson notes, schemes and exam questions are
          drafts: a qualified teacher must review and approve them before they are used in a
          classroom or an examination. The school remains responsible for the accuracy of its
          records, results and report cards.
        </P>

        <H2>5. Acceptable use</H2>
        <P>
          Klassrun is for legitimate school work. Accounts may not be used to break the law, to
          attempt to access another school’s information, or to interfere with the service. We may
          suspend accounts that do.
        </P>

        <H2>6. Fees and billing</H2>
        <P>
          Plans are billed per term. Current amounts are communicated before any charge — there are
          no hidden fees. New accounts start with a 14-day free trial with no card required. If a
          school does not continue after the trial or a paid term, access is paused but records are
          not immediately deleted.
        </P>

        <H2>7. Ownership</H2>
        <P>
          The school owns its records and the content created in its account, including generated
          lesson notes and exam questions, for its own use. Klassrun Technologies Ltd owns the
          platform, its software and its design.
        </P>

        <H2>8. Availability and changes</H2>
        <P>
          We work to keep Klassrun available and reliable, but no online service can promise
          uninterrupted access. We may improve or change features over time; if a change materially
          reduces what a paid plan includes, schools will be informed in advance.
        </P>

        <H2>9. Liability</H2>
        <P>
          To the extent permitted by Nigerian law, Klassrun Technologies Ltd is not liable for
          indirect losses, and its total liability in connection with the service is limited to the
          amount the school paid for the service in the term in which the issue arose.
        </P>

        <H2>10. Ending the agreement</H2>
        <P>
          A school may stop using Klassrun and request deletion of its account at any time by
          emailing{' '}
          <a href="mailto:info@klassrun.com" className="text-primary font-semibold hover:underline">
            info@klassrun.com
          </a>
          . We may end the agreement for serious or repeated breach of these terms.
        </P>

        <H2>11. Governing law</H2>
        <P>These terms are governed by the laws of the Federal Republic of Nigeria.</P>

        <H2>12. Contact</H2>
        <P>
          Questions about these terms: email{' '}
          <a href="mailto:info@klassrun.com" className="text-primary font-semibold hover:underline">
            info@klassrun.com
          </a>
          .
        </P>
      </article>
    </main>
  )
}
