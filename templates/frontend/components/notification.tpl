{**
 * templates/frontend/components/notification.tpl
 *
 * Copyright (c) 2026 Flavor Theme
 *
 * @brief Styled notification/alert component for empty states and warnings.
 *}
<div class="flavor-notice flavor-notice--{$type|escape|default:'info'}">
	<div class="flavor-notice__icon">
		{if $type == 'warning'}
			<svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
				<path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"/>
				<line x1="12" y1="9" x2="12" y2="13"/>
				<line x1="12" y1="17" x2="12.01" y2="17"/>
			</svg>
		{else}
			<svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
				<circle cx="12" cy="12" r="10"/>
				<line x1="12" y1="16" x2="12" y2="12"/>
				<line x1="12" y1="8" x2="12.01" y2="8"/>
			</svg>
		{/if}
	</div>
	<div class="flavor-notice__content">
		{if $messageKey}
			{translate key=$messageKey}
		{else}
			{$message}
		{/if}
	</div>
</div>
