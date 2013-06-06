<?php echo $this->Session->flash('auth'); ?>

<!-- header actions -->
<?php echo $this->element('actions_header');	?>

<!-- view filters -->
<div class="filter">
</div>

<!-- view content -->
<?php
	if (empty($users)) {
?>
	<p><?php echo __('There are no users.'); ?></p>
<?php
	} else {
?>
	<table>
		<?php
			$tags = array('thead', 'tfoot');
			foreach ($tags as $tag) {
		?>
			<<?php echo $tag; ?>>
				<tr>
					<th><?php echo __('Item ID'); ?></th>
					<th><?php echo __('ID'); ?></th>
					<th><?php echo __('Username'); ?></th>
					<th><?php echo __('User Role'); ?></th>
					<th><?php echo __('Display Name'); ?></th>
					<th><?php echo __('Email'); ?></th>
					<th><?php echo __('URL'); ?></th>
					<th><?php echo __('Actions'); ?></th>
				</tr>
			</<?php echo $tag; ?>>
		<? } ?>
		<tbody>
			<?php
				foreach ($users as $user):
			?>
				<tr>
					<td data-title="<?php echo __('Item ID'); ?>"><?php echo $this->Html->link($user['User']['item_id'], array('controller' => 'users', 'action' => 'view', $user['User']['id'])); ?></td>
					<td data-title="<?php echo __('ID'); ?>"><?php echo $this->Html->link($user['User']['id'], array('controller' => 'users', 'action' => 'view', $user['User']['id'])); ?></td>
					<td data-title="<?php echo __('Username'); ?>"><?php echo $this->Html->link($user['User']['username'], array('controller' => 'users', 'action' => 'view', $user['User']['id'])); ?></td>
					<td data-title="<?php echo __('User Role'); ?>"><?php echo $this->Html->link($user['UserRole']['sid'], array('controller' => 'user_roles', 'action' => 'view', $user['UserRole']['id'])); ?></td>
					<td data-title="<?php echo __('Display Name'); ?>"><?php echo $this->Html->link($user['User']['name'], array('controller' => 'users', 'action' => 'view', $user['User']['id'])); ?></td>
					<td data-title="<?php echo __('Email'); ?>"><?php echo $this->Html->link($user['User']['email'], 'mailto:' . $user['User']['email']); ?></td>
					<td data-title="<?php echo __('URL'); ?>"><?php echo $this->Html->link($user['User']['url']); ?></td>
				</tr>
			<?php endforeach; ?>
		</tbody>
	</table>
<?php
	}
?>

