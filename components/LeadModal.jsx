'use client'

// components/LeadModal.jsx
// leads-capture-modal
// Popup lead form. Opens via a small event bus (window dispatch) so any CTA
// on the page can trigger it with a `type` of 'demo' or 'founding'.
// Posts to the public /api/leads endpoint on klassrun-api.

import { useEffect, useState } from 'react'
import { X, ArrowRight, Check } from 'lucide-react'

const API_URL = 'https://klassrun-api.onrender.com/api/leads'

// Any CTA calls: window.dispatchEvent(new CustomEvent('klassrun:lead', { detail: { type } }))
export function openLeadForm(type = 'demo') {
  if (typeof window !== 'undefined') {
    window.dispatchEvent(new CustomEvent('klassrun:lead', { detail: { type } }))
  }
}

const EMPTY = { name: '', school: '', phone: '', email: '', message: '', website: '' }

export default function LeadModal() {
  const [open, setOpen] = useState(false)
  const [type, setType] = useState('demo')
  const [form, setForm] = useState(EMPTY)
  const [status, setStatus] = useState('idle') // idle | sending | done | error
  const [errMsg, setErrMsg] = useState('')

  useEffect(() => {
    function onOpen(e) {
      setType(e?.detail?.type === 'founding' ? 'founding' : 'demo')
      setForm(EMPTY)
      setStatus('idle')
      setErrMsg('')
      setOpen(true)
    }
    window.addEventListener('klassrun:lead', onOpen)
    return () => window.removeEventListener('klassrun:lead', onOpen)
  }, [])

  useEffect(() => {
    function onKey(e) { if (e.key === 'Escape') setOpen(false) }
    if (open) window.addEventListener('keydown', onKey)
    return () => window.removeEventListener('keydown', onKey)
  }, [open])

  if (!open) return null

  const heading = type === 'founding' ? 'Claim a Founding School spot' : 'Book a demo'
  const sub = type === 'founding'
    ? 'Tell us about your school. A founder will reach out — usually the same day.'
    : "Fifteen minutes, and we'll show you the product on your own school's setup."

  const set = (k) => (e) => setForm((f) => ({ ...f, [k]: e.target.value }))

  async function submit() {
    setErrMsg('')
    // client-side minimal check (server validates authoritatively)
    if (!form.name || !form.school || !form.phone || !form.email) {
      setErrMsg('Please fill in your name, school, phone, and email.')
      return
    }
    setStatus('sending')
    try {
      const res = await fetch(API_URL, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ ...form, type }),
      })
      if (!res.ok) {
        const d = await res.json().catch(() => ({}))
        setErrMsg(d?.error?.message || 'Something went wrong. Please email info@klassrun.com.')
        setStatus('error')
        return
      }
      setStatus('done')
    } catch {
      setErrMsg('Network error. Please email info@klassrun.com.')
      setStatus('error')
    }
  }

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center bg-foreground/60 p-4 backdrop-blur-sm"
      onClick={() => setOpen(false)}
    >
      <div
        className="relative w-full max-w-md rounded-2xl border border-soft bg-white p-6 shadow-lift sm:p-8"
        onClick={(e) => e.stopPropagation()}
      >
        <button
          onClick={() => setOpen(false)}
          className="absolute right-4 top-4 rounded-full p-1 text-muted-foreground hover:bg-secondary hover:text-foreground transition-colors"
          aria-label="Close"
        >
          <X size={18} />
        </button>

        {status === 'done' ? (
          <div className="py-6 text-center">
            <span className="mx-auto mb-4 flex h-12 w-12 items-center justify-center rounded-full bg-primary/12">
              <Check size={22} className="text-primary" strokeWidth={3} />
            </span>
            <h3 className="font-display text-xl font-bold text-foreground">Thank you.</h3>
            <p className="mt-2 text-sm leading-relaxed text-muted-foreground">
              We&apos;ve got your details — a founder will reach out shortly. If it&apos;s urgent,
              email <a href="mailto:info@klassrun.com" className="font-bold text-primary">info@klassrun.com</a>.
            </p>
            <button
              onClick={() => setOpen(false)}
              className="mt-6 inline-flex items-center justify-center rounded-full bg-primary px-6 py-3 text-sm font-bold text-primary-foreground hover:bg-klassrun-green-dark transition-colors"
            >
              Done
            </button>
          </div>
        ) : (
          <>
            <h3 className="font-display text-xl font-bold text-foreground sm:text-2xl">{heading}</h3>
            <p className="mt-2 text-sm leading-relaxed text-muted-foreground">{sub}</p>

            <div className="mt-6 space-y-3">
              {/* honeypot — visually hidden, real users never fill it */}
              <input
                type="text" tabIndex={-1} autoComplete="off"
                value={form.website} onChange={set('website')}
                className="absolute left-[-9999px] h-0 w-0 opacity-0" aria-hidden="true"
              />
              <Field label="Your name" value={form.name} onChange={set('name')} placeholder="e.g. Mrs. Adaeze Okoro" />
              <Field label="School name" value={form.school} onChange={set('school')} placeholder="e.g. Greenfield Model College" />
              <Field label="Phone" value={form.phone} onChange={set('phone')} placeholder="e.g. 0801 234 5678" type="tel" />
              <Field label="Email" value={form.email} onChange={set('email')} placeholder="you@school.com" type="email" />
              <div>
                <label className="mb-1 block text-xs font-bold text-foreground/80">Anything you&apos;d like us to know? <span className="font-normal text-muted-foreground">(optional)</span></label>
                <textarea
                  value={form.message} onChange={set('message')} rows={3}
                  placeholder="How many teachers? What matters most to you?"
                  className="w-full rounded-lg border border-soft bg-white px-3 py-2 text-sm text-foreground placeholder:text-muted-foreground/70 focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary"
                />
              </div>

              {errMsg && <p className="text-sm text-red-600">{errMsg}</p>}

              <button
                onClick={submit}
                disabled={status === 'sending'}
                className="group mt-1 inline-flex w-full items-center justify-center gap-2 rounded-full bg-primary px-7 py-3.5 text-sm font-bold text-primary-foreground hover:bg-klassrun-green-dark transition-colors disabled:opacity-60"
              >
                {status === 'sending' ? 'Sending…' : (type === 'founding' ? 'Claim my spot' : 'Request demo')}
                {status !== 'sending' && <ArrowRight size={16} className="transition-transform group-hover:translate-x-0.5" />}
              </button>
              <p className="text-center text-[11px] text-muted-foreground">
                Or email <a href="mailto:info@klassrun.com" className="font-bold text-foreground hover:text-primary">info@klassrun.com</a>
              </p>
            </div>
          </>
        )}
      </div>
    </div>
  )
}

function Field({ label, value, onChange, placeholder, type = 'text' }) {
  return (
    <div>
      <label className="mb-1 block text-xs font-bold text-foreground/80">{label}</label>
      <input
        type={type} value={value} onChange={onChange} placeholder={placeholder}
        className="w-full rounded-lg border border-soft bg-white px-3 py-2 text-sm text-foreground placeholder:text-muted-foreground/70 focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary"
      />
    </div>
  )
}
