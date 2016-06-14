/**
 * HOMER - Responsive Admin Theme
 * Copyright 2015 Webapplayers.com
 *
 */

angular
    .module('homer')
    .directive('pageTitle', pageTitle)
    .directive('sideNavigation', sideNavigation)
    .directive('minimalizaMenu', minimalizaMenu)
    .directive('sparkline', sparkline)
    .directive('icheck', icheck)
    .directive('panelTools', panelTools)
    .directive('smallHeader', smallHeader)
    .directive('animatePanel', animatePanel)
    .directive('landingScrollspy', landingScrollspy)
    .directive('validNumber', validNumber)
    .directive('validDecimal', validDecimal)
    .directive('validEmail', validEmail)
    .directive('validCidr', validCidr)
    .directive('pandaModalHeader', pandaModalHeader)
    .directive('pandaQuickSearch', pandaQuickSearch)
    .directive('appCurrency', appCurrency)
    .directive('appCurrencyLabel',appCurrencyLabel)
    .directive('appClock', appClock)
    .directive('appScroll', appScroll)
    .directive('select2', select2)
    .directive('templateQuickSearch', templateQuickSearch)
    .directive('paginationContent', paginationContent)
    .directive('paginationContents', paginationContents)
    .directive('getLoaderImage', getLoaderImage)
    .directive('getLoaderImageOffer', getLoaderOfferImage)
    .directive('getLoaderImageDetail', getLoaderDetailImage)
    .directive('getLoginLoaderImage', getLoginLoaderImage)
    .directive('passwordVerify', passwordVerify)
    .directive('validInteger', validInteger)
    .directive('validCharacters', validCharacters)
    .directive('hasPermission', hasPermission)
    .directive('chart', function(){
    return{
        restrict: 'E',
        link: function(scope, elem, attrs){

            var chart = null,
                opts  = { };

            var data = scope[attrs.ngModel];

            scope.$watch('data', function(v){
                if(!chart){
                    chart = $.plot(elem, v , opts);
                    elem.show();
                }else{
                    chart.setData(v);
                    chart.setupGrid();
                    chart.draw();
                }
            });
        }
    };
})

    .directive('multiselect', function () {
    return {
        restrict: 'E',
        scope: {
            model: '=',
            multiselectoptions: '=',
            maxlenghttoshowselectedvalues: '=',
            onchangeeventofcheckbox: '&',
        },
        template:
        '<div class="btn-group" ng-class={open:open}> \
            <button type="button" class="multiselect dropdown-toggle btn btn-default" title="None selected" ng-click="toggledropdown()"> \
                <span class="multiselect-selected-text">{{model.toggletext}}</span> \
                <b class="caret"></b> \
            </button> \
            <ul class="multiselect-container dropdown-menu"> \
                <li class="multiselect-item filter" value="0"> \
                    <div class="input-group"> \
                        <span class="input-group-addon"><i class="glyphicon glyphicon-search"></i></span> \
                        <input class="form-control multiselect-search" type="text" placeholder="Search" ng-model="model.query"><span class="input-group-btn"> \
                            <button class="btn btn-default multiselect-clear-filter" ng-click="clearsearch()" type="button"><i class="glyphicon glyphicon-remove-circle"></i></button> \
                        </span> \
                    </div> \
                </li> \
                <li class="multiselect-item multiselect-all"><label style="padding: 6px 0px 4px 8px;"><input type="checkbox" icheck  ng-model="model.selectall" ng-change="toggleselectall()"><span class="m-l-sm">Select all</span></label></li> \
                <li ng-repeat="option in (filteredOptions = (multiselectoptions| filter:model.query))"><label style="padding: 6px 0px 4px 8px;"><input icheck type="checkbox" ng-checked="isselected(option)" ng-model="option.Selected" ng-change="toggleselecteditem(option);doOnChangeOfCheckBox()"><span class="m-l-sm">{{option.Text}}</span></label></li> \
            </ul> \
        </div>',
        controller: function ($scope) {
            debugger;
            $scope.toggledropdown = function () {
                $scope.open = !$scope.open;
            };

            $scope.toggleselectall = function ($event) {
                var selectallclicked = true;
                if ($scope.model.selectall == false) {
                    selectallclicked = false;
                }
                $scope.doonselectallclick(selectallclicked, $scope.filteredOptions);
            };

            $scope.doonselectallclick = function (selectallclicked, optionArrayList) {
                $scope.model = [];
                if (selectallclicked) {
                    angular.forEach(optionArrayList, function (item, index) {
                        item["Selected"] = true;
                        $scope.model.push(item);
                    });

                    if (optionArrayList.length == $scope.multiselectoptions.length)
                    {
                        $scope.model.selectall = true;
                    }
                }
                else {
                    angular.forEach(optionArrayList, function (item, index) {
                        item["Selected"] = false;
                    });
                    $scope.model.selectall = false;
                }
                $scope.settoggletext();
            }

            $scope.toggleselecteditem = function (option) {
                var intIndex = -1;
                angular.forEach($scope.model, function (item, index) {
                    if (item.Value == option.Value) {
                        intIndex = index;
                    }
                });

                if (intIndex >= 0) {
                    $scope.model.splice(intIndex, 1);
                }
                else {
                    $scope.model.push(option);
                }

                if ($scope.model.length == $scope.multiselectoptions.length) {
                    $scope.model.selectall = true;
                }
                else {
                    $scope.model.selectall = false;
                }
                $scope.settoggletext();
            };

            $scope.clearsearch = function () {
                $scope.model.query = "";

            }

            $scope.settoggletext = function () {
                if ($scope.model.length > $scope.maxlenghttoshowselectedvalues) {
                    $scope.model.toggletext = $scope.model.length + " Selected";
                }
                else {
                    $scope.model.toggletext = "";
                    angular.forEach($scope.model, function (item, index) {
                        if (index == 0) {
                            $scope.model.toggletext = item.Text;
                        }
                        else {
                            $scope.model.toggletext += ", " + item.Text;
                        }
                    });

                    if (!($scope.model.toggletext.length > 0)) {
                        $scope.model.toggletext = "None Selected"
                    }
                }
            }

            $scope.isselected = function (option) {
                var selected = false;
                angular.forEach($scope.model, function (item, index) {
                    if (item.Value == option.Value) {
                        selected = true;
                    }
                });
                option.Selected = selected;
                return selected;
            }

            $scope.doOnChangeOfCheckBox = function () {
                $scope.onchangeeventofcheckbox();
            }

            var onload = function () {
                if ($scope.model.length == $scope.multiselectoptions.length) {
                    $scope.doonselectallclick(true, $scope.multiselectoptions);
                }
                $scope.settoggletext();
            }();
        }
    }
});

