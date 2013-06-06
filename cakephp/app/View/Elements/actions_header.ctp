<?php if ($isReporter) { ?>

	<div class="actions">
		<?php echo $this->Html->link(__('New'), array('action' => 'add'), array('class' => 'button-link access-reporter')); ?>

		<?php if ($isModerator) { ?>
				<?php if (isset($id)) { ?>
					<?php echo $this->Html->link(__('Editieren'), array('action' => 'edit', $id), array('class' => 'button-link access-moderator')); ?>
					<?php echo $this->Html->link(__('Löschen'), array('action' => 'delete', $id), array('class' => 'button-link access-moderator')); ?>
				<?php } ?>
		<?php } ?>

	</div>

<?php } ?>

