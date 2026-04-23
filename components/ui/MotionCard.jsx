'use client'

import { useRef } from 'react'
import {
  motion,
  useMotionValue,
  useSpring,
  useTransform,
  useScroll,
} from 'framer-motion'
import { ease, viewportOnce } from '@/lib/motion'

/**
 * MotionCard — 3D card with:
 *   • Proximity fade: opacity rises gradually as you scroll toward it
 *   • Entrance: 'lift' (soft) | 'flip' (deep 90° unfold) | 'none'
 *   • Pointer tilt: rotateX / rotateY on mouse move
 *   • Hover lift: translateY on hover
 *   • Pointer-only tilt — touch devices get clean static cards
 */
export function MotionCard({
  children,
  className = '',
  entrance = 'lift',
  intensity = 10,
  lift = 8,
  index = 0,
}) {
  const ref = useRef(null)

  // Proximity fade — progress runs 0→1 as card rises into viewport
  const { scrollYProgress } = useScroll({
    target: ref,
    offset: ['start 0.95', 'start 0.45'],
  })

  const opacity = useTransform(scrollYProgress, [0, 0.4, 1], [0, 0.6, 1])
  const y = useTransform(scrollYProgress, [0, 1], [60, 0])

  // Pointer tilt
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
    if (e.pointerType === 'touch') return
    const r = ref.current.getBoundingClientRect()
    mx.set((e.clientX - r.left) / r.width - 0.5)
    my.set((e.clientY - r.top) / r.height - 0.5)
  }
  const onLeave = () => { mx.set(0); my.set(0) }

  const entranceVariants = {
    none: {
      hidden: { opacity: 1, rotateX: 0, rotateY: 0, scale: 1 },
      show: { opacity: 1, rotateX: 0, rotateY: 0, scale: 1 },
    },
    lift: {
      hidden: { rotateX: -12, rotateY: 6, scale: 0.94 },
      show: {
        rotateX: 0, rotateY: 0, scale: 1,
        transition: { duration: 0.9, ease, delay: index * 0.12 },
      },
    },
    flip: {
      hidden: { rotateX: -90, rotateY: 20, scale: 0.8 },
      show: {
        rotateX: 0, rotateY: 0, scale: 1,
        transition: { duration: 1.1, ease, delay: index * 0.18 },
      },
    },
  }[entrance]

  return (
    <motion.div
      ref={ref}
      variants={entranceVariants}
      initial="hidden"
      whileInView="show"
      viewport={viewportOnce}
      style={{
        opacity,
        y,
        transformPerspective: 1400,
        transformStyle: 'preserve-3d',
      }}
      className={`relative will-change-transform ${className}`}
    >
      <motion.div
        whileHover={{ y: -lift, transition: { duration: 0.4, ease } }}
        onPointerMove={onMove}
        onPointerLeave={onLeave}
        style={{
          rotateX: rx,
          rotateY: ry,
          transformStyle: 'preserve-3d',
        }}
        className="h-full w-full"
      >
        <div
          style={{ transform: 'translateZ(40px)', transformStyle: 'preserve-3d' }}
          className="h-full"
        >
          {children}
        </div>
      </motion.div>
    </motion.div>
  )
}