/**
 * pageTitle - Directive for set Page title - mata title
 */
function pageTitle($rootScope, $timeout) {
    return {
        link: function(scope, element) {
            var listener = function(event, toState, toParams, fromState, fromParams) {
                var themeSettings = localStorageService.get('themeSettings');
                // Default title
                if(themeSettings == null || typeof(themeSettings) == "undefined") {
                    headerTitle = "Panda";
                } else {
                    headerTitle = themeSettings.data.headerTitle;
                }

                if(themeSettings.data.headerTitle == null) {
                    themeSettings.data.headerTitle = "Panda";
                }

                var title = headerTitle;
                // Create your own title pattern
                if (toState.data && toState.data.pageTitle) title = 'Panda | ' + toState.data.pageTitle;
                $timeout(function() {
                   // element.text(title);
                });
            };
            $rootScope.$on('$stateChangeStart', listener);
        }
    }
};



/**
 * sideNavigation - Directive for run metsiMenu on sidebar navigation
 */
function sideNavigation($timeout) {
    return {
        restrict: 'A',
        link: function(scope, element) {
            // Call the metsiMenu plugin and plug it to sidebar navigation
            element.metisMenu();

            // Colapse menu in mobile mode after click on element
            var menuElement = $('#side-menu a:not([href$="\\#"])');
            menuElement.click(function(){

                if ($(window).width() < 769) {
                    $("body").toggleClass("show-sidebar");
                }
            });


        }
    };
};


