{**
 * templates/frontend/pages/userLostPassword.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Lost password page — centered auth card with icon and proper styling.
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated={translate key="user.login.resetPassword"}}

<div class="flavor-auth__card">
	<a href="{url page="index"}" class="flavor-auth__back">
		<svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
			<line x1="19" y1="12" x2="5" y2="12"></line>
			<polyline points="12 19 5 12 12 5"></polyline>
		</svg>
		{translate key="navigation.home"}
	</a>
	<div class="flavor-auth__icon">
		<svg viewBox="0 0 24 24" width="28" height="28" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
			<rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
			<path d="M7 11V7a5 5 0 0 1 9.9-1"></path>
		</svg>
	</div>
	<h1 class="flavor-auth__title">{translate key="user.login.resetPassword"}</h1>
	<p class="flavor-auth__subtitle">{translate key="plugins.themes.flavor.lostPassword.subtitle"}</p>

	{* Display any notifications/errors *}
	{if $error}
		<div class="flavor-auth__error">
			{translate key=$error}
		</div>
	{/if}

	<form method="post" action="{url page="login" op="requestResetPassword"}" role="form">
		{csrf}

		<div class="flavor-form-group">
			<label class="flavor-label" for="email">
				{translate key="user.login.registeredEmail"}
				<span class="flavor-label__required" aria-hidden="true">*</span>
			</label>
			<input type="email" name="email" id="email" class="flavor-input" required
				autocomplete="email"
				placeholder="{translate key="user.login.registeredEmail"}">
		</div>

		<div class="flavor-form-actions">
			<button type="submit" class="flavor-btn flavor-btn--primary" style="width:100%">
				{translate key="user.login.resetPassword"}
			</button>
		</div>
	</form>

	<div class="flavor-auth__footer">
		<a href="{url page="login"}">{translate key="user.login"}</a>
		{if !$disableUserReg}
			&nbsp;·&nbsp;
			<a href="{url page="user" op="register"}">{translate key="user.login.registerNewAccount"}</a>
		{/if}
	</div>
</div>

{include file="frontend/components/footer.tpl"}
