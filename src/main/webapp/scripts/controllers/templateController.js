/**
 *
 * templatesCtrl
 *
 */

angular
        .module('homer')
        .controller('templatesCtrl', templatesCtrl)
        .controller('templateDetailsCtrl', templateDetailsCtrl)
        .controller('uploadTemplateCtrl', uploadTemplateCtrl)

function templatesCtrl($scope, $stateParams, appService, $timeout, promiseAjax, globalConfig, $modal, $log, localStorageService) {

    $scope.global = globalConfig;
    $scope.sort = appService.globalConfig.sort;
    $scope.paginationObject = {};
    $scope.changeSorting = appService.utilService.changeSorting;
    $scope.template = {
        templateList: {}
    };
/** $scope.template = {
        listFeaturedTemplate: {}
    };
**/


 $scope.templates = {};
$scope.template.listAllTemplate = {};
 $scope.TemplateForm = {};
    $scope.paginationObject.sortOrder = '+';
    $scope.paginationObject.sortBy = 'name';

    Math.round = (function() {
    	  var originalRound = Math.round;
    	  return function(number, precision) {
    	    precision = Math.abs(parseInt(precision)) || 0;
    	    var multiplier = Math.pow(10, precision);
    	    return (originalRound(number * multiplier) / multiplier);
    	  };
    	})();

        $scope.changeSort = function(sortBy, pageNumber,communityGridTemplate) {
	if(angular.isUndefined(communityGridTemplate)) {
		communityGridTemplate = "ALL";
	}
	else if (!angular.isUndefined(communityGridTemplate) && communityGridTemplate != null) {
		communityGridTemplate = communityGridTemplate;
	}
		var sort = appService.globalConfig.sort;
		if (sort.column == sortBy) {
			sort.descending = !sort.descending;
		} else {
			sort.column = sortBy;
			sort.descending = false;
		}
		var sortOrder = '-';
		if(!sort.descending){
			sortOrder = '+';
		}
		$scope.paginationObject.sortOrder = sortOrder;
		$scope.paginationObject.sortBy = sortBy;
		$scope.showLoader = true;
		var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
if (((angular.isUndefined($scope.communityGridTemplate)) || $scope.communityGridTemplate == "ALL") && $scope.templateCommunityListSearch == null) {
        var hasCommunityList = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "templates/listalltemplateforadmin" +"?lang=" + localStorageService.cookie.get('language') +"&sortBy="+appService.globalConfig.sort.sortOrder+appService.globalConfig.sort.sortBy +"&type=community"+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
}
else {
if ($scope.templateCommunityListSearch != null) {
	$scope.filter = "&searchText=" + $scope.templateCommunityListSearch;
}
if ($scope.communityGridTemplate != "ALL" && $scope.templateCommunityListSearch == null) {
		$scope.filter = "&typeView="+ communityGridTemplate + "&searchText=";
	}
if ($scope.communityGridTemplate == "ALL" && $scope.templateCommunityListSearch != null) {
		$scope.filter = "&typeView="+ communityGridTemplate + "&searchText=" + $scope.templateCommunityListSearch;
	}
if ($scope.communityGridTemplate != "ALL" && $scope.templateCommunityListSearch != null) {
		$scope.filter = "&typeView="+ communityGridTemplate + "&searchText=" + $scope.templateCommunityListSearch ;
	}

var hasCommunityList = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "templates/listall" +"?lang=" + localStorageService.cookie.get('language')+ $scope.filter +"&sortBy="+appService.globalConfig.sort.sortOrder+appService.globalConfig.sort.sortBy +"&type=community"+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
	}


                    hasCommunityList.then(function(result) { // this is only run after $http
			// completes0
			$scope.communityList = result;
			// For pagination
			$scope.paginationObject.limit = limit;
			$scope.paginationObject.currentPage = pageNumber;
			$scope.paginationObject.totalItems = result.totalItems;
			$scope.paginationObject.sortOrder = sortOrder;
			$scope.paginationObject.sortBy = sortBy;
			$scope.showLoader = false;
		});
	};


$scope.quickVmSearch = null;

    $scope.searchVMList = function(quickVmSearch,communityGridTemplate) {
        $scope.quickVmSearch = quickVmSearch;

if(angular.isUndefined(communityGridTemplate)) {
	communityGridTemplate = "ALL";
}
else if (!angular.isUndefined(communityGridTemplate) && communityGridTemplate != null) {
	communityGridTemplate = communityGridTemplate.name;
}
        $scope.templateList(communityGridTemplate);
    };


   /** $scope.templateList = function () {

        $scope.showLoader = true;
if ($scope.quickVmSearch == null) {
   var hastemplatesList= appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "templates/listalltemplateByType?type="+ "community"+"&sortBy=-id");

}
if ($scope.quickVmSearch != null) {
	$scope.filter = "&searchText=" + $scope.quickVmSearch;
   var hastemplatesList= appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "templates/listalltemplateByTypeSearchText?type="+ "community"+ $scope.filter +"&sortBy=-id");
}
        hastemplatesList.then(function (result) {  // this is only run after $http completes0
            $scope.showLoader = true;
            $scope.template.listCommunityTemplate = result;
           $scope.showLoader = false;
        });
    };
    $scope.templateList();**/

// Community Grid :
$scope.gridElements = {
        communityGridList: [{
            id: 0,
            name: 'ISO'
        }, {
            id: 1,
            name: 'TEMPLATE'
        }, ]
    };

    $scope.templateList = function (communityGridTemplate) {
if(angular.isUndefined(communityGridTemplate)) {
	communityGridTemplate = "ALL";
}
$scope.communityGridTemplates = communityGridTemplate;
        $scope.showLoader = true;
if (((angular.isUndefined($scope.communityGridTemplates)) || $scope.communityGridTemplates == "ALL") && $scope.quickVmSearch == null){
   var hastemplatesList= appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "templates/listalltemplateByType?type="+ "community"+"&sortBy=-id");

} else {
	if ($scope.communityGridTemplates != "ALL" && $scope.quickVmSearch == null) {
		$scope.filter = "&gridViewType="+ communityGridTemplate + "&searchText=";
	}
	if ($scope.communityGridTemplates != "ALL" && $scope.quickVmSearch != null) {
		$scope.filter = "&gridViewType="+ communityGridTemplate + "&searchText=" + $scope.quickVmSearch;
	}
if ($scope.communityGridTemplates == "ALL" && $scope.quickVmSearch != null) {
		$scope.filter = "&gridViewType="+ communityGridTemplate + "&searchText=" + $scope.quickVmSearch;
	}
   var hastemplatesList= appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "templates/listalltemplateByTypeSearchText?type="+ "community"+ $scope.filter +"&sortBy=-id");

}
        hastemplatesList.then(function (result) {  // this is only run after $http completes0
            $scope.showLoader = true;
            $scope.template.listCommunityTemplate = result;
           $scope.showLoader = false;
        });
    };
 $scope.templateList("ALL");

