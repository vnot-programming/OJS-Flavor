{**
 * templates/frontend/pages/userRegisterComplete.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Registration complete page.
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated={translate key="user.login.registrationComplete"}}

<div class="flavor-auth__card" style="text-align:center">
	<h1 class="flavor-auth__title">{translate key="user.login.registrationComplete"}</h1>
	<p class="text-secondary" style="margin:var(--space-4) 0 var(--space-6)">
		{translate key="user.login.registrationComplete.instructions"}
	</p>
	<a href="{url page="index"}" class="flavor-btn flavor-btn--primary">
		{translate key="common.homepageNavigationLabel"}
	</a>
</div>

{include file="frontend/components/footer.tpl"}
