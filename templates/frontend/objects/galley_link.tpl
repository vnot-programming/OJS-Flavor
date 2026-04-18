{**
 * templates/frontend/objects/galley_link.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Galley download pill link.
 *}
{if $galley->isPdfGalley()}
	{assign var="type" value="PDF"}
{else}
	{assign var="type" value=$galley->getLabel()}
{/if}

{if $purchaseFee && $currentContext->getData('paymentsEnabled') && !$hasAccess}
	<a class="flavor-galley-link" href="{url page="article" op="view" path=$parent->getBestId()|to_array:$galley->getBestGalleyId()}">
		{$type} — {$purchaseCurrency} {$purchaseFee}
	</a>
{else}
	<a class="flavor-galley-link" href="{url page="article" op="view" path=$parent->getBestId()|to_array:$galley->getBestGalleyId()}">
		<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" width="14" height="14">
			<path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
			<polyline points="7 10 12 15 17 10"></polyline>
			<line x1="12" y1="15" x2="12" y2="3"></line>
		</svg>
		{$type}
	</a>
{/if}
