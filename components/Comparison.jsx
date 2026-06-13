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

function Mark({ yes }) {
  return yes ? (
    <Check size={20} strokeWidth={3} className="inline-block chalk-green" aria-label="Yes" />
  ) : (
    <X size={20} strokeWidth={2.5} className="inline-block chalk-red" aria-label="No" />
  )
}

export default function Comparison() {
  return (
    <Section id="compare" surface="mint">
      <SectionHeader title="How we compare" subtitle="Why Nigerian schools pick Klassrun" />

      <div className="overflow-x-auto pb-1">
        {/* Wooden frame → slate board → chalk-drawn table */}
        <div className="chalk-frame min-w-[760px] rounded-2xl p-3 sm:p-4">
          <div className="chalk-board rounded-lg p-3 sm:p-5">
            <table className="w-full border-separate border-spacing-0">
              <thead>
                <tr>
                  <th className="w-[40%] border-t border-l border-r border-b chalk-line text-left px-4 py-3.5 text-sm font-bold chalk-text">
                    Offerings
                  </th>
                  {COLUMNS.map((col) => (
                    <th
                      key={col.key}
                      className={`border-t border-r border-b chalk-line px-4 py-3.5 text-center align-top ${
                        col.key === 'klassrun' ? 'bg-white/5' : ''
                      }`}
                    >
                      <span
                        className={`block text-sm font-bold leading-snug ${
                          col.key === 'klassrun' ? 'chalk-green' : 'chalk-text'
                        }`}
                      >
                        {col.label}
                      </span>
                      {col.sub && (
                        <span className="block mt-0.5 text-[11px] font-normal chalk-dim">
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
                    <td className="border-l border-r border-b chalk-line px-4 py-4 align-top">
                      <p className="text-sm font-bold chalk-text leading-snug">{row.title}</p>
                      <p className="mt-1 text-xs chalk-dim leading-relaxed">{row.sub}</p>
                    </td>
                    {COLUMNS.map((col) => (
                      <td
                        key={col.key}
                        className={`border-r border-b chalk-line px-4 py-4 text-center align-middle ${
                          col.key === 'klassrun' ? 'bg-white/5' : ''
                        }`}
                      >
                        <Mark yes={row.values[col.key]} />
                      </td>
                    ))}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <p className="mt-4 text-center text-xs text-muted-foreground sm:hidden">
        Swipe sideways to see the full table
      </p>
    </Section>
  )
}
