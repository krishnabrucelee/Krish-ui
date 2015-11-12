<!-- This is content container for nested view in UI-Router-->
<!-- You can put here any constant element in app content for example: Page title or breadcrum -->

<!-- Header -->
<div id="header" ng-include="'views/common/header.html'"></div>

<!-- Navigation -->
<aside id="menu" ng-include="'views/common/navigation.html'"></aside>

<!-- Main Wrapper -->
<div id="wrapper">
           <div small-header class="normalheader transition ng-scope small-header">
        <div class="hpanel" tour-step order="1" title="Page header" content="Place your page title and breadcrumb. Select small or large header or give the user choice to change the size." placement="bottom">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-right">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a ui-sref="dashboard">Home</a></li>
                        <li ng-repeat="state in $state.$current.path" ng-switch="$last || !!state.abstract" ng-class="{active: $last}">
                            <a ng-switch-when="false" href="#{{state.url.format($stateParams)}}">{{state.data.pageTitle}}</a>
                            <span ng-switch-when="true">{{state.data.pageTitle}}</span>
                        </li>
                    </ol>
                </div>
                <h2 class="font-light m-b-xs">
                    {{ $state.current.data.pageTitle }}
                </h2>
                <small>{{ $state.current.data.pageDesc }}</small>
            </div>
        </div>
    </div>
    <div class="content">
        <div ui-view >                     
           
                    <div class="row m-l-xs m-b-xs" id="compute-network">
                    <h3><u> Cloud & Networks</u></h3>
                            
                        <div class="row m-l-sm m-r-sm">
                                    <div class="col-md-3 col-sm-3 hpanel">
                                        <div class="panel-body">
                                        <div class="custom-icon custom-icon-ip ver-align-mid m-t-sm m-r-xs"></div><a href="#" class="" id="serviceMenuIPManager"><h4>IP Manager</h4></a>
                                        <p>Centralized IP Managers helps you to manage all your IP resources.</p>
                                        </div>
                                   
                                        </div>
                                    <div class="col-md-3 col-sm-3 hpanel">
                                        <div class="panel-body">
                                        <div class="custom-icon custom-load-ip ver-align-mid m-t-sm m-r-xs"></div><a class="" href="#" id="serviceMenuLoadBalancer"><h4>Load Balancer</h4></a>                                                                           
                                        <p>Setup your load-balancing policys on the fly with few clicks.</p>
                                        </div>
                                        </div>
                                    <div class="col-md-3 col-sm-3 hpanel">
                                        <div class="panel-body">
                                        <div class="custom-icon custom-icon-vpn ver-align-mid m-t-sm m-r-xs"></div><a class="" href="#" id="serviceMenuVPN"><h4>VPN</h4></a>
                                        <p>VPN manager helps you to setup, track and manage your VPN requirments.</p>
                                        </div>
                                        </div>
                                    <div class="col-md-3 col-sm-3 hpanel">
                                        <div class="panel-body">
                                        <div class="fa fa-share-alt ver-align-mid  m-r-xs"></div><a class="" href="#" id="serviceMenuPortForwarding"><h4>Port Forwarding</h4></a>
                                        <p>Setup your Port Forwarding policys on the fly with few clicks.</p>
                                        </div>
                                        </div>
                                </div>
                            <div class="row m-l-sm m-r-sm">
                                    <div class="col-md-3 col-sm-3 hpanel">
                                        <div class="panel-body">
                                        <div class="custom-icon custom-firewall-ip ver-align-mid m-t-sm m-r-xs"></div><a class="" href="#" id="serviceMenuFirewall"><h4>Firewall</h4></a>
                                        <p>Manage all your inbound and outbound traffic with Firewall Manager.</p>
                                        </div></div>
                                    <div class="col-md-3 col-sm-3 hpanel">
                                        <div class="panel-body">
                                        <div class="custom-icon custom-icon-vpc ver-align-mid m-t-sm m-r-xs"></div><a class="" href="#" id="serviceMenuVPC" onclick=""><h4>VPC</h4></a>
                                        <p>VPC - lets you launch cloud resources in a private, isolated cloud.</p>
                                        </div>
                                        </div>
                            </div>
                </div>
                        
                        <div class="row m-l-xs m-b-xs" id="cloud-storage">
                          
                            <h3><u>Cloud & Storage Service</u></h3>
                        <div class="row m-l-sm m-r-sm">
                                <div class="col-md-3 col-sm-3 hpanel">
                                    <div class="panel-body">
                                    <div class="fa fa-database ver-align-mid  m-r-xs"></div><a class="" id="serviceMenuStorageContainer"><h4>Storage Container</h4></a>
                                    <p>On-demand storage and content delivery that is highly scalable to fit your needs.</p>
                                    </div></div>
                                <div class="col-md-3 col-sm-3 hpanel">
                                    <div class="panel-body">
                                    <div class="custom-icon custom-icon-s3 ver-align-mid m-t-sm m-r-xs "></div><a class="" id="serviceMenuAmazonS3"><h4>Amazon S3</h4></a>
                                    <p>On-demand file storage on Amazon elastic Simple Storage Service (S3).</p>
                                    </div></div>
                                
                      
                        </div>
            
                        </div>
                      
                    <div class="row m-l-xs m-b-xs" id="netscalar">
                        
                        <h3> <u>Netscalar As A Service</u> </h3>
                           <div class="row m-l-sm m-r-sm">
                                    <div class=" col-md-3 col-sm-3 hpanel">
                                        <div class="panel-body">
                                        <div class="custom-icon custom-icon-elastic ver-align-mid m-t-sm m-r-xs"></div><a class="" id="serviceMenuElasticIP"><h4>Elastic IP</h4></a>
                                        <p>Elastic IP addresses are static IP addresses designed for dynamic cloud computing.</p>
                                        </div></div>
                                    <div class="col-md-3 col-sm-3 hpanel">
                                        <div class="panel-body">
                                        <div class="custom-icon custom-icon-scale ver-align-mid m-t-sm m-r-xs"></div><a class="" id="serviceMenuAutoScale"><h4>AutoScale</h4></a>
                                        <p>The Auto Scale feature of Cloud Servers helps you prepare for high-traffic events and scheduled load changes.</p>
                                        </div></div>
                                    <div class="col-md-3 col-sm-3 hpanel">
                                        <div class="panel-body">
                                        <div class="custom-icon custom-load-ip ver-align-mid m-t-sm m-r-xs"></div><a class="" id="serviceMenuNetScaleLoadBalancer"><h4>Load Balancer</h4></a>
                                        <p>Setup your load-balancing policys on the fly with few clicks.</p>
                                        </div></div>
                                    <div class="col-md-3 col-sm-3 hpanel">
                                        <div class="panel-body">
                                        <div class="custom-icon custom-icon-vpn ver-align-mid m-t-sm m-r-xs"></div><a class="" id="serviceMenuNetScaleVPN"><h4>VPN</h4></a>
                                        <p>VPN manager helps you to setup, track and manage your VPN requirments.</p>
                                        </div></div>
                           </div>
                        <div class="row m-l-sm m-r-sm">
                                    <div class="col-md-3 col-sm-3 hpanel">
                                        <div class="panel-body">
                                        <div class="fa fa-share-alt ver-align-mid  m-r-xs"></div><a class="" id="serviceMenuNetScalePortForwarding"><h4>Port Forwarding</h4></a>
                                        <p>Setup your Port Forwarding policys on the fly with few clicks.</p>
                                        </div></div>
                                    <div class="col-md-3 col-sm-3 hpanel">
                                        <div class="panel-body">
                                        <div class="custom-icon custom-firewall-ip ver-align-mid m-t-sm m-r-xs"></div><a class="" id="serviceMenuNetScaleFirewall"><h4>Firewall</h4></a>
                                        <p>Manage all your inbound and outbound traffic with Firewall Manager.</p>
                                        </div></div>
                           </div>
                    </div>
                </div>
                     
                     
                         
            </div>
            </div>
 
