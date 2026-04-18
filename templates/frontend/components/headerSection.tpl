{**
 * templates/frontend/components/headerSection.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Hero section with CSS gradient mesh background.
 *}
<section class="flavor-hero{if isset($homepageImageUrl)} flavor-hero--image{/if}">
	<div class="flavor-hero__bg"
		{if isset($homepageImageUrl)} style="background-image:url('{$homepageImageUrl}');background-size:cover;background-position:center;"{/if}>
	</div>
	<div class="flavor-hero__content">
		<h1 class="flavor-hero__title">{$displayPageHeaderTitle|escape}</h1>
		{if $activeTheme->getOption('showDescriptionInJournalIndex')}
			<p class="flavor-hero__description">
				{$currentContext->getLocalizedData('description')|strip_tags|truncate:200}
			</p>
		{/if}
		<div class="flavor-hero__actions">
			<a class="flavor-btn flavor-btn--primary" href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="about" op="submissions"}" role="button">
				{translate key="plugins.themes.flavor.makeSubmission"}
			</a>
			<a class="flavor-btn flavor-btn--ghost" href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive"}">
				{translate key="plugins.themes.flavor.browseArchives"}
			</a>
		</div>
	</div>
</section>
