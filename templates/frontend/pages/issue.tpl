{**
 * templates/frontend/pages/issue.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Display a landing page for a single issue (current or specific).
 *  Shows the table of contents or an empty state message.
 *
 * @uses $issue Issue The issue
 * @uses $issueIdentification string Label for this issue
 * @uses $issueGalleys array Galleys for the entire issue
 * @uses $publishedSubmissions array Articles grouped by section
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$issueIdentification}

<div class="flavor-page-issue">

	{* ═══ No Current Issue (Empty State) ═══ *}
	{if !$issue}
		{include file="frontend/components/breadcrumbs_issue.tpl" currentTitleKey="current.noCurrentIssue"}

		<div class="flavor-page-issue__empty">
			<div class="flavor-page-issue__empty-icon">
				<svg viewBox="0 0 24 24" width="56" height="56" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
					<path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
					<polyline points="14 2 14 8 20 8"/>
					<line x1="9" y1="15" x2="15" y2="15"/>
				</svg>
			</div>
			<h1 class="flavor-page-issue__empty-title">{translate key="current.noCurrentIssue"}</h1>
			<p class="flavor-page-issue__empty-desc">{translate key="current.noCurrentIssueDesc"}</p>
			<a href="{url page="issue" op="archive"}" class="flavor-btn flavor-btn--secondary">
				{translate key="navigation.archives"}
			</a>
		</div>

	{* ═══ Current Issue with TOC ═══ *}
	{else}
		{include file="frontend/components/breadcrumbs_issue.tpl" currentTitle=$issueIdentification}

		<div class="flavor-page-issue__header">
			<h1 class="flavor-page-issue__title">{$issueIdentification|escape}</h1>
			{if $issue->getDatePublished()}
				<div class="flavor-page-issue__meta">
					<time datetime="{$issue->getDatePublished()|date_format:"%Y-%m-%d"}">
						{translate key="submissions.published"}: {$issue->getDatePublished()|date_format:$dateFormatLong}
					</time>
				</div>
			{/if}
		</div>

		{* Issue Cover & Description *}
		{assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}
		{if $issueCover || $issue->hasDescription()}
			<div class="flavor-page-issue__intro">
				{if $issueCover}
					<div class="flavor-page-issue__cover">
						<img src="{$issueCover|escape}" alt="{$issue->getLocalizedCoverImageAltText()|escape|default:''}">
					</div>
				{/if}
				{if $issue->hasDescription()}
					<div class="flavor-page-issue__description flavor-prose">
						{$issue->getLocalizedDescription()|strip_unsafe_html}
					</div>
				{/if}
			</div>
		{/if}

		{* Full-issue Galleys *}
		{if $issueGalleys}
			<div class="flavor-page-issue__galleys">
				<h3 class="flavor-page-issue__galleys-label">{translate key="issue.fullIssue"}</h3>
				<div class="flavor-page-issue__galleys-list">
					{foreach from=$issueGalleys item=galley}
						{include file="frontend/objects/galley_link.tpl" parent=$issue purchaseFee=$currentJournal->getData('purchaseIssueFee') purchaseCurrency=$currentJournal->getData('currency')}
					{/foreach}
				</div>
			</div>
		{/if}

		{* Articles by Section *}
		{foreach name=sections from=$publishedSubmissions item=section}
			{if $section.articles}
				<section class="flavor-page-issue__section">
					{if $section.title}
						<div class="flavor-page-issue__section-header">
							<h2 class="flavor-page-issue__section-title">{$section.title|escape}</h2>
							<span class="flavor-page-issue__section-count">{$section.articles|@count} {if $section.articles|@count == 1}article{else}articles{/if}</span>
						</div>
					{/if}
					<div class="flavor-page-issue__articles">
						{foreach from=$section.articles item=article}
							{include file="frontend/objects/article_summary.tpl"}
						{/foreach}
					</div>
				</section>
			{/if}
		{/foreach}

	{/if}

</div>

{include file="frontend/components/footer.tpl"}
