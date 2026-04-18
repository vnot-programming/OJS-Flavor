{**
 * templates/frontend/pages/message.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Generic message page — Bio-Digital Minimalism auth card style.
 * Used for: password reset confirmation, account activation, etc.
 *}
{include file="frontend/components/header.tpl"}

<div class="flavor-auth__card">
	<a href="{url page="index"}" class="flavor-auth__back">
		<svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
			<line x1="19" y1="12" x2="5" y2="12"></line>
			<polyline points="12 19 5 12 12 5"></polyline>
		</svg>
		{translate key="navigation.home"}
	</a>

	{* ── Icon: success checkmark ── *}
	<div class="flavor-auth__icon flavor-auth__icon--success">
		<svg viewBox="0 0 24 24" width="28" height="28" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
			<path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
			<polyline points="22 4 12 14.01 9 11.01"></polyline>
		</svg>
	</div>

	{* ── Title ── *}
	<h1 class="flavor-auth__title">{translate key=$pageTitle}</h1>

	{* ── Message Body ── *}
	<p class="flavor-auth__message">
		{if $messageTranslated}
			{$messageTranslated}
		{else}
			{translate key=$message}
		{/if}
	</p>

	{* ── Back Link ── *}
	{if $backLink}
		<div class="flavor-form-actions" style="margin-top:var(--space-6)">
			<a href="{$backLink}" class="flavor-btn flavor-btn--primary" style="width:100%;text-align:center">
				{translate key=$backLinkLabel}
			</a>
		</div>
	{/if}
</div>

{include file="frontend/components/footer.tpl"}
