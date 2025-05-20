"use strict";

document.addEventListener('DOMContentLoaded', () => {

    // --- DOM ELEMENT SELECTORS ---
    const body = document.body;
    const siteHeader = document.getElementById('siteHeader');
    const themeSwitcher = document.getElementById('themeSwitcher');
    const sunIcon = themeSwitcher?.querySelector('.sun-icon');
    const moonIcon = themeSwitcher?.querySelector('.moon-icon');
    const mobileNavToggle = document.getElementById('mobileNavToggle');
    const mainNav = document.getElementById('mainNav');
    const pageOverlay = document.getElementById('pageOverlay');
    const scrollToTopBtn = document.getElementById('scrollToTopBtn');

    // --- THEME SWITCHER LOGIC ---
    if (themeSwitcher && sunIcon && moonIcon) {
        const THEME_KEY = 'user-preferred-theme';

        const applyTheme = (theme) => {
            body.setAttribute('data-theme', theme);
            localStorage.setItem(THEME_KEY, theme);
            const isDarkMode = theme === 'dark';
            sunIcon.style.display = isDarkMode ? 'none' : 'inline-block';
            moonIcon.style.display = isDarkMode ? 'inline-block' : 'none';
            themeSwitcher.setAttribute('aria-label', `Switch to ${isDarkMode ? 'light' : 'dark'} theme`);
            themeSwitcher.setAttribute('aria-pressed', isDarkMode.toString());

            const rootStyle = document.documentElement.style;
            if (isDarkMode) {
                rootStyle.setProperty('--color-accent-primary-rgb', '0, 245, 212'); // Dark theme teal
            } else {
                rootStyle.setProperty('--color-accent-primary-rgb', '0, 122, 204'); // Light theme blue
            }
        };

        const initializeTheme = () => {
            let preferredTheme = localStorage.getItem(THEME_KEY);
            if (!preferredTheme) {
                preferredTheme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
            }
            applyTheme(preferredTheme);
        };

        initializeTheme();

        themeSwitcher.addEventListener('click', () => {
            const currentTheme = body.getAttribute('data-theme');
            const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
            applyTheme(newTheme);
        });
    }

    // --- MOBILE NAVIGATION HANDLING ---
    if (mobileNavToggle && mainNav && pageOverlay) {
        const toggleMobileNav = (forceOpen) => {
            const isOpen = typeof forceOpen === 'boolean' ? forceOpen : !mainNav.classList.contains('active');
            mainNav.classList.toggle('active', isOpen);
            mobileNavToggle.classList.toggle('active', isOpen);
            mobileNavToggle.setAttribute('aria-expanded', isOpen.toString());
            pageOverlay.classList.toggle('active', isOpen);
            body.classList.toggle('no-scroll', isOpen);
        };

        mobileNavToggle.addEventListener('click', () => toggleMobileNav());

        mainNav.querySelectorAll('a[href^="#"]').forEach(link => {
            link.addEventListener('click', () => {
                if (mainNav.classList.contains('active')) {
                    toggleMobileNav(false);
                }
            });
        });

        pageOverlay.addEventListener('click', () => {
            if (mainNav.classList.contains('active')) {
                 toggleMobileNav(false);
            }
        });

        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && mainNav.classList.contains('active')) {
                toggleMobileNav(false);
            }
        });
    }

    // --- ACTIVE NAVIGATION LINK HIGHLIGHTING ON SCROLL ---
    const navLinks = mainNav?.querySelectorAll('a[href^="#"]');
    const contentSections = document.querySelectorAll('main section[id]');

    if (navLinks && navLinks.length > 0 && contentSections && contentSections.length > 0 && siteHeader) {
        let scrollTimeout;
        const headerHeight = siteHeader.offsetHeight;

        const highlightActiveLink = () => {
            // Determine current scroll position with an offset for fixed header and trigger point
            const scrollPosition = window.pageYOffset + headerHeight + 50;
            let activeSectionId = null;

            contentSections.forEach(section => {
                if (scrollPosition >= section.offsetTop && scrollPosition < section.offsetTop + section.offsetHeight) {
                    activeSectionId = section.id;
                }
            });

            // If near bottom of page, and last section is visible, make its link active
            if ((window.innerHeight + window.pageYOffset) >= document.body.offsetHeight - 5 && contentSections.length > 0) { // 5px buffer
                activeSectionId = contentSections[contentSections.length - 1].id;
            }

            navLinks.forEach(link => {
                link.classList.toggle('active', link.hash === `#${activeSectionId}`);
            });
        };

        window.addEventListener('scroll', () => {
            clearTimeout(scrollTimeout);
            scrollTimeout = setTimeout(highlightActiveLink, 75); // Debounce for performance
        }, { passive: true });
        highlightActiveLink(); // Initial call to set active link on load
    }

    // --- SMOOTH SCROLLING FOR ANCHOR LINKS (Considering Fixed Header) ---
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            const targetId = this.hash;
            // Ensure targetId is not just "#" and that an element with that ID exists
            if (targetId.length > 1 && document.querySelector(targetId)) {
                const targetElement = document.querySelector(targetId);
                if (targetElement && siteHeader) {
                    e.preventDefault();
                    const headerOffset = siteHeader.offsetHeight;
                    const elementPosition = targetElement.getBoundingClientRect().top;
                    const offsetPosition = elementPosition + window.pageYOffset - headerOffset;

                    window.scrollTo({
                        top: offsetPosition,
                        behavior: 'smooth'
                    });
                }
            }
        });
    });

    // --- CODE BLOCK COPY FUNCTIONALITY ---
    document.querySelectorAll('.code-block-wrapper pre').forEach(preElement => {
        const codeElement = preElement.querySelector('code');
        if (!codeElement) return;

        const copyButton = document.createElement('button');
        copyButton.type = 'button';
        copyButton.classList.add('copy-button');
        copyButton.setAttribute('aria-label', 'Copy code to clipboard');
        copyButton.innerHTML = 'Copy <span class="icon" aria-hidden="true">📋</span>';

        if (preElement.parentNode.classList.contains('code-block-wrapper')) {
            preElement.parentNode.appendChild(copyButton);
        } else {
            preElement.insertAdjacentElement('afterend', copyButton);
        }

        copyButton.addEventListener('click', () => {
            navigator.clipboard.writeText(codeElement.innerText).then(() => {
                copyButton.innerHTML = 'Copied! <span class="icon" aria-hidden="true">✅</span>';
                copyButton.classList.add('copied');
                setTimeout(() => {
                    copyButton.innerHTML = 'Copy <span class="icon" aria-hidden="true">📋</span>';
                    copyButton.classList.remove('copied');
                }, 2500);
            }).catch(err => {
                console.error('Failed to copy code:', err);
                copyButton.textContent = 'Error';
                setTimeout(() => {
                    copyButton.innerHTML = 'Copy <span class="icon" aria-hidden="true">📋</span>';
                }, 2500);
            });
        });
    });

    // --- DYNAMIC FOOTER YEAR ---
    const yearSpan = document.getElementById('currentYear');
    if (yearSpan) {
        yearSpan.textContent = new Date().getFullYear();
    }

    // --- SCROLL TO TOP BUTTON VISIBILITY & FUNCTIONALITY ---
    if (scrollToTopBtn) {
        const toggleScrollTopVisibility = () => {
            scrollToTopBtn.classList.toggle('visible', window.pageYOffset > 300);
        };
        window.addEventListener('scroll', toggleScrollTopVisibility, { passive: true });
        toggleScrollTopVisibility(); // Initial check

        scrollToTopBtn.addEventListener('click', () => {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });
    }

    // --- INTERSECTION OBSERVER FOR SCROLL ANIMATIONS ---
    const animatedElements = document.querySelectorAll('.animate-on-scroll');
    if (animatedElements.length > 0 && 'IntersectionObserver' in window) {
        const observerOptions = {
            root: null,
            rootMargin: '0px',
            threshold: 0.15 // Trigger when 15% of the element is visible
        };

        const animationObserver = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const delay = entry.target.dataset.animationDelay || '0s';
                    entry.target.style.transitionDelay = delay;
                    entry.target.classList.add('is-visible');
                    observer.unobserve(entry.target); // Animate only once
                }
            });
        }, observerOptions);

        animatedElements.forEach(el => animationObserver.observe(el));
    } else {
        // Fallback for browsers without IntersectionObserver
        animatedElements.forEach(el => el.classList.add('is-visible'));
    }

});
