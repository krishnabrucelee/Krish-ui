function appService(crudService, localStorageService, globalConfig, promiseAjax, notify, utilService,  dialogService) {

	var object = {};

	// Crud related functionalities goes here
	object.crudService = crudService;

	// Local storage service to store data in client side
	object.localStorageService = localStorageService;

	// Global configuration to add configuration vlaues
    object.globalConfig = globalConfig;

    // Application ajax calls goes here
    object.promiseAjax = promiseAjax

    // Application notification
    object.notify = notify

    // Applicaiton Utilities
    object.utilService = utilService

 // Application ajax calls goes here
    object.dialogService = dialogService

    return object;

};


/**
 * Pass function into module
 */
angular
    .module('homer')
    .factory('appService', appService);
