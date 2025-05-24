"use strict"; // Enforces stricter parsing and error handling in JavaScript.

// Wait for the DOM to be fully loaded before running any scripts.
document.addEventListener('DOMContentLoaded', () => {

    // --- DOM ELEMENT SELECTORS ---
    // Cache common DOM elements to avoid repeated lookups.
    const body = document.body;
    const siteHeader = document.getElementById('siteHeader');
    const themeSwitcher = document.getElementById('themeSwitcher');
    const sunIcon = themeSwitcher?.querySelector('.sun-icon'); // Optional chaining in case themeSwitcher is not found
    const moonIcon = themeSwitcher?.querySelector('.moon-icon');
    const mobileNavToggle = document.getElementById('mobileNavToggle');
    const mainNav = document.getElementById('mainNav');
    const pageOverlay = document.getElementById('pageOverlay');
    const scrollToTopBtn = document.getElementById('scrollToTopBtn');

    // --- THEME SWITCHER LOGIC ---
    // Handles switching between light and dark themes and persisting the choice.
    if (themeSwitcher && sunIcon && moonIcon) {
        const THEME_KEY = 'user-preferred-theme'; // Key for storing theme in localStorage.

        // Function to apply the selected theme to the page.
        const applyTheme = (theme) => {
            body.setAttribute('data-theme', theme); // Set data-theme attribute on body for CSS styling.
            localStorage.setItem(THEME_KEY, theme); // Save preference to localStorage.

            const isDarkMode = theme === 'dark';

            // Toggle visibility of sun/moon icons.
            sunIcon.style.display = isDarkMode ? 'none' : 'inline-block';
            moonIcon.style.display = isDarkMode ? 'inline-block' : 'none';

            // Update ARIA attributes for accessibility.
            themeSwitcher.setAttribute('aria-label', `Switch to ${isDarkMode ? 'light' : 'dark'} theme`);
            themeSwitcher.setAttribute('aria-pressed', isDarkMode.toString());

            // Update CSS custom property for --color-accent-primary-rgb based on theme.
            // This is used for rgba() colors that need the primary accent.
            const rootStyle = document.documentElement.style;
            if (isDarkMode) {
                // Dark theme primary accent: #00f5d4 (RGB: 0, 245, 212)
                rootStyle.setProperty('--color-accent-primary-rgb', '0, 245, 212');
            } else {
                // Light theme primary accent: #003aee (RGB: 0, 58, 238) - UPDATED
                rootStyle.setProperty('--color-accent-primary-rgb', '0, 58, 238');
            }
        };

        // Function to initialize the theme on page load.
        const initializeTheme = () => {
            let preferredTheme = localStorage.getItem(THEME_KEY);
            if (!preferredTheme) {
                // If no preference stored, use system preference.
                preferredTheme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
            }
            applyTheme(preferredTheme);
        };

        initializeTheme(); // Set initial theme.

        // Event listener for the theme switcher button.
        themeSwitcher.addEventListener('click', () => {
            const currentTheme = body.getAttribute('data-theme');
            const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
            applyTheme(newTheme);
        });
    } else {
        console.warn("Theme switcher elements not found. Theme functionality may be impaired.");
    }

    // --- MOBILE NAVIGATION HANDLING ---
    // Manages the opening and closing of the mobile navigation menu.
    if (mobileNavToggle && mainNav && pageOverlay) {
        // Toggles the navigation state (open/closed).
        // Can be forced open/closed by passing a boolean to `forceOpen`.
        const toggleMobileNav = (forceOpen) => {
            const isOpen = typeof forceOpen === 'boolean' ? forceOpen : !mainNav.classList.contains('active');

            mainNav.classList.toggle('active', isOpen);
            mobileNavToggle.classList.toggle('active', isOpen); // For hamburger icon animation
            mobileNavToggle.setAttribute('aria-expanded', isOpen.toString());
            pageOverlay.classList.toggle('active', isOpen); // Show/hide overlay
            body.classList.toggle('no-scroll', isOpen); // Prevent body scroll when nav is open
        };

        // Event listener for mobile navigation toggle button.
        mobileNavToggle.addEventListener('click', () => toggleMobileNav());

        // Close mobile nav when a nav link is clicked (for anchor links).
        mainNav.querySelectorAll('a[href^="#"]').forEach(link => {
            link.addEventListener('click', () => {
                if (mainNav.classList.contains('active')) {
                    toggleMobileNav(false); // Force close
                }
            });
        });

        // Close mobile nav when the overlay is clicked.
        pageOverlay.addEventListener('click', () => {
            if (mainNav.classList.contains('active')) {
                 toggleMobileNav(false); // Force close
            }
        });

        // Close mobile nav when the 'Escape' key is pressed.
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && mainNav.classList.contains('active')) {
                toggleMobileNav(false); // Force close
            }
        });
    } else {
        console.warn("Mobile navigation elements not found. Mobile menu functionality may be impaired.");
    }

    // --- ACTIVE NAVIGATION LINK HIGHLIGHTING ON SCROLL ---
    // Highlights the current section's link in the navigation as the user scrolls.
    const navLinks = mainNav?.querySelectorAll('a[href^="#"]'); // Links in the main navigation
    const contentSections = document.querySelectorAll('main section[id]'); // Sections in main content with an ID

    if (navLinks && navLinks.length > 0 && contentSections && contentSections.length > 0 && siteHeader) {
        let scrollTimeout; // To debounce scroll events for performance
        const headerHeight = siteHeader.offsetHeight; // Height of the sticky header

        const highlightActiveLink = () => {
            // Determine current scroll position with an offset for the fixed header and a small buffer.
            // The buffer helps activate the link slightly before the section strictly hits the top.
            const scrollPosition = window.pageYOffset + headerHeight + 50; // 50px buffer
            let activeSectionId = null;

            // Find which section is currently in view.
            contentSections.forEach(section => {
                // Check if the scroll position is within the bounds of this section.
                if (scrollPosition >= section.offsetTop && scrollPosition < section.offsetTop + section.offsetHeight) {
                    activeSectionId = section.id;
                }
            });

            // Special case: If near the bottom of the page, and the last section is visible, make its link active.
            // This handles cases where the last section is too short to fill the viewport height.
            if ((window.innerHeight + window.pageYOffset) >= (document.body.offsetHeight - 5) && contentSections.length > 0) { // 5px buffer from bottom
                activeSectionId = contentSections[contentSections.length - 1].id;
            }

            // Update 'active' class on navigation links.
            navLinks.forEach(link => {
                // `link.hash` includes the '#', e.g., "#about"
                link.classList.toggle('active', link.hash === `#${activeSectionId}`);
            });
        };

        // Listen to scroll events, but debounce for performance.
        window.addEventListener('scroll', () => {
            clearTimeout(scrollTimeout);
            scrollTimeout = setTimeout(highlightActiveLink, 75); // Debounce by 75ms
        }, { passive: true }); // Use passive listener for scroll performance.

        highlightActiveLink(); // Initial call to set active link on page load/refresh.
    }

    // --- SMOOTH SCROLLING FOR ANCHOR LINKS (Considering Fixed Header) ---
    // Overrides default anchor link behavior for smoother scrolling and header offset.
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            const targetId = this.hash; // e.g., "#about"

            // Ensure targetId is not just "#" (empty hash) and an element with that ID exists.
            if (targetId.length > 1 && document.querySelector(targetId)) {
                const targetElement = document.querySelector(targetId);
                if (targetElement && siteHeader) { // Ensure target and header exist
                    e.preventDefault(); // Prevent default jump
                    const headerOffset = siteHeader.offsetHeight; // Get current height of sticky header
                    const elementPosition = targetElement.getBoundingClientRect().top; // Position relative to viewport
                    const offsetPosition = elementPosition + window.pageYOffset - headerOffset; // Calculate final scroll position

                    window.scrollTo({
                        top: offsetPosition,
                        behavior: 'smooth' // Smooth scroll animation
                    });
                }
            }
        });
    });

    // --- CODE BLOCK COPY FUNCTIONALITY ---
    // Adds a "Copy" button to each <pre> element inside a .code-block-wrapper.
    document.querySelectorAll('.code-block-wrapper pre').forEach(preElement => {
        const codeElement = preElement.querySelector('code');
        if (!codeElement) return; // Skip if no <code> tag found inside <pre>

        // Create the copy button
        const copyButton = document.createElement('button');
        copyButton.type = 'button'; // Good practice for buttons not submitting forms
        copyButton.classList.add('copy-button');
        copyButton.setAttribute('aria-label', 'Copy code to clipboard');
        copyButton.innerHTML = 'Copy <span class="icon" aria-hidden="true">📋</span>'; // Initial text with icon

        // Insert the button. It should be a sibling of <pre> if <pre> is wrapped.
        if (preElement.parentNode.classList.contains('code-block-wrapper')) {
            preElement.parentNode.appendChild(copyButton); // Append to wrapper
        } else {
            // Fallback: insert after <pre> if not directly wrapped as expected (less ideal structure)
            preElement.insertAdjacentElement('afterend', copyButton);
        }

        // Event listener for the copy button.
        copyButton.addEventListener('click', () => {
            navigator.clipboard.writeText(codeElement.innerText)
                .then(() => {
                    // Success: Update button text and style
                    copyButton.innerHTML = 'Copied! <span class="icon" aria-hidden="true">✅</span>';
                    copyButton.classList.add('copied');
                    // Revert button text after a delay
                    setTimeout(() => {
                        copyButton.innerHTML = 'Copy <span class="icon" aria-hidden="true">📋</span>';
                        copyButton.classList.remove('copied');
                    }, 2500); // Revert after 2.5 seconds
                })
                .catch(err => {
                    // Error: Log error and briefly show error message on button
                    console.error('Failed to copy code:', err);
                    copyButton.textContent = 'Error';
                    setTimeout(() => {
                        copyButton.innerHTML = 'Copy <span class="icon" aria-hidden="true">📋</span>';
                    }, 2500);
                });
        });
    });

    // --- DYNAMIC FOOTER YEAR ---
    // Automatically updates the copyright year in the footer.
    const yearSpan = document.getElementById('currentYear');
    if (yearSpan) {
        yearSpan.textContent = new Date().getFullYear();
    }

    // --- SCROLL TO TOP BUTTON VISIBILITY & FUNCTIONALITY ---
    // Shows/hides the "Scroll to Top" button and handles its click event.
    if (scrollToTopBtn) {
        // Toggles button visibility based on scroll position.
        const toggleScrollTopVisibility = () => {
            // Show button if scrolled more than 300px down.
            scrollToTopBtn.classList.toggle('visible', window.pageYOffset > 300);
        };

        window.addEventListener('scroll', toggleScrollTopVisibility, { passive: true });
        toggleScrollTopVisibility(); // Initial check on page load.

        // Event listener for scroll to top button click.
        scrollToTopBtn.addEventListener('click', () => {
            window.scrollTo({ top: 0, behavior: 'smooth' }); // Smooth scroll to top
        });
    }

    // --- INTERSECTION OBSERVER FOR SCROLL ANIMATIONS ---
    // Animates elements into view as they are scrolled to.
    const animatedElements = document.querySelectorAll('.animate-on-scroll');
    if (animatedElements.length > 0 && 'IntersectionObserver' in window) {
        const observerOptions = {
            root: null, // Observe against the viewport.
            rootMargin: '0px', // No margin around the root.
            threshold: 0.15 // Trigger when 15% of the element is visible.
        };

        const animationObserver = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) { // If the element is in view
                    const delay = entry.target.dataset.animationDelay || '0s'; // Get delay from data-attribute
                    entry.target.style.transitionDelay = delay; // Apply delay
                    entry.target.classList.add('is-visible'); // Add class to trigger animation
                    observer.unobserve(entry.target); // Stop observing once animated (animate only once).
                }
            });
        }, observerOptions);

        animatedElements.forEach(el => animationObserver.observe(el)); // Start observing each animated element.
    } else {
        // Fallback for browsers without IntersectionObserver or if no elements to animate.
        // Simply make all elements visible immediately.
        animatedElements.forEach(el => el.classList.add('is-visible'));
    }

}); // End of DOMContentLoaded