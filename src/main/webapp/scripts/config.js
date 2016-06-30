/**
 * HOMER - Responsive Admin Theme Copyright 2015 Webapplayers.com
 *
 */

function configState($stateProvider, $httpProvider, $urlRouterProvider, $compileProvider, localStorageServiceProvider, PANDA_CONFIG) {

    var VIEW_URL = "app/";
    // Optimize load start with remove binding information inside the DOM
    // element
    $compileProvider.debugInfoEnabled(true);

    $httpProvider.defaults.headers.common = {};
    $httpProvider.defaults.headers.post = {};
    $httpProvider.defaults.headers.put = {};
    $httpProvider.defaults.headers.patch = {};
    // Set default state
    $urlRouterProvider.otherwise("/login");
    $stateProvider

            // Home - Main page
            .state('login', {
                url : "/login",
                templateUrl : VIEW_URL + "login.jsp",
                data : {
                    pageTitle : 'common.login',
                }
            })
            .state('dashboard', {
                url : "/dashboard",
                templateUrl : VIEW_URL + "views/dashboard.jsp",
                data : {
                    pageTitle : 'common.home',
                }
            })

            .state('report', {
                url : "/usage/report",
                templateUrl : VIEW_URL + "views/client-usage.jsp",
                data : {
                    pageTitle : 'Usage Details',
                }
            })
            .state('profile', {
                url : "/profile",
                templateUrl : VIEW_URL + "views/profile.jsp",
                data : {
                    pageTitle : 'Profile Settings',
                }
            })
            .state('invoice', {
                url : "/invoice",
                templateUrl : VIEW_URL + "views/common/retail-invoice.html",
                data : {
                    pageTitle : 'Invoice',
                }
            })

            // Analytics
            .state('analytics', {
                url : "/analytics",
                templateUrl : VIEW_URL + "views/analytics.jsp",
                data : {
                    pageTitle : 'Analytics',
                }
            })

            // App views
            .state('views', {
                abstract : true,
                url : "/views",
                templateUrl : VIEW_URL + "views/common/content.jsp",
                data : {
                    pageTitle : 'App Views'
                }
            })

            .state('views.material', {
                url : "/sample/material",
                templateUrl : VIEW_URL + "views/samples/materail.jsp",
                data : {
                    pageTitle : 'Sample Form',
                    pageDesc : 'Sample Form'
                }
            })

            .state('activity', {
                url : "/activity",
                templateUrl : VIEW_URL + "views/activity/index.jsp",
                data : {
                    pageTitle : 'Activity'
                }
            })

            // Cloud
            .state('cloud', {
                abstract : true,
                url : "/",
                templateUrl : VIEW_URL + "views/common/content.jsp",
                data : {
                    pageTitle : 'common.cloud'
                }
            })

            .state('cloud.list-instance', {
                url : "instance/list",
                templateUrl : VIEW_URL + "views/cloud/instance/list.jsp",
                data : {
                    pageTitle : 'common.instances'
                }
            })

            .state('cloud.list-instance.view-instance', {
                url : "/view/:id",
                templateUrl : VIEW_URL + "views/cloud/instance/view.jsp",
                data : {
                    pageTitle : 'view.instance',
                    id : ""
                }
            })

            .state('cloud.list-instance-host', {
                url : "host/list/:id",
                templateUrl : VIEW_URL + "views/cloud/instance/listhost.jsp",
                data : {
                    pageTitle : 'common.host'
                }
            })

            .state('cloud.list-instance.view-instance.ipaddress', {
                url : "/ip-address/:id1",
                templateUrl : VIEW_URL + "views/cloud/instance/listIPAddress.jsp",
                data : {
                    pageTitle : 'Secondary IP Address'
                }
            })

            .state('cloud.list-instance.monitor-instance', {
                url : "/view/:id",
                templateUrl : VIEW_URL + "views/cloud/instance/monitor.jsp",
                data : {
                    pageTitle : 'common.monitor'
                }
            })

            .state('cloud.list-volume', {
                url : "volume/list",
                templateUrl : VIEW_URL + "views/cloud/volume/list.jsp",
                data : {
                    pageTitle : 'common.volume'
                }
            })
            .state('cloud.volume-snapshot', {
                url : "volume/snapshot",
                templateUrl : VIEW_URL + "views/cloud/volume/volume-snapshot.jsp",
                data : {
                    pageTitle : 'common.snapshots'
                }
            })
            .state('cloud.list-volume.view-volume', {
                url : "/view/:id",
                templateUrl : VIEW_URL + "views/cloud/volume/view.jsp",
                data : {
                    pageTitle : 'View Volume'
                }
            })

            .state('cloud.quota-limit', {
                url : "quota-limit",
                templateUrl : VIEW_URL + "views/cloud/quota/quota-limit.jsp",
                data : {
                    pageTitle : 'common.quota.limit'
                }
            })

            .state('cloud.list-ssh', {
                url : "sshkeys/list",
                templateUrl : VIEW_URL + "views/cloud/sshkeys/list.jsp",
                data : {
                    pageTitle : 'common.ssh.keys'
                }
            })
            .state('cloud.list-affinity', {
                url : "affinitygroup/list",
                templateUrl : VIEW_URL + "views/cloud/affinitygroup/list.jsp",
                data : {
                    pageTitle : 'common.affinity.group'
                }
            })
            .state('cloud.list-snapshot', {
                url : "snapshot/list",
                templateUrl : VIEW_URL + "views/cloud/snapshot/list.jsp",
                data : {
                    pageTitle : 'common.snapshot'
                }
            })

            .state('cloud.landing', {
                url : "index",
                templateUrl : VIEW_URL + "views/cloud/cloud-landing.jsp",
                data : {
                    pageTitle : 'Cloud'
                }
            })

            .state('views.form', {
                url : "/sample/form",
                templateUrl : VIEW_URL + "views/samples/form.jsp",
                data : {
                    pageTitle : 'Sample Form',
                    pageDesc : 'Sample Form'
                }
            })

            // VPC list
            .state('vpc', {
                url : "/vpc",
                templateUrl : VIEW_URL + "views/vpc/list.jsp",
                data : {
                    pageTitle : 'VPC'
                }
            })

            // View VPC
            .state('vpc.view-vpc', {
                url : "/:view/:id",
                templateUrl : VIEW_URL + "views/vpc/view-vpc.jsp",
                data : {
                    pageTitle : 'view VPC'
                }
            })



            // Config VPC
            .state('vpc.view-vpc.config-vpc', {
                url : "/config-vpc",
                templateUrl : VIEW_URL + "views/vpc/config-vpc.jsp",
                data : {
                    pageTitle : 'config VPC'
                }
            })

   	   .state('vpc.view-vpc.config-vpc.view-network', {
                url : "/:view/:idNetwork",
                templateUrl : VIEW_URL + "views/vpc/vpc-network-dashboard.jsp",
                data : {
                    pageTitle : 'view.network',
                    networkTab : 'details'
                }
            })

              // VPN Customer Gateway list
            .state('vpngateway', {
                url : "/vpngateway",
                templateUrl : VIEW_URL + "views/vpn/list.jsp",
                data : {
                    pageTitle : 'VPN Customer Gateway'
                }
            })

            // Public IP
            .state('vpc.view-vpc.config-vpc.public-ip', {
                url : "/public-ip",
                templateUrl : VIEW_URL + "views/vpc/public-ip.jsp",
                data : {
                    pageTitle : 'Public IP'
                }
            })

           // View Site to Site VPN
            .state('vpc.view-vpc.config-vpc.view-sitevpn', {
                url : "/view-sitevpn",
                templateUrl : VIEW_URL + "views/vpc/view-site-vpn.jsp",
                data : {
                    pageTitle : 'Site to Site VPN'
                }
            })

            // View IP
            .state('vpc.view-vpc.config-vpc.public-ip.ip-view', {
                url : "/ip-address/:id1",
                templateUrl : VIEW_URL + "views/vpc/vpcip-view.jsp",
                data : {
                    pageTitle : 'View IP',
                    networkTabs : 'ipdetails'
                }
            })

            // Private Gateway
            .state('vpc.private-gateway', {
                url : "/private-gateway/:id",
                templateUrl : VIEW_URL + "views/vpc/private-gateway.jsp",
                data : {
                    pageTitle : 'Private Gateway'
                }
            })

            // Network ACL
            .state('vpc.view-vpc.config-vpc.network-acl', {
                url : "/network-acl",
                templateUrl : VIEW_URL + "views/vpc/network-acl.jsp",
                data : {
                    pageTitle : 'Network ACL'
                }
            })

            .state('vpc.view-vpc.config-vpc.network-acl.view-networkAcl', {
                url : "/:view/:id3",
                templateUrl : VIEW_URL + "views/vpc/view-network-acl.jsp",
                data : {
                    pageTitle : 'View Network',
                    networkTab : 'details'
                }
            })

            // Public LB IP
            .state('vpc.public-lbip', {
                url : "/public-lbip/:id",
                templateUrl : VIEW_URL + "views/vpc/public-lbip.jsp",
                data : {
                    pageTitle : 'Public LB IP'
                }
            })

            // Static NAT
            .state('vpc.static-nat', {
                url : "/static-nat/:id",
                templateUrl : VIEW_URL + "views/vpc/static-nat.jsp",
                data : {
                    pageTitle : 'Static NAT'
                }
            })

            // Virtual Machines
            .state('vpc.view-vpc.config-vpc.virtual-machines', {
                url : "/virtual-machines/:id2",
                templateUrl : VIEW_URL + "views/vpc/virtual-machines.jsp",
                data : {
                    pageTitle : 'Virtual Machines'
                }
            })

            // Virtual Machines
            .state('vpc.view-vpc.config-vpc.lbip', {
                url : "/lbip/:id3",
                templateUrl : VIEW_URL + "views/vpc/lbip.jsp",
                data : {
                    pageTitle : 'LoadBalancer IP'
                }
            })

            // Virtual Machines
            .state('vpc.view-vpc.config-vpc.natip', {
                url : "/staticnat/:id4",
                templateUrl : VIEW_URL + "views/vpc/staticnat.jsp",
                data : {
                    pageTitle : 'Static Nat IP'
                }
            })

            .state('vpc.ip-view', {
                url : "/:view/:id",
                templateUrl : VIEW_URL + "views/vpc/vpcip-view.jsp",
                data : {
                    pageTitle : 'View IP'
                }
            })

                // Organization
            .state('organization', {
                abstract : true,
                url : "/organization",
                templateUrl : VIEW_URL + "views/common/content.jsp",
                data : {
                    pageTitle : 'common.organization'
                }
            })

            // Projects
            .state('organization.projects', {
                url : "/projects",
                templateUrl : VIEW_URL + "views/project/index.jsp",
                data : {
                    pageTitle : 'common.projects'
                }
            })
            .state('organization.projects.view', {
                url : "/:id",
                templateUrl : VIEW_URL + "views/project/view.jsp",
                data : {
                    pageTitle : 'view.projects'
                }
            })

            .state('organization.projects.quotalimit', {
                url : "/:quotaType/:id",
                templateUrl : VIEW_URL + "views/project/projectquota.jsp",
                data : {
                    pageTitle : 'quota.limit'
                }
            })

            // Applications
            .state('organization.applications', {
                url : "/applications",
                templateUrl : VIEW_URL + "views/application/list.jsp",
                data : {
                    pageTitle : 'common.applications'
                }
            })

            // payment
            .state('alipayments', {
                url : "/alipayments",
                templateUrl : VIEW_URL + "views/common/payment-confirm.jsp",
                data : {
                    pageTitle : 'Payment'
                }
            })

            // Accounts
            .state('organization.accounts', {
                url : "/accounts",
                templateUrl : VIEW_URL + "views/account/list.jsp",
                data : {
                    pageTitle : 'common.accounts'
                }
            })

            // Billing module

            .state('billing', {
                abstract : true,
                url : "/billing",
                templateUrl : VIEW_URL + "views/common/billingcontent.jsp",
                data : {
                    pageTitle : 'Billing'
                }
            })

            .state('billing.current-usage', {
                url : "/usage",
                templateUrl : VIEW_URL + "views/billing/current-usage.jsp",
                data : {
                    pageTitle : 'Current Usage'
                }
            })

            .state('billing.invoice', {
                url : "/invoice",
                templateUrl : VIEW_URL + "views/billing/invoice.jsp",
                data : {
                    pageTitle : 'Invoices'
                }
            })

            .state('billing.usageStatistics', {
                url : "/usageStatistics",
                templateUrl : VIEW_URL + "views/billing/usageStatistics.jsp",
                data : {
                    pageTitle : 'Usage statistics'
                }
            })

            .state('billing.payments', {
                url : "/payments",
                templateUrl : VIEW_URL + "views/billing/payments.jsp",
                data : {
                    pageTitle : 'Payments'
                }
            })

            .state('billing.recurring', {
                url : "/recurring",
                templateUrl : VIEW_URL + "views/billing/recurring.jsp",
                data : {
                    pageTitle : 'Recurring Items',
                }
            })

            // Templates

            .state('template-store', {
                url : "/templates",
                templateUrl : VIEW_URL + "views/templates/index.jsp",
                data : {
                    pageTitle : 'Template Store'
                }
            })

            // Services

            .state('services', {
                url : "/services",
                templateUrl : VIEW_URL + "views/services/index.jsp",
                data : {
                    pageTitle : 'Services'
                }
            })

            // Support

            .state('support', {
                abstract : true,
                url : "/",
                templateUrl : VIEW_URL + "views/common/content.jsp",
                data : {
                    pageTitle : 'Support'
                }
            })
            .state('support.tickets', {
                url : "support/tickets",
                templateUrl : VIEW_URL + "views/support/list.jsp",
                data : {
                    pageTitle : 'Tickets'
                }
            })

            .state('support.tickets.view-ticket', {
                url : "/:id",
                templateUrl : VIEW_URL + "views/support/view.jsp",
                data : {
                    pageTitle : 'View Ticket'
                }

            })

            // Network
            .state('cloud.list-network', {
                url : "network/list",
                templateUrl : VIEW_URL + "views/cloud/network/list.jsp",
                data : {
                    pageTitle : 'common.network'
                }
            })

            .state('cloud.list-network.view-network', {
                url : "/:view/:id",
                templateUrl : VIEW_URL + "views/cloud/network/view.jsp",
                data : {
                    pageTitle : 'view.network',
                    networkTab : 'details'
                }
            })

            .state('cloud.list-network.view-network.view-ipaddress', {
                url : "/ip-address/:id1",
                templateUrl : VIEW_URL + "views/cloud/network/ip-view.jsp",
                data : {
                    pageTitle : 'ip.address',
                    networkTabs : 'ipdetails'
                }
            })

            // Roles
            // .state('roles', {
            // abstract: true,
            // url: "/roles",
            // templateUrl: VIEW_URL + "views/common/content.jsp",
            // data: {
            // pageTitle: 'Role'
            // }
            // })

            .state('organization.roles', {
                url : "/roles",
                templateUrl : VIEW_URL + "views/roles/list.jsp",
                data : {
                    pageTitle : 'common.roles'
                }
            })

            .state('organization.roles.list-add', {
                url : "/add",
                templateUrl : VIEW_URL + "views/roles/add.jsp",
                data : {
                    pageTitle : 'add.role'
                }

            })
            .state('organization.roles.list-edit', {
                url : "/edit/:id",
                templateUrl : VIEW_URL + "views/roles/edit.jsp",
                data : {
                    pageTitle : 'edit.role'
                }

            })

            // Charts
            .state('charts', {
                abstract : true,
                url : "/charts",
                templateUrl : VIEW_URL + "views/common/content.jsp",
                data : {
                    pageTitle : 'Charts'
                }
            })
            .state('charts.flot', {
                url : "/flot",
                templateUrl : VIEW_URL + "views/charts/flot.jsp",
                data : {
                    pageTitle : 'Flot chart',
                    pageDesc : 'Flot is a pure JavaScript plotting library for jQuery, with a focus on simple usage, attractive looks and interactive features.'
                }
            }).state('charts.chartjs', {
                url : "/chartjs",
                templateUrl : VIEW_URL + "views/charts/chartjs.jsp",
                data : {
                    pageTitle : 'ChartJS',
                    pageDesc : 'Simple HTML5 Charts using the canvas element'
                }
            }).state('charts.inline', {
                url : "/inline",
                templateUrl : VIEW_URL + "views/charts/inline.jsp",
                data : {
                    pageTitle : 'Inline charts',
                    pageDesc : 'Small inline charts directly in the browser using data supplied in the controller.'
                }
            })

            // Common views
            .state('common', {
                abstract : true,
                url : "/common",
                templateUrl : VIEW_URL + "views/common/content_empty.jsp",
                data : {
                    pageTitle : 'Common'
                }
            })

            .state('organization.department', {
                url : "/department",
                templateUrl : VIEW_URL + "views/department/list.jsp",
                data : {
                    pageTitle : 'common.departments'
                }
            })

            // Domains

            .state('domain', {
                url : "/domain",
                templateUrl : VIEW_URL + "views/domain/list.jsp",
                data : {
                    pageTitle : 'Domains'
                }
            })

            .state('organization.department.quotalimit', {
                url : "/:quotaType/:id",
                templateUrl : VIEW_URL + "views/department/departmentquota.jsp",
                data : {
                    pageTitle : 'quota.limit'
                }
            })

}

