// Shared Framer Motion easings & variants.
// Keeps motion identity consistent across the whole site.

export const ease = [0.22, 1, 0.36, 1]      // ease-out-expo — smooth, premium
export const easeSoft = [0.4, 0, 0.2, 1]    // material ease
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
  show: {
    transition: { delayChildren, staggerChildren },
  },
})

// Card scroll-in: subtle lift + fade, aligns on entry.
export const cardIn = {
  hidden: { opacity: 0, y: 32, rotateX: -4 },
  show: {
    opacity: 1,
    y: 0,
    rotateX: 0,
    transition: { duration: 0.7, ease },
  },
}

export const viewportOnce = { once: true, amount: 0.2 }
