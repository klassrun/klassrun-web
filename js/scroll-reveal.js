/**
 * scroll-reveal.js
 * Observes .reveal elements and adds .visible when they enter the viewport.
 * Staggers siblings slightly so they don't all pop at once.
 *
 * Waits for 'components:loaded' since elements are injected dynamically.
 */

document.addEventListener('components:loaded', () => {

  const reveals = document.querySelectorAll('.reveal');

  if (!('IntersectionObserver' in window)) {
    // Fallback: just make everything visible immediately
    reveals.forEach(el => el.classList.add('visible'));
    return;
  }

  const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry, i) => {
      if (entry.isIntersecting) {
        setTimeout(() => {
          entry.target.classList.add('visible');
        }, i * 60); // stagger: each sibling 60ms apart
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.12 });

  reveals.forEach(el => observer.observe(el));

});
