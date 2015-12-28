function utilService(globalConfig) {

    var object = {};

    object.getReferenceObjet = function(reference) {
    	referenceObject  = {
    			"id": reference.id,
    			"uuid": reference.uuid
    	};
    	return referenceObject;
    };

    return object;
};


/**
 * Pass function into module
 */
angular
    .module('homer')
    .factory('utilService', utilService);
