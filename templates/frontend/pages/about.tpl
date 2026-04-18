{**
 * templates/frontend/pages/about.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Display the journal's about page with rich-text support.
 *
 * @uses $currentContext Journal The current journal
 *}
{include file="frontend/components/header.tpl" pageTitle="about.aboutContext"}

<div class="flavor-about">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="about.aboutContext"}

	<div class="flavor-about__header">
		<h1 class="flavor-about__title">{translate key="about.aboutContext"}</h1>
	</div>

	{include file="frontend/components/editLink.tpl" page="management" op="settings" path="context" anchor="masthead" sectionTitleKey="about.aboutContext"}

	<div class="flavor-about__prose">
		{$currentContext->getLocalizedData('about')}
	</div>
</div>

{include file="frontend/components/footer.tpl"}
