<div class="row" >                
    <div class="col-lg-6 col-md-6 col-sm-12"> 
        <div class="row ">
            <div class="p-sm pull-right">
                <a href="#" class="btn btn-info" title="Enable VPN"><span class="custom-icon custom-vpn font-bold m-xs"></span> Enable VPN</a>

                <a href="#" class="btn btn-info" title="Enable Static NAT"><span class="custom-icon custom-nat font-bold m-xs"></span> Enable Static NAT</a>

                <a href="#" class="btn btn-info" title="Delete IP"><span class="fa-trash fa font-bold m-xs"></span> Delete IP </a>
            </div>     

        </div>

        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="custom-icon custom-icon-ip"></i>&nbsp;&nbsp;IP Address Details</h3>
            </div>
            <div class="panel-body">
                <div class="row">
                    <table class="table table-condensed table-striped" cellspacing="1" cellpadding="1">
                        <tbody>
                            <tr>
                                <td><b>IP Address</b></td>
                                <td>{{ipDetails.ipaddress}}</td>
                            </tr>
                            <tr>
                                <td class="col-md-4 col-sm-4"><b>Network ID</b></td>
                                <td class="col-md-8 col-sm-8">{{ipDetails.networkid}}</td>
                            </tr>
                            <tr>
                                <td><b>VLAN</b></td>
                                <td>{{ipDetails.vlanname}}</td>
                            </tr>
                            <tr>
                                <td><b>Source NAT</b></td>
                                <td>{{ipDetails.isstaticnat}}</td>
                            </tr>
                            <tr>
                                <td><b>Static NAT</b></td>
                                <td><b class="text-success text-uppercase">{{ipDetails.state}}</b></td>
                            </tr>

                            <tr>
                                <td class="col-md-4 col-sm-4"><b>Zone</b></td>
                                <td class="col-md-8 col-sm-8">{{ipDetails.zonename}}</td>
                            </tr>

                        </tbody>
                    </table>
                </div>                    
            </div>
        </div>
    </div>

    <div class="col-md-6 col-sm-12" data-ng-controller="networkViewCtrl">
            <div class="cloud-diagram1 center-block">
                <div class="main-title">Internet<span>{{ipDetails.ipaddress}}</span></div>
                <div class="firewall">
                    Firewall
                    <a href="javascript:void(0)" data-ng-click="selectTab('firewall')" class="btn-diagram"><span>View</span></a>
                </div>
                 <div class="child-left pull-left">
                    Port Forwarding
                    <a href="javascript:void(0)" data-ng-click="selectTab('portForward')" class="btn-diagram"><span>View</span></a>
                </div>
                <div class="child-right pull-right">
                    Load Balancing
                    <a href="javascript:void(0)" data-ng-click="selectTab('loadBalance')" class="btn-diagram"><span>View</span></a>
                </div>
               
            </div>  
    </div>


</div>