angular
        .module('homer')
        .constant("PANDA_CONFIG", {
            "VIEW_URL" : "app/views/",
        })
        .factory('myFactory', function($http, globalConfig, AppConstants, $cookies, $window, tokens, localStorageService, utilService) {
            var loginSession = globalConfig.sessionValues;
            if ((loginSession == null || angular.isUndefined(globalConfig.sessionValues)) && tokens != null) {
                globalConfig.sessionValues = tokens;
                globalConfig.CONTENT_LIMIT = tokens.paginationLimit;
                globalConfig.sessionValues.token = localStorageService.get('token');
                globalConfig.sessionValues.loginToken = localStorageService.get('loginToken');
                AppConstants.REQUEST_PROTOCOL = tokens.REQUEST_PROTOCOL;
                AppConstants.REQUEST_PORT = tokens.REQUEST_PORT;
                localStorageService.set('rememberMe', tokens.rememberMe);
                if ((angular.isUndefined(localStorageService.get('rememberMe')) || localStorageService
                        .get('rememberMe') == false || localStorageService.get('rememberMe') == "false") && (angular
                        .isUndefined($cookies.rememberMe) || $cookies.rememberMe == undefined || $cookies.rememberMe == "undefined")) {
                    utilService.logoutApplication("COOKIE_TIME_OUT");
                }
            }
            return {
                foo : function() {
                    return 'bar'
                }
            };
        }).run(function($rootScope, $state, webSockets, editableOptions, myFactory, appService) {
            $rootScope.$state = $state;
            editableOptions.theme = 'bs3';
            $rootScope.$on('$locationChangeStart', function(event, next, current) {
                var nextRoute = next.split('#')[1];
                var currentPath = current.split('#')[1];
                if (nextRoute.indexOf('instance/list/view/') == -1 && currentPath.indexOf('instance/list/view/') > -1) {
                	webSockets.disconnect(appService.globalConfig.MONITOR_SOCKET_URL + 'stack/watch');
                }
            });
        }).config(configState);
