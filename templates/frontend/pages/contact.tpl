{**
 * templates/frontend/pages/contact.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Display journal contact information with card layout.
 *
 * @uses $currentContext Journal The current journal
 * @uses $mailingAddress string Mailing address
 * @uses $contactName string Primary contact name
 * @uses $contactTitle string Primary contact title
 * @uses $contactAffiliation string Primary contact affiliation
 * @uses $contactPhone string Primary contact phone
 * @uses $contactEmail string Primary contact email
 * @uses $supportName string Support contact name
 * @uses $supportPhone string Support contact phone
 * @uses $supportEmail string Support contact email
 *}
{include file="frontend/components/header.tpl" pageTitle="about.contact"}

<div class="flavor-about">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="about.contact"}

	<div class="flavor-about__header">
		<h1 class="flavor-about__title">{translate key="about.contact"}</h1>
	</div>

	{include file="frontend/components/editLink.tpl" page="management" op="settings" path="context" anchor="contact" sectionTitleKey="about.contact"}

	{* ── Mailing Address ── *}
	{if $mailingAddress}
		<div class="flavor-about__address">
			<div class="flavor-about__address-label">
				<svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
					<path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
					<circle cx="12" cy="10" r="3"></circle>
				</svg>
				{translate key="common.mailingAddress"}
			</div>
			<address>
				{$mailingAddress|nl2br|strip_unsafe_html}
			</address>
		</div>
	{/if}

	{* ── Contact Cards Grid ── *}
	<div class="flavor-about__contact-grid">

		{* Primary Contact *}
		{if $contactTitle || $contactName || $contactAffiliation || $contactPhone || $contactEmail}
			<div class="flavor-about__contact-card">
				<div class="flavor-about__contact-label">
					<svg viewBox="0 0 24 24" width="12" height="12" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
						<path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
						<circle cx="12" cy="7" r="4"></circle>
					</svg>
					{translate key="about.contact.principalContact"}
				</div>
				{if $contactName}
					<div class="flavor-about__contact-name">{$contactName|escape}</div>
				{/if}
				{if $contactTitle}
					<div class="flavor-about__contact-title">{$contactTitle|escape}</div>
				{/if}
				{if $contactAffiliation}
					<div class="flavor-about__contact-affiliation">{$contactAffiliation|strip_unsafe_html}</div>
				{/if}
				{if $contactPhone}
					<div class="flavor-about__contact-detail">
						<svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
							<path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
						</svg>
						{$contactPhone|escape}
					</div>
				{/if}
				{if $contactEmail}
					<div class="flavor-about__contact-detail">
						<svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
							<path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
							<polyline points="22,6 12,13 2,6"></polyline>
						</svg>
						{mailto address=$contactEmail encode='javascript'}
					</div>
				{/if}
			</div>
		{/if}

		{* Support Contact *}
		{if $supportName || $supportPhone || $supportEmail}
			<div class="flavor-about__contact-card">
				<div class="flavor-about__contact-label">
					<svg viewBox="0 0 24 24" width="12" height="12" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
						<circle cx="12" cy="12" r="10"></circle>
						<path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"></path>
						<line x1="12" y1="17" x2="12.01" y2="17"></line>
					</svg>
					{translate key="about.contact.supportContact"}
				</div>
				{if $supportName}
					<div class="flavor-about__contact-name">{$supportName|escape}</div>
				{/if}
				{if $supportPhone}
					<div class="flavor-about__contact-detail">
						<svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
							<path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
						</svg>
						{$supportPhone|escape}
					</div>
				{/if}
				{if $supportEmail}
					<div class="flavor-about__contact-detail">
						<svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
							<path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
							<polyline points="22,6 12,13 2,6"></polyline>
						</svg>
						{mailto address=$supportEmail encode='javascript'}
					</div>
				{/if}
			</div>
		{/if}

	</div>
</div>

{include file="frontend/components/footer.tpl"}
