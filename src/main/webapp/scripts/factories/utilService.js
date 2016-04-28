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

    object.getFlotBarData = function() {
      return [
          {
              label: "bar",
              data: []
          }
      ];
    }

    /**
     * Bar Chart Options
     */
    object.getFlotBarOptions = function() {

      return {
          series: {
              bars: {
                  show: true,
                  barWidth: 0.8,
                  fill: true,
                  fillColor: {
                      colors: [ { opacity: 0.6 }, { opacity: 0.6 } ]
                  },
                  lineWidth: 1
              }
          },
          xaxis: {
              tickDecimals: 0,
              ticks: []
          },
          colors: ["#c3d1db"],
          grid: {
              color: "#c3d1db",
              hoverable: true,
              clickable: true,
              tickColor: "#D4D4D4",
              borderWidth: 0,
              borderColor: 'e4e5e7',
          },
          legend: {
              show: false
          },
          tooltip: true,
          tooltipOpts: {
              content: "x: %x, y: %y"
          }
      };
    }

    object.getMonthList = function() {
        return [ {
            'id' : 1,
            'name' : 'January'
        }, {
            'id' : 2,
            'name' : 'February'
        }, {
            'id' : 3,
            'name' : 'March'
        }, {
            'id' : 4,
            'name' : 'April'
        }, {
            'id' : 5,
            'name' : 'May'
        }, {
            'id' : 6,
            'name' : 'June'
        }, {
            'id' : 7,
            'name' : 'July'
        }, {
            'id' : 8,
            'name' : 'August'
        }, {
            'id' : 9,
            'name' : 'September'
        }, {
            'id' : 10,
            'name' : 'October'
        }, {
            'id' : 11,
            'name' : 'November'
        }, {
            'id' : 12,
            'name' : 'December'
        }
        ]
    }

    return object;
};


/**
 * Pass function into module
 */
angular
    .module('homer')
    .factory('utilService', utilService);
