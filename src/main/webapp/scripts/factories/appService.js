function appService(crudService, localStorageService, globalConfig, promiseAjax, notify, utilService,  dialogService, monitorService) {

	var object = {};

	// Crud related functionalities goes here
	object.crudService = crudService;

	// Local storage service to store data in client side
	object.localStorageService = localStorageService;

	// Global configuration to add configuration vlaues
    object.globalConfig = globalConfig;

    // Promise ajax call goes here
    object.promiseAjax = promiseAjax

    // Application notification
    object.notify = notify

    // Applicaiton Utilities
    object.utilService = utilService

    // Dialog Service call goes here
    object.dialogService = dialogService

    // Model service call goes here
    object.modalService = modalService

    // Volume service call goes here
    object.volumeService = volumeService

    // Instance monitoring chart calls goes here
    object.monitorService = monitorService

    return object;

};


/**
 * Pass function into module
 */
angular
    .module('homer')
    .factory('appService', appService);
