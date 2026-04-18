{**
 * templates/frontend/pages/indexSite.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Site portal — multi-journal listing page.
 *}
{include file="frontend/components/header.tpl"}

{* ═══ Site Name Banner (Portal Hero) ═══ *}
<section class="flavor-hero flavor-hero--portal">
	<div class="flavor-hero__bg"></div>
	<div class="flavor-hero__content">
		<div class="flavor-site-name-wrapper">
			<h1 class="flavor-hero__title">
				<a href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="index"}" class="flavor-site-name__link">
					<span class="flavor-hero__prefix">Portal</span>
					{$siteTitle|escape|default:$displayPageHeaderTitle|escape|default:"Open Journal Systems"}
				</a>
			</h1>
			{if $about}
				<p class="flavor-hero__description">{$about|strip_tags|truncate:200}</p>
			{/if}
		</div>
	</div>
</section>

<div class="flavor-page-portal">

	{include file="frontend/objects/announcements_list.tpl" numAnnouncements=$numAnnouncementsHomepage}

	<div class="journals">
		<h2 class="flavor-page-portal__heading">{translate key="context.contexts"}</h2>
		{if !$journals|@count}
			<p class="text-secondary">{translate key="site.noJournals"}</p>
		{else}
			<div class="flavor-page-portal__grid">
				{foreach from=$journals item=journal}
					{capture assign="url"}{url journal=$journal->getPath()}{/capture}
					{assign var="thumb" value=$journal->getLocalizedData('journalThumbnail')}
					{assign var="description" value=$journal->getLocalizedDescription()}
					<div class="flavor-journal-card">
						{if $thumb}
							<div class="flavor-journal-card__thumb">
								<a href="{$url}" target="_blank" rel="noopener noreferrer">
									<img src="{$journalFilesPath}{$journal->getId()}/{$thumb.uploadName|escape:"url"}"
										{if $thumb.altText} alt="{$thumb.altText|escape|default:''}"{/if}>
								</a>
							</div>
						{/if}
						<div class="flavor-journal-card__body">
							<h3 class="flavor-journal-card__title">
								<a href="{$url}" rel="bookmark" target="_blank" rel="noopener noreferrer">{$journal->getLocalizedName()|escape}</a>
							</h3>
							{if $description}
								<div class="flavor-journal-card__desc">{$description|strip_tags|truncate:200}</div>
							{/if}
							<div class="flavor-journal-card__links">
								<a href="{$url}" class="flavor-btn flavor-btn--secondary flavor-btn--sm" target="_blank" rel="noopener noreferrer">
									{translate key="site.journalView"}
								</a>
								<a href="{url journal=$journal->getPath() page="issue" op="current"}" class="flavor-btn flavor-btn--secondary flavor-btn--sm" target="_blank" rel="noopener noreferrer">
									{translate key="site.journalCurrent"}
								</a>
							</div>
						</div>
					</div>
				{/foreach}
			</div>
		{/if}
	</div>

</div>

{include file="frontend/components/footer.tpl"}
