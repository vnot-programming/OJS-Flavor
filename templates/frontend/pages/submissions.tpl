{**
 * templates/frontend/pages/submissions.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Display submission guidelines and checklist.
 *
 * @uses $currentContext Journal The current journal
 * @uses $submissionChecklist array List of requirements
 * @uses $submissionChecklistAfterContent string Optional data after checklist
 * @uses $sections array Journal sections
 *}
{include file="frontend/components/header.tpl" pageTitle="about.submissions"}

<div class="flavor-about">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="about.submissions"}

	<div class="flavor-about__header">
		<h1 class="flavor-about__title">{translate key="about.submissions"}</h1>
	</div>

	{* ── Submission CTA / Notice ── *}
	<div class="flavor-about__notice">
		<div class="flavor-about__notice-icon">
			<svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
				<path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
				<polyline points="14 2 14 8 20 8"></polyline>
				<line x1="12" y1="18" x2="12" y2="12"></line>
				<line x1="9" y1="15" x2="15" y2="15"></line>
			</svg>
		</div>
		<div>
			{if $sections|@count == 0 || $currentContext->getData('disableSubmissions')}
				{translate key="author.submit.notAccepting"}
			{else}
				{if $isUserLoggedIn}
					{capture assign="newSubmission"}<a href="{url page="submission"}">{translate key="about.onlineSubmissions.newSubmission"}</a>{/capture}
					{capture assign="viewSubmissions"}<a href="{url page="submissions"}">{translate key="about.onlineSubmissions.viewSubmissions"}</a>{/capture}
					{translate key="about.onlineSubmissions.submissionActions" newSubmission=$newSubmission viewSubmissions=$viewSubmissions}
				{else}
					{capture assign="login"}<a href="{url page="login"}">{translate key="about.onlineSubmissions.login"}</a>{/capture}
					{capture assign="register"}<a href="{url page="user" op="register"}">{translate key="about.onlineSubmissions.register"}</a>{/capture}
					{translate key="about.onlineSubmissions.registrationRequired" login=$login register=$register}
				{/if}
			{/if}
		</div>
	</div>

	{* ── Author Guidelines ── *}
	{if $currentContext->getLocalizedData('authorGuidelines')}
		<div class="flavor-about__section" id="authorGuidelines">
			<h2 class="flavor-about__section-title">
				{translate key="about.authorGuidelines"}
				{include file="frontend/components/editLink.tpl" page="management" op="settings" path="workflow" anchor="submission/instructions" sectionTitleKey="about.authorGuidelines"}
			</h2>
			<div class="flavor-about__prose">
				{$currentContext->getLocalizedData('authorGuidelines')}
			</div>
		</div>
	{/if}

	{* ── Submission Checklist ── *}
	{if $submissionChecklist}
		<div class="flavor-about__section">
			<h2 class="flavor-about__section-title">
				{translate key="about.submissionPreparationChecklist"}
				{include file="frontend/components/editLink.tpl" page="management" op="settings" path="workflow" anchor="submission/instructions" sectionTitleKey="about.submissionPreparationChecklist"}
			</h2>
			<div class="flavor-about__prose">
				{$submissionChecklist}
			</div>
		</div>
	{/if}

	{if isset($submissionChecklistAfterContent)}
		{$submissionChecklistAfterContent}
	{/if}

	{* ── Copyright Notice ── *}
	{if $currentContext->getLocalizedData('copyrightNotice')}
		<div class="flavor-about__section">
			<h2 class="flavor-about__section-title">
				{translate key="about.copyrightNotice"}
				{include file="frontend/components/editLink.tpl" page="management" op="settings" path="workflow" anchor="submission/instructions" sectionTitleKey="about.copyrightNotice"}
			</h2>
			<div class="flavor-about__prose">
				{$currentContext->getLocalizedData('copyrightNotice')}
			</div>
		</div>
	{/if}

	{* ── Privacy Statement ── *}
	{if $currentContext->getLocalizedData('privacyStatement')}
		<div class="flavor-about__section" id="privacyStatement">
			<h2 class="flavor-about__section-title">
				{translate key="about.privacyStatement"}
				{include file="frontend/components/editLink.tpl" page="management" op="settings" path="website" anchor="setup/privacy" sectionTitleKey="about.privacyStatement"}
			</h2>
			<div class="flavor-about__prose">
				{$currentContext->getLocalizedData('privacyStatement')}
			</div>
		</div>
	{/if}
</div>

{include file="frontend/components/footer.tpl"}
