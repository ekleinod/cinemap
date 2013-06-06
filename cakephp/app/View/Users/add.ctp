<?php echo $this->Session->flash('auth'); ?>

<?php echo $this->Form->create('User'); ?>
	<fieldset>
		<legend><?php echo __('Core information'); ?></legend>
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

				// user role
				$label = $this->Form->label('User.user_role_id', __('User Role'), 'required');
				$input = $this->Form->select('User.user_role_id',
						$userRoles,
						array('type' => 'select',
									'value' => '1',
									'required' => 'required')
				);
				echo $this->Html->tag('li',
						$label . $input,
						array('class' => 'input select required')
				);

			?>
		</ol>
	</fieldset>
	<fieldset>
		<legend><?php echo __('Additional information'); ?></legend>
		<ol>
			<?php
				// username
				$label = $this->Form->label('User.name', __('Display Name'));
				$input = $this->Form->text('User.name',
						array('type' => 'text',
									'placeholder' => __('Display Name'), 'title' => __('Display Name'),
									'maxlength' => '100')
				);
				echo $this->Html->tag('li',
						$label . $input,
						array('class' => 'input text')
				);

				// email
				$label = $this->Form->label('User.email', __('Email'));
				$input = $this->Form->text('User.email',
						array('type' => 'text',
									'placeholder' => __('xyz@xyz.com'), 'title' => __('Email'),
									'maxlength' => '100')
				);
				echo $this->Html->tag('li',
						$label . $input,
						array('class' => 'input text')
				);

				// url
				$label = $this->Form->label('User.url', __('URL'));
				$input = $this->Form->text('User.url',
						array('type' => 'text',
									'placeholder' => __('http://www.xyz.com/'), 'title' => __('URL'),
									'maxlength' => '100')
				);
				echo $this->Html->tag('li',
						$label . $input,
						array('class' => 'input text')
				);

			?>
		</ol>
	</fieldset>
	<fieldset>
		<?php echo $this->Form->button(__('Add user'), array('type' => 'submit')); ?>
		<?php echo $this->Form->button(__('Reset form'), array('type' => 'reset')); ?>
	</fieldset>
<?php echo $this->Form->end(); ?>

