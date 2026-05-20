// Fade-in on scroll
const observer = new IntersectionObserver((entries) => {
  entries.forEach(e => {
    if (e.isIntersecting) { e.target.classList.add('visible'); observer.unobserve(e.target); }
  });
}, { threshold: 0.12 });

document.querySelectorAll('.why-heading, .why-body, .what-title, .card, .manifesto blockquote, .contact-inner').forEach(el => {
  el.classList.add('fade-in');
  observer.observe(el);
});

// Mobile menu toggle
const hamburger = document.querySelector('.nav-hamburger');
const navLinks = document.querySelector('.nav-links');
hamburger.addEventListener('click', () => {
  const open = navLinks.style.display === 'flex';
  navLinks.style.display = open ? 'none' : 'flex';
  if (!open) {
    navLinks.style.flexDirection = 'column';
    navLinks.style.position = 'absolute';
    navLinks.style.top = '100%';
    navLinks.style.left = '0';
    navLinks.style.right = '0';
    navLinks.style.background = '#0a0a0a';
    navLinks.style.padding = '24px';
    navLinks.style.borderBottom = '1px solid rgba(255,255,255,0.08)';
  }
});

// Close mobile menu on link click
document.querySelectorAll('.nav-links a').forEach(a => {
  a.addEventListener('click', () => { navLinks.style.display = 'none'; });
});
