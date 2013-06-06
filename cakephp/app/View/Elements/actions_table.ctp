<?php echo $this->Html->link(__('View'), array('action' => 'view', $id), array('class' => 'button-link access-anonymous')); ?>
<?php if ($isModerator) { ?>
	<?php echo $this->Html->link(__('Edit'), array('action' => 'edit', $id), array('class' => 'button-link access-moderator')); ?>
	<?php echo $this->Html->link(__('Delete'), array('action' => 'delete', $id), array('class' => 'button-link access-moderator')); ?>
<?php } ?>

