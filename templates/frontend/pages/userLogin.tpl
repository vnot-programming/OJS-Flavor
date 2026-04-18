{**
 * templates/frontend/pages/userLogin.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Login page — centered auth card with full OJS compatibility.
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated={translate key="user.login"}}

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
			<path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"></path>
			<polyline points="10 17 15 12 10 7"></polyline>
			<line x1="15" y1="12" x2="3" y2="12"></line>
		</svg>
	</div>
	<h1 class="flavor-auth__title">{translate key="user.login"}</h1>
	<p class="flavor-auth__subtitle">{translate key="plugins.themes.flavor.login.subtitle"}</p>

	{* Login errors *}
	{if $loginMessage}
		<div class="flavor-auth__error">
			{translate key=$loginMessage}
		</div>
	{/if}
	{if $error}
		<div class="flavor-auth__error">
			{translate key=$error reason=$reason}
		</div>
	{/if}

	<form method="post" action="{$loginUrl}" role="form">
		{csrf}
		<input type="hidden" name="source" value="{$source|default:""|escape}" />

		<div class="flavor-form-group">
			<label class="flavor-label" for="username">
				{translate key="user.usernameOrEmail"}
				<span class="flavor-label__required" aria-hidden="true">*</span>
			</label>
			<input type="text" name="username" id="username" value="{$username|default:""|escape}"
				class="flavor-input" required autocomplete="username"
				placeholder="{translate key="user.usernameOrEmail"}">
		</div>

		<div class="flavor-form-group">
			<label class="flavor-label" for="password">
				{translate key="user.password"}
				<span class="flavor-label__required" aria-hidden="true">*</span>
			</label>
			<input type="password" name="password" id="password"
				class="flavor-input" required autocomplete="current-password"
				placeholder="{translate key="user.password"}" maxlength="32">
		</div>

		<div class="flavor-form-group">
			<div class="flavor-checkbox-group">
				<input type="checkbox" name="remember" id="remember" value="1">
				<label for="remember" class="text-sm text-secondary">{translate key="user.login.rememberUsernameAndPassword"}</label>
			</div>
		</div>

		{* reCAPTCHA *}
		{if $recaptchaPublicKey}
			<div class="flavor-form-group">
				<div class="g-recaptcha" data-sitekey="{$recaptchaPublicKey|escape}"></div>
				<label for="g-recaptcha-response" style="display:none;" hidden>Recaptcha response</label>
			</div>
		{/if}

		{* Altcha *}
		{if $altchaEnabled}
			<div class="flavor-form-group">
				<altcha-widget challengejson='{$altchaChallenge|@json_encode}' floating></altcha-widget>
			</div>
		{/if}

		<div class="flavor-form-actions">
			<button type="submit" class="flavor-btn flavor-btn--primary" style="width:100%">
				{translate key="user.login"}
			</button>
		</div>
	</form>

	<div class="flavor-auth__footer">
		<a href="{url page="login" op="lostPassword"}">{translate key="user.login.forgotPassword"}</a>
		{if !$disableUserReg}
			&nbsp;·&nbsp;
			<a href="{url page="user" op="register" source=$source}">{translate key="user.login.registerNewAccount"}</a>
		{/if}
	</div>
</div>

{include file="frontend/components/footer.tpl"}
