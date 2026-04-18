{**
 * templates/frontend/objects/issue_summary.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Issue card for archive grid.
 *}
{assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}

<div class="flavor-issue-card">
	{if $issueCover}
		<div class="flavor-issue-card__cover">
			<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
				<img src="{$issueCover|escape}" alt="{$issue->getLocalizedCoverImageAltText()|escape|default:''}">
			</a>
		</div>
	{/if}
	<div class="flavor-issue-card__body">
		<div class="flavor-issue-card__title">
			<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
				{$issue->getIssueIdentification()|escape}
			</a>
		</div>
		{if $issue->getDatePublished()}
			<div class="flavor-issue-card__date">
				{$issue->getDatePublished()|date_format:$dateFormatShort}
			</div>
		{/if}
	</div>
</div>
