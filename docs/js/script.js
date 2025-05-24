"use strict"; // Keeps our JavaScript clean and strict!

// Let's wait for the entire page to be ready before we start messing with it.
document.addEventListener('DOMContentLoaded', () => {

    // --- GRABBING OUR DOM ELEMENTS ---
    // It's good practice to grab these once and store them, rather than searching the DOM repeatedly.
    const body = document.body;
    const siteHeader = document.getElementById('siteHeader');
    const themeSwitcher = document.getElementById('themeSwitcher');
    const sunIcon = themeSwitcher?.querySelector('.sun-icon'); // The little sun for light mode
    const moonIcon = themeSwitcher?.querySelector('.moon-icon'); // The little moon for dark mode
    const mobileNavToggle = document.getElementById('mobileNavToggle'); // The hamburger button
    const mainNav = document.getElementById('mainNav'); // The navigation menu itself
    const pageOverlay = document.getElementById('pageOverlay'); // The dim overlay for mobile nav
    const scrollToTopBtn = document.getElementById('scrollToTopBtn'); // Our trusty "back to top" button
    const currentYearSpan = document.getElementById('currentYear'); // For the copyright year

    // --- THEME SWITCHER: Light, Dark, and openSUSE Green! ---
    if (themeSwitcher && sunIcon && moonIcon) {
        const THEME_KEY = 'user-preferred-theme'; // How we remember the user's choice in their browser

        // This function actually applies the chosen theme.
        const applyTheme = (theme) => {
            body.setAttribute('data-theme', theme); // This tells our CSS which theme to use.
            localStorage.setItem(THEME_KEY, theme); // Save it for next time!
            const isDarkMode = theme === 'dark';

            // Show the correct sun/moon icon.
            sunIcon.style.display = isDarkMode ? 'none' : 'inline-block';
            moonIcon.style.display = isDarkMode ? 'inline-block' : 'none';

            // Make sure screen readers know what's up.
            themeSwitcher.setAttribute('aria-label', `Switch to ${isDarkMode ? 'light' : 'dark'} theme`);
            themeSwitcher.setAttribute('aria-pressed', isDarkMode.toString());

            // Our CSS uses RGB versions of accent colors for transparency (rgba).
            // Let's make sure these are correctly set when the theme changes.
            const rootStyle = document.documentElement.style;
            const computedStyles = getComputedStyle(document.documentElement);

            // It's a bit verbose, but this tries to get the RGB values defined in CSS.
            // If for some reason they aren't there, it uses sensible fallbacks for the openSUSE theme.
            if (isDarkMode) {
                // Fallbacks for openSUSE dark theme greens/blues
                rootStyle.setProperty('--color-accent-primary-rgb', computedStyles.getPropertyValue('--color-accent-primary-rgb').trim() || '134, 220, 61');
                rootStyle.setProperty('--color-accent-secondary-rgb', computedStyles.getPropertyValue('--color-accent-secondary-rgb').trim() || '111, 160, 216');
            } else {
                // Fallbacks for openSUSE light theme greens/blues
                rootStyle.setProperty('--color-accent-primary-rgb', computedStyles.getPropertyValue('--color-accent-primary-rgb').trim() || '32, 103, 44');
                rootStyle.setProperty('--color-accent-secondary-rgb', computedStyles.getPropertyValue('--color-accent-secondary-rgb').trim() || '90, 131, 182');
            }
        };

        // When the page first loads, figure out which theme to show.
        const initializeTheme = () => {
            let preferredTheme = localStorage.getItem(THEME_KEY); // Did the user pick one last time?
            if (!preferredTheme) { // Nope? Okay, let's see what their OS prefers.
                preferredTheme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
            }
            // We add a tiny delay here. Sometimes, CSS variables (especially those defined in :root)
            // might not be fully parsed and available to JS immediately on DOMContentLoaded.
            // This helps ensure getComputedStyle can read them accurately.
            setTimeout(() => applyTheme(preferredTheme), 10);
        };

        initializeTheme(); // Let's get this theme party started!

        // When the theme switcher button is clicked...
        themeSwitcher.addEventListener('click', () => {
            const currentTheme = body.getAttribute('data-theme');
            applyTheme(currentTheme === 'dark' ? 'light' : 'dark'); // Flip it!
        });
    } else {
        // If we can't find the theme switcher stuff, let's log a little note.
        console.warn("Theme switcher elements (button, sun/moon icons) are missing. Theme functionality might be a bit sad.");
    }

    // --- HEADER SCROLL BEHAVIOR: Adding a shadow when you scroll down ---
    if (siteHeader) {
        const headerScrollHandler = () => {
            // If the page is scrolled down even a tiny bit (10 pixels)...
            if (window.pageYOffset > 10) {
                siteHeader.classList.add('scrolled'); // ...add a class. CSS will handle the shadow.
            } else {
                siteHeader.classList.remove('scrolled'); // Otherwise, remove it.
            }
        };
        window.addEventListener('scroll', headerScrollHandler, { passive: true }); // Listen for scrolls.
        headerScrollHandler(); // Check right away when the page loads.
    }


    // --- MOBILE NAVIGATION: Making the hamburger menu work its magic ---
    if (mobileNavToggle && mainNav && pageOverlay) {
        const toggleMobileNav = (forceOpen) => {
            // Figure out if we're opening or closing.
            const isOpen = typeof forceOpen === 'boolean' ? forceOpen : !mainNav.classList.contains('active');
            // Toggle all the 'active' classes and ARIA attributes.
            mainNav.classList.toggle('active', isOpen);
            mobileNavToggle.classList.toggle('active', isOpen); // Animates the hamburger -> X
            mobileNavToggle.setAttribute('aria-expanded', isOpen.toString());
            pageOverlay.classList.toggle('active', isOpen); // Show/hide the dim background.
            body.classList.toggle('no-scroll', isOpen); // Stop the page from scrolling underneath.
        };

        mobileNavToggle.addEventListener('click', () => toggleMobileNav()); // Click the hamburger.

        // If a nav link is clicked (like an anchor #link to a section)...
        mainNav.querySelectorAll('a[href^="#"]').forEach(link => {
            link.addEventListener('click', () => {
                if (mainNav.classList.contains('active')) toggleMobileNav(false); // ...close the nav.
            });
        });

        // Clicking the dim overlay also closes the nav.
        pageOverlay.addEventListener('click', () => {
            if (mainNav.classList.contains('active')) toggleMobileNav(false);
        });

        // Pressing 'Escape' should also close it - good for keyboard users!
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && mainNav.classList.contains('active')) toggleMobileNav(false);
        });
    } else {
        console.warn("Mobile navigation elements (toggle, nav panel, overlay) are missing. The mobile menu might not work.");
    }

    // --- ACTIVE NAVIGATION LINK HIGHLIGHTING: Showing where you are on the page ---
    const navLinks = mainNav?.querySelectorAll('a[href^="#"]'); // All the links in our main nav.
    const contentSections = document.querySelectorAll('main section[id]'); // All the sections with an ID.

    if (navLinks && navLinks.length > 0 && contentSections && contentSections.length > 0 && siteHeader) {
        let scrollTimeout; // To avoid running this function too often while scrolling (performance).
        const getHeaderHeight = () => siteHeader.offsetHeight; // Get header height dynamically, as it might change.

        const highlightActiveLink = () => {
            const currentHeaderHeight = getHeaderHeight();
            // We calculate the scroll position, taking the sticky header into account,
            // plus a small buffer (10% of viewport height or 50px, whichever is smaller).
            // This makes the link activate a bit before the section strictly hits the top.
            const scrollThreshold = window.pageYOffset + currentHeaderHeight + Math.min(50, window.innerHeight * 0.1);
            let activeSectionId = null;

            // Loop through our sections to see which one is currently "active".
            contentSections.forEach(section => {
                if (section.offsetTop <= scrollThreshold && (section.offsetTop + section.offsetHeight) > scrollThreshold) {
                    activeSectionId = section.id;
                }
            });

            // A little tweak: if we're scrolled all the way to the bottom, make sure the last section's link is active.
            // This helps with short final sections.
            if ((window.innerHeight + window.pageYOffset + 10) >= document.body.offsetHeight && contentSections.length > 0) { // 10px buffer from bottom
                activeSectionId = contentSections[contentSections.length - 1].id;
            }

            // Now, update the 'active' class on the nav links.
            navLinks.forEach(link => {
                link.classList.toggle('active', link.hash === `#${activeSectionId}`);
            });
        };

        // We listen for scroll events, but "debounce" the handler.
        // This means it only runs after scrolling has paused for a moment (60ms here).
        const debouncedHighlight = () => {
            clearTimeout(scrollTimeout);
            scrollTimeout = setTimeout(highlightActiveLink, 60);
        };
        window.addEventListener('scroll', debouncedHighlight, { passive: true });
        window.addEventListener('resize', debouncedHighlight, { passive: true }); // Also on resize, header height might change.

        setTimeout(highlightActiveLink, 100); // Run it once after the page loads too.
    }

    // --- SMOOTH SCROLLING FOR ANCHOR LINKS: Graceful jumps to sections ---
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            const targetId = this.hash; // e.g., "#about"
            if (targetId.length > 1) { // Make sure it's not just a lonely "#"
                const targetElement = document.querySelector(targetId);
                if (targetElement) {
                    e.preventDefault(); // Stop the browser's default jump.
                    const headerOffset = siteHeader ? siteHeader.offsetHeight : 0; // Account for sticky header.
                    const elementPosition = targetElement.getBoundingClientRect().top;
                    const offsetPosition = elementPosition + window.pageYOffset - headerOffset;

                    window.scrollTo({ top: offsetPosition, behavior: 'smooth' }); // Smoothly scroll there.

                    // After scrolling, let's try to focus the target element if it's focusable.
                    // This is good for accessibility. A small delay helps ensure scrolling is done.
                    setTimeout(() => {
                        // Check if the element is genuinely focusable or has a tabindex.
                        const isFocusable = targetElement.hasAttribute('tabindex') || ['INPUT', 'SELECT', 'BUTTON', 'A', 'TEXTAREA'].includes(targetElement.tagName);
                        if (isFocusable || targetElement.tabIndex !== -1) {
                            targetElement.focus({ preventScroll: true }); // preventScroll stops it from jumping again.
                        }
                    }, 500); // Adjust delay if smooth scroll takes longer.
                }
            }
        });
    });

    // --- CODE BLOCK COPY FUNCTIONALITY: One-click copy for code snippets! ---
    document.querySelectorAll('.code-block-wrapper pre').forEach(preElement => {
        const codeElement = preElement.querySelector('code');
        if (!codeElement) { // Should always have a <code> inside <pre> for this.
            console.warn("Found a <pre> without a <code> child in .code-block-wrapper. Copy button skipped.", preElement);
            return;
        }

        const copyButton = document.createElement('button');
        copyButton.type = 'button'; // It's a button, not a form submitter.
        copyButton.classList.add('copy-button');
        copyButton.setAttribute('aria-label', 'Copy code to clipboard');
        copyButton.setAttribute('aria-live', 'polite'); // So screen readers announce changes (like "Copied!").
        copyButton.innerHTML = 'Copy <span class="icon" aria-hidden="true">📋</span>'; // Initial text and icon.

        // Add the button to the DOM.
        if (preElement.parentNode.classList.contains('code-block-wrapper')) {
            preElement.parentNode.appendChild(copyButton);
        } else {
            // Fallback, though ideally the structure is consistent.
            preElement.insertAdjacentElement('afterend', copyButton);
            console.warn("Copy button added as sibling to <pre>, not child of .code-block-wrapper. Layout might be affected.", preElement);
        }

        // What happens when you click "Copy"...
        copyButton.addEventListener('click', () => {
            navigator.clipboard.writeText(codeElement.innerText)
                .then(() => { // Success!
                    copyButton.innerHTML = 'Copied! <span class="icon" aria-hidden="true">✅</span>';
                    copyButton.classList.add('copied');
                    copyButton.setAttribute('aria-label', 'Code copied to clipboard!'); // Update for screen readers.
                    // Change it back after a bit.
                    setTimeout(() => {
                        copyButton.innerHTML = 'Copy <span class="icon" aria-hidden="true">📋</span>';
                        copyButton.classList.remove('copied');
                        copyButton.setAttribute('aria-label', 'Copy code to clipboard');
                    }, 2800); // A good amount of time to see the "Copied!" message.
                })
                .catch(err => { // Oops, something went wrong.
                    console.error('Failed to copy code:', err);
                    copyButton.textContent = 'Error';
                    copyButton.setAttribute('aria-label', 'Error copying code');
                    setTimeout(() => { // Change it back.
                        copyButton.innerHTML = 'Copy <span class="icon" aria-hidden="true">📋</span>';
                        copyButton.setAttribute('aria-label', 'Copy code to clipboard');
                    }, 2800);
                });
        });
    });

    // --- DYNAMIC FOOTER YEAR: Always up-to-date copyright! ---
    if (currentYearSpan) {
        currentYearSpan.textContent = new Date().getFullYear();
    }

    // --- SCROLL TO TOP BUTTON: Helping users get back up quickly ---
    if (scrollToTopBtn) {
        const toggleScrollTopVisibility = () => {
            // Show the button if the user has scrolled down about 40% of the viewport height.
            scrollToTopBtn.classList.toggle('visible', window.pageYOffset > (window.innerHeight * 0.4));
        };
        window.addEventListener('scroll', toggleScrollTopVisibility, { passive: true });
        toggleScrollTopVisibility(); // Check on load.

        scrollToTopBtn.addEventListener('click', () => {
            window.scrollTo({ top: 0, behavior: 'smooth' }); // Zoom to the top!
        });
    }

    // --- INTERSECTION OBSERVER FOR SCROLL ANIMATIONS: Making elements appear gracefully ---
    const animatedElements = document.querySelectorAll('.animate-on-scroll');
    if (animatedElements.length > 0 && 'IntersectionObserver' in window) { // Check if browser supports it.
        const observerOptions = {
            root: null, // Observe against the main viewport.
            rootMargin: '0px 0px -50px 0px', // Trigger a bit earlier when scrolling up (bottom margin is negative).
            threshold: 0.1 // Element is 10% visible.
        };

        const animationObserver = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) { // If the element is now in view...
                    const delay = entry.target.dataset.animationDelay || '0s'; // Get custom delay from HTML.
                    entry.target.style.setProperty('--animation-delay', delay); // Apply it.
                    entry.target.classList.add('is-visible'); // Add class to trigger CSS animation.
                    observer.unobserve(entry.target); // Animate only once, then stop watching.
                }
            });
        }, observerOptions);
        animatedElements.forEach(el => animationObserver.observe(el)); // Start watching each element.
    } else {
        // If IntersectionObserver isn't supported, or no elements to animate,
        // just make them all visible so content isn't hidden.
        animatedElements.forEach(el => el.classList.add('is-visible'));
        if (animatedElements.length > 0 && !('IntersectionObserver' in window)) {
            console.warn("IntersectionObserver API not supported. Scroll animations will use a fallback (elements shown immediately).");
        }
    }

    console.log("openSUSE-themed UI scripts initialized! Happy Tumbleweeding! 🦎");

}); // End of DOMContentLoaded. Phew!