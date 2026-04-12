'use client'

import { useState, useEffect } from 'react'
import Image from 'next/image'

export default function LoadingSplash() {
  const [isLoaded, setIsLoaded] = useState(false)
  const [shouldHide, setShouldHide] = useState(false)

  useEffect(() => {
    // Listen for when the page is fully loaded
    const handleLoad = () => {
      // Start fade-out
      setIsLoaded(true)
      // Remove from DOM after fade-out animation completes
      setTimeout(() => setShouldHide(true), 600)
    }

    // If document already loaded (e.g. cached), skip splash
    if (document.readyState === 'complete') {
      // Still show briefly so it doesn't flash
      setTimeout(handleLoad, 800)
    } else {
      window.addEventListener('load', handleLoad)
      // Safety timeout — never show splash for more than 5 seconds
      const timeout = setTimeout(handleLoad, 5000)
      return () => {
        window.removeEventListener('load', handleLoad)
        clearTimeout(timeout)
      }
    }
  }, [])

  if (shouldHide) return null

  return (
    <div
      style={{
        position: 'fixed',
        inset: 0,
        zIndex: 9999,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        backgroundColor: '#ffffff',
        transition: 'opacity 0.5s ease-out',
        opacity: isLoaded ? 0 : 1,
        pointerEvents: isLoaded ? 'none' : 'auto',
      }}
    >
      <div
        style={{
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
          gap: '0px',
        }}
      >
        <Image
          src="/images/logo.webp"
          alt="Klassrun"
          width={180}
          height={140}
          priority
          style={{
            animation: 'splashPulse 1.8s ease-in-out infinite',
            width: '180px',
            height: 'auto',
          }}
        />
      </div>

      <style>{`
        @keyframes splashPulse {
          0%, 100% {
            opacity: 0.3;
            transform: scale(0.95);
          }
          50% {
            opacity: 1;
            transform: scale(1);
          }
        }
      `}</style>
    </div>
  )
}