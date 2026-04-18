{**
 * templates/frontend/components/breadcrumbs.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Breadcrumb navigation with chevron separators.
 *}
<nav class="flavor-breadcrumbs" role="navigation" aria-label="{translate key="navigation.breadcrumbLabel"}">
	<a href="{url page="index" router=\PKP\core\PKPApplication::ROUTE_PAGE}">
		{if $currentContext}{$currentContext->getLocalizedData('name')|escape}{else}{translate key="common.homepageNavigationLabel"}{/if}
	</a>
	{if $requestedPage}
		<span class="flavor-breadcrumbs__separator" aria-hidden="true">
			<svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M9 5l7 7-7 7"/></svg>
		</span>
		<span class="flavor-breadcrumbs__current" aria-current="page">{$pageTitleTranslated|escape}</span>
	{/if}
</nav>
