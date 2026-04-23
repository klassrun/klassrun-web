// Shared Framer Motion easings & variants.
// Consistent motion identity across the whole site.

export const ease = [0.22, 1, 0.36, 1]
export const easeSoft = [0.4, 0, 0.2, 1]
export const spring = { type: 'spring', stiffness: 120, damping: 18, mass: 0.6 }

export const fadeUp = {
  hidden: { opacity: 0, y: 24 },
  show:   { opacity: 1, y: 0, transition: { duration: 0.6, ease } },
}

export const fadeIn = {
  hidden: { opacity: 0 },
  show:   { opacity: 1, transition: { duration: 0.5, ease } },
}

export const scaleIn = {
  hidden: { opacity: 0, scale: 0.96 },
  show:   { opacity: 1, scale: 1, transition: { duration: 0.5, ease } },
}

export const stagger = (delayChildren = 0.05, staggerChildren = 0.08) => ({
  hidden: {},
  show: { transition: { delayChildren, staggerChildren } },
})

// Deep 3D flip-in — "unfolds" from ~90° to flat
export const flipIn = {
  hidden: { opacity: 0, y: 60, rotateX: -90, rotateY: 25, scale: 0.85 },
  show: {
    opacity: 1, y: 0, rotateX: 0, rotateY: 0, scale: 1,
    transition: { duration: 1.0, ease },
  },
}

// Softer lift-in — default for most grids
export const cardIn = {
  hidden: { opacity: 0, y: 40, rotateX: -8, scale: 0.96 },
  show: {
    opacity: 1, y: 0, rotateX: 0, scale: 1,
    transition: { duration: 0.8, ease },
  },
}

// Stagger for card grids — each card ~150ms after previous
export const gridStagger = {
  hidden: {},
  show: {
    transition: { delayChildren: 0.1, staggerChildren: 0.15 },
  },
}

export const viewportOnce = { once: true, amount: 0.25 }
export const viewportProgressive = { once: true, amount: 0.1 }
