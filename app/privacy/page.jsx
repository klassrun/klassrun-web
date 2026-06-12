// DRAFT — written from how Klassrun actually works today. Have a lawyer
// review before relying on it, especially around students' records (NDPA).
import Image from 'next/image'
import Link from 'next/link'

export const metadata = {
  title: 'Privacy Policy',
  description: 'How Klassrun collects, uses and protects information for schools, staff and students.',
}

const H2 = ({ children }) => (
  <h2 className="mt-10 mb-3 text-xl font-bold text-foreground">{children}</h2>
)
const P = ({ children }) => (
  <p className="mb-4 text-sm leading-relaxed text-muted-foreground">{children}</p>
)
const LI = ({ children }) => (
  <li className="mb-2 text-sm leading-relaxed text-muted-foreground">{children}</li>
)

export default function PrivacyPage() {
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
        <h1 className="text-3xl font-extrabold text-foreground">Privacy Policy</h1>
        <p className="mt-2 text-xs text-muted-foreground">Last updated: June 2026</p>

        <H2>Who we are</H2>
        <P>
          Klassrun is operated by Klassrun Technologies Ltd (RC 9463863), Lagos, Nigeria. We build
          school management software for Nigerian schools. This policy covers our website
          (klassrun.com) and the Klassrun application (app.klassrun.com).
        </P>

        <H2>Information we collect</H2>
        <P>We only hold the information needed to run the service:</P>
        <ul className="list-disc pl-5 mb-4">
          <LI>
            <strong className="text-foreground">School and staff details</strong> — the school’s
            name, and the names, email addresses and roles of staff accounts the school creates
            (owner, teacher, bursar).
          </LI>
          <LI>
            <strong className="text-foreground">Student academic records entered by the school</strong>{' '}
            — student names, classes, scores, attendance, behaviour assessments, promotion records
            and fee status. The school enters and controls this information; we process it on the
            school’s behalf.
          </LI>
          <LI>
            <strong className="text-foreground">Content the school creates</strong> — lesson notes,
            schemes of work and exam questions generated or edited in the app, stored in the
            school’s own private space.
          </LI>
          <LI>
            <strong className="text-foreground">Basic technical logs</strong> — standard records of
            requests to our servers, used for security and to keep the service running.
          </LI>
        </ul>
        <P>
          Our marketing website does not run advertising trackers or analytics cookies. The
          application uses only the cookies needed to keep you signed in.
        </P>

        <H2>How we use information</H2>
        <ul className="list-disc pl-5 mb-4">
          <LI>To provide the service: generating content, computing results, printing report cards, tracking attendance and fees.</LI>
          <LI>To support schools when they contact us.</LI>
          <LI>To keep the service secure and improve how it works.</LI>
        </ul>
        <P>We do not sell personal information, and we do not show ads.</P>

        <H2>Students’ information</H2>
        <P>
          Students’ records belong to the school. The school decides what to enter and who in the
          school can see it; Klassrun processes those records only on the school’s instructions. We
          handle personal information in line with the Nigeria Data Protection Act, 2023. Schools
          remain responsible for having the authority to enter their students’ information.
        </P>

        <H2>Where information is stored and how it is protected</H2>
        <P>
          Information is stored with reputable cloud hosting providers. Each school operates in its
          own isolated space — one school’s students, results, fee records and question bank are
          never visible to another school. Access within a school is controlled by roles set by the
          school’s owner or admin.
        </P>

        <H2>Sharing</H2>
        <P>
          We share information only with the service providers needed to run Klassrun (such as
          hosting and email providers), or where the law requires it. Nothing is shared for
          advertising.
        </P>

        <H2>Your choices</H2>
        <P>
          Staff and parents should direct requests about records to their school, which controls
          them. Schools can request access to, correction of, or deletion of their account and its
          records by emailing{' '}
          <a href="mailto:info@klassrun.com" className="text-primary font-semibold hover:underline">
            info@klassrun.com
          </a>
          . When a school’s account is deleted, its records are removed from the live service.
        </P>

        <H2>Changes to this policy</H2>
        <P>
          If we change this policy, we will update this page and the date above. Significant changes
          will be communicated to schools directly.
        </P>

        <H2>Contact</H2>
        <P>
          Questions about privacy: email{' '}
          <a href="mailto:info@klassrun.com" className="text-primary font-semibold hover:underline">
            info@klassrun.com
          </a>{' '}
          — Klassrun Technologies Ltd, Lagos, Nigeria.
        </P>
      </article>
    </main>
  )
}
