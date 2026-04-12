import Image from 'next/image'

export default function OfflinePage() {
  return (
    <div
      style={{
        minHeight: '100vh',
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
        fontFamily: 'system-ui, -apple-system, sans-serif',
        backgroundColor: '#ffffff',
        color: '#1f2937',
        padding: '2rem',
        textAlign: 'center',
      }}
    >
      <Image
        src="/images/logo.webp"
        alt="Klassrun"
        width={120}
        height={90}
        style={{
          width: '120px',
          height: 'auto',
          marginBottom: '1.5rem',
          opacity: 0.6,
        }}
      />
      <h1
        style={{
          fontSize: '1.35rem',
          fontWeight: 700,
          marginBottom: '0.5rem',
          color: '#1a2332',
        }}
      >
        You&apos;re offline
      </h1>
      <p
        style={{
          fontSize: '0.95rem',
          color: '#6b7280',
          maxWidth: '360px',
          lineHeight: 1.6,
          marginBottom: '2rem',
        }}
      >
        Check your internet connection and try again.
      </p>
      <button
        onClick={() => window.location.reload()}
        style={{
          padding: '0.7rem 2.5rem',
          backgroundColor: '#3DB54A',
          color: '#ffffff',
          border: 'none',
          borderRadius: '8px',
          fontSize: '0.95rem',
          fontWeight: 600,
          cursor: 'pointer',
          transition: 'background-color 0.2s',
        }}
        onMouseOver={(e) => (e.currentTarget.style.backgroundColor = '#35a041')}
        onMouseOut={(e) => (e.currentTarget.style.backgroundColor = '#3DB54A')}
      >
        Retry
      </button>
    </div>
  )
}