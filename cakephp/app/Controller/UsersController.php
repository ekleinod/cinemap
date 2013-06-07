<?php

App::uses('AppController', 'Controller');

/**
 * Users Controller
 *
 * @property User $User
 */
class UsersController extends AppController {

	/**
	 * Defines actions to perform before the action method is executed.
	 *
	 */
	public function beforeFilter() {
		parent::beforeFilter();
		$this->Auth->allow('add'); // this would allow users to register themselves, this is not used for now
	}

	/**
	 * Login to the application.
	 *
	 */
	public function login() {
		if ($this->request->is('post')) {
			if ($this->Auth->login()) {
				$this->redirect($this->Auth->redirect());
			} else {
				$this->Session->setFlash(__('Invalid username or password, try again'));
			}
		}

		// set title
		$this->set('title_for_layout', __('Login'));
	}

	/**
	 * Logout of the application.
	 *
	 */
	public function logout() {
		$this->redirect($this->Auth->logout());
	}

	/**
	 * index method
	 *
	 * @return void
	 */
	public function index() {
		$users = $this->User->find('all');
		//usort($users, array('UsersController', 'compareTo'));

		$this->set('users', $users);

		// set title
		$this->set('title_for_layout', __('List of users'));
	}

	/**
	 * view method
	 *
	 * @throws NotFoundException
	 * @param string $id
	 * @return void
	 */
	public function view($id = null) {
		$this->User->id = $id;
		if (!$this->User->exists()) {
			throw new NotFoundException(__('Invalid user'));
		}
		$this->set('user', $this->User->read(null, $id));

		// set title
		$this->set('title_for_layout', __('View user'));
	}

	/**
	 * add method
	 *
	 * @return void
	 */
	public function add() {
		if ($this->request->is('post')) {

			$this->loadModel('Item');
			$this->Item->create();
			$newItem = $this->Item->save();
			if ($newItem) {
				$this->User->create();
				$this->request->data['User']['salt'] = Security::generateAuthKey();
				$this->request->data['User']['item_id'] = $newItem['Item']['id'];
				if ($this->User->save($this->request->data)) {
					$this->Session->setFlash(__('The user has been saved'));
					$this->redirect(array('action' => 'index'));
				} else {
					$this->Session->setFlash(__('The user could not be saved. Please, try again.'));
				}
			} else {
				$this->Session->setFlash(__('The user could not be saved, because the item could not be saved. Please, try again.'));
			}
		}
		$userRoles = $this->User->UserRole->find('list');
		ksort($userRoles, SORT_LOCALE_STRING);
		$this->set(compact('userRoles'));

		// set title
		$this->set('title_for_layout', __('Add new user'));
	}

	/**
	 * edit method
	 *
	 * @throws NotFoundException
	 * @param string $id
	 * @return void
	 */
	public function edit($id = null) {
		$this->User->id = $id;
		if (!$this->User->exists()) {
			throw new NotFoundException(__('Invalid user'));
		}
		if ($this->request->is('post') || $this->request->is('put')) {
			if ($this->User->save($this->request->data)) {
				$this->Session->setFlash(__('The user has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The user could not be saved. Please, try again.'));
			}
		} else {
			$this->request->data = $this->User->read(null, $id);
		}
		$userRoles = $this->User->UserRole->find('list');
		$people = $this->User->Person->find('list');
		$this->set(compact('userRoles', 'people'));

		// set title
		$this->set('title_for_layout', __('Edit user'));
	}

	/**
	 * delete method
	 *
	 * @throws MethodNotAllowedException
	 * @throws NotFoundException
	 * @param string $id
	 * @return void
	 */
	public function delete($id = null) {
		if (!$this->request->is('post')) {
			throw new MethodNotAllowedException();
		}
		$this->User->id = $id;
		if (!$this->User->exists()) {
			throw new NotFoundException(__('Invalid user'));
		}
		if ($this->User->delete()) {
			$this->Session->setFlash(__('User deleted'));
			$this->redirect(array('action' => 'index'));
		}
		$this->Session->setFlash(__('User was not deleted'));
		$this->redirect(array('action' => 'index'));

		// set title
		$this->set('title_for_layout', __('Delete user'));
	}
}

/* EOF */

