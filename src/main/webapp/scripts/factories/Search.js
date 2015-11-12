function Search($http, $cacheFactory, globalConfig, crudService) {
	var object = {};
	object.global = crudService.globalConfig;
	return {
		get: function(payload, dataUrl, successCallback){
		var key = 'search_' + payload.q;
		if($cacheFactory.get(key) == undefined || $cacheFactory.get(key) == ''){
		var hasUsers = crudService.listSearch(dataUrl+"?q=" + payload.q +"&");
		hasUsers.then(function(data){
		$cacheFactory(key).put('result', data);
		successCallback(data);
		});
		}else{
		successCallback($cacheFactory.get(key).get('result'));
		}
		}
		}
};
angular.module('homer')
        .factory('Search', Search);
