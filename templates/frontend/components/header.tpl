{**
 * templates/frontend/components/header.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Common frontend site header — Glassmorphism sticky header.
 *}
{strip}
	{assign var="showingLogo" value=true}
	{if !$displayPageHeaderLogo}
		{assign var="showingLogo" value=false}
	{/if}
{/strip}
<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}"
	data-accent="{$flavorAccent|default:'cyan'}">

{if !$pageTitleTranslated}
	{capture assign="pageTitleTranslated"}
		{translate key=$pageTitle}
	{/capture}
{/if}
{include file="frontend/components/headerHead.tpl"}

<body class="pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}{if $showingLogo} has_site_logo{/if}" dir="{$currentLocaleLangDir|escape|default:"ltr"}">

{if $requestedPage !== 'login' && $requestedPage !== 'user'}

	{* ═══ Glassmorphism Header ═══ *}
	<header class="flavor-header" role="banner">
		<div class="flavor-header__left">
			{* Mobile hamburger *}
			<button type="button" class="flavor-header__hamburger" data-mobile-open aria-label="Open navigation">
				<svg viewBox="0 0 24 24"><path d="M4 7h16M4 12h16M4 17h16"></path></svg>
			</button>
			{* Logo *}
			{include file="frontend/components/logo.tpl"}
		</div>

		{* Desktop primary nav *}
		<div class="flavor-header__center">
			{capture assign="primaryMenu"}
				{load_menu name="primary" id="navigationPrimary" ulClass="pkp_navigation_primary"}
			{/capture}
			{$primaryMenu}
		</div>

		{* Right side: search + dark mode + user nav *}
		<div class="flavor-header__right">
			{if $currentContext && $requestedPage !== 'search'}
				<a href="{url page="search"}" class="flavor-header__search" aria-label="Search">
					<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" width="16" height="16">
						<circle cx="11" cy="11" r="8"></circle>
						<line x1="21" y1="21" x2="16.65" y2="16.65"></line>
					</svg>
				</a>
			{/if}
			{include file="frontend/components/darkModeToggle.tpl"}
			<div class="flavor-user-nav flavor-hide-mobile">
				{load_menu name="user" id="navigationUser" ulClass="pkp_navigation_user" liClass="profile"}
			</div>
		</div>
	</header>

	{* ═══ Mobile Slide Panel ═══ *}
	<div class="flavor-mobile-panel" id="flavorMobilePanel">
		<div class="flavor-mobile-panel__content">
			<button type="button" class="flavor-mobile-panel__close" data-mobile-close aria-label="Close navigation">
				<svg viewBox="0 0 24 24"><path d="M5 5l14 14M19 5l-14 14"></path></svg>
			</button>
			<div class="flavor-nav-vertical">
				{$primaryMenu}
			</div>
			<hr style="border:none;border-top:1px solid var(--border);margin:var(--space-6) 0">
			<div class="flavor-nav-vertical">
				{load_menu name="user" id="navigationUserMobile" ulClass="pkp_navigation_user" liClass="profile"}
			</div>
			<hr style="border:none;border-top:1px solid var(--border);margin:var(--space-6) 0">
			{include file="frontend/components/sidebar.tpl"}
		</div>
	</div>

	{* ═══ Hero Section (only on journal homepage) ═══ *}
	{if $requestedPage == 'index' || $requestedPage == ''}
		{if $currentContext}
			{include file="frontend/components/headerSection.tpl"}
		{/if}
	{/if}

	{* ═══ Main Content Wrapper ═══ *}
	<main role="main" id="pkp_content_main">
		<div class="flavor-container" style="padding-top:var(--space-8);padding-bottom:var(--space-8)">
			<div class="flavor-layout">
				<div class="flavor-layout__content">

{else}
	{* Auth pages (login/register) — no header chrome *}
	<main class="flavor-auth" role="main">
		<a id="pkp_content_main"></a>
{/if}
