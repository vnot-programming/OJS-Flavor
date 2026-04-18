{**
 * templates/frontend/components/logo.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Logo component.
 *}
{if $displayPageHeaderLogo}
	<a href="{url page="index" router=\PKP\core\PKPApplication::ROUTE_PAGE}" class="flavor-logo">
		<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}"
			{if $displayPageHeaderLogo.altText} alt="{$displayPageHeaderLogo.altText|escape}"{else} alt="{$applicationName|escape}"{/if}>
	</a>
{else}
	<a href="{url page="index" router=\PKP\core\PKPApplication::ROUTE_PAGE}" class="flavor-logo">
		{$displayPageHeaderTitle|escape}
	</a>
{/if}
