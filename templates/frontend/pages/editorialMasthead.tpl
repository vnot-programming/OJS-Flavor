{**
 * templates/frontend/pages/editorialMasthead.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Display the journal's editorial team / masthead.
 *}
{include file="frontend/components/header.tpl" pageTitle="common.editorialMasthead"}

<div class="flavor-about">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="common.editorialMasthead"}

	<div class="flavor-about__header">
		<h1 class="flavor-about__title">{translate key="common.editorialMasthead"}</h1>
	</div>

	{* ── Editorial Roles ── *}
	{foreach from=$mastheadRoles item="mastheadRole"}
		{if array_key_exists($mastheadRole->id, $mastheadUsers)}
			<div class="flavor-about__masthead-role">
				<h2 class="flavor-about__masthead-role-title">
					{$mastheadRole->getLocalizedData('name')|escape}
					<span class="flavor-about__masthead-count">{$mastheadUsers[$mastheadRole->id]|@count}</span>
				</h2>
				<ul class="flavor-about__user-list" role="list">
					{foreach from=$mastheadUsers[$mastheadRole->id] item="mastheadUser"}
						<li class="flavor-about__user-item">
							{if !empty($mastheadUser['dateStart'])}
								<span class="flavor-about__user-date">{translate key="common.fromUntil" from=$mastheadUser['dateStart'] until=""}</span>
							{/if}
							<span class="flavor-about__user-name">
								{$mastheadUser['user']->getFullName()|escape}
								{if $mastheadUser['user']->getData('orcid') && $mastheadUser['user']->hasVerifiedOrcid()}
									<span class="orcid">
										<a href="{$mastheadUser['user']->getData('orcid')|escape}" target="_blank" aria-label="{translate key="common.editorialHistory.page.orcidLink" name=$mastheadUser['user']->getFullName()|escape}">
											{$orcidIcon}
										</a>
									</span>
								{/if}
							</span>
							{if !empty($mastheadUser['user']->getLocalizedData('affiliation'))}
								<span class="flavor-about__user-affiliation">{$mastheadUser['user']->getLocalizedData('affiliation')|escape}</span>
							{/if}
						</li>
					{/foreach}
				</ul>
			</div>
		{/if}
	{/foreach}

	{* ── Editorial History Link ── *}
	<p class="flavor-about__history-link">
		{capture assign=editorialHistoryUrl}{url page="about" op="editorialHistory" router=\PKP\core\PKPApplication::ROUTE_PAGE}{/capture}
		{translate key="about.editorialMasthead.linkToEditorialHistory" url=$editorialHistoryUrl}
	</p>

	<hr class="flavor-about__divider">

	{* ── Peer Reviewers ── *}
	{if $reviewers->count()}
		<div class="flavor-about__section">
			<h2 class="flavor-about__section-title">{translate key="common.editorialMasthead.peerReviewers"}</h2>
			<p class="flavor-about__reviewers-desc">{translate key="common.editorialMasthead.peerReviewers.description" year=$previousYear}</p>
			<ul class="flavor-about__user-list" role="list">
				{foreach from=$reviewers item="reviewer"}
					<li class="flavor-about__user-item">
						<span class="flavor-about__user-name">
							{$reviewer->getFullName()|escape}
							{if $reviewer->getData('orcid') && $reviewer->getData('orcidAccessToken')}
								<span class="orcid">
									<a href="{$reviewer->getData('orcid')|escape}" target="_blank" aria-label="{translate key="common.editorialHistory.page.orcidLink" name=$reviewer->getFullName()|escape}">
										{$orcidIcon}
									</a>
								</span>
							{/if}
						</span>
						{if !empty($reviewer->getLocalizedData('affiliation'))}
							<span class="flavor-about__user-affiliation">{$reviewer->getLocalizedData('affiliation')|escape}</span>
						{/if}
					</li>
				{/foreach}
			</ul>
		</div>
	{/if}
</div>

{include file="frontend/components/footer.tpl"}
