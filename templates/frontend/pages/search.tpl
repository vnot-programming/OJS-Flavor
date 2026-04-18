{**
 * templates/frontend/pages/search.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Search results page.
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated={translate key="common.search"}}

<div class="flavor-search">
	<h1 style="margin-bottom:var(--space-6)">{translate key="common.search"}</h1>

	{* Search Form *}
	<form class="flavor-search__form" method="post" action="{url op="search"}">
		{csrf}
		<div class="flavor-search__input-group">
			<input type="text" name="query" value="{$searchQuery|escape}" class="flavor-input" placeholder="{translate key="common.search"}..." aria-label="{translate key="common.search"}">
			<button type="submit" class="flavor-btn flavor-btn--primary">
				{translate key="common.search"}
			</button>
		</div>

		{* Filters *}
		<div class="flavor-search__filters">
			<div class="flavor-form-group">
				<label class="flavor-label" for="searchAuthors">{translate key="search.author"}</label>
				<input type="text" id="searchAuthors" name="authors" value="{$authors|escape}" class="flavor-input">
			</div>
			<div class="flavor-form-group">
				<label class="flavor-label" for="searchDateFrom">{translate key="search.dateFrom"}</label>
				<input type="date" id="searchDateFrom" name="dateFromYear" value="{$dateFromYear|escape}" class="flavor-input">
			</div>
			<div class="flavor-form-group">
				<label class="flavor-label" for="searchDateTo">{translate key="search.dateTo"}</label>
				<input type="date" id="searchDateTo" name="dateToYear" value="{$dateToYear|escape}" class="flavor-input">
			</div>
		</div>
	</form>

	{* Results *}
	{if $results && $results->getCount()}
		<div class="flavor-search__results">
			<p class="flavor-search__result-count">
				{translate key="search.searchResults" numResults=$results->getCount()}
			</p>
			{iterate from=results item=result}
				{include file="frontend/objects/article_summary.tpl" article=$result.publishedSubmission journal=$result.journal showDatePublished=true hideGalleys=false}
			{/iterate}
		</div>
	{elseif $searchQuery}
		<p class="text-secondary" style="margin-top:var(--space-6)">{translate key="search.noResults"}</p>
	{/if}
</div>

{include file="frontend/components/footer.tpl"}
