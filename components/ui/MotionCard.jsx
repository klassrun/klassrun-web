'use client'

import { useRef } from 'react'
import { motion, useMotionValue, useSpring, useTransform } from 'framer-motion'
import { cardIn, ease, viewportOnce } from '@/lib/motion'

/**
 * MotionCard — reusable card with:
 *  • scroll-in reveal (aligns when in viewport)
 *  • 3D rotateX / rotateY tilt on pointer
 *  • translateY lift on hover
 *
 * Pointer-only effect; disabled on touch for cleaner mobile feel.
 */
export function MotionCard({
  children,
  className = '',
  intensity = 8,       // max tilt in degrees
  lift = 6,            // translateY px on hover
  asChild = false,     // render as inner wrapper only
}) {
  const ref = useRef(null)

  const mx = useMotionValue(0)
  const my = useMotionValue(0)

  const rx = useSpring(useTransform(my, [-0.5, 0.5], [intensity, -intensity]), {
    stiffness: 180, damping: 20, mass: 0.4,
  })
  const ry = useSpring(useTransform(mx, [-0.5, 0.5], [-intensity, intensity]), {
    stiffness: 180, damping: 20, mass: 0.4,
  })

  const onMove = (e) => {
    if (!ref.current) return
    // Ignore on fine-grained touch devices
    if (e.pointerType === 'touch') return
    const r = ref.current.getBoundingClientRect()
    mx.set((e.clientX - r.left) / r.width - 0.5)
    my.set((e.clientY - r.top) / r.height - 0.5)
  }
  const onLeave = () => {
    mx.set(0)
    my.set(0)
  }

  return (
    <motion.div
      ref={ref}
      variants={cardIn}
      initial="hidden"
      whileInView="show"
      viewport={viewportOnce}
      whileHover={{ y: -lift, transition: { duration: 0.35, ease } }}
      onPointerMove={onMove}
      onPointerLeave={onLeave}
      style={{
        rotateX: rx,
        rotateY: ry,
        transformStyle: 'preserve-3d',
        transformPerspective: 1200,
      }}
      className={`relative will-change-transform ${className}`}
    >
      {/* inner translateZ layer — gives genuine 3D separation */}
      <div
        style={{ transform: 'translateZ(30px)', transformStyle: 'preserve-3d' }}
        className="h-full"
      >
        {children}
      </div>
    </motion.div>
  )
}
