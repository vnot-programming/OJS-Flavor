{**
 * templates/frontend/components/breadcrumbs_issue.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Breadcrumb navigation for issue pages (Home → Archives → Current).
 *}
<nav class="flavor-breadcrumbs" role="navigation" aria-label="{translate key="navigation.breadcrumbLabel"}">
	<a href="{url page="index" router=\PKP\core\PKPApplication::ROUTE_PAGE}">
		{if $currentContext}{$currentContext->getLocalizedData('name')|escape}{else}{translate key="common.homepageNavigationLabel"}{/if}
	</a>
	<span class="flavor-breadcrumbs__separator" aria-hidden="true">
		<svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M9 5l7 7-7 7"/></svg>
	</span>
	<a href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive"}">
		{translate key="navigation.archives"}
	</a>
	<span class="flavor-breadcrumbs__separator" aria-hidden="true">
		<svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M9 5l7 7-7 7"/></svg>
	</span>
	<span class="flavor-breadcrumbs__current" aria-current="page">
		{if $currentTitleKey}
			{translate key=$currentTitleKey}
		{else}
			{$currentTitle|escape}
		{/if}
	</span>
</nav>
