/**
 *
 * quotaLimitCtrl
 *
 */
angular
    .module('homer')
    .controller('quotaLimitCtrl', quotaLimitCtrl)
    .controller('quotaReasonCtrl', quotaReasonCtrl)

function quotaReasonCtrl($scope, $modalInstance, userForm, quotaReason, notify) {

    $scope.quotaReason = quotaReason;

    $scope.submitForm = function() {
        if ($scope.form.userForm.$valid) {
            $scope.homerTemplate = 'app/views/notification/notify.jsp';
            notify({
                message: 'Request has been sent successfully',
                classes: 'alert-success',
                templateUrl: $scope.homerTemplate
            });
            $modalInstance.close('closed');
        } else {

        }
    };

    $scope.cancel = function() {
        $modalInstance.dismiss('cancel');
    };
};

function quotaLimitCtrl($scope, $state, $stateParams, globalConfig, appService, $window) {

	$scope.global = appService.globalConfig;
	$scope.sort = appService.globalConfig.sort;
	$scope.resourceDomainList = {};
	$scope.resourceQuota = {};
	$scope.resourceTypeList = [ "Instance",
	/** Number of public IP addresses a user can own. */
	"IP",
	/** Number of disk volumes a user can create. */
	"Volume",
	/** Number of snapshots a user can create. */
	"Snapshot",
	/** Number of templates that a user can register/create. */
	"Template",
	/** Number of projects an account can own. */
	"Project",
	/** Number of guest network a user can create. */
	"Network",
	/** Number of VPC a user can create. */
	"VPC",
	/** Total number of CPU cores a user can use. */
	"CPU",
	/** Total Memory (in MB) a user can use. */
	"Memory",
	/** Total primary storage space (in GiB) a user can use. */
	"PrimaryStorage",
	/** Total secondary storage space (in GiB) a user can use. */
	"SecondaryStorage" ];

    // Load domain
    $scope.domain = {};
    $scope.domainList = [];
    var hasDomains = appService.crudService.listAll("domains/list");
    hasDomains.then(function (result) {
    	$scope.domainList = result;
    });



	// Get volume list based on domain selection
    $scope.selectDomainView = function() {
    	$scope.resourceDomainList = {};
    	$scope.getResourceDomain();
    };
	$scope.showForm = function(quotaReason) {
		// $scope.quota = quota;
		var modalInstance = $modal.open({
			templateUrl : 'app/views/cloud/quota/quota-reason.jsp',
			controller : 'quotaReasonCtrl',
			backdrop : 'static',
			keyboard : false,
			scope : $scope,
			resolve : {
				userForm : function() {
					return $scope.userForm;
				},
				quotaReason : function() {
					return quotaReason;
				}
			}
		});
	};

	/**
	 * Resource limit types, used and available mapping to view data.
	 */
	$scope.quotaLimitData = [];
	$scope.resource = {};
	$scope.resourceListMap = function(resourceName, used, max) {
		$scope.resource[resourceName + "Limit"] = {
			"title" : resourceName,
			"options" : [ {
				value : parseFloat(used),
				color : "#3399FF",
				highlight : "#e74c3c",
				label : "Used",
				showLabels : "true",
			}, {
				value : parseFloat(max),
				color : "#A9A9A9",
				highlight : "#57b32c",
				label : "Available",
				showLabels : "true",
			} ]
		};
		$scope.quotaLimitData.push($scope.resource[resourceName + "Limit"]);
	}

    /**
     * Options for Doughnut chart
     */
    $scope.doughnutOptions = {
        segmentShowStroke: true,
        segmentStrokeColor: "#fff",
        segmentStrokeWidth: 0,
        percentageInnerCutout: 85, // This is 0 for Pie charts
        animationSteps: 100,
        animationEasing: "easeOutBounce",
        animateRotate: false,
        animateScale: false,

        customTooltips: function customTooltips(tooltip){
            // Tooltip Element
            var tooltipEl = $('#chartjs-customtooltip');
            // Make the element if not available
            if (!tooltipEl[0]) {
                $('body').append('<div id="chartjs-customtooltip"></div>');
                tooltipEl = $('#chartjs-customtooltip');
            }
            // Hide if no tooltip
            if (!tooltip) {
                tooltipEl.css({
                    opacity: 0
                });
                return;
            }
            // Set caret Position
            tooltipEl.removeClass('above below no-transform');
            if (tooltip.yAlign) {
                tooltipEl.addClass(tooltip.yAlign);
            } else {
                tooltipEl.addClass('no-transform');
            }
            // Set Text
            if (tooltip.text) {
                tooltipEl.html(tooltip.text);
            } else {
                var innerHtml = '<div class="title">' + tooltip.title + '</div>';
                for (var i = 0; i < tooltip.labels.length; i++) {
                    innerHtml += [
                        '<div class="section">',
                        '   <span class="key" style="background-color:' + tooltip.legendColors[i].fill + '"></span>',
                        '   <span class="value">' + tooltip.labels[i] + '</span>',
                        '</div>'
                    ].join('');
                }
                tooltipEl.html(innerHtml);
            }
            // Find Y Location on page
            var top = 0;
            if (tooltip.yAlign) {
                if (tooltip.yAlign == 'above') {
                    top = tooltip.y - tooltip.caretHeight - tooltip.caretPadding;
                } else {
                    top = tooltip.y + tooltip.caretHeight + tooltip.caretPadding;
                }
            }
            var offset = $(tooltip.chart.canvas).offset();

            // Display, position, and set styles for font
            tooltipEl.css({
                opacity: 1,
                width: tooltip.width ? (tooltip.width + 'px') : 'auto',
                left: offset.left + tooltip.x + 'px',
                top: offset.top + top + 'px',
                fontFamily: tooltip.fontFamily,
                fontSize: tooltip.fontSize,
                fontStyle: tooltip.fontStyle,
            });
        }
    };

	/**
	 * Options for Doughnut chart
	 */
	$scope.quotaChartOptions = {
		segmentShowStroke : true,
		segmentStrokeColor : "#fff",
		segmentStrokeWidth : 1,
		percentageInnerCutout : 40, // This is 0 for Pie charts
		animationSteps : 100,
		animationEasing : false,
		animateRotate : false,
		animateScale : false,
		showTooltips : true,
		tooltipCaretSize : 12,
		tooltipFontSize : 12,
		tooltipYPadding : 4,
		tooltipXPadding : 4,
		legend : true
	};

$scope.getResourceDomain = function() {
//    $scope.quotaLimits = {
// 	       "Instance":{label: "VM"},"CPU": {label: "vCPU"}, "Memory": {label: "Memory"},"Template":{label: "Template"},"Snapshot": {label: "Snapshot"}, "Network": {label: "Network"},
// 	       "IP": {label: "IP"}, "VPC": {label: "VPC"}, "Volume": {label: "Volume"},"PrimaryStorage": {label: "PrimaryStorage"}, "SecondaryStorage": {label: "SecondaryStorage"},
//
// 	     };
	  $scope.quotaLimits = [];
	     $scope.networkQuotaList = [];
	     $scope.storageQuotaList = [];
    $scope.showLoader = true;
    var resourceArr = ["Instance","CPU", "Memory","Template","Snapshot", "Network", "IP", "VPC","Volume", "PrimaryStorage", "SecondaryStorage"];
    if (angular.isUndefined($scope.domainView) || $scope.domainView == null) {
        var hasResourceDomainId = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "dashboard/quota");
   } else {
       var hasResourceDomainId = appService.promiseAjax.httpTokenRequest( globalConfig.HTTP_GET , globalConfig.APP_URL + "resourceDomains/listByDomain/"+$scope.domainView.id);
   }
    hasResourceDomainId.then(function (result) {  // this is only run after $http completes

        $scope.showLoader = false;
       // console.log("Result",result);
          angular.forEach(result, function(obj, key) {
         	 //console.log("Key-",key,"Resource-",obj.resourceType);
         	 if(obj.resourceType == "Instance"){
         		 $scope.addText = function() {
         		        $scope.quotaLimits[0] = obj;
         		        $scope.quotaLimits[0].label= "VM";
         		        $scope.quotaLimits[0].max = parseInt(obj.max);
                         $scope.quotaLimits[0].usedLimit = parseInt(obj.usedLimit);
                         $scope.quotaLimits[0].percentage = parseFloat(parseInt(obj.usedLimit) / parseInt(obj.max) * 100).toFixed(2);
                         if(obj.usedLimit == null || obj.usedLimit == "null" || isNaN(obj.usedLimit)) {
                             obj.usedLimit = 0;
                         }
                        if(resourceArr.indexOf(obj.resourceType) > -1) {
                          if(angular.isUndefined($scope.quotaLimits[0])) {
                              $scope.quotaLimits[0] = {};

                          }
         		    }
                        if(isNaN($scope.quotaLimits[0].percentage)) {
                            $scope.quotaLimits[0].percentage = 0;
                        }

                        var unUsed = $scope.quotaLimits[0].max - $scope.quotaLimits[0].usedLimit;

                        var usedColor = "#48a9da";
                        if($scope.quotaLimits[0].percentage > 79 && $scope.quotaLimits[0].percentage < 90) {
                            usedColor = "#f0ad4e";
                        } else if($scope.quotaLimits[0].percentage > 89){
                            usedColor = "#df6457";
                        }

                        $scope.quotaLimits[0].doughnutData = [
                           {
                           value: parseInt(obj.usedLimit),
                           color: usedColor,
                           highlight: usedColor,
                           label: "Used"
                           },
                           {
                           value: unUsed,
                           color: "#ebf1f4",
                           highlight: "#ebf1f4",
                           label: "UnUsed"
                           }];
                        }
         		 $scope.addText();

         	 }
         	 if(obj.resourceType == "CPU"){
         		 $scope.addText = function() {
      		        $scope.quotaLimits[1] = obj;
     		        $scope.quotaLimits[1].label= "vCPU";
     		        $scope.quotaLimits[1].max = parseInt(obj.max);
                     $scope.quotaLimits[1].usedLimit = parseInt(obj.usedLimit);
                     $scope.quotaLimits[1].percentage = parseFloat(parseInt(obj.usedLimit) / parseInt(obj.max) * 100).toFixed(2);

                     if(obj.usedLimit == null || obj.usedLimit == "null" || isNaN(obj.usedLimit)) {
                         obj.usedLimit = 0;
                     }
                    if(resourceArr.indexOf(obj.resourceType) > -1) {
                      if(angular.isUndefined($scope.quotaLimits[1])) {
                          $scope.quotaLimits[1] = {};

                      }
     		    }
                     if(isNaN($scope.quotaLimits[1].percentage)) {
                         $scope.quotaLimits[1].percentage = 0;
                     }

                     var unUsed = $scope.quotaLimits[1].max - $scope.quotaLimits[1].usedLimit;

                     var usedColor = "#48a9da";
                     if($scope.quotaLimits[1].percentage > 79 && $scope.quotaLimits[1].percentage < 90) {
                         usedColor = "#f0ad4e";
                     } else if($scope.quotaLimits[1].percentage > 89){
                         usedColor = "#df6457";
                     }

                     $scope.quotaLimits[1].doughnutData = [
                        {
                        value: parseInt(obj.usedLimit),
                        color: usedColor,
                        highlight: usedColor,
                        label: "Used"
                        },
                        {
                        value: unUsed,
                        color: "#ebf1f4",
                        highlight: "#ebf1f4",
                        label: "UnUsed"
                        }];

         		    }
         		 $scope.addText();

         	 }
         	 if(obj.resourceType == "Memory"){
         		 $scope.addText = function() {
      		        $scope.quotaLimits[2] = obj;
     		        $scope.quotaLimits[2].label= "Memory";

     		        obj.usedLimit = Math.round( obj.usedLimit / 1024);
                     if (obj.max != -1) {
                                 obj.max = Math.round(obj.max / 1024);
                                 $scope.quotaLimits[2].label = $scope.quotaLimits[2].label + " " + "(GiB)";
                     }

                     $scope.quotaLimits[2].max = parseInt(obj.max);
                     $scope.quotaLimits[2].usedLimit = parseInt(obj.usedLimit);
                     $scope.quotaLimits[2].percentage = parseFloat(parseInt(obj.usedLimit) / parseInt(obj.max) * 100).toFixed(2);

                     if(obj.usedLimit == null || obj.usedLimit == "null" || isNaN(obj.usedLimit)) {
                         obj.usedLimit = 0;
                     }
                    if(resourceArr.indexOf(obj.resourceType) > -1) {
                      if(angular.isUndefined($scope.quotaLimits[2])) {
                          $scope.quotaLimits[2] = {};

                      }
     		    }
                     if(isNaN($scope.quotaLimits[2].percentage)) {
                         $scope.quotaLimits[2].percentage = 0;
                     }

                     var unUsed = $scope.quotaLimits[2].max - $scope.quotaLimits[2].usedLimit;

                     var usedColor = "#48a9da";
                     if($scope.quotaLimits[2].percentage > 79 && $scope.quotaLimits[2].percentage < 90) {
                         usedColor = "#f0ad4e";
                     } else if($scope.quotaLimits[2].percentage > 89){
                         usedColor = "#df6457";
                     }

                     $scope.quotaLimits[2].doughnutData = [
                        {
                        value: parseInt(obj.usedLimit),
                        color: usedColor,
                        highlight: usedColor,
                        label: "Used"
                        },
                        {
                        value: unUsed,
                        color: "#ebf1f4",
                        highlight: "#ebf1f4",
                        label: "UnUsed"
                        }];
         		    }
         		 $scope.addText();

         	 }
         	 if(obj.resourceType == "Template"){
         		 $scope.addText = function() {
      		        $scope.quotaLimits[3] = obj;
     		        $scope.quotaLimits[3].label= "Template";
     		        $scope.quotaLimits[3].max = parseInt(obj.max);
                     $scope.quotaLimits[3].usedLimit = parseInt(obj.usedLimit);
                     $scope.quotaLimits[3].percentage = parseFloat(parseInt(obj.usedLimit) / parseInt(obj.max) * 100).toFixed(2);

                     if(obj.usedLimit == null || obj.usedLimit == "null" || isNaN(obj.usedLimit)) {
                         obj.usedLimit = 0;
                     }
                    if(resourceArr.indexOf(obj.resourceType) > -1) {
                      if(angular.isUndefined($scope.quotaLimits[3])) {
                          $scope.quotaLimits[3] = {};

                      }
     		    }
                     if(isNaN($scope.quotaLimits[3].percentage)) {
                         $scope.quotaLimits[3].percentage = 0;
                     }

                     var unUsed = $scope.quotaLimits[3].max - $scope.quotaLimits[3].usedLimit;

                     var usedColor = "#48a9da";
                     if($scope.quotaLimits[3].percentage > 79 && $scope.quotaLimits[3].percentage < 90) {
                         usedColor = "#f0ad4e";
                     } else if($scope.quotaLimits[3].percentage > 89){
                         usedColor = "#df6457";
                     }

                     $scope.quotaLimits[3].doughnutData = [
                        {
                        value: parseInt(obj.usedLimit),
                        color: usedColor,
                        highlight: usedColor,
                        label: "Used"
                        },
                        {
                        value: unUsed,
                        color: "#ebf1f4",
                        highlight: "#ebf1f4",
                        label: "UnUsed"
                        }];

         		    }
         		 $scope.addText();

         	 }
         	 if(obj.resourceType == "Snapshot"){
         		 $scope.addText = function() {
      		        $scope.quotaLimits[4] = obj;
     		        $scope.quotaLimits[4].label= "Snapshot";
     		        $scope.quotaLimits[4].max = parseInt(obj.max);
                     $scope.quotaLimits[4].usedLimit = parseInt(obj.usedLimit);
                     $scope.quotaLimits[4].percentage = parseFloat(parseInt(obj.usedLimit) / parseInt(obj.max) * 100).toFixed(2);

                     if(obj.usedLimit == null || obj.usedLimit == "null" || isNaN(obj.usedLimit)) {
                         obj.usedLimit = 0;
                     }
                    if(resourceArr.indexOf(obj.resourceType) > -1) {
                      if(angular.isUndefined($scope.quotaLimits[4])) {
                          $scope.quotaLimits[4] = {};

                      }
     		    }
                     if(isNaN($scope.quotaLimits[4].percentage)) {
                         $scope.quotaLimits[4].percentage = 0;
                     }

                     var unUsed = $scope.quotaLimits[4].max - $scope.quotaLimits[4].usedLimit;

                     var usedColor = "#48a9da";
                     if($scope.quotaLimits[4].percentage > 79 && $scope.quotaLimits[4].percentage < 90) {
                         usedColor = "#f0ad4e";
                     } else if($scope.quotaLimits[4].percentage > 89){
                         usedColor = "#df6457";
                     }

                     $scope.quotaLimits[4].doughnutData = [
                        {
                        value: parseInt(obj.usedLimit),
                        color: usedColor,
                        highlight: usedColor,
                        label: "Used"
                        },
                        {
                        value: unUsed,
                        color: "#ebf1f4",
                        highlight: "#ebf1f4",
                        label: "UnUsed"
                        }];

         		    }
         		 $scope.addText();

         	 }

         	 if(obj.resourceType == "Network"){
         		 $scope.addText = function() {
      		        $scope.networkQuotaList[0] = obj;
     		        $scope.networkQuotaList[0].label= "Network";
     		        $scope.networkQuotaList[0].max = parseInt(obj.max);
                     $scope.networkQuotaList[0].usedLimit = parseInt(obj.usedLimit);
                     $scope.networkQuotaList[0].percentage = parseFloat(parseInt(obj.usedLimit) / parseInt(obj.max) * 100).toFixed(2);

                     if(obj.usedLimit == null || obj.usedLimit == "null" || isNaN(obj.usedLimit)) {
                         obj.usedLimit = 0;
                     }
                    if(resourceArr.indexOf(obj.resourceType) > -1) {
                      if(angular.isUndefined($scope.networkQuotaList[0])) {
                          $scope.networkQuotaList[0] = {};

                      }
     		    }
                     if(isNaN($scope.networkQuotaList[0].percentage)) {
                         $scope.networkQuotaList[0].percentage = 0;
                     }

                     var unUsed = $scope.networkQuotaList[0].max - $scope.networkQuotaList[0].usedLimit;

                     var usedColor = "#48a9da";
                     if($scope.networkQuotaList[0].percentage > 79 && $scope.networkQuotaList[0].percentage < 90) {
                         usedColor = "#f0ad4e";
                     } else if($scope.networkQuotaList[0].percentage > 89){
                         usedColor = "#df6457";
                     }

                     $scope.networkQuotaList[0].doughnutData = [
                        {
                        value: parseInt(obj.usedLimit),
                        color: usedColor,
                        highlight: usedColor,
                        label: "Used"
                        },
                        {
                        value: unUsed,
                        color: "#ebf1f4",
                        highlight: "#ebf1f4",
                        label: "UnUsed"
                        }];

         		    }
         		 $scope.addText();

         	 }
         	 if(obj.resourceType == "IP"){
         		 $scope.addText = function() {
       		        $scope.networkQuotaList[1] = obj;
       		      $scope.networkQuotaList[1].label= "IP";
   		        $scope.networkQuotaList[1].max = parseInt(obj.max);
                   $scope.networkQuotaList[1].usedLimit = parseInt(obj.usedLimit);
                   $scope.networkQuotaList[1].percentage = parseFloat(parseInt(obj.usedLimit) / parseInt(obj.max) * 100).toFixed(2);

                   if(obj.usedLimit == null || obj.usedLimit == "null" || isNaN(obj.usedLimit)) {
                       obj.usedLimit = 0;
                   }
                  if(resourceArr.indexOf(obj.resourceType) > -1) {
                    if(angular.isUndefined($scope.networkQuotaList[1])) {
                        $scope.networkQuotaList[1] = {};

                    }
   		    }
                   if(isNaN($scope.networkQuotaList[1].percentage)) {
                       $scope.networkQuotaList[1].percentage = 0;
                   }

                   var unUsed = $scope.networkQuotaList[1].max - $scope.networkQuotaList[1].usedLimit;

                   var usedColor = "#48a9da";
                   if($scope.networkQuotaList[1].percentage > 79 && $scope.networkQuotaList[1].percentage < 90) {
                       usedColor = "#f0ad4e";
                   } else if($scope.networkQuotaList[1].percentage > 89){
                       usedColor = "#df6457";
                   }

                   $scope.networkQuotaList[1].doughnutData = [
                      {
                      value: parseInt(obj.usedLimit),
                      color: usedColor,
                      highlight: usedColor,
                      label: "Used"
                      },
                      {
                      value: unUsed,
                      color: "#ebf1f4",
                      highlight: "#ebf1f4",
                      label: "UnUsed"
                      }];
         		    }
         		 $scope.addText();

         	 }
         	 if(obj.resourceType == "VPC"){
         		 $scope.addText = function() {
       		        $scope.networkQuotaList[2] = obj;
       		      $scope.networkQuotaList[2].label= "VPC";
   		        $scope.networkQuotaList[2].max = parseInt(obj.max);
                   $scope.networkQuotaList[2].usedLimit = parseInt(obj.usedLimit);
                   $scope.networkQuotaList[2].percentage = parseFloat(parseInt(obj.usedLimit) / parseInt(obj.max) * 100).toFixed(2);

                   if(obj.usedLimit == null || obj.usedLimit == "null" || isNaN(obj.usedLimit)) {
                       obj.usedLimit = 0;
                   }
                  if(resourceArr.indexOf(obj.resourceType) > -1) {
                    if(angular.isUndefined($scope.networkQuotaList[2])) {
                        $scope.networkQuotaList[2] = {};

                    }
   		    }
                   if(isNaN($scope.networkQuotaList[2].percentage)) {
                       $scope.networkQuotaList[2].percentage = 0;
                   }

                   var unUsed = $scope.networkQuotaList[2].max - $scope.networkQuotaList[2].usedLimit;

                   var usedColor = "#48a9da";
                   if($scope.networkQuotaList[2].percentage > 79 && $scope.networkQuotaList[2].percentage < 90) {
                       usedColor = "#f0ad4e";
                   } else if($scope.networkQuotaList[2].percentage > 89){
                       usedColor = "#df6457";
                   }

                   $scope.networkQuotaList[2].doughnutData = [
                      {
                      value: parseInt(obj.usedLimit),
                      color: usedColor,
                      highlight: usedColor,
                      label: "Used"
                      },
                      {
                      value: unUsed,
                      color: "#ebf1f4",
                      highlight: "#ebf1f4",
                      label: "UnUsed"
                      }];
         		    }
         		 $scope.addText();

         	 }

         	 if(obj.resourceType == "Volume"){
         		 $scope.addText = function() {

       		        $scope.storageQuotaList[0] = obj;
      		        $scope.storageQuotaList[0].label= "Volume";
      		        $scope.storageQuotaList[0].max = parseInt(obj.max);
                      $scope.storageQuotaList[0].usedLimit = parseInt(obj.usedLimit);
                      $scope.storageQuotaList[0].percentage = parseFloat(parseInt(obj.usedLimit) / parseInt(obj.max) * 100).toFixed(2);

                      if(obj.usedLimit == null || obj.usedLimit == "null" || isNaN(obj.usedLimit)) {
                          obj.usedLimit = 0;
                      }
                     if(resourceArr.indexOf(obj.resourceType) > -1) {
                       if(angular.isUndefined($scope.storageQuotaList[0])) {
                           $scope.storageQuotaList[0] = {};

                       }
      		    }
                      if(isNaN($scope.storageQuotaList[0].percentage)) {
                          $scope.storageQuotaList[0].percentage = 0;
                      }

                      var unUsed = $scope.storageQuotaList[0].max - $scope.storageQuotaList[0].usedLimit;

                      var usedColor = "#48a9da";
                      if($scope.storageQuotaList[0].percentage > 79 && $scope.storageQuotaList[0].percentage < 90) {
                          usedColor = "#f0ad4e";
                      } else if($scope.storageQuotaList[0].percentage > 89){
                          usedColor = "#df6457";
                      }

                      $scope.storageQuotaList[0].doughnutData = [
                         {
                         value: parseInt(obj.usedLimit),
                         color: usedColor,
                         highlight: usedColor,
                         label: "Used"
                         },
                         {
                         value: unUsed,
                         color: "#ebf1f4",
                         highlight: "#ebf1f4",
                         label: "UnUsed"
                         }];

          		            		    }
         		 $scope.addText();

         	 }
         	 if(obj.resourceType == "PrimaryStorage"){
         		 $scope.addText = function() {
       		        $scope.storageQuotaList[1] = obj;
       		        $scope.storageQuotaList[1].label = "Primary Storage";
       		      if (obj.max == -1 && obj.resourceType == "PrimaryStorage" || obj.max == -1 && obj.resourceType == "SecondaryStorage") {
                       // obj.usedLimit = Math.round( obj.usedLimit / (1024 * 1024 * 1024));
              $scope.storageQuotaList[1].label = $scope.storageQuotaList[1].label + " " + "(GiB)";
           }

       		    $scope.storageQuotaList[1].max = parseInt(obj.max);
                 $scope.storageQuotaList[1].usedLimit = parseInt(obj.usedLimit);
                 $scope.storageQuotaList[1].percentage = parseFloat(parseInt(obj.usedLimit) / parseInt(obj.max) * 100).toFixed(2);

                 if(obj.usedLimit == null || obj.usedLimit == "null" || isNaN(obj.usedLimit)) {
                     obj.usedLimit = 0;
                 }
                if(resourceArr.indexOf(obj.resourceType) > -1) {
                  if(angular.isUndefined($scope.storageQuotaList[1])) {
                      $scope.storageQuotaList[1] = {};

                  }
 		    }
                 if(isNaN($scope.storageQuotaList[1].percentage)) {
                     $scope.storageQuotaList[1].percentage = 0;
                 }

                 var unUsed = $scope.storageQuotaList[1].max - $scope.storageQuotaList[1].usedLimit;

                 var usedColor = "#48a9da";
                 if($scope.storageQuotaList[1].percentage > 79 && $scope.storageQuotaList[1].percentage < 90) {
                     usedColor = "#f0ad4e";
                 } else if($scope.storageQuotaList[1].percentage > 89){
                     usedColor = "#df6457";
                 }

                 $scope.storageQuotaList[1].doughnutData = [
                    {
                    value: parseInt(obj.usedLimit),
                    color: usedColor,
                    highlight: usedColor,
                    label: "Used"
                    },
                    {
                    value: unUsed,
                    color: "#ebf1f4",
                    highlight: "#ebf1f4",
                    label: "UnUsed"
                    }];
         		    }
         		 $scope.addText();

         	 }
         	 if(obj.resourceType == "SecondaryStorage"){
         		 $scope.addText = function() {
       		        $scope.storageQuotaList[2] = obj;
       		      $scope.storageQuotaList[2].label = "Secondary Storage";
       		      if (obj.max == -1 && obj.resourceType == "PrimaryStorage" || obj.max == -1 && obj.resourceType == "SecondaryStorage") {
                       // obj.usedLimit = Math.round( obj.usedLimit / (1024 * 1024 * 1024));
              $scope.storageQuotaList[2].label = $scope.storageQuotaList[2].label + " " + "(GiB)";
           }

       		    $scope.storageQuotaList[2].max = parseInt(obj.max);
                 $scope.storageQuotaList[2].usedLimit = parseInt(obj.usedLimit);
                 $scope.storageQuotaList[2].percentage = parseFloat(parseInt(obj.usedLimit) / parseInt(obj.max) * 100).toFixed(2);

                 if(obj.usedLimit == null || obj.usedLimit == "null" || isNaN(obj.usedLimit)) {
                     obj.usedLimit = 0;
                 }
                if(resourceArr.indexOf(obj.resourceType) > -1) {
                  if(angular.isUndefined($scope.storageQuotaList[2])) {
                      $scope.storageQuotaList[2] = {};

                  }
 		    }
                 if(isNaN($scope.storageQuotaList[2].percentage)) {
                     $scope.storageQuotaList[2].percentage = 0;
                 }

                 var unUsed = $scope.storageQuotaList[2].max - $scope.storageQuotaList[2].usedLimit;

                 var usedColor = "#48a9da";
                 if($scope.storageQuotaList[2].percentage > 79 && $scope.storageQuotaList[2].percentage < 90) {
                     usedColor = "#f0ad4e";
                 } else if($scope.storageQuotaList[2].percentage > 89){
                     usedColor = "#df6457";
                 }

                 $scope.storageQuotaList[2].doughnutData = [
                    {
                    value: parseInt(obj.usedLimit),
                    color: usedColor,
                    highlight: usedColor,
                    label: "Used"
                    },
                    {
                    value: unUsed,
                    color: "#ebf1f4",
                    highlight: "#ebf1f4",
                    label: "UnUsed"
                    }];
         		    }
         		 $scope.addText();

         	 }
          });

      });
};
$scope.getResourceDomain();

}
