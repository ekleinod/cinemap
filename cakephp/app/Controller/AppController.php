<?php
/**
 * Application level Controller
 *
 * This file is application-wide controller file. You can put all
 * application-wide controller-related methods here.
 *
 * PHP 5
 *
 * CakePHP(tm) : Rapid Development Framework (http://cakephp.org)
 * Copyright 2005-2012, Cake Software Foundation, Inc. (http://cakefoundation.org)
 *
 * Licensed under The MIT License
 * Redistributions of files must retain the above copyright notice.
 *
 * @copyright     Copyright 2005-2012, Cake Software Foundation, Inc. (http://cakefoundation.org)
 * @link          http://cakephp.org CakePHP(tm) Project
 * @package       app.Controller
 * @since         CakePHP(tm) v 0.2.9
 * @license       MIT License (http://www.opensource.org/licenses/mit-license.php)
 */

App::uses('Controller', 'Controller');
App::uses('Security', 'Utility'); // use more secure salt hash

/**
 * Application Controller
 *
 * Add your application-wide methods in the class below, your controllers
 * will inherit them.
 *
 * @package       app.Controller
 * @link http://book.cakephp.org/2.0/en/controllers.html#the-app-controller
 */
class AppController extends Controller {

	/** Role: reporter. */
	const ROLE_REPORTER = 'reporter';

	/** Role: moderator. */
	const ROLE_MODERATOR = 'moderator';

	/** Role: administrator. */
	const ROLE_ADMINISTRATOR = 'administrator';

	/**
	 * Extend components array by Auth component for simple authentication.
	 *
	 * @var array
	 */
	public $components = array(
		'Session',
		'Auth' => array(
			'loginRedirect' => array('controller' => 'movies', 'action' => 'index'),
			'logoutRedirect' => array('controller' => 'movies', 'action' => 'index'),
			'authenticate' => array('SaltForm') // use own authentication class
		)
	);

	/**
	 * Defines actions to perform before the action method is executed.
	 *
	 */
	public function beforeFilter() {
		parent::beforeFilter();

		Configure::write('Config.language', $this->Session->read('Config.language'));

		Security::setHash('sha512');
		$this->Auth->allow('index', 'view', 'export');

		// set user role checks
		$user = $this->Auth->user();
		$this->set('isReporter', $this->isReporter($user));
		$this->set('isModerator', $this->isModerator($user));
		$this->set('isAdministrator', $this->isAdministrator($user));

		// set user name
		if (($user != null) && !empty($user) && ($user['id'] !== null)) {
			$this->set('username', $user['username']);
		}

	}

	/**
	 * Returns if the user has the rights of a reporter.
	 *
	 * This includes moderators and administrators.
	 *
	 * @param $user user to check
	 * @return true = reporter, false = no reporter
	 */
	public function isReporter($user = null) {

		// no user given
		if ($user == null) {
			return false;
		}

		// user not logged in
		if (empty($user) || ($user['id'] == null)) {
			return false;
		}

		// hierarchy
		if ($this->isAdministrator($user)) {
			return true;
		}
		if ($this->isModerator($user)) {
			return true;
		}

		// check rights
		$this->loadModel('User');
		$this->User->id = $user['id'];
		if (!$this->User->exists()) {
			throw new NotFoundException(__('Invalid user: ') . $user['id']);
		}
		$theUser = $this->User->read(null, $user['id']);

		if ($theUser['UserRole']['sid'] == self::ROLE_REPORTER) {
			return true;
		}

		return false;
	}

	/**
	 * Returns if the user has the rights of a moderator.
	 *
	 * This includes administrators.
	 *
	 * @param $user user to check
	 * @return true = moderator, false = no moderator
	 */
	public function isModerator($user = null) {

		// no user given
		if ($user == null) {
			return false;
		}

		// user not logged in
		if (empty($user) || ($user['id'] == null)) {
			return false;
		}

		// hierarchy
		if ($this->isAdministrator($user)) {
			return true;
		}

		// check rights
		$this->loadModel('User');
		$this->User->id = $user['id'];
		if (!$this->User->exists()) {
			throw new NotFoundException(__('Invalid user: ') . $user['id']);
		}
		$theUser = $this->User->read(null, $user['id']);

		if ($theUser['UserRole']['sid'] == self::ROLE_MODERATOR) {
			return true;
		}

		return false;
	}

	/**
	 * Returns if the user has the rights of an administrator.
	 *
	 * @param $user user to check
	 * @return true = administrator, false = no administrator
	 */
	public function isAdministrator($user = null) {

		// no user given
		if ($user == null) {
			return false;
		}

		// user not logged in
		if (empty($user) || ($user['id'] == null)) {
			return false;
		}

		// check rights
		$this->loadModel('User');
		$this->User->id = $user['id'];
		if (!$this->User->exists()) {
			throw new NotFoundException(__('Invalid user: ') . $user['id']);
		}
		$theUser = $this->User->read(null, $user['id']);

		if ($theUser['UserRole']['sid'] == self::ROLE_ADMINISTRATOR) {
			return true;
		}

		return false;
	}

}

/* EOF */

