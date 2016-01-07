function utilService(globalConfig) {

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


    return object;
};


/**
 * Pass function into module
 */
angular
    .module('homer')
    .factory('utilService', utilService);
