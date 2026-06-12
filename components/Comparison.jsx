import { Check, X } from 'lucide-react'
import { Section, SectionHeader } from './ui/Section'

// REVIEW BEFORE LAUNCH — every cell in the three competitor columns is a
// claim about other products. Confirm each one yourself before this goes live.
const COLUMNS = [
  { key: 'klassrun', label: 'Klassrun', sub: null },
  { key: 'chatbot', label: 'Generic AI chatbots', sub: '(ChatGPT, e.t.c)' },
  { key: 'sms', label: 'School management software', sub: '(Edves, Educare, e.t.c)' },
  { key: 'manual', label: 'Manual / paper process', sub: null },
]

const ROWS = [
  {
    title: 'Writes lesson notes, schemes and exam questions',
    sub: 'Complete drafts the teacher reviews and edits',
    values: { klassrun: true, chatbot: true, sms: false, manual: false },
  },
  {
    title: 'Tied to NERDC topics per class and term',
    sub: 'The curriculum is built in — no copy-paste prompting',
    values: { klassrun: true, chatbot: false, sms: false, manual: false },
  },
  {
    title: 'School-owned question bank',
    sub: 'Every question saved and reusable for years',
    values: { klassrun: true, chatbot: false, sms: false, manual: false },
  },
  {
    title: 'Nigerian report cards, computed and printed',
    sub: 'Totals, grades and positions worked out for you',
    values: { klassrun: true, chatbot: false, sms: true, manual: false },
  },
  {
    title: 'Attendance, behaviour, promotions and fees together',
    sub: 'Academic and money records in the same system',
    values: { klassrun: true, chatbot: false, sms: true, manual: false },
  },
  {
    title: 'One school account with owner, teacher and bursar roles',
    sub: 'Everyone sees what their role allows',
    values: { klassrun: true, chatbot: false, sms: true, manual: false },
  },
]

function Cell({ yes, highlighted }) {
  return (
    <td className={`px-4 py-5 text-center ${highlighted ? 'bg-klassrun-navy' : ''}`}>
      <span className="inline-flex items-center gap-1.5">
        <span
          className={`h-5 w-5 rounded-full flex items-center justify-center ${
            yes ? 'bg-primary/15' : 'bg-destructive/10'
          }`}
        >
          {yes ? (
            <Check size={12} className="text-primary" strokeWidth={3.5} />
          ) : (
            <X size={12} className="text-destructive" strokeWidth={3.5} />
          )}
        </span>
        <span
          className={`text-sm font-semibold ${
            highlighted ? 'text-white' : 'text-foreground/75'
          }`}
        >
          {yes ? 'Yes' : 'No'}
        </span>
      </span>
    </td>
  )
}

export default function Comparison() {
  return (
    <Section id="compare" surface="mint">
      <SectionHeader
        title="How we compare"
        subtitle="Why Nigerian schools pick Klassrun"
      />

      <div className="overflow-x-auto rounded-2xl bg-white shadow-card">
        <table className="w-full min-w-[820px] text-left border-collapse">
          <thead>
            <tr className="border-b border-soft">
              <th className="px-5 py-5 text-sm font-bold text-foreground w-[30%]">Offerings</th>
              {COLUMNS.map((col) => (
                <th
                  key={col.key}
                  className={`px-4 py-5 text-center align-top ${
                    col.key === 'klassrun' ? 'bg-klassrun-navy' : ''
                  }`}
                >
                  <span
                    className={`block text-sm font-bold leading-snug ${
                      col.key === 'klassrun' ? 'text-white' : 'text-foreground'
                    }`}
                  >
                    {col.label}
                  </span>
                  {col.sub && (
                    <span className="block mt-1 text-[11px] font-normal text-muted-foreground">
                      {col.sub}
                    </span>
                  )}
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {ROWS.map((row, i) => (
              <tr key={row.title} className={i < ROWS.length - 1 ? 'border-b border-subtle' : ''}>
                <td className="px-5 py-5 align-top">
                  <p className="text-sm font-bold text-foreground leading-snug">{row.title}</p>
                  <p className="mt-1 text-xs text-muted-foreground leading-relaxed">{row.sub}</p>
                </td>
                {COLUMNS.map((col) => (
                  <Cell
                    key={col.key}
                    yes={row.values[col.key]}
                    highlighted={col.key === 'klassrun'}
                  />
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <p className="mt-4 text-center text-xs text-muted-foreground sm:hidden">
        Swipe sideways to see the full table
      </p>
    </Section>
  )
}
