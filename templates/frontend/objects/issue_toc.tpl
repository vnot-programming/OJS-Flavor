{**
 * templates/frontend/objects/issue_toc.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Issue table of contents.
 *}
{if !$heading}
	{assign var="heading" value="h2"}
{/if}
{assign var="articleHeading" value="h3"}
{if $heading == "h3"}
	{assign var="articleHeading" value="h4"}
{elseif $heading == "h4"}
	{assign var="articleHeading" value="h5"}
{/if}

<div class="flavor-issue">

	{if !$issue->getPublished()}
		<div class="flavor-notice">
			{translate key="editor.issues.preview"}
		</div>
	{/if}

	{* Cover & Description *}
	{assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}
	{if $issueCover}
		<div class="flavor-issue__cover">
			<img src="{$issueCover|escape}" alt="{$issue->getLocalizedCoverImageAltText()|escape|default:''}">
		</div>
	{/if}

	{if $issue->hasDescription()}
		<div class="flavor-issue__description">
			{$issue->getLocalizedDescription()|strip_unsafe_html}
		</div>
	{/if}

	{if $issue->getDatePublished()}
		<div class="flavor-issue__date">
			<span class="font-semibold">{translate key="submissions.published"}:</span>
			{$issue->getDatePublished()|date_format:$dateFormatShort}
		</div>
	{/if}

	{* Full-issue Galleys *}
	{if $issueGalleys}
		<div class="flavor-issue__full-galleys">
			<h3 class="label-text" style="width:100%;margin-bottom:var(--space-2)">{translate key="issue.fullIssue"}</h3>
			{foreach from=$issueGalleys item=galley}
				{include file="frontend/objects/galley_link.tpl" parent=$issue purchaseFee=$currentJournal->getData('purchaseIssueFee') purchaseCurrency=$currentJournal->getData('currency')}
			{/foreach}
		</div>
	{/if}

	{* Articles by Section *}
	{foreach name=sections from=$publishedSubmissions item=section}
		{if $section.articles}
			<div class="flavor-issue-section">
				{if $section.title}
					<h3 class="flavor-issue-section__title">{$section.title|escape}</h3>
				{/if}
				{foreach from=$section.articles item=article}
					{include file="frontend/objects/article_summary.tpl" heading=$articleHeading}
				{/foreach}
			</div>
		{/if}
	{/foreach}

</div>
