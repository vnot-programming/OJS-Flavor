{**
 * templates/frontend/components/navigationMenu.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Primary navigation menu renderer.
 *}
<nav class="flavor-nav" aria-label="{translate key="common.navigation.site"}">
	<ul class="flavor-nav" id="{$id|escape}">
		{foreach key=field item=navigationMenuItemAssignment from=$navigationMenu->menuTree}
			{if !$navigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
				{continue}
			{/if}
			<li class="flavor-dropdown">
				<a href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}">
					{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
				</a>
				{if $navigationMenuItemAssignment->navigationMenuItem->getIsChildVisible()}
					<div class="flavor-dropdown__menu">
						{foreach key=childField item=childNavigationMenuItemAssignment from=$navigationMenuItemAssignment->children}
							{if $childNavigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
								<a href="{$childNavigationMenuItemAssignment->navigationMenuItem->getUrl()}">
									{$childNavigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
								</a>
							{/if}
						{/foreach}
					</div>
				{/if}
			</li>
		{/foreach}
	</ul>
</nav>
