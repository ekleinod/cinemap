<?php echo $this->Html->docType('html5'); ?>
<?php
	$attLang = Configure::read('Config.language');
	if (strpos($attLang, "-")) {
		$attLang = substr($attLang, 0, strpos($attLang, "-"));
	}
?>
<!--[if lt IE 7 ]><html class="ie ie6" lang="<?php echo $attLang; ?>"> <![endif]-->
<!--[if IE 7 ]><html class="ie ie7" lang="<?php echo $attLang; ?>"> <![endif]-->
<!--[if IE 8 ]><html class="ie ie8" lang="<?php echo $attLang; ?>"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!--><html lang="<?php echo $attLang; ?>"> <!--<![endif]-->

	<head>

		<?php
			// character encoding
			echo $this->Html->charset();

			// meta tags
			$this->Html->meta(array('name' => 'viewport', 'content' => 'width=device-width, initial-scale=1, maximum-scale=1'), null, array('inline' => false));
			echo $this->fetch('meta');

			// css files
			$this->Html->css('base', null, array('inline' => false));
			$this->Html->css('skeleton', null, array('inline' => false));
			$this->Html->css('layout', null, array('inline' => false));
			echo $this->fetch('css');
		?>

		<!-- favicons by hand, maybe later using cakephp methods -->
		<link rel="shortcut icon" href="img/favicon.ico" />
		<link rel="apple-touch-icon" href="img/apple-touch-icon.png" />
		<link rel="apple-touch-icon" sizes="72x72" href="img/apple-touch-icon-72x72.png" />
		<link rel="apple-touch-icon" sizes="114x114" href="img/apple-touch-icon-114x114.png" />

		<!-- title -->
		<title><?php echo $title_for_layout; ?></title>

	</head>
	<body>

		<div class="page">

			<div class="band header">

				<header class="container main">

					<div class="sixteen columns">

						<h1><?php echo $this->Html->link(__('Cinemap'), array('controller' => 'pages', 'action' => 'display', 'home')); ?></h1>

					</div><!-- end sixteen -->

				</header><!-- end container -->

			</div><!-- end band header -->

			<div class="band navigation">

				<nav class="container primary">

					<div class="sixteen columns">

						<?php
						$navarray = array(
															array('title' => __('Locations'), 'routing' => array('action' => 'index', 'controller' => 'locations'),
																		'subnav' => array(
																											array('title' => __('List'), 'routing' => array('action' => 'index', 'controller' => 'locations')),
																											//array('title' => __('Search'), 'routing' => array('action' => 'search', 'controller' => 'locations')),
																											array('title' => __('Add'), 'routing' => array('action' => 'add', 'controller' => 'locations')),
																											)
																		),
															array('title' => __('Movies'), 'routing' => array('action' => 'index', 'controller' => 'movies'),
																		'subnav' => array(
																											array('title' => __('List'), 'routing' => array('action' => 'index', 'controller' => 'movies')),
																											//array('title' => __('Search'), 'routing' => array('action' => 'search', 'controller' => 'movies')),
																											array('title' => __('Add'), 'routing' => array('action' => 'add', 'controller' => 'movies')),
																											)
																		),
															array('title' => __('Users'), 'routing' => array('action' => 'index', 'controller' => 'users'),
																		'subnav' => array(
																											array('title' => __('List'), 'routing' => array('action' => 'index', 'controller' => 'users')),
																											array('title' => __('Add'), 'routing' => array('action' => 'add', 'controller' => 'users')),
																											)
																		),
															);
							echo $this->element('navigation', array('navarray' => $navarray));
						?>

					</div><!-- end sixteen -->

				</nav><!-- end container primary -->

			</div><!-- end band navigation -->

			<?php if (isset($username)) { ?>
				<div class="band username">
					<div class="container">
						<div class="sixteen columns">
							<p>
								Logged in as: "<?php echo $username; ?>"
								(<?php echo $this->Html->link(__('Logout'), array('action' => 'logout', 'controller' => 'users'), array('class' => '')); ?>)
							</p>
						</div><!-- end sixteen -->
					</div><!-- end container -->
				</div><!-- end band content -->
			<?php } ?>

			<div class="band content">

				<div class="container">

					<div class="sixteen columns">

						<article>
							<div id="flash"><?php echo $this->Session->flash(); ?></div>
							<div id="content">
								<h2><?php echo $title_for_layout; ?></h2>
								<?php echo $this->fetch('content'); ?>
							</div>
						</article>

					</div><!-- end sixteen -->

				</div><!-- end container -->

			</div><!-- end band content -->

			<div class="band footer">

				<footer class="container">

					<div class="four columns">

						<ul>
							<li><?php echo $this->Html->link(__('Cinemap Home'), 'http://www.cinemap.de/'); ?></li>
						</ul>

					</div><!-- end four -->

					<div class="four columns">

						<ul>
							<li><?php echo $this->Html->link(__('Login'), array('action' => 'login', 'controller' => 'users'), array('class' => '')); ?></li>
							<li><?php echo $this->Html->link(__('Logout'), array('action' => 'logout', 'controller' => 'users'), array('class' => '')); ?></li>
						</ul>

					</div><!-- end four -->

				</footer><!-- end container -->

			</div><!-- end band footer -->

			<div class="band sqldump">

				<footer class="container">

					<div class="sixteen columns">

						<?php echo $this->element('sql_dump'); ?>

					</div><!-- end sixteen -->

				</footer><!-- end container -->

			</div><!-- end band footer -->

		</div><!-- end page -->

		<?php
			// load scripts at end of page in order to improve page load speed
			echo $this->fetch('script');
		?>

	</body>
</html>

