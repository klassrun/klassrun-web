import { Check, X } from 'lucide-react'
import { Section, SectionHeader } from './ui/Section'

// REVIEW BEFORE LAUNCH — every cell in the competitor columns is a claim
// about other products. Confirm each one yourself before this goes live.
const COLUMNS = [
  { key: 'klassrun', label: 'Klassrun', sub: null },
  { key: 'chatbot', label: 'Generic AI chatbots', sub: '(ChatGPT, e.t.c)' },
  { key: 'manual', label: 'Manual / paper process', sub: null },
]

const ROWS = [
  {
    title: 'Writes lesson notes, schemes and exam questions',
    sub: 'Complete drafts the teacher reviews and edits',
    values: { klassrun: true, chatbot: true, manual: false },
  },
  {
    title: 'Tied to NERDC topics per class and term',
    sub: 'The curriculum is built in — no copy-paste prompting',
    values: { klassrun: true, chatbot: false, manual: false },
  },
  {
    title: 'School-owned question bank',
    sub: 'Every question saved and reusable for years',
    values: { klassrun: true, chatbot: false, manual: false },
  },
  {
    title: 'Nigerian report cards, computed and printed',
    sub: 'Totals, grades and positions worked out for you',
    values: { klassrun: true, chatbot: false, manual: false },
  },
  {
    title: 'Attendance, behaviour, promotions and fees together',
    sub: 'Academic and money records in the same system',
    values: { klassrun: true, chatbot: false, manual: false },
  },
  {
    title: 'One school account with owner, teacher and bursar roles',
    sub: 'Everyone sees what their role allows',
    values: { klassrun: true, chatbot: false, manual: false },
  },
]

export default function Comparison() {
  return (
    <Section id="compare" surface="mint">
      <SectionHeader
        title="How we compare"
        subtitle="Why Nigerian schools pick Klassrun"
      />

      <div className="overflow-x-auto">
        <div className="min-w-[720px] rounded-2xl border border-soft bg-white overflow-hidden shadow-card">
          <table className="w-full border-collapse text-left">
            <thead>
              <tr>
                <th className="border border-soft px-5 py-4 text-sm font-bold text-foreground w-[34%]">
                  Offerings
                </th>
                {COLUMNS.map((col) => (
                  <th
                    key={col.key}
                    className={`border border-soft px-4 py-4 text-center align-top ${
                      col.key === 'klassrun' ? 'bg-primary/5' : ''
                    }`}
                  >
                    <span
                      className={`block text-sm font-bold leading-snug ${
                        col.key === 'klassrun' ? 'text-primary' : 'text-foreground'
                      }`}
                    >
                      {col.label}
                    </span>
                    {col.sub && (
                      <span className="block mt-0.5 text-[11px] font-normal text-muted-foreground">
                        {col.sub}
                      </span>
                    )}
                  </th>
                ))}
              </tr>
            </thead>
            <tbody>
              {ROWS.map((row) => (
                <tr key={row.title}>
                  <td className="border border-soft px-5 py-4 align-top">
                    <p className="text-sm font-bold text-foreground leading-snug">{row.title}</p>
                    <p className="mt-1 text-xs text-muted-foreground leading-relaxed">{row.sub}</p>
                  </td>
                  {COLUMNS.map((col) => (
                    <td
                      key={col.key}
                      className={`border border-soft px-4 py-4 text-center align-middle ${
                        col.key === 'klassrun' ? 'bg-primary/5' : ''
                      }`}
                    >
                      {row.values[col.key] ? (
                        <Check
                          size={18}
                          className="inline-block text-primary"
                          strokeWidth={3}
                          aria-label="Yes"
                        />
                      ) : (
                        <X
                          size={18}
                          className="inline-block text-destructive"
                          strokeWidth={2.5}
                          aria-label="No"
                        />
                      )}
                    </td>
                  ))}
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      <p className="mt-4 text-center text-xs text-muted-foreground sm:hidden">
        Swipe sideways to see the full table
      </p>
    </Section>
  )
}
