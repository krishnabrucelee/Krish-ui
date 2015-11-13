function crudService($window, localStorageService, globalConfig, $stateParams, promiseAjax) {

    var object = {};

    object.globalConfig = globalConfig;

    // List all the objects    object.setModuleName = function(moduleName) {
    object.list = function(moduleName, headers, data) {
        return promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + moduleName +"?lang=" + localStorageService.cookie.get('language') + "&sortBy=ASC&limit="+data.limit, headers, data);
    };

    object.listAll = function(moduleName) {
        return promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + moduleName +"?lang=" + localStorageService.cookie.get('language'));
    };

    object.listSearch = function(moduleName) {
        return promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + moduleName +"lang=" + localStorageService.cookie.get('language'));
    };

    object.vmUpdate = function(moduleName,Id,event) {
        return promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + moduleName +"?lang=" + localStorageService.cookie.get('language')+"&vm="+Id+"&event=" + event);
    };

    object.add = function(moduleName, object) {
        return promiseAjax.httpTokenRequest( globalConfig.HTTP_POST, globalConfig.APP_URL + moduleName +"?lang=" + localStorageService.cookie.get('language'), '', object);
    };

    object.read = function(moduleName, id) {
        return promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + moduleName  +"/"+id+"?lang=" + localStorageService.cookie.get('language'), '');
    };

    object.update = function(moduleName, object) {
        return promiseAjax.httpTokenRequest( globalConfig.HTTP_PUT , globalConfig.APP_URL + moduleName  +"/"+object.id+"?lang=" + localStorageService.cookie.get('language'), '', object);
    };

    object.listAllByFilter = function(moduleName, object) {
        return promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + moduleName +"?dept=" +object.id+ "&lang=" + localStorageService.cookie.get('language'));
    };

object.listAllByTag = function(moduleName, val) {
        return promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + moduleName +"?tags=" +val);
    };

    object.delete = function(moduleName, id) {
        return promiseAjax.httpTokenRequest( globalConfig.HTTP_DELETE , globalConfig.APP_URL + moduleName  +"/"+id+"?lang=" + localStorageService.cookie.get('language'), '');
    };

    object.softDelete = function(moduleName, object) {
        return promiseAjax.httpTokenRequest( globalConfig.HTTP_DELETE , globalConfig.APP_URL + moduleName  +"/delete/"+object.id+"?lang=" + localStorageService.cookie.get('language'), '', object);
    };


    return object;
};


/**
 * Pass function into module
 */
angular
    .module('homer')
    .factory('crudService', crudService);
