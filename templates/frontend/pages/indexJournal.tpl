{**
 * templates/frontend/pages/indexJournal.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Journal homepage with latest issue.
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

<div class="flavor-journal-content">

	{call_hook name="Templates::Index::journal"}

	{if !$activeTheme->getOption('useHomepageImageAsHeader') && $homepageImage}
		<div style="margin-bottom:var(--space-8)">
			<img src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}"
				{if $homepageImage.altText} alt="{$homepageImage.altText|escape}"{/if}
				style="border-radius:var(--radius-xl);max-width:100%">
		</div>
	{/if}

	{if $activeTheme->getOption('showDescriptionInJournalIndex')}
		<section class="flavor-section">
			<h2 class="flavor-section__heading">{translate key="about.aboutContext"}</h2>
			<div class="flavor-prose">
				{$currentContext->getLocalizedData('description')}
			</div>
		</section>
	{/if}

	{include file="frontend/objects/announcements_list.tpl" numAnnouncements=$numAnnouncementsHomepage}

	{if $issue}
		<section class="flavor-section">
			<h2 class="flavor-section__heading">{translate key="journal.currentIssue"}</h2>
			<p class="flavor-section__subheading">
				{$issue->getIssueIdentification()|strip_unsafe_html}
			</p>
			{include file="frontend/objects/issue_toc.tpl" heading="h3"}
			<a href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive"}" class="flavor-btn flavor-btn--secondary" style="margin-top:var(--space-6)">
				{translate key="journal.viewAllIssues"}
			</a>
		</section>
	{/if}

	{if $additionalHomeContent}
		<section class="flavor-section">
			<div class="flavor-prose">{$additionalHomeContent}</div>
		</section>
	{/if}
</div>

{include file="frontend/components/footer.tpl"}
