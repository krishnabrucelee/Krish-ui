/**
 * Pass function into module
 */
angular
    .module('homer')
    .factory('globalConfig', globalConfig);


function globalConfig($window) {
    var appGlobalConfig = {};

    /**
     *  Global configuration goes here
     */
    appGlobalConfig = {
        project:{id:0, name:'Projects'},
        projectList:[{id:0, name:'Projects'},{id:1, name:'IMS'},{id:2, name:'Programming'},{id:3, name:'Testing'}],
        zone:{id:1, name:'Beijing'},
        zoneList:[{id:1, name:'Beijing'},{id:2, name:'Liaoning'},{id:3, name:'Shanghai'},{id:4, name:'Henan'}],
        settings: {
            currency : "¥",
            currencyLabel:"CNY"
        },
        networks:{
            name:''
        },
        sort : {
        		column : '',
        		descending : false
        	},
        rulesLB:[{name:'Test','protocol':'tcp',publicPort:'90',privatePort:'90',publicEndPort:'120',privateEndPort:'120',algorithm:'Round-robin',vms:[{id:'',name: "NorthChina- Beijing",zone:"Beijing"}],state:'active'}],
        rulesPF:[{publicStartPort:90,privateStartPort:90,publicEndPort:120,privateEndPort:120,protocolType:'TCP',state:true}],
        Vms:['1','2','3','4'],
        selectedVms:[],
        date: {
            format:'dd/MMM/yyyy',
            dateOptions: {
                formatYear: 'yy',
                startingDay: 1
            },
            minDate:  new Date(),
        },
        Math: window.Math,

 	STICKINESS : {
				NONE: "NONE",
                SOURCEBASED: "SourceBased",
        		APPCOOKIE: "AppCookie",
        		LBCOOKIE: "LbCookie"

        	     },


        HTTP_GET: 'GET',
        HTTP_POST: 'POST',
        HTTP_PUT: 'PUT',
        HTTP_DELETE: 'DELETE',
        APP_URL: "http://localhost:8080/api/",
        CONTENT_LIMIT: 10,
        VIEW_URL : 'app/views/',
        NOTIFICATION_TEMPLATE: 'app/views/notification/notify.jsp',
        TOKEN_SEPARATOR: "@@",
        PAGE_ERROR_SEPARATOR: "PAGE_ERROR",

        paginationHeaders: function(pageNumber, limit) {
            var headers = {};

            var rangeStart = (pageNumber - 1) * limit;
            var rangeEnd = (pageNumber - 1) * limit + (limit - 1);
            headers.Range = "items=" + rangeStart + "-" + rangeEnd;
            return headers;
        },

        getViewPageUrl: function(url) {
        	return appGlobalConfig.VIEW_URL + url;
        },
        instanceCustomPlan : {
            computeOffer: {
                category: 'static',
                memory: {
                    value: 512,
                    floor: 512,
                    ceil: 4096
                },
                cpuCore: {
                    value: 1,
                    floor: 1,
                    ceil: 32
                },
                cpuSpeed: {
                    value: 500,
                    floor: 500,
                    ceil: 3500
                },
                minIops: {
                	value: 0,
                    floor: 0,
                    ceil: 500
                },
                maxIops: {
                	value: 0,
                    floor: 0,
                    ceil: 500
                },
                isOpen: true
            },
            diskOffer: {
                category: 'static',
                diskSize: {
                    value: 1,
                    floor: 1,
                    ceil: 1024
                },
                iops: {
                    value: 0,
                    floor: 0,
                    ceil: 500
                },
                isOpen: false
            },
            networks: {
                category: 'all',
                isOpen: false
            }
            },
        sessionValues:  JSON.parse($window.sessionStorage.getItem("loginSession")),
        loginRemeberMeTimeout: 30 * 24 * 60 * 60 * 1000
    };

    return appGlobalConfig;

}