$scope.featureSearch = null;

    $scope.featureSearchList = function(featureSearch,templateTypes) {
        $scope.featureSearch = featureSearch;

if(angular.isUndefined(templateTypes)) {
	templateTypes = "ALL";
}
else if (!angular.isUndefined(templateTypes) && templateTypes != null) {
	templateTypes = templateTypes.name;
}
        $scope.featuredTemplateList(templateTypes);
    };


   $scope.featuredTemplateList = function (templateTypes) {
if(angular.isUndefined(templateTypes)) {
	templateTypes = "ALL";
}
$scope.templateTypes = templateTypes;
        $scope.showLoader = true;
if (((angular.isUndefined($scope.templateTypes)) || $scope.templateTypes == "ALL") && $scope.featureSearch == null) {
   var hasfeaturetemplatesList= appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "templates/listalltemplateByType?type="+ "featured"+"&sortBy=-id");
} else {
	if ($scope.templateTypes != "ALL" && $scope.featureSearch == null) {
		$scope.filter = "&gridViewType="+ templateTypes + "&searchText=";
	}
	if ($scope.templateTypes != "ALL" && $scope.featureSearch != null) {
		$scope.filter = "&gridViewType="+ templateTypes + "&searchText=" + $scope.featureSearch;
	}
	if ($scope.templateTypes == "ALL" && $scope.featureSearch != null) {
		$scope.filter = "&gridViewType="+ templateTypes + "&searchText=" + $scope.featureSearch;
	}
   var hasfeaturetemplatesList= appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "templates/listalltemplateByTypeSearchText?type="+ "featured"+ $scope.filter +"&sortBy=-id");

}
        hasfeaturetemplatesList.then(function (result) {  // this is only run after $http completes0
            $scope.showLoader = true;
            $scope.template.listFeaturedTemplate = result;
           $scope.showLoader = false;
        });
    };
$scope.featuredTemplateList("ALL");

