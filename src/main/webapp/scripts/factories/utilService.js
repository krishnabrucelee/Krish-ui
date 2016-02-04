function utilService(crudService, promiseAjax, globalConfig) {

    var object = {};

    object.getReferenceObjet = function(reference) {
    	referenceObject  = {
    			"id": reference.id,
    			"uuid": reference.uuid
    	};
    	return referenceObject;
    };

    object.changeSorting = function(column) {
		var sort = globalConfig.sort;

		if (sort.column == column) {
			sort.descending = !sort.descending;
		} else {
			sort.column = column;
			sort.descending = false;
		}
		return sort.descending;
	};

	// Domains List
	object.getDomains = function() {
		var hasDomains = crudService.listAll("domains/list");
		hasDomains.then(function (result) {
			object.domainList = result;
		});
	}

	// Department List By Domain
	object.getDepartmentsByDomain = function(domain) {
		var hasDepartments = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "departments/domain/" +domain.id+ "?lang=" + appService.localStorageService.cookie.get('language'));
	    hasDepartments.then(function (result) {  // this is only run after $http completes0
	    	return result;
	    });
	}

	// Project List by department
	object.getProjectByDepartment = function(department) {
		var hasProjects = promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "projects/departments/" +department.id+ "?lang=" + appService.localStorageService.cookie.get('language'));
		hasProjects.then(function (result) {  // this is only run after $http completes0
	    	return result;
	    });
	}

    return object;
};


/**
 * Pass function into module
 */
angular
    .module('homer')
    .factory('utilService', utilService);
