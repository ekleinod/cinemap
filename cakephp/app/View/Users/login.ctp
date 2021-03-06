<?php echo $this->Session->flash('auth'); ?>

<?php echo $this->Form->create('User'); ?>
	<fieldset>
		<legend><?php echo __('Username and Password'); ?></legend>
		<ol>
			<?php
				// username
				$label = $this->Form->label('User.username', __('Username'), 'required');
				$input = $this->Form->text('User.username',
						array('type' => 'text',
									'placeholder' => __('Username'), 'title' => __('Username'),
									'maxlength' => '100',
									'autofocus' => 'autofocus',
									'required' => 'required')
				);
				echo $this->Html->tag('li',
						$label . $input,
						array('class' => 'input text required')
				);

				// password
				$label = $this->Form->label('User.password', __('Password'), 'required');
				$input = $this->Form->text('User.password',
						array('type' => 'password',
									'placeholder' => __('Password'), 'title' => __('Password'),
									'maxlength' => '100',
									'required' => 'required')
				);
				echo $this->Html->tag('li',
						$label . $input,
						array('class' => 'input password required')
				);
			?>
		</ol>
	</fieldset>
	<fieldset>
		<?php echo $this->Form->button(__('Log in'), array('type' => 'submit')); ?>
		<?php echo $this->Form->button(__('Reset form'), array('type' => 'reset')); ?>
	</fieldset>
<?php echo $this->Form->end(); ?>