$scope.templateCommunityListSearch = null;
    $scope.searchList = function(templateCommunityListSearch,communityGridTemplate) {
        $scope.templateCommunityListSearch = templateCommunityListSearch;
if(angular.isUndefined(communityGridTemplate)) {
	communityGridTemplate = "ALL";
}
else if (!angular.isUndefined(communityGridTemplate) && communityGridTemplate != null) {
	communityGridTemplate = communityGridTemplate.name;
}
        $scope.list(1,communityGridTemplate);
    };


    $scope.communitylist = function () {

$scope.formElements = {
        communitytypeList: [{
            id: 0,
            name: 'ISO'
        }, {
            id: 1,
            name: 'TEMPLATE'
        }, ]
    };

    $scope.formElements.category = 'community';

    //community List
    $scope.list = function (pageNumber,communityGridTemplate) {
if((angular.isUndefined(communityGridTemplate)) || $scope.communityGridTemplate == null ) {
	communityGridTemplate = "ALL";
}
$scope.communityGridTemplate = communityGridTemplate;
        appService.globalConfig.sort.sortOrder = $scope.paginationObject.sortOrder;
        appService.globalConfig.sort.sortBy = $scope.paginationObject.sortBy;
    	$scope.showLoader = true;
    	var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;

 if (((angular.isUndefined($scope.communityGridTemplate)) || $scope.communityGridTemplate == "ALL") && $scope.templateCommunityListSearch == null) {
        var hasCommunity = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "templates/listalltemplateforadmin" +"?lang=" + localStorageService.cookie.get('language') +"&sortBy="+appService.globalConfig.sort.sortOrder+appService.globalConfig.sort.sortBy +"&type=community"+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
}
else {
if ($scope.communityGridTemplate != "ALL" && $scope.templateCommunityListSearch == null) {
		$scope.filter = "&typeView="+ communityGridTemplate + "&searchText=";
	}
if ($scope.communityGridTemplate == "ALL" && $scope.templateCommunityListSearch != null) {
		$scope.filter = "&typeView="+ communityGridTemplate + "&searchText=" + $scope.templateCommunityListSearch;
	}
if ($scope.communityGridTemplate != "ALL" && $scope.templateCommunityListSearch != null) {
		$scope.filter = "&typeView="+ communityGridTemplate + "&searchText=" + $scope.templateCommunityListSearch ;
	}
var hasCommunity = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "templates/listall" +"?lang=" + localStorageService.cookie.get('language')+ encodeURI($scope.filter) +"&sortBy="+appService.globalConfig.sort.sortOrder+appService.globalConfig.sort.sortBy +"&type=community"+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
	}
        hasCommunity.then(function (result) {  // this is only run after $http completes0
            $scope.communityList = result;
            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.showLoader = false;
        });
    };
    $scope.list (1, "ALL");

    }




$scope.templateFeaturedListSearch = null;
    $scope.searchFeaturedList = function(templateFeaturedListSearch,templateType) {
        $scope.templateFeaturedListSearch = templateFeaturedListSearch;

if(angular.isUndefined(templateType)) {
	templateType = "ALL";
}
else if (!angular.isUndefined(templateType) && templateType != null) {
	templateType = templateType.name;
}
        $scope.list(1,templateType);
    };

  $scope.changeSorts = function(sortBy, pageNumber,templateType) {
		if(angular.isUndefined(templateType)) {
			templateType = "ALL";
		}
		else if (!angular.isUndefined(templateType) && templateType != null) {
			templateType = templateType;
		}
		var sort = appService.globalConfig.sort;
		if (sort.column == sortBy) {
			sort.descending = !sort.descending;
		} else {
			sort.column = sortBy;
			sort.descending = false;
		}
		var sortOrder = '-';
		if(!sort.descending){
			sortOrder = '+';
		}
		$scope.paginationObject.sortOrder = sortOrder;
		$scope.paginationObject.sortBy = sortBy;
		$scope.showLoader = true;
		var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
	if (((angular.isUndefined($scope.templateType)) || $scope.templateType == "ALL") && $scope.templateFeaturedListSearch == null) {
        var hasFeaturedList = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "templates/listalltemplateforadmin" +"?lang=" + localStorageService.cookie.get('language') +"&sortBy="+appService.globalConfig.sort.sortOrder+appService.globalConfig.sort.sortBy +"&type=featured"+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
}
else {
if ($scope.templateFeaturedListSearch != null) {
	$scope.filter = "&searchText=" + $scope.templateFeaturedListSearch;
}

if ($scope.templateType != "ALL" && $scope.templateFeaturedListSearch == null) {
		$scope.filter = "&typeView="+ templateType + "&searchText=";
	}
if ($scope.templateType == "ALL" && $scope.templateFeaturedListSearch != null) {
		$scope.filter = "&typeView="+ templateType + "&searchText=" + $scope.templateFeaturedListSearch;
	}
if ($scope.templateType != "ALL" && $scope.templateFeaturedListSearch != null) {
		$scope.filter = "&typeView="+ templateType + "&searchText=" + $scope.templateFeaturedListSearch ;
	}
var hasFeaturedList = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "templates/listall" +"?lang=" + localStorageService.cookie.get('language')+ $scope.filter +"&sortBy="+appService.globalConfig.sort.sortOrder+appService.globalConfig.sort.sortBy +"&type=featured"+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});

}

                    hasFeaturedList.then(function(result) { // this is only run after $http
			// completes0
			$scope.featuredList = result;
			// For pagination
			$scope.paginationObject.limit = limit;
			$scope.paginationObject.currentPage = pageNumber;
			$scope.paginationObject.totalItems = result.totalItems;
			$scope.paginationObject.sortOrder = sortOrder;
			$scope.paginationObject.sortBy = sortBy;
			$scope.showLoader = false;
		});
	};


   $scope.featuredlist = function () {

 $scope.formElements = {
        typeList: [{
            id: 0,
            name: 'ISO'
        }, {
            id: 1,
            name: 'TEMPLATE'
        }, ]
    };

   $scope.formElements.category = 'featured';



    //featured List
    $scope.list = function (pageNumber,templateType) {
if(angular.isUndefined(templateType)) {
	templateType = "ALL";
}
$scope.templateType = templateType;
        appService.globalConfig.sort.sortOrder = $scope.paginationObject.sortOrder;
        appService.globalConfig.sort.sortBy = $scope.paginationObject.sortBy;
    	$scope.showLoader = true;
    	var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
 if (((angular.isUndefined($scope.templateType)) || $scope.templateType == "ALL") && $scope.templateFeaturedListSearch == null) {
        var hasFeatured = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "templates/listalltemplateforadmin" +"?lang=" + localStorageService.cookie.get('language') +"&sortBy="+appService.globalConfig.sort.sortOrder+appService.globalConfig.sort.sortBy +"&type=featured"+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
} else {
	if ($scope.templateType != "ALL" && $scope.templateFeaturedListSearch == null) {
		$scope.filter = "&typeView="+ templateType + "&searchText=";
	}
	if ($scope.templateType != "ALL" && $scope.templateFeaturedListSearch != null) {
		$scope.filter = "&typeView="+ templateType + "&searchText=" + $scope.templateFeaturedListSearch;
	}
if ($scope.templateType == "ALL" && $scope.templateFeaturedListSearch != null) {
		$scope.filter = "&typeView="+ templateType + "&searchText=" + $scope.templateFeaturedListSearch;
	}
//$scope.filter = "&searchText=" + $scope.templateFeaturedListSearch;
var hasFeatured = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "templates/listall" +"?lang=" + localStorageService.cookie.get('language')+ encodeURI($scope.filter) +"&sortBy="+appService.globalConfig.sort.sortOrder+appService.globalConfig.sort.sortBy +"&type=featured"+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
	}
        hasFeatured.then(function (result) {  // this is only run after $http completes0
            $scope.featuredList = result;
            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.showLoader = false;
        });
    };
    $scope.list(1,"ALL");
   }


  /** $scope.selectTypeView = function(pageNumber,templateType) {
	alert(pageNumber+ templateType);
   	$scope.list(1);
   };**/


