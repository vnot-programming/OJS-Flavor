{**
 * templates/frontend/components/footer.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Common site frontend footer.
 *}
{if $requestedPage !== 'login' && $requestedPage !== 'user'}
			</div>{* /.flavor-layout__content *}
			<aside class="flavor-layout__sidebar flavor-hide-mobile" role="complementary">
				{include file="frontend/components/sidebar.tpl"}
			</aside>
		</div>{* /.flavor-layout *}
		</div>{* /.flavor-container *}
	</main>

	<footer class="flavor-footer" role="contentinfo">
		{if $pageFooter}
			<div class="flavor-footer__custom">
				{$pageFooter}
			</div>
		{/if}
		<div class="flavor-footer__meta">
			{assign var="currentYear" value=$smarty.now|date_format:"Y"}
			<span>&copy; {$currentYear} {translate key="plugins.themes.flavor.poweredBy"} <a href="{url page="about" op="aboutThisPublishingSystem"}">Open Journal Systems</a></span>
			<span>{translate key="plugins.themes.flavor.designedBy"}</span>
		</div>
	</footer>
{else}
	</main>
{/if}

{call_hook name="Templates::Common::Footer::PageFooter"}

</body>
</html>
