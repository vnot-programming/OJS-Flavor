{**
 * templates/frontend/pages/issueArchive.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Issue archive page — grid of past issues with proper empty state.
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated={translate key="archive.archives"}}

<div class="flavor-archive">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="archive.archives"}

	<div class="flavor-about__header">
		<h1 class="flavor-about__title">{translate key="archive.archives"}</h1>
	</div>

	{if $issues|@count}
		<div class="flavor-archive__grid">
			{foreach from=$issues item=issue}
				{include file="frontend/objects/issue_summary.tpl"}
			{/foreach}
		</div>

		{* Pagination *}
		{if $prevPage > 0}
			{capture assign=prevUrl}{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive" path=$prevPage}{/capture}
		{/if}
		{if $nextPage}
			{capture assign=nextUrl}{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive" path=$nextPage}{/capture}
		{/if}
		{if $prevUrl || $nextUrl}
			<nav class="flavor-archive__pagination" role="navigation" aria-label="Pagination">
				{if $prevUrl}
					<a href="{$prevUrl}" class="flavor-btn flavor-btn--secondary flavor-btn--sm">
						<svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M15 18l-6-6 6-6"/></svg>
						{translate key="navigation.previousPage"}
					</a>
				{/if}
				{if $nextUrl}
					<a href="{$nextUrl}" class="flavor-btn flavor-btn--secondary flavor-btn--sm" style="margin-left:auto">
						{translate key="navigation.nextPage"}
						<svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M9 18l6-6-6-6"/></svg>
					</a>
				{/if}
			</nav>
		{/if}
	{else}
		<div class="flavor-page-issue__empty">
			<div class="flavor-page-issue__empty-icon">
				<svg viewBox="0 0 24 24" width="32" height="32" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
					<path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"></path>
					<path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"></path>
				</svg>
			</div>
			<div class="flavor-page-issue__empty-title">{translate key="archive.archives"}</div>
			<div class="flavor-page-issue__empty-desc">{translate key="current.noCurrentIssueDesc"}</div>
		</div>
	{/if}
</div>

{include file="frontend/components/footer.tpl"}
