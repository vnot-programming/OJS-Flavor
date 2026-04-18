<?php

/**
 * @file plugins/themes/flavor/FlavorThemePlugin.php
 *
 * Copyright (c) 2026 Flavor Theme
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @class FlavorThemePlugin
 *
 * @brief Flavor — Bio-Digital Minimalism theme for OJS 3.5+
 *
 * A premium, human-centric theme designed for academic journals.
 * Implements circadian-sync interfaces, fluid typography,
 * glassmorphism, and cognitive-load optimization.
 */


namespace APP\plugins\themes\flavor;

use APP\core\Application;
use APP\file\PublicFileManager;
use PKP\config\Config;
use PKP\core\PKPSessionGuard;
use APP\template\TemplateManager;

class FlavorThemePlugin extends \PKP\plugins\ThemePlugin
{
    /**
     * @copydoc ThemePlugin::isActive()
     */
    public function isActive()
    {
        if (PKPSessionGuard::isSessionDisable()) {
            return true;
        }
        return parent::isActive();
    }

    /**
     * Initialize the theme's styles, scripts and hooks.
     */
    public function init()
    {
        /* -------------------------------------------------------
         * Theme Options
         * ----------------------------------------------------- */

        // Show journal description in hero
        $this->addOption('showDescriptionInJournalIndex', 'FieldOptions', [
            'label' => __('manager.setup.contextSummary'),
            'options' => [
                [
                    'value' => true,
                    'label' => __('plugins.themes.flavor.option.showDescriptionInJournalIndex.option'),
                ],
            ],
            'default' => false,
        ]);

        // Use homepage image as hero background
        $this->addOption('useHomepageImageAsHeader', 'FieldOptions', [
            'label' => __('plugins.themes.flavor.option.useHomepageImageAsHeader.label'),
            'description' => __('plugins.themes.flavor.option.useHomepageImageAsHeader.description'),
            'options' => [
                [
                    'value' => true,
                    'label' => __('plugins.themes.flavor.option.useHomepageImageAsHeader.option'),
                ],
            ],
            'default' => false,
        ]);

        // Accent color
        $this->addOption('accentColor', 'FieldOptions', [
            'type' => 'radio',
            'label' => __('plugins.themes.flavor.option.accentColor.label'),
            'description' => __('plugins.themes.flavor.option.accentColor.description'),
            'options' => [
                [
                    'value' => 'cyan',
                    'label' => 'Cyan',
                ],
                [
                    'value' => 'teal',
                    'label' => 'Teal',
                ],
                [
                    'value' => 'violet',
                    'label' => 'Violet',
                ],
                [
                    'value' => 'rose',
                    'label' => 'Rose',
                ],
                [
                    'value' => 'amber',
                    'label' => 'Amber',
                ],
            ],
            'default' => 'cyan',
        ]);

        /* -------------------------------------------------------
         * Template Manager Setup
         * ----------------------------------------------------- */
        $request = Application::get()->getRequest();
        $templateManager = TemplateManager::getManager($request);

        // Pass jQuery paths for OJS compatibility
        $min = Config::getVar('general', 'enable_minified') ? '.min' : '';
        $templateManager->assign('jquery', $request->getBaseUrl() . '/js/build/jquery/jquery' . $min . '.js');
        $templateManager->assign('jqueryUI', $request->getBaseUrl() . '/js/build/jquery-ui/jquery-ui' . $min . '.js');

        // Get accent color and pass to templates
        $accentColor = $this->getOption('accentColor') ?: 'cyan';
        $templateManager->assign('flavorAccent', $accentColor);

        // Homepage image handling
        $context = $request->getContext();
        if ($context) {
            if ($this->getOption('useHomepageImageAsHeader')) {
                if ($homepageImage = $context->getLocalizedData('homepageImage')) {
                    $publicFileManager = new PublicFileManager();
                    $publicFilesDir = $request->getBaseUrl() . '/' . $publicFileManager->getContextFilesPath($context->getId());
                    $homepageImageUrl = $publicFilesDir . '/' . $homepageImage['uploadName'];
                    $templateManager->assign('homepageImageUrl', $homepageImageUrl);
                }
            }
        }

        /* -------------------------------------------------------
         * Load Assets
         * ----------------------------------------------------- */

        // Load the main stylesheet (Vanilla CSS — no build step required)
        $this->addStyle('stylesheet', 'styles/main.css');

        // Load theme JavaScript
        $this->addScript('mainjs', 'js/main.js');

        /* -------------------------------------------------------
         * Navigation Menu Areas
         * ----------------------------------------------------- */
        $this->addMenuArea(['primary', 'user']);
    }

    /**
     * Get the name of the settings file to be installed on new journal
     * creation.
     *
     * @return string
     */
    public function getContextSpecificPluginSettingsFile()
    {
        return $this->getPluginPath() . '/settings.xml';
    }

    /**
     * Get the name of the settings file to be installed site-wide when
     * OJS is installed.
     *
     * @return string
     */
    public function getInstallSitePluginSettingsFile()
    {
        return $this->getPluginPath() . '/settings.xml';
    }

    /**
     * Get the display name of this plugin.
     *
     * @return string
     */
    public function getDisplayName()
    {
        return __('plugins.themes.flavor.name');
    }

    /**
     * Get the description of this plugin.
     *
     * @return string
     */
    public function getDescription()
    {
        return __('plugins.themes.flavor.description');
    }

    /**
     * Get the validated accent color key.
     *
     * @return string
     */
    public function getAccentColor()
    {
        $color = $this->getOption('accentColor');
        $valid = ['cyan', 'teal', 'violet', 'rose', 'amber'];
        return in_array($color, $valid) ? $color : 'cyan';
    }
}

if (!PKP_STRICT_MODE) {
    class_alias('\APP\plugins\themes\flavor\FlavorThemePlugin', '\FlavorThemePlugin');
}
