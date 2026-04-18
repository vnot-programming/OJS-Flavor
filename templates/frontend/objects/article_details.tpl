{**
 * templates/frontend/objects/article_details.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Full article detail view with metadata grid.
 *}
{if !$heading}
	{assign var="heading" value="h3"}
{/if}

<article class="flavor-article">

	{* Preview notice *}
	{if $publication->getData('status') !== \PKP\submission\PKPSubmission::STATUS_PUBLISHED}
		<div class="flavor-notice">
			{capture assign="submissionUrl"}{url page="workflow" op="access" path=$article->getId()}{/capture}
			{translate key="submission.viewingPreview" url=$submissionUrl}
		</div>
	{elseif $currentPublication->getId() !== $publication->getId()}
		<div class="flavor-notice">
			{capture assign="latestVersionUrl"}{url page="article" op="view" path=$article->getBestId()}{/capture}
			{translate key="submission.outdatedVersion"
				datePublished=$publication->getData('datePublished')|date_format:$dateFormatShort
				urlRecentVersion=$latestVersionUrl|escape
			}
		</div>
	{/if}

	<h1 class="flavor-article__title">
		{$publication->getLocalizedTitle(null, 'html')|strip_unsafe_html}
	</h1>

	{if $publication->getLocalizedData('subtitle')}
		<h2 class="flavor-article__subtitle">
			{$publication->getLocalizedSubTitle(null, 'html')|strip_unsafe_html}
		</h2>
	{/if}

	{* ═══ Metadata Definition List ═══ *}
	<div class="flavor-article__meta">

		{* Authors *}
		{if $publication->getData('authors')}
			<div class="flavor-article__meta-row">
				<div class="flavor-article__meta-label">{translate key="article.authors"}</div>
				<div class="flavor-article__meta-value">
					<div class="flavor-author-list">
						{foreach from=$publication->getData('authors') item=author}
							<div class="flavor-author">
								<div class="flavor-author__name">{$author->getFullName()|escape}</div>
								{if count($author->getAffiliations()) > 0}
									<div class="flavor-author__affiliation">
										{foreach name="affiliations" from=$author->getAffiliations() item="affiliation"}
											{$affiliation->getLocalizedName()|escape}{if !$smarty.foreach.affiliations.last}, {/if}
										{/foreach}
									</div>
								{/if}
								{if $author->getData('orcid')}
									<a class="flavor-author__orcid" href="{$author->getData('orcid')|escape}" target="_blank">
										{$author->getOrcidDisplayValue()|escape}
									</a>
								{/if}
								{assign var=authorUserGroup value=$userGroupsById[$author->getData('userGroupId')]}
								{if $authorUserGroup->showTitle}
									<span class="flavor-badge flavor-badge--success flavor-author__role">
										{$authorUserGroup->getLocalizedData('name')|escape}
									</span>
								{/if}
							</div>
						{/foreach}
					</div>
				</div>
			</div>
		{/if}

		{* DOI *}
		{assign var=doiObject value=$article->getCurrentPublication()->getData('doiObject')}
		{if $doiObject}
			{assign var="doiUrl" value=$doiObject->getData('resolvingUrl')|escape}
			<div class="flavor-article__meta-row">
				<div class="flavor-article__meta-label">
					{capture assign=translatedDOI}{translate key="doi.readerDisplayName"}{/capture}
					{translate key="semicolon" label=$translatedDOI}
				</div>
				<div class="flavor-article__meta-value">
					<a href="{$doiUrl}" class="meta-text">{$doiUrl}</a>
				</div>
			</div>
		{/if}

		{* Keywords *}
		{if !empty($publication->getLocalizedData('keywords'))}
			<div class="flavor-article__meta-row">
				<div class="flavor-article__meta-label">
					{capture assign=translatedKeywords}{translate key="article.subject"}{/capture}
					{translate key="semicolon" label=$translatedKeywords}
				</div>
				<div class="flavor-article__meta-value">
					{foreach name="keywords" from=$publication->getLocalizedData('keywords') item="keyword"}
						<span class="flavor-badge flavor-badge--neutral">{$keyword|escape}</span>
					{/foreach}
				</div>
			</div>
		{/if}

		{* Abstract *}
		{if $publication->getLocalizedData('abstract')}
			<div class="flavor-article__meta-row">
				<div class="flavor-article__meta-label">{translate key="article.abstract"}</div>
				<div class="flavor-article__meta-value flavor-article__abstract flavor-prose">
					{$publication->getLocalizedData('abstract')|strip_unsafe_html}
				</div>
			</div>
		{/if}

		{call_hook name="Templates::Article::Main"}

		{* Galleys *}
		{if $primaryGalleys}
			<div class="flavor-article__meta-row">
				<div class="flavor-article__meta-label">{translate key="submission.downloads"}</div>
				<div class="flavor-article__meta-value">
					<div class="flavor-article__galleys">
						{foreach from=$primaryGalleys item=galley}
							{include file="frontend/objects/galley_link.tpl" parent=$article publication=$publication galley=$galley purchaseFee=$currentJournal->getData('purchaseArticleFee') purchaseCurrency=$currentJournal->getData('currency')}
						{/foreach}
					</div>
				</div>
			</div>
		{/if}

		{if $supplementaryGalleys}
			<div class="flavor-article__meta-row">
				<div class="flavor-article__meta-label">{translate key="submission.additionalFiles"}</div>
				<div class="flavor-article__meta-value">
					<div class="flavor-article__galleys">
						{foreach from=$supplementaryGalleys item=galley}
							{include file="frontend/objects/galley_link.tpl" parent=$article publication=$publication galley=$galley isSupplementary="1"}
						{/foreach}
					</div>
				</div>
			</div>
		{/if}

		{* Published date *}
		{if $publication->getData('datePublished')}
			<div class="flavor-article__meta-row">
				<div class="flavor-article__meta-label">{translate key="submissions.published"}</div>
				<div class="flavor-article__meta-value">
					{if $firstPublication->getId() === $publication->getId()}
						{$firstPublication->getData('datePublished')|date_format:$dateFormatShort}
					{else}
						{translate key="submission.updatedOn" datePublished=$firstPublication->getData('datePublished')|date_format:$dateFormatShort dateUpdated=$publication->getData('datePublished')|date_format:$dateFormatShort}
					{/if}
				</div>
			</div>
		{/if}

		{* Issue *}
		{if $issue}
			<div class="flavor-article__meta-row">
				<div class="flavor-article__meta-label">{translate key="issue.issue"}</div>
				<div class="flavor-article__meta-value">
					<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">{$issue->getIssueIdentification()}</a>
				</div>
			</div>
		{/if}

		{* Section *}
		{if $section}
			<div class="flavor-article__meta-row">
				<div class="flavor-article__meta-label">{translate key="section.section"}</div>
				<div class="flavor-article__meta-value">{$section->getLocalizedTitle()|escape}</div>
			</div>
		{/if}

		{* References *}
		{if $parsedCitations || $publication->getData('citationsRaw')}
			<div class="flavor-article__meta-row">
				<div class="flavor-article__meta-label">{translate key="submission.citations"}</div>
				<div class="flavor-article__meta-value flavor-article__references">
					{if $parsedCitations}
						{foreach from=$parsedCitations item="parsedCitation"}
							<p>{$parsedCitation->getCitationWithLinks()|strip_unsafe_html} {call_hook name="Templates::Article::Details::Reference" citation=$parsedCitation}</p>
						{/foreach}
					{else}
						{$publication->getData('citationsRaw')|escape|nl2br}
					{/if}
				</div>
			</div>
		{/if}

		{* License *}
		{if $currentContext->getLocalizedData('licenseTerms') || $publication->getData('licenseUrl')}
			<div class="flavor-article__meta-row">
				<div class="flavor-article__meta-label">{translate key="submission.license"}</div>
				<div class="flavor-article__meta-value">
					{if $publication->getData('licenseUrl')}
						{if $ccLicenseBadge}
							{if $publication->getLocalizedData('copyrightHolder')}
								<p>{translate key="submission.copyrightStatement" copyrightHolder=$publication->getLocalizedData('copyrightHolder') copyrightYear=$publication->getData('copyrightYear')}</p>
							{/if}
							{$ccLicenseBadge}
						{else}
							<a href="{$publication->getData('licenseUrl')|escape}">
								{if $publication->getLocalizedData('copyrightHolder')}
									{translate key="submission.copyrightStatement" copyrightHolder=$publication->getLocalizedData('copyrightHolder') copyrightYear=$publication->getData('copyrightYear')}
								{else}
									{translate key="submission.license"}
								{/if}
							</a>
						{/if}
					{/if}
					{$currentContext->getLocalizedData('licenseTerms')}
				</div>
			</div>
		{/if}

	</div>{* /.flavor-article__meta *}

	{* Hook content area *}
	<div class="flavor-article__extra">
		{call_hook name="Templates::Article::Details"}
	</div>

</article>
