/**
 * @file plugins/themes/flavor/js/main.js
 *
 * Copyright (c) 2026 Flavor Theme
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Flavor theme — Dark mode toggle & mobile panel.
 */

(function () {
    'use strict';

    /* ── Dark Mode ────────────────────────────────────────────────── */

    const STORAGE_KEY = 'flavor-dark-mode';
    const html = document.documentElement;

    function applyTheme(mode) {
        if (mode === 'dark') {
            html.classList.add('dark');
        } else if (mode === 'light') {
            html.classList.remove('dark');
        } else {
            // system
            if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
                html.classList.add('dark');
            } else {
                html.classList.remove('dark');
            }
        }
    }

    function getStoredMode() {
        return localStorage.getItem(STORAGE_KEY) || 'system';
    }

    function setMode(mode) {
        localStorage.setItem(STORAGE_KEY, mode);
        applyTheme(mode);
        updateToggleIcons(mode);
    }

    function updateToggleIcons(mode) {
        document.querySelectorAll('[data-theme-toggle]').forEach(function (btn) {
            var iconLight = btn.querySelector('[data-icon="light"]');
            var iconDark = btn.querySelector('[data-icon="dark"]');
            if (iconLight && iconDark) {
                if (mode === 'dark' || (mode === 'system' && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
                    iconLight.style.display = 'none';
                    iconDark.style.display = 'block';
                } else {
                    iconLight.style.display = 'block';
                    iconDark.style.display = 'none';
                }
            }
        });
    }

    // Apply on load (before paint if possible)
    applyTheme(getStoredMode());

    document.addEventListener('DOMContentLoaded', function () {
        var mode = getStoredMode();
        updateToggleIcons(mode);

        // Toggle button click
        document.querySelectorAll('[data-theme-toggle]').forEach(function (btn) {
            btn.addEventListener('click', function () {
                var current = getStoredMode();
                var next = current === 'dark' ? 'light' : 'dark';
                setMode(next);
            });
        });

        // System preference change
        window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', function () {
            if (getStoredMode() === 'system') {
                applyTheme('system');
                updateToggleIcons('system');
            }
        });

        /* ── Mobile Panel ─────────────────────────────────────────── */

        document.querySelectorAll('[data-mobile-open]').forEach(function (btn) {
            btn.addEventListener('click', function () {
                var panel = document.getElementById('flavorMobilePanel');
                if (panel) {
                    panel.classList.add('is-open');
                    document.body.style.overflow = 'hidden';
                }
            });
        });

        document.querySelectorAll('[data-mobile-close]').forEach(function (btn) {
            btn.addEventListener('click', function () {
                var panel = document.getElementById('flavorMobilePanel');
                if (panel) {
                    panel.classList.remove('is-open');
                    document.body.style.overflow = '';
                }
            });
        });

        // Close on backdrop click
        var panel = document.getElementById('flavorMobilePanel');
        if (panel) {
            panel.addEventListener('click', function (e) {
                if (e.target === panel) {
                    panel.classList.remove('is-open');
                    document.body.style.overflow = '';
                }
            });
        }
    });
})();
