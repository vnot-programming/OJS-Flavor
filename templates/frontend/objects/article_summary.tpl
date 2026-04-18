{**
 * templates/frontend/objects/article_summary.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Article summary card in issue table of contents.
 *}
{assign var=publication value=$article->getCurrentPublication()}
{assign var=articlePath value=$publication->getData('urlPath')|default:$article->getId()}
{if !$heading}
	{assign var="heading" value="h2"}
{/if}

{if (!$section.hideAuthor && $publication->getData('hideAuthor') == \APP\submission\Submission::AUTHOR_TOC_DEFAULT) || $publication->getData('hideAuthor') == \APP\submission\Submission::AUTHOR_TOC_SHOW}
	{assign var="showAuthor" value=true}
{/if}

<div class="flavor-article-item">
	{if $publication->getLocalizedData('coverImage')}
		<div class="flavor-article-item__cover">
			<a {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if}>
				{assign var="coverImage" value=$publication->getLocalizedData('coverImage')}
				<img src="{$publication->getLocalizedCoverImageUrl($article->getData('contextId'))|escape}" alt="{$coverImage.altText|escape|default:''}">
			</a>
		</div>
	{/if}

	<div class="flavor-article-item__body">
		<{$heading} class="flavor-article-item__title">
			<a id="article-{$article->getId()}" {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if}>
				{$publication->getLocalizedTitle(null, 'html')|strip_unsafe_html}
			</a>
		</{$heading}>

		{assign var=localizedSubtitle value=$publication->getLocalizedSubtitle(null, 'html')|strip_unsafe_html}
		{if $localizedSubtitle}
			<div class="flavor-article-item__subtitle">{$localizedSubtitle}</div>
		{/if}

		{if $showAuthor}
			<div class="flavor-article-item__authors">
				{$publication->getAuthorString($authorUserGroups)|escape}
			</div>
		{/if}

		<div class="flavor-article-item__meta">
			{assign var=submissionPages value=$publication->getData('pages')}
			{if $submissionPages}
				<span class="flavor-badge flavor-badge--success">{$submissionPages|escape}</span>
			{/if}
			{assign var=submissionDatePublished value=$publication->getData('datePublished')}
			{if $showDatePublished && $submissionDatePublished}
				<span class="flavor-badge flavor-badge--neutral">{$submissionDatePublished|date_format:$dateFormatShort}</span>
			{/if}
		</div>

		{if !$hideGalleys}
			<div class="flavor-article-item__galleys">
				{foreach from=$article->getGalleys() item=galley}
					{if $primaryGenreIds}
						{assign var="file" value=$galley->getFile()}
						{if !$galley->getData('urlRemote') && !($file && in_array($file->getGenreId(), $primaryGenreIds))}
							{continue}
						{/if}
					{/if}
					{assign var="hasArticleAccess" value=$hasAccess}
					{if $currentContext->getSetting('publishingMode') == \APP\journal\Journal::PUBLISHING_MODE_OPEN || $publication->getData('accessStatus') == \APP\submission\Submission::ARTICLE_ACCESS_OPEN}
						{assign var="hasArticleAccess" value=1}
					{/if}
					{include file="frontend/objects/galley_link.tpl" parent=$article publication=$publication galley=$galley hasAccess=$hasArticleAccess purchaseFee=$currentJournal->getData('purchaseArticleFee') purchaseCurrency=$currentJournal->getData('currency')}
				{/foreach}
			</div>
		{/if}
	</div>

	{call_hook name="Templates::Issue::Issue::Article"}
</div>
