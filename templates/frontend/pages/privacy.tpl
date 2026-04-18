{**
 * templates/frontend/pages/privacy.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Display the journal's privacy statement.
 *
 * @uses $currentContext Journal The current journal
 * @uses $privacyStatement string The privacy statement content
 *}
{include file="frontend/components/header.tpl" pageTitle="manager.setup.privacyStatement"}

<div class="flavor-about">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="manager.setup.privacyStatement"}

	<div class="flavor-about__header">
		<h1 class="flavor-about__title">{translate key="manager.setup.privacyStatement"}</h1>
		<p class="flavor-about__subtitle">{translate key="about.aboutContext"}</p>
	</div>

	<div class="flavor-about__prose">
		{$privacyStatement}
	</div>
</div>

{include file="frontend/components/footer.tpl"}
