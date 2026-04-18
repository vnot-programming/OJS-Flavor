{**
 * templates/frontend/components/headerHead.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief HTML <head> section with fonts, meta, and styles.
 *}
<head>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	{* ── Smart Title: Portal (site index) vs Home (journal index) vs Normal ── *}
	{assign var="isPortalIndex" value=false}
	{assign var="isJournalHome" value=false}

	{* Deteksi duplikasi judul (pageTitleTranslated === displayPageHeaderTitle) *}
	{assign var="isDuplicatedTitle" value=false}
	{if $pageTitleTranslated}
		{assign var="strippedPageTitle" value=$pageTitleTranslated|strip_tags|trim}
		{assign var="strippedSiteTitle" value=$displayPageHeaderTitle|strip_tags|trim|default:''}
		{if $strippedPageTitle === $strippedSiteTitle}
			{assign var="isDuplicatedTitle" value=true}
		{/if}
	{/if}

	{* Site-level portal: tidak ada currentContext (bukan di dalam jurnal) *}
	{if !$currentContext && $isDuplicatedTitle}
		{assign var="isPortalIndex" value=true}
	{/if}

	{* Journal-level home: ada currentContext tapi judul terduplikasi *}
	{if $currentContext && $isDuplicatedTitle}
		{assign var="isJournalHome" value=true}
	{/if}

	{if $isPortalIndex}
		<title>{title|strip_tags value="Portal"}</title>
	{elseif $isJournalHome}
		<title>{title|strip_tags value="Home"}</title>
	{else}
		<title>{title|strip_tags value=$pageTitleTranslated}</title>
	{/if}

	{* Google Fonts: Inter (heading/ui), Lora (body), JetBrains Mono (meta) *}
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Lora:ital,wght@0,400;0,500;0,600;0,700;1,400&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">

	{load_header context="frontend"}
	{load_stylesheet context="frontend"}
	{load_script context="frontend"}
</head>
