<div class="row" >

                <div class="col-lg-9 col-md-9 col-sm-12">
                    <div class="hpanel">
                        <div class="pull-right">
                            <a ui-sref-opts="{reload: true}" title="Refresh" ui-sref="cloud.list-network" class="btn btn-info" href="#/network/list"><span class="fa fa-refresh fa-lg "></span></a>
                            
                        </div>
                        <div class="pull-right m-r-sm">
                            <select  class="form-control" name="actions" data-ng-init="network.actions=networkElements.actions[3].name" data-ng-model="network.actions" ng-options="actions.name for actions in networkElements.actions" >
                                <option value="">Minutes</option>
                            </select>
                        </div>
                        <div class="clearfix"></div>
                        <div class="chart">
                            <canvas linechart options="lineOptions" data="lineData" width="800" height="150"></canvas>
                        </div>
                        <table >
                            <tbody>
                                <tr>
                                    <td class="legendColorBox p-xs">
                                        <div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #E56919;overflow:hidden"></div></div>
                                    </td>
                                    <td class="legendLabel">B/W IN</td>
                                    <td class="legendColorBox p-xs"><div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #16658D;overflow:hidden"></div></div>
                                    </td>
                                    <td class="legendLabel">B/W OUT</td>
                                  
                                </tr></tbody></table>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-4">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h3 class="panel-title"><i class="fa fa-bolt"></i>&nbsp;&nbsp;Quick Actions</h3>
                        </div>
                        <div class="panel-body no-padding">
                            <ul class="list-group">
                                <li class="list-group-item">
                                    <a href="#" title="Restart Network"><span class="fa-repeat fa font-bold m-xs"></span> Restart Network</a>
                                </li>
                                <li class="list-group-item">
                                    <a href="#" title="Delete Network"><span class="fa-trash fa font-bold m-xs"></span> Delete Network </a>
                                </li>
                                <li class="list-group-item">
                                    <a href="#" title="Edit Network"><span class="fa-edit fa font-bold m-xs"></span> Edit Network</a>
                                </li>
                              
                               
                            </ul>
                        </div>
                    </div>
            </div>
            <div class="col-lg-12 col-md-12 col-sm-8"> 
                <div class="panel panel-info">
                   <div class="panel-heading">
                       <h3 class="panel-title"><i class="fa fa-sitemap"></i>&nbsp;&nbsp;Network Details</h3>
                   </div>
                   <div class="panel-body">
                       <div class="row">
                       <div class="col-md-6">
                           <table class="table table-condensed table-striped" cellspacing="1" cellpadding="1">
                               <tbody>
                                   <tr>
                                       <td><b>Name</b></td>
                                       <td>{{network.name}}</td>
                                   </tr>
                                   <tr>
                                       <td class="col-md-4 col-sm-4"><b>ID</b></td>
                                       <td class="col-md-8 col-sm-8">{{network.networkID}}</td>
                                   </tr>
                                   <tr>
                                       <td class="col-md-4 col-sm-4"><b>Zone</b></td>
                                       <td class="col-md-8 col-sm-8">{{network.zone.name}}</td>
                                   </tr>
                                   <tr>
                                       <td><b>Description</b></td>
                                       <td>{{network.name}}</td>
                                   </tr>
                                    <tr>
                                       <td><b>Type</b></td>
                                       <td>{{network.type.name}}</td>
                                   </tr>
                                   <tr>
                                       <td><b>State</b></td>
                                       <td><b class="text-success text-uppercase">{{network.state}}</b></td>
                                   </tr>
                                   <tr>
                                       <td><b>VPC ID</b></td>
                                       <td>{{network.vpc}}</td>
                                   </tr>
                                   <tr>
                                       <td><b>Persistent </b></td>
                                       <td>{{network.persistent}} </td>
                                   </tr>
                                    <tr>
                                       <td><b> Domain</b></td>
                                       <td>{{network.domainName}}</td>
                                   </tr>
                                     <tr>
                                       <td><b> Account</b></td>
                                       <td>{{network.accountName}}</td>
                                   </tr>
                               </tbody>
                           </table>
                       </div>
                       <div class="col-md-6">
                           <table class="table table-condensed table-striped" cellspacing="1" cellpadding="1">
                               <tbody>
                                   <tr>
                                       <td class="col-md-4 col-sm-4"><b>Restart Required</b></td>
                                       <td class="col-md-8 col-sm-8">{{network.restart}}</td>
                                   </tr>
                                   <tr>
                                       <td><b>VLAN/VNI ID</b></td>
                                       <td>{{network.VLAN}}</td>
                                   </tr>
                                   <tr>
                                       <td><b>Broadcast URI</b></td>
                                       <td>{{network.broadcasturi}}</td>
                                   </tr>
                                   <tr>
                                       <td><b>Network Offering</b></td>
                                       <td>{{network.offering}}</td>
                                   </tr>
                                   <tr>
                                       <td><b>CIDR</b></td>
                                       <td>{{network.CIDR}}</td>
                                   </tr>
                                   <tr>
                                       <td><b>Network CIDR</b></td>
                                       <td>{{network.networkCIDR}}</td>
                                   </tr>
                                    <tr>
                                       <td><b>IPv6 Gateway</b></td>
                                       <td>{{network.ipv6gateway}}</td>
                                   </tr>
                                   <tr>
                                       <td><b>IPv6 CIDR</b></td>
                                       <td>{{network.ipv6CIDR}}</td>
                                   </tr>
                                   <tr>
                                       <td><b>Reserved IP Range</b></td>
                                       <td>{{network.ipRange}}</td>
                                   </tr>
                                   <tr>
                                       <td><b>Network Domain</b></td>
                                       <td>{{network.networkDomain}}</td>
                                   </tr>
                               </tbody>
                           </table>
                       </div>                    
                       </div>                    
                   </div>
               </div>
            </div>
         </div>