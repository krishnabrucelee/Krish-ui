
angular
        .module('pandaConfig', [])
        .factory('globalConfig', globalConfig);


        function globalConfig() {
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
                rulesLB:[{name:'Test','protocol':'tcp',publicPort:'90',privatePort:'90',publicEndPort:'120',privateEndPort:'120',algorithm:'Round-robin',vms:[{id:'',name: "NorthChina- Beijing",zone:"Beijing"}],state:'active'}],
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
                
                HTTP_GET: 'GET',
                HTTP_POST: 'POST',
                HTTP_PUT: 'PUT',
                HTTP_DELETE: 'DELETE',
                APP_URL: "http://192.168.1.27:8080/api/",
                NOTIFICATION_TEMPLATE: 'views/notification/notify.html',
                CONTENT_LIMIT: 10,
                
                paginationHeaders: function(pageNumber, limit) {
                    var headers = {};

                    var rangeStart = (pageNumber - 1) * limit;
                    var rangeEnd = (pageNumber - 1) * limit + (limit - 1);
                    headers.Range = "items=" + rangeStart + "-" + rangeEnd;
                    return headers;
                }
            };
            
            return appGlobalConfig;

        }