$scope.vmSearch = null;
    $scope.vmSearchList = function(vmSearch,userListTemplateType) {
        $scope.vmSearch = vmSearch;
if(angular.isUndefined(userListTemplateType)) {
	userListTemplateType = "ALL";
}
else if (!angular.isUndefined(userListTemplateType) && userListTemplateType != null) {
	userListTemplateType = userListTemplateType.name;
}
         $scope.list(1,userListTemplateType);
    };

   $scope.changeSortings = function(sortBy, pageNumber,userListTemplateType) {
		if(angular.isUndefined(userListTemplateType)) {
			userListTemplateType = "ALL";
		}
		else if (!angular.isUndefined(userListTemplateType) && userListTemplateType != null) {
			userListTemplateType = userListTemplateType;
		}
		var sort = appService.globalConfig.sort;
		if (sort.column == sortBy) {
			sort.descending = !sort.descending;
		} else {
			sort.column = sortBy;
			sort.descending = false;
		}
		var sortOrder = '-';
		if(!sort.descending){
			sortOrder = '+';
		}
		$scope.paginationObject.sortOrder = sortOrder;
		$scope.paginationObject.sortBy = sortBy;
		$scope.showLoader = true;
		var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
	if (((angular.isUndefined($scope.userListTemplateType)) || $scope.userListTemplateType == "ALL") && $scope.vmSearch == null) {
        var hasUserTemplateList = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "templates/listalltemplateforadmin" +"?lang=" + localStorageService.cookie.get('language') +"&sortBy="+appService.globalConfig.sort.sortOrder+appService.globalConfig.sort.sortBy +"&type=user"+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
}
else {
	if ($scope.userListTemplateType != "ALL" && $scope.vmSearch == null) {
		$scope.filter = "&typeView="+ userListTemplateType + "&searchText=";
	}
	if ($scope.userListTemplateType == "ALL" && $scope.vmSearch != null) {
		$scope.filter = "&typeView="+ userListTemplateType + "&searchText=" + $scope.vmSearch;
	}
	if ($scope.userListTemplateType != "ALL" && $scope.vmSearch != null) {
		$scope.filter = "&typeView="+ userListTemplateType + "&searchText=" + $scope.vmSearch ;
	}

var hasUserTemplateList = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "templates/listall" +"?lang=" + localStorageService.cookie.get('language')+ $scope.filter +"&sortBy="+appService.globalConfig.sort.sortOrder+appService.globalConfig.sort.sortBy +"&type=user"+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});

}


                    hasUserTemplateList.then(function(result) { // this is only run after $http
			// completes0
			$scope.userTemplateList = result;
			// For pagination
			$scope.paginationObject.limit = limit;
			$scope.paginationObject.currentPage = pageNumber;
			$scope.paginationObject.totalItems = result.totalItems;
			$scope.paginationObject.sortOrder = sortOrder;
			$scope.paginationObject.sortBy = sortBy;
			$scope.showLoader = false;
		});
	};



