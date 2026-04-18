{**
 * templates/frontend/pages/userRegister.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief User registration page — full OJS form with Flavor styling.
 *
 * @uses $primaryLocale string The primary locale
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated={translate key="user.register"}}

{assign var="siteContextId" value=PKP\core\PKPApplication::SITE_CONTEXT_ID|intval}

<div class="flavor-auth__card flavor-auth__card--wide">
	<a href="{url page="index"}" class="flavor-auth__back">
		<svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
			<line x1="19" y1="12" x2="5" y2="12"></line>
			<polyline points="12 19 5 12 12 5"></polyline>
		</svg>
		{translate key="navigation.home"}
	</a>
	<div class="flavor-auth__icon">
		<svg viewBox="0 0 24 24" width="28" height="28" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
			<path d="M16 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
			<circle cx="8.5" cy="7" r="4"></circle>
			<line x1="20" y1="8" x2="20" y2="14"></line>
			<line x1="23" y1="11" x2="17" y2="11"></line>
		</svg>
	</div>
	<h1 class="flavor-auth__title">{translate key="user.register"}</h1>
	<p class="flavor-auth__subtitle">{translate key="plugins.themes.flavor.register.subtitle"}<br><small>{translate key="common.requiredField"}</small></p>

	<form class="flavor-register-form" id="register" method="post" action="{url op="register"}" role="form">
		{if $orcidEnabled}
			{include file="form/orcidProfile.tpl"}
		{/if}

		{csrf}

		{if $source}
			<input type="hidden" name="source" value="{$source|escape}" />
		{/if}

		{include file="common/formErrors.tpl"}

		{include file="frontend/components/registrationForm.tpl"}

		{* ── Context-specific fields (journal registration) ── *}
		{if $currentContext}

			{* Privacy consent + email optin *}
			<fieldset class="flavor-auth__fieldset">
				{if $currentContext->getData('privacyStatement')}
					<div class="flavor-checkbox-group flavor-form-group">
						<input type="checkbox" name="privacyConsent" id="privacyConsent" value="1"{if $privacyConsent} checked="checked"{/if}>
						<label for="privacyConsent">
							{capture assign="privacyUrl"}{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="privacy"}{/capture}
							{translate key="user.register.form.privacyConsent" privacyUrl=$privacyUrl}
						</label>
					</div>
				{/if}
				<div class="flavor-checkbox-group flavor-form-group">
					<input type="checkbox" name="emailConsent" id="emailConsent" value="1"{if $emailConsent} checked="checked"{/if}>
					<label for="emailConsent">{translate key="user.register.form.emailConsent"}</label>
				</div>
			</fieldset>

			{* Reviewer registration *}
			{assign var=contextId value=$currentContext->getId()}
			{assign var=userCanRegisterReviewer value=0}
			{foreach from=$reviewerUserGroups[$contextId] item=userGroup}
				{if $userGroup->permitSelfRegistration}
					{assign var=userCanRegisterReviewer value=$userCanRegisterReviewer+1}
				{/if}
			{/foreach}
			{if $userCanRegisterReviewer}
				<fieldset class="flavor-auth__fieldset">
					<legend class="flavor-auth__fieldset-legend">
						{translate key="user.reviewerPrompt"}
					</legend>
					{if $userCanRegisterReviewer > 1}
						{capture assign="checkboxLocaleKey"}user.reviewerPrompt.userGroup{/capture}
					{else}
						{capture assign="checkboxLocaleKey"}user.reviewerPrompt.optin{/capture}
					{/if}
					{foreach from=$reviewerUserGroups[$contextId] item=userGroup}
						{if $userGroup->permitSelfRegistration}
							<div class="flavor-checkbox-group flavor-form-group">
								{assign var="userGroupId" value=$userGroup->id}
								<input type="checkbox" name="reviewerGroup[{$userGroupId}]" id="reviewerGroup_{$userGroupId}" value="1"{if in_array($userGroupId, $userGroupIds)} checked="checked"{/if}>
								<label for="reviewerGroup_{$userGroupId}">{translate key=$checkboxLocaleKey userGroup=$userGroup->getLocalizedData('name')}</label>
							</div>
						{/if}
					{/foreach}
					<div class="flavor-form-group">
						<label class="flavor-label" for="interests">{translate key="user.interests"}</label>
						<input type="text" name="interests" id="interests" value="{$interests|default:""|escape}" class="flavor-input">
					</div>
				</fieldset>
			{/if}
		{/if}

		{include file="frontend/components/registrationFormContexts.tpl"}

		{* ── Non-context registration fields ── *}
		{if !$currentContext}
			<div class="flavor-form-group">
				<label class="flavor-label" for="interests">{translate key="user.register.noContextReviewerInterests"}</label>
				<input type="text" name="interests" id="interests" value="{$interests|default:""|escape}" class="flavor-input">
			</div>

			{if $siteWidePrivacyStatement}
				<div class="flavor-checkbox-group flavor-form-group">
					<input type="checkbox" name="privacyConsent[{$siteContextId}]" id="privacyConsent_{$siteContextId}" value="1"{if $privacyConsent[$siteContextId]} checked="checked"{/if}>
					<label for="privacyConsent_{$siteContextId}">
						{capture assign="privacyUrl"}{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="privacy"}{/capture}
						{translate key="user.register.form.privacyConsent" privacyUrl=$privacyUrl}
					</label>
				</div>
			{/if}

			<div class="flavor-checkbox-group flavor-form-group">
				<input type="checkbox" name="emailConsent" id="emailConsent" value="1"{if $emailConsent} checked="checked"{/if}>
				<label for="emailConsent">{translate key="user.register.form.emailConsent"}</label>
			</div>
		{/if}

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

		<div class="flavor-form-actions" style="flex-direction:column;gap:var(--space-4)">
			<button type="submit" class="flavor-btn flavor-btn--primary" style="width:100%">
				{translate key="user.register"}
			</button>
		</div>
	</form>

	<div class="flavor-auth__footer">
		{translate key="plugins.themes.flavor.register.alreadyHaveAccount"}
		{capture assign=rolesProfileUrl}{url page="user" op="profile" path="roles"}{/capture}
		<a href="{url page="login" source=$rolesProfileUrl}">{translate key="user.login"}</a>
	</div>
</div>

{include file="frontend/components/footer.tpl"}
