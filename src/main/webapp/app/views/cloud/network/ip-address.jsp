<div class="panel-heading">
                <div class="row">
                    <div class="col-md-3 col-sm-3 col-xs-3 ">
                        <div class="quick-search">
                            <div class="input-group">
                                <input data-ng-model="networkSearch" type="text" class="form-control input-medium" placeholder="Quick Search" aria-describedby="quicksearch-go">
                                <span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-9 col-sm-9 col-xs-9">
                        <span class="pull-right">
                            <a class="btn btn-info" data-ng-click="openAddIP('md')"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span>Acquire new IP</a>
                       </span>
                    </div>
                </div>
               <div class="clearfix"></div>
</div>
<div class="white-content">
<form >
    
     <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
                    <thead>
                    <tr>
                        <th>IPS</th>
                        <th>Zone</th>
                        <th>State</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>
                            <a class="text-info"  ui-sref="cloud.list-network.view-network.view-ipaddress({id1:1})"  title="View IP"> {{ network.ip }}[Source NAT]</a>
                        </td>
                        <td>{{ network.zone.name }} </td>
                        <td> <b class="text-success text-uppercase">{{network.state}}</b></td>
                      <td>
                            <a class="icon-button" title="Enable VPN">                    
                                <i class="custom-link-icon custom-vpn-ip"></i> 
                            </a>
                            <a class="icon-button" title="Release IP"  ><span class="fa fa-chain-broken"></span></a>
                      </td>
                    </tr>
                    </tbody>
                </table>
</form>
</div>