function validEmail() {
    var EMAIL_REGEXP = /^[_a-z0-9]+(\.[_a-z0-9]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/;

  return {
    require: 'ngModel',
    restrict: '',
    link: function(scope, elm, attrs, ctrl) {
      // only apply the validator if ngModel is present and Angular has added the email validator
      if (ctrl && ctrl.$validators.email) {

        // this will overwrite the default Angular email validator
        ctrl.$validators.email = function(modelValue) {
          return ctrl.$isEmpty(modelValue) || EMAIL_REGEXP.test(modelValue);
        };
      }
    }
  };
}

/**
 * minimalizaSidebar - Directive for minimalize sidebar
 */
function minimalizaMenu($rootScope) {
    return {
        restrict: 'EA',
        template: '<div class="header-link hide-menu" ng-click="minimalize()"><a class="nav-icons" ><i class="fa fa-bars"></a></i></div>',
        controller: function ($scope, $element) {

            $scope.minimalize = function () {
            if ($(window).width() < 769) {
                    $("body").toggleClass("show-sidebar");
                } else {
                    $("body").toggleClass("hide-sidebar");
                }
            }
        }
    };
};


/**
 * sparkline - Directive for Sparkline chart
 */
function sparkline() {
    return {
        restrict: 'A',
        scope: {
            sparkData: '=',
            sparkOptions: '=',
        },
        link: function (scope, element, attrs) {
            scope.$watch(scope.sparkData, function () {
                render();
            });
            scope.$watch(scope.sparkOptions, function(){
                render();
            });
            var render = function () {
                $(element).sparkline(scope.sparkData, scope.sparkOptions);
            };
        }
    }
};

/**
 * icheck - Directive for custom checkbox icheck
 */
function icheck($timeout) {
    return {
        restrict: 'A',
        require: 'ngModel',
        link: function($scope, element, $attrs, ngModel) {
            return $timeout(function() {
                var value;
                value = $attrs['value'];

                $scope.$watch($attrs['ngModel'], function(newValue){
                    $(element).iCheck('update');
                })

                return $(element).iCheck({
                    checkboxClass: 'icheckbox_square-green',
                    radioClass: 'iradio_square-green'

                }).on('ifChanged', function(event) {
                        if ($(element).attr('type') === 'checkbox' && $attrs['ngModel']) {
                            $scope.$apply(function() {
                                return ngModel.$setViewValue(event.target.checked);
                            });
                        }
                        if ($(element).attr('type') === 'radio' && $attrs['ngModel']) {
                            return $scope.$apply(function() {
                                return ngModel.$setViewValue(value);
                            });
                        }
                    });
            });
        }
    };
}


/**
 * panelTools - Directive for panel tools elements in right corner of panel
 */
function panelTools($timeout) {
    return {
        restrict: 'A',
        scope: true,
        templateUrl: 'app/views/common/panel_tools.jsp',
        controller: function ($scope, $element) {
            // Function for collapse ibox
            $scope.showhide = function () {
                var hpanel = $element.closest('div.hpanel');
                var icon = $element.find('i:first');
                var body = hpanel.find('div.panel-body');
                var footer = hpanel.find('div.panel-footer');
                body.slideToggle(300);
                footer.slideToggle(200);
                // Toggle icon from up to down
                icon.toggleClass('fa-chevron-up').toggleClass('fa-chevron-down');
                hpanel.toggleClass('').toggleClass('panel-collapse');
                $timeout(function () {
                    hpanel.resize();
                    hpanel.find('[id^=map-]').resize();
                }, 50);
            },

            // Function for close ibox
            $scope.closebox = function () {
                var hpanel = $element.closest('div.hpanel');
                hpanel.remove();
            }

        }
    };
};


/**
 * smallHeader - Directive for page title panel
 */
function smallHeader() {
    return {
        restrict: 'A',
        scope:true,
        controller: function ($scope, $element) {
            $scope.small = function() {
                var icon = $element.find('i:first');
                var breadcrumb  = $element.find('#hbreadcrumb');
                $element.toggleClass('small-header');
                breadcrumb.toggleClass('m-t-lg');
                icon.toggleClass('fa-arrow-up').toggleClass('fa-arrow-down');
            }
        }
    }
}

function animatePanel($timeout,$state) {
    return {
        restrict: 'A',
        link: function (scope, element, attrs) {

            //Set defaul values for start animation and delay
            var startAnimation = 0;
            var delay = 0.06;   // secunds
            var start = Math.abs(delay) + startAnimation;

            // Store current state where directive was start
            var currentState = $state.current.name;

            // Set default values for attrs
            if(!attrs.effect) { attrs.effect = 'zoomIn'};
            if(attrs.delay) { delay = attrs.delay / 10 } else { delay = 0.06 };
            if(!attrs.child) { attrs.child = '.row > div'} else {attrs.child = "." + attrs.child};

            // Get all visible element and set opactiy to 0
            var panel = element.find(attrs.child);
            panel.addClass('opacity-0');

            // Count render time
            var renderTime = panel.length * delay * 1000 + 700;

            // Wrap to $timeout to execute after ng-repeat
            $timeout(function(){

                // Get all elements and add effect class
                panel = element.find(attrs.child);
                panel.addClass('animated-panel').addClass(attrs.effect);

                // Add delay for each child elements
                panel.each(function (i, elm) {
                    start += delay;
                    var rounded = Math.round(start * 10) / 10;
                    $(elm).css('animation-delay', rounded + 's')
                    // Remove opacity 0 after finish
                    $(elm).removeClass('opacity-0');
                });

                // Clear animate class after finish render
                $timeout(function(){

                    // Check if user change state and only run renderTime on current state
                    if(currentState == $state.current.name){
                        // Remove effect class - fix for any backdrop plgins (e.g. Tour)
                        $('.animated-panel:not([ng-repeat]').removeClass(attrs.effect);
                    }
                }, renderTime)

            });

        }
    }
}

function landingScrollspy(){
    return {
        restrict: 'A',
        link: function (scope, element, attrs) {
            element.scrollspy({
                target: '.navbar-fixed-top',
                offset: 80
            });
        }
    }
}

function validNumber() {
    return {
        require: '?ngModel',
        link: function (scope, element, attrs, ngModelCtrl) {
            if (!ngModelCtrl) {
                return;
            }

            ngModelCtrl.$parsers.push(function (val) {
                if (angular.isUndefined(val)) {
                    var val = '';
                }
                var clean = val.replace(/[^0-9]/g, '');

                if(parseInt(attrs.ngMin) == 500 || parseInt(attrs.ngMin) == 512){
                    if (clean < parseInt(attrs.ngMin)) {
                        clean = clean.substring(0, clean.length);
                   }
                } else {
                if (clean < parseInt(attrs.ngMin)) {
                     clean = clean.substring(1, clean.length);
                }
                }

                if (clean > parseInt(attrs.ngMax)) {
                     clean = clean.substring(0, clean.length - 1);
                }

                if (val !== clean) {
                    ngModelCtrl.$setViewValue(clean);
                    ngModelCtrl.$render();
                }
                return clean;
            });

            element.bind('keypress', function (event) {
                if (event.keyCode === 32) {
                    event.preventDefault();
                }
            });
        }
    };
}

function validCidr() {
    return {
        require: '?ngModel',
        link: function (scope, element, attrs, ngModelCtrl) {
              if (!ngModelCtrl) {
                return;
            }

            ngModelCtrl.$parsers.push(function (val) {
                if (angular.isUndefined(val)) {
                    var val = 0;
                }
                var clean = val.replace(/[^0-9./\/]/g, '');


                if (clean < parseInt(attrs.ngMin)) {
                     clean = clean.substring(1, clean.length);
                }


                if (clean > parseInt(attrs.ngMax)) {
                     clean = clean.substring(0, clean.length - 1);
                }

                if (val !== clean) {
                    ngModelCtrl.$setViewValue(clean);
                    ngModelCtrl.$render();
                }
                return clean;
            });

            element.bind('keypress', function (event) {
                if (event.keyCode === 32) {
                    event.preventDefault();
                }
            });
        }
    };
}

function validDecimal() {
    return {
        require: '?ngModel',
        link: function (scope, element, attrs, ngModelCtrl) {
            if (!ngModelCtrl) {
                return;
            }


            ngModelCtrl.$parsers.push(function (val) {
                if (angular.isUndefined(val)) {
                    var val = '';
                }
                var clean = val.replace(/[^-0-9\.]./g, '');
                var decimalCheck = clean.split('.');
                if (!angular.isUndefined(decimalCheck[1])) {
                    decimalCheck[1] = decimalCheck[1].slice(0, 2);
                    clean = decimalCheck[0] + '.' + decimalCheck[1];
                }

                if (val !== clean) {
                    ngModelCtrl.$setViewValue(clean);
                    ngModelCtrl.$render();
                }
                return clean;
            });

            element.bind('keypress', function (event) {
                if (event.keyCode === 32) {
                    event.preventDefault();
                }
            });
        }
    };
}

function pandaModalHeader() {
    return {
        restrict: 'E',
        link: function (scope, element, attrs) {
            scope.pageTitle = attrs["pageTitle"];
            scope.pageIcon = attrs["pageIcon"];
            if(attrs["pageCustomIcon"] != null && !angular.isUndefined(attrs["pageCustomIcon"])) {
                scope.pageCustomIcon = attrs["pageCustomIcon"];
            } else {
                scope.pageCustomIcon = false;
            }
            scope.hideZone = attrs["hideZone"];
        },
        templateUrl: "app/views/common/modal-header.jsp",
    };
}

function pandaQuickSearch() {
    return {
        restrict: 'E',
        link: function (scope, element, attrs) {

        },
        templateUrl: "app/views/common/quick-search.jsp",
    };
}


function appCurrency() {
    return {
        restrict: 'E',
        template: "{{ global.settings.currency }}",
    };
}

function appCurrencyLabel() {
    return {
        restrict: 'E',
        template: "{{ global.settings.currencyLabel }}",
    };
}

function appClock(dateFilter, $timeout) {
    return {
        restrict: 'E',
        scope: {
            format: '@'
        },
        link: function(scope, element, attrs){
            var updateTime = function(){
                var now = Date.now();

                element.jsp(dateFilter(now, scope.format));
                $timeout(updateTime, now % 1000);
            };

            updateTime();
        }
    };
}

function appScroll() {
    return {
        restrict: 'E',
        link: function (scope, element, attrs) {

        },
        template: "<script type='text/javascript'>setTimeout(function() { $('.slimScroll').slimScroll(); },1000)</script>",
    };
}

function select2() {
    return {
        restrict: 'E',
        link: function (scope, element, attrs) {

        },
        template: "<script type='text/javascript'>	function loadSelect2() { $('.select2' ).select2( { placeholder: 'Select', maximumSelectionSize: 6 } );};</script>",
    };
}

function templateQuickSearch() {
    return {
        restrict: 'E',
        link: function (scope, element, attrs) {

        },
        templateUrl: "app/views/common/grid-list.jsp",
    };
}

function paginationContent() {
    return {
        restrict: 'E',
        link: function (scope, element, attrs) {

        },
        templateUrl: "app/views/common/pagination-content.jsp",
    };
}

function paginationContents() {
    return {
        restrict: 'E',
        link: function (scope, element, attrs) {

        },
        templateUrl: "app/views/common/pagination-contents.jsp",
    };
}

function getLoaderImage() {
    return {
        restrict: 'E',
        link: function (scope, element, attrs) {

        },
        templateUrl: "app/views/common/loader-image.jsp",
    }
}

function getLoaderDetailImage() {
    return {
        restrict: 'E',
        link: function (scope, element, attrs) {

        },
        templateUrl: "app/views/common/loader-image-details.jsp",
    }
}

function getLoaderOfferImage() {
    return {
        restrict: 'E',
        link: function (scope, element, attrs) {

        },
        templateUrl: "app/views/common/loader-image-offer.jsp",
    }
}

function getLoginLoaderImage() {
    return {
        restrict: 'E',
        link: function (scope, element, attrs) {

        },
        templateUrl: "app/views/common/login-loader-image.jsp",
    }
}

function validInteger() {
    return {
        require : '?ngModel',
        link : function(scope, element, attrs, ngModelCtrl) {
            if (!ngModelCtrl) {
                return;
            }

            ngModelCtrl.$parsers.push(function(val) {
                if (angular.isUndefined(val)) {
                    var val = '';
                }

                var clean = val.replace(/[^-0-9]/g, '');
                var negativeCheck = clean.split('-');
                if (!angular.isUndefined(negativeCheck[1])) {
                    negativeCheck[1] = negativeCheck[1].slice(0,
                            negativeCheck[1].length);
                    clean = negativeCheck[0] + '-' + negativeCheck[1];
                    if (negativeCheck[0].length > 0) {
                        clean = negativeCheck[0];
                    }

                }

                if (val !== clean) {
                    ngModelCtrl.$setViewValue(clean);
                    ngModelCtrl.$render();
                }
                return clean;
            });

            element.bind('keypress', function(event) {
                if (event.keyCode === 32) {
                    event.preventDefault();
                }
            });
        }
    };
}

function passwordVerify() {
    return {
        require : "ngModel",
        scope : {
            passwordVerify : '='
        },
        link : function(scope, element, attrs, ctrl) {
            scope.$watch(function() {
                var combined;

                if (scope.passwordVerify || ctrl.$viewValue) {
                    combined = scope.passwordVerify + '_' + ctrl.$viewValue;
                }
                return combined;
            }, function(value) {
                if (value) {
                    ctrl.$parsers.unshift(function(viewValue) {
                        var origin = scope.passwordVerify;
                        if (origin !== viewValue) {
                            ctrl.$setValidity("passwordVerify", false);
                            return undefined;
                        } else {
                            ctrl.$setValidity("passwordVerify", true);
                            return viewValue;
                        }
                    });
                }
            });
        }
    };
};
function validCharacters() {
    return {
        require: '?ngModel',
        link: function (scope, element, attrs, ngModelCtrl) {
              if (!ngModelCtrl) {
                return;
            }

            ngModelCtrl.$parsers.push(function (val) {
                if (angular.isUndefined(val)) {
                    var val = 0;
                }
                var clean = val.replace(/[^0-9.*!@$A-Za-z-_\s\u4e00-\u9fa5]/g, '');


                if (clean < parseInt(attrs.ngMin)) {
                     clean = clean.substring(1, clean.length);
                }


                if (clean > parseInt(attrs.ngMax)) {
                     clean = clean.substring(0, clean.length - 1);
                }

                if (val !== clean) {
                    ngModelCtrl.$setViewValue(clean);
                    ngModelCtrl.$render();
                }
                return clean;
            });

            element.bind('keypress', function (event) {
                if (event.keyCode === 32) {
                    event.preventDefault();
                }
            });
        }
    };
}

/**
 * Check the User has permission or not
 */
function hasPermission() {
    return {
        restrict: 'A',
        link: function (scope, element, attrs) {
            var permission=false;
            for(var i=0;i<scope.global.sessionValues.permissionList.length;i++){
                if(scope.global.sessionValues.permissionList[i].action_key === attrs["hasPermission"]){
                    permission = true;
                    break;
                }
            }

            if(!permission) {
                element.hide();
            }
        }
    }
}
