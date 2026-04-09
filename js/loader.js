/**
 * loader.js
 * Fetches each [data-component] partial and injects it into the DOM.
 * Must be loaded synchronously (no defer) so components exist before
 * navbar.js and scroll-reveal.js run.
 */

(async function loadComponents() {
  const slots = document.querySelectorAll('[data-component]');

  // Load all components in parallel
  const promises = Array.from(slots).map(async (slot) => {
    const name = slot.getAttribute('data-component');
    try {
      const res = await fetch(`/components/${name}.html`);
      if (!res.ok) throw new Error(`Failed to load component: ${name}`);
      const html = await res.text();
      slot.outerHTML = html; // replace the placeholder div entirely
    } catch (err) {
      console.error(err);
    }
  });

  await Promise.all(promises);

  // Dispatch a custom event so deferred scripts know the DOM is ready
  document.dispatchEvent(new Event('components:loaded'));
})();
