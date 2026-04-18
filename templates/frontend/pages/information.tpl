{**
 * templates/frontend/pages/information.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Information page.
 *
 *}
{if !$contentOnly}
	{include file="frontend/components/header.tpl" pageTitle=$pageTitle}
{/if}

<div class="flavor-about page_information">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey=$pageTitle}

	<div class="flavor-about__header">
		<h1 class="flavor-about__title">{translate key=$pageTitle}</h1>
	</div>

	{include file="frontend/components/editLink.tpl" page="management" op="settings" path="website" anchor="setup/information" sectionTitleKey="manager.website.information"}

	<div class="flavor-about__prose">
		{$content}
	</div>
</div>

{if !$contentOnly}
	{include file="frontend/components/footer.tpl"}
{/if}
