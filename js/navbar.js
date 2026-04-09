/**
 * navbar.js
 * Hamburger toggle using the HTML `hidden` attribute (matches CSS :not([hidden])).
 * Accessible: aria-expanded, Esc key, active nav highlighting.
 */
document.addEventListener('components:loaded', () => {
  const hamburger   = document.getElementById('hamburger');
  const mobileMenu  = document.getElementById('mobileMenu');
  const mobileLinks = document.querySelectorAll('.mobile-link');
  const navLinks    = document.querySelectorAll('.nav-links a');
  const sections    = document.querySelectorAll('section[id]');

  if (!hamburger || !mobileMenu) return;

  const openMenu = () => {
    mobileMenu.removeAttribute('hidden');
    hamburger.classList.add('open');
    hamburger.setAttribute('aria-expanded', 'true');
    document.body.style.overflow = 'hidden';
  };

  const closeMenu = () => {
    mobileMenu.setAttribute('hidden', '');
    hamburger.classList.remove('open');
    hamburger.setAttribute('aria-expanded', 'false');
    document.body.style.overflow = '';
  };

  hamburger.addEventListener('click', () => {
    mobileMenu.hasAttribute('hidden') ? openMenu() : closeMenu();
  });

  mobileLinks.forEach(link => link.addEventListener('click', closeMenu));
  document.addEventListener('keydown', e => { if (e.key === 'Escape') closeMenu(); });
  window.addEventListener('resize', () => { if (window.innerWidth >= 768) closeMenu(); });

  // Active link highlight on scroll
  const highlightNav = () => {
    let current = '';
    sections.forEach(sec => {
      if (window.scrollY >= sec.offsetTop - 120) current = sec.id;
    });
    navLinks.forEach(link => {
      if (link.getAttribute('href') === '#' + current) {
        link.setAttribute('aria-current', 'page');
      } else {
        link.removeAttribute('aria-current');
      }
    });
  };

  window.addEventListener('scroll', highlightNav, { passive: true });
});