$scope.mySearch = null;
    $scope.mySearchList = function(mySearch,userGridTemplate) {
        $scope.mySearch = mySearch;
if(angular.isUndefined(userGridTemplate)) {
	userGridTemplate = "ALL";
}
else if (!angular.isUndefined(userGridTemplate) && userGridTemplate != null) {
	userGridTemplate = userGridTemplate.name;
}

        $scope.userCreatedtemplatelist(userGridTemplate);
};

$scope.templateElements = {
        usertypeList: [{
            id: 0,
            name: 'ISO'
        }, {
            id: 1,
            name: 'TEMPLATE'
        }, ]
    };


  $scope.userCreatedtemplatelist = function (userGridTemplate) {
$scope.usertemplateTypes = userGridTemplate;
if(angular.isUndefined(userGridTemplate)) {
	userGridTemplate = "ALL";
}
	if (((angular.isUndefined($scope.usertemplateTypes)) || $scope.usertemplateTypes == "ALL") && $scope.mySearch == null){
     var hastemplates = appService.crudService.listAll("templates/listalltemplate");
	}
else {
	if ($scope.usertemplateTypes != "ALL" && $scope.mySearch == null) {
		$scope.filter = "&gridViewType="+ userGridTemplate + "&searchText=";
	}
	if ($scope.usertemplateTypes != "ALL" && $scope.mySearch != null) {
		$scope.filter = "&gridViewType="+ userGridTemplate + "&searchText=" + $scope.mySearch;
	}
	if ($scope.usertemplateTypes == "ALL" && $scope.mySearch != null) {
		$scope.filter = "&gridViewType="+ userGridTemplate + "&searchText=" + $scope.mySearch;
	}
  var hastemplates =  appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "templates/listalltemplateSearchText?type="+ "userstemplate"+ $scope.filter +"&sortBy=-id");

}
        hastemplates.then(function (result) {  // this is only run after $http completes0
            $scope.template.listAllTemplate = result;
            $scope.showLoader = false;
        });
}
$scope.userCreatedtemplatelist();





   $scope.usertemplatelist = function () {
   $scope.formElements.category = 'mytemplates';

    //Mytemplate List
   $scope.userTemplatePage = function (userListTemplateType) {

	   if(angular.isUndefined(userListTemplateType)) {
			userListTemplateType = "ALL";
		}

	   $scope.list = function (pageNumber) {
$scope.userListTemplateType = userListTemplateType;
        appService.globalConfig.sort.sortOrder = $scope.paginationObject.sortOrder;
        appService.globalConfig.sort.sortBy = $scope.paginationObject.sortBy;
    	$scope.showLoader = true;

    	var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
 if (((angular.isUndefined($scope.userListTemplateType)) || $scope.userListTemplateType == "ALL") && $scope.vmSearch == null){
        var hasFeatured = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "templates/listalltemplateforadmin" +"?lang=" + localStorageService.cookie.get('language') +"&sortBy="+appService.globalConfig.sort.sortOrder+appService.globalConfig.sort.sortBy +"&type=user"+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});
}
else {
if ($scope.userListTemplateType != "ALL" && $scope.vmSearch == null) {
		$scope.filter = "&typeView="+ userListTemplateType + "&searchText=";
	}
	if ($scope.userListTemplateType != "ALL" && $scope.vmSearch != null) {
		$scope.filter = "&typeView="+ userListTemplateType + "&searchText=" + $scope.vmSearch;
	}
if ($scope.userListTemplateType == "ALL" && $scope.vmSearch != null) {
		$scope.filter = "&typeView="+ userListTemplateType + "&searchText=" + $scope.vmSearch;
	}
var hasFeatured = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET, globalConfig.APP_URL + "templates/listall" +"?lang=" + localStorageService.cookie.get('language')+ encodeURI($scope.filter) +"&sortBy="+appService.globalConfig.sort.sortOrder+appService.globalConfig.sort.sortBy +"&type=user"+"&limit="+limit, $scope.global.paginationHeaders(pageNumber, limit), {"limit" : limit});

}
        hasFeatured.then(function (result) {  // this is only run after $http completes0
            $scope.userTemplateList = result;
            // For pagination
            $scope.paginationObject.limit = limit;
            $scope.paginationObject.currentPage = pageNumber;
            $scope.paginationObject.totalItems = result.totalItems;
            $scope.showLoader = false;
        });
    };
    $scope.list (1);
   }
   $scope.userTemplatePage("ALL");
   }

    $scope.showCommunityTemplateContent = function () {
        $scope.showLoader = true;
        $timeout(function () {
            $scope.showLoader = false;
            $scope.listView = !$scope.listView;
        }, 800);
	$scope.communitylist();
    };

    $scope.showFeaturedTemplateContent = function () {
        $scope.showLoader = true;
        $timeout(function () {
            $scope.showLoader = false;
            $scope.listView = !$scope.listView;
        }, 800);
    $scope.featuredlist();
    };

   $scope.showUserTemplateContent = function () {
        $scope.showLoader = true;
        $timeout(function () {
            $scope.showLoader = false;
            $scope.listView = !$scope.listView;
        }, 800);
    $scope.usertemplatelist();
    };

 $scope.showCommunityRefresh = function () {
        $scope.showLoader = true;
        $timeout(function () {
            $scope.showLoader = false;
            $scope.listView = $scope.listView;
        }, 800);
    };

 $scope.showFeaturedRefresh = function () {
        $scope.showLoader = true;
        $timeout(function () {
            $scope.showLoader = false;
            $scope.listView = $scope.listView;
        }, 800);
    };

 $scope.showuserTemplateRefresh = function () {
        $scope.showLoader = true;
        $timeout(function () {
            $scope.showLoader = false;
            $scope.listView = $scope.listView;
        }, 800);
    };

	 // OS Categorys list from server
    $scope.oscategorys = {};
    var hasOsCategoryList = appService.crudService.listAll("oscategorys/list");
    hasOsCategoryList.then(function (result) {
    	$scope.formElements.osCategoryList = result;
    });

    // OS Type list from server
    $scope.categoryChange = function() {
        $scope.ostypes = {};
        var hasosTypeList = appService.crudService.filterList("ostypes/list", $scope.templates.osCategory.name);
        hasosTypeList.then(function (result) {
    	    $scope.formElements.osTypeList = result;
        });
    };

	 // Hypervisors list from server
    $scope.hypervisors = {};
    appService.globalConfig.sort.sortOrder = $scope.paginationObject.sortOrder;
    appService.globalConfig.sort.sortBy = $scope.paginationObject.sortBy;
    var limit = (angular.isUndefined($scope.paginationObject.limit)) ? $scope.global.CONTENT_LIMIT : $scope.paginationObject.limit;
    var hashypervisorList = appService.crudService.list("hypervisors", $scope.global.paginationHeaders(1, limit), {"limit": limit});
    hashypervisorList.then(function (result) {
    	$scope.formElements.hypervisorList = result;
    });


	  $scope.templateCostList = function () {
        $scope.showLoader = true;
        var hastemplateList = appService.crudService.listAll("miscellaneous/listtemplate");
        hastemplateList.then(function (result) {  // this is only run after $http completes0
            $scope.miscellaneousList = result;
            $scope.showLoader = false;
        });

    };
    $scope.templateCostList();

    $scope.formElements = {
            rootDiskControllerList: {
                "0":"SCSI",
                "1":"IDE"
            },
            nicTypeList: {
          	  "0":"E1000",
          	  "1":"PCNET32",
          	  "2":"VMXNET2",
          	  "3":"VMXNET3"
            },
            keyboardTypeList: {
          	  "0":"US_KEYBOARD",
          	  "1":"UK_KEYBOARD",
          	  "2":"JAPANESE_KEYBOARD",
          	  "3":"SIMPLIFIED_CHINESE"
            },
            formatList: {
                         "Hyperv" : {
  			        	  "0":"VHD",
  			        	  "1":"VHDX",
  			           },
  			           "VMware" :
  			           {
  			        	  "0":"OVA",
  			           },
  			           "KVM" :
  			           {
  			        	  "0":"QCOW2",
  			        	  "1":"RAW",
  			        	  "2":"VHD",
  			        	  "3":"VMDK",
  			           },
  			           "XenServer" :
  			           {
  			        	  "0":"VHD",
  			           },
  			           "BareMetal" :
  			           {
  			        	  "0":"BAREMETAL",
  			           },
  			           "LXC" :
  			           {
  			        	  "0":"TAR",
  			           },
  			           "Ovm" :
  			           {
  			        	  "0":"RAW",
  			          }
  		          }
      }

    // Zone list from server
    $scope.zones = {};
    var haszoneList = appService.crudService.listAll("zones/list");
    haszoneList.then(function (result) {
    	$scope.formElements.zoneList = result;
    });



     $scope.uploadTemplateContainer = function (size){
           appService.dialogService.openDialog("app/views/templates/upload.jsp", 'lg', $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {
     $scope.save = function (form,templates) {

        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.showLoader = true;
            var template = angular.copy(templates);
            	template.zoneId = template.zone.id;
            template.hypervisorId = template.hypervisor.id;
            template.osCategoryId = template.osCategory.id;
            template.osTypeId = template.osType.id;
	    template.templateCreationType = true ;
            delete template.zone;
            delete template.hypervisor;
            delete template.osCategory;
            delete template.osType;
            var hasTemplate = appService.crudService.add("templates", template);
            hasTemplate.then(function (result) {  // this is only run after $http completes
                $scope.showLoader = false;
		 $modalInstance.close();
                appService.notify({message: 'Template created successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                if(template.format == "ISO") {
                        	$scope.isolist(1);
                } else {
                        	$scope.list(1);
                }

            }).catch(function (result) {
                if (!angular.isUndefined(result.data)) {
                	if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                  	    var msg = result.data.globalError[0];
                  	  $scope.showLoader = false;
                  	appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                    } else if (result.data.fieldErrors != null) {
                        angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                            $scope.TemplateForm[key].$invalid = true;
                            $scope.TemplateForm[key].errorMessage = errorMessage;
                        });
                	}
                }
            });
        }
    },
 $scope.cancel = function () {
                    $modalInstance.close();
                };
   }]);
    };


    // Delete the template
    $scope.delete = function (size, templateId) {
    	var hasTemplateRead = appService.crudService.read("templates", templateId);
     	hasTemplateRead.then(function (template) {
    	appService.dialogService.openDialog("app/views/templates/confirm-delete.jsp", size, $scope, ['$scope', '$modalInstance', function ($scope, $modalInstance) {
                $scope.deleteId = template.id;
                $scope.ok = function (deleteId) {
                	$scope.showLoader = true;
                    var hasStorage = appService.crudService.delete("templates", deleteId);
                    hasStorage.then(function (result) {
                        $scope.homerTemplate = 'app/views/notification/notify.jsp';
                        $scope.showLoader = false;
                        $modalInstance.close();
                        appService.notify({message: 'Template deleted successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
                        if(template.format == "ISO") {
                        	$scope.isolist(1);
                        } else {
                        	$scope.list(1);
                        }
                    }).catch(function (result) {
                        if (!angular.isUndefined(result.data)) {
                        	if (result.data.globalError[0] != '' && !angular.isUndefined(result.data.globalError[0])) {
                          	    var msg = result.data.globalError[0];
                          	    $scope.showLoader = false;
                          	    appService.notify({message: msg, classes: 'alert-danger', templateUrl: $scope.global.NOTIFICATION_TEMPLATE });
                            }
                        	$modalInstance.close();
                        }
                    });
                },
                $scope.cancel = function () {
                    $modalInstance.close();
                };
            }]);
     	});
    };


    if (!angular.isUndefined($stateParams.id) && $stateParams.id != '') {
        $scope.edit($stateParams.id)
    }


 $scope.editTemplateContainer = function (size, templateId){
	var hasTemplateRead = appService.crudService.read("templates", templateId);
 	hasTemplateRead.then(function (templateObj) {
	$scope.templates = templateObj;
           appService.dialogService.openDialog("app/views/templates/edit-template.jsp", 'lg', $scope, ['$scope', '$modalInstance', '$rootScope', function ($scope, $modalInstance, $rootScope) {

$scope.oscategorys = {};
    $scope.getOsCategoryList = function() {
	    var hasOsCategoryList = appService.crudService.listAll("oscategorys/list");
	    hasOsCategoryList.then(function (result) {
	    	$scope.formElements.osCategoryList = result;
	    	angular.forEach($scope.formElements.osCategoryList, function(obj, key) {
	    		if(obj.id == $scope.templates.osCategory.id) {
	    			$scope.templates.osCategory = obj;
	    		}
	    	});
	    });
    }
$scope.getOsCategoryList();

    // Edit the Template
    $scope.update = function (form, template) {
        $scope.formSubmitted = true;
        if (form.$valid) {
        	$scope.showLoader = true;
            var template = angular.copy($scope.templates);
            template.zoneId = template.zone.id;
            template.hypervisorId = template.hypervisor.id;
            template.osCategoryId = template.osCategory.id;
            template.osTypeId = template.osType.id;
		    template.templateCreationType = true ;
            delete template.zone;
            delete template.hypervisor;
            delete template.osCategory;
            delete template.osType;
            var hasTemplates = appService.crudService.update("templates", template);
            hasTemplates.then(function (result) {
                $scope.homerTemplate = 'app/views/notification/notify.jsp';
                $scope.showLoader = false;
		$modalInstance.close();
                appService.notify({message: 'Template updated successfully', classes: 'alert-success', templateUrl: $scope.global.NOTIFICATION_TEMPLATE});
                if(template.format == "ISO") {
                        	$scope.isolist(1);
                } else {
                        	$scope.list(1);
                }
            }).catch(function (result) {
                if (!angular.isUndefined(result.data)) {
                	if (result.data.fieldErrors != null) {
                		$scope.showLoader = false;
                        angular.forEach(result.data.fieldErrors, function (errorMessage, key) {
                            $scope.TemplateForm[key].$invalid = true;
                            $scope.TemplateForm[key].errorMessage = errorMessage;
                        });
                	}
                }
            });
        }
    },
 $scope.cancel = function () {
                    $modalInstance.close();
                };
  }]);
 	});
    };


    $scope.openDescription = function (index) {
        angular.forEach($scope.template.listFeaturedTemplate, function (value, key) {
            if (index == key && !$scope.template.listFeaturedTemplate[key].openDescription) {
                $scope.template.listFeaturedTemplate[key].openDescription = true;
            } else {
                $scope.template.listFeaturedTemplate[key].openDescription = false;
            }
        });
    }

  $scope.openCommunityDescription = function (index) {
        angular.forEach($scope.template.listCommunityTemplate, function (value, key) {
            if (index == key && !$scope.template.listCommunityTemplate[key].openCommunityDescription) {
                $scope.template.listCommunityTemplate[key].openCommunityDescription = true;
            } else {
                $scope.template.listCommunityTemplate[key].openCommunityDescription = false;
            }
        });
    }

$scope.openUserDescription = function (index) {
        angular.forEach($scope.template.listAllTemplate, function (value, key) {
            if (index == key && !$scope.template.listAllTemplate[key].openUserDescription) {
                $scope.template.listAllTemplate[key].openUserDescription = true;
            } else {
                $scope.template.listAllTemplate[key].openUserDescription = false;
            }
        });
    }

    // INFO PAGE
    $scope.templateInfo = $scope.template.templateList[$stateParams.id - 1];
    $scope.showDescription = function (templateId) {
    	var hasTemplateRead = appService.crudService.read("templates", templateId);
    	hasTemplateRead.then(function (templateObj) {
        var modalInstance = $modal.open({
            animation: $scope.animationsEnabled,
            templateUrl: 'app/views/templates/properties.jsp',
            controller: 'templateDetailsCtrl',
            size: 'md',
            backdrop: 'static',
            windowClass: "hmodal-info",
            resolve: {
                templateObj: function () {
                    return angular.copy(templateObj);
                }
            }
        });
        modalInstance.result.then(function (selectedItem) {
            $scope.selected = selectedItem;
        });
    	});
    };

    $scope.openAddInstance = function (templateId) {
    	var hasTemplateRead = appService.crudService.read("templates", templateId);
    	hasTemplateRead.then(function (templateObj) {
        appService.localStorageService.set("selectedTemplate", templateObj);
        if(templateObj.format == "ISO") {
            appService.localStorageService.set("view", "iso");
        } else {
        	appService.localStorageService.set("view", "template");
        }
        var modalInstance = $modal.open({
            templateUrl: 'app/views/cloud/instance/add.jsp',
            controller: 'instanceCtrl',
            size: 'lg',
            backdrop: 'static',
            windowClass: "hmodal-info",
            resolve: {
                items: function () {
                    return $scope.items;
                }
            }
        });

        modalInstance.result.then(function (templateObj) {
            $scope.selected = templateObj;
        });
    	});

    };
};



function templateDetailsCtrl($scope, templateObj, globalConfig, $modalInstance) {
    $scope.global = globalConfig;
    $scope.templateObj = templateObj;
    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
}
;

function uploadTemplateCtrl($scope, globalConfig, $modalInstance, notify) {
    $scope.global = globalConfig;
    $scope.formElements = {
        hypervisorList: [
            {
                id: 1,
                name: 'Hyperv',
                formatList: [
                    {id: 1, name: 'VHD'},
                    {id: 2, name: 'VHDX'},
                ]
            },
            {
                id: 2,
                name: 'KVM',
                formatList: [
                    {id: 1, name: 'QCOW2'},
                    {id: 2, name: 'RAW'},
                    {id: 3, name: 'VHD'},
                    {id: 4, name: 'VHDX'},
                ]
            },
            {
                id: 3,
                name: 'XenServer',
                formatList: [
                    {id: 1, name: 'VHD'},
                ]
            },
            {
                id: 4,
                name: 'VMware',
                formatList: [
                    {id: 1, name: 'OVA'},
                ],
                rootDiskControllerList: [
                    {id: 1, name: 'SCSI'},
                    {id: 2, name: 'IDE'},
                ],
                nicTypeList: [
                    {id: 1, name: 'E1000'},
                    {id: 2, name: 'PCNET32'},
                    {id: 3, name: 'VMXNET2'},
                    {id: 4, name: 'VMXNET3'},
                ],
                keyboardTypeList: [
                    {id: 1, name: 'US Keyboard'},
                    {id: 2, name: 'UK Keyboard'},
                    {id: 3, name: 'Japanese Keyboard'},
                    {id: 4, name: 'Simplified Chinese'},
                ],
            },
            {
                id: 5,
                name: 'BareMetal',
                formatList: [
                    {id: 1, name: 'BareMetal'},
                ]
            },
            {
                id: 6,
                name: 'Ovm',
                formatList: [
                    {id: 1, name: 'RAW'},
                ]
            },
            {
                id: 7,
                name: 'LXC',
                formatList: [
                    {id: 1, name: 'TAR'},
                ]
            },
        ],
        osTypeList:[
            {id: 1, name: 'Apple Mac OS X 10.6 (32-bit)'},
            {id: 2, name: 'Apple Mac OS X 10.6 (64-bit)'},
            {id: 3, name: 'CentOS 6.5 (32-bit)'},
            {id: 4, name: 'CentOS 6.5 (64-bit)'},
            {id: 5, name: 'Windows Server 2008 (32-bit)'},
            {id: 6, name: 'Windows Server 2008 (64-bit)'},
        ]
    }
 /**   $scope.save = function (form) {
        $scope.formSubmitted = true;
        if (form.$valid) {
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({message: 'Uploaded successfully', classes: 'alert-success', templateUrl: $scope.homerTemplate});
            $scope.cancel();
        }
    };
    $scope.ok = function () {
        $modalInstance.close();
    };
    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };**/



}

