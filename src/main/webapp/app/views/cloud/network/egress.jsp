<!-- <div data-ng-controller="networksCtrl">
<div class="white-content" >


        <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th class="col-md-3 col-xs-3">Source CIDR</th>
                    <th class="col-md-2 col-xs-2">Protocol</th>
                    <th class="col-md-2 col-xs-2" data-ng-show="udp || tcp">Start Port</th>
                    <th class="col-md-2 col-xs-2"data-ng-show="udp || tcp">End Port</th>
                    <th class="col-md-2 col-xs-2" data-ng-show="icmp">ICMP Type</th>
                    <th class="col-md-2 col-xs-2" data-ng-show="icmp">ICMP Code</th>
                    <th class="col-md-3 col-xs-3">Action</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><input  type="text" name="cidr"  valid-cidr placeholder="0.0.0.0/24"  data-ng-model="cidr" class="form-control input-group " ><span class="text-center" data-ng-show="cidrValidate && actionRule" data-ng-class="cidrValidate && actionRule ? 'text-danger' : ''"> Invalid format</span></td>
                    <td><select  class="form-control input-group" name="protocol" data-ng-model="protocolName" data-ng-init="protocolName = networkLists.protocols[0]" data-ng-change="selectProtocol(protocolName.name)" data-ng-options="protocolName.name for protocolName in networkLists.protocols"></select></td>
                    <td data-ng-show="udp || tcp"<input valid-number  placeholder="1-65535" data-ng-min="1" data-ng-max="65535"   type="text" name="startPort" data-ng-model="startPort" class="form-control " autofocus > </td>
                    <td data-ng-show="udp || tcp"><input valid-number placeholder="1-65535" data-ng-min="1" data-ng-max="65535"   type="text" name="endPort" data-ng-model="endPort" class="form-control " autofocus > </td>
                    <td data-ng-show="icmp"><input valid-number   name="icmpType" data-ng-model="icmpType" class="form-control " autofocus type="text"></td>
                    <td data-ng-show="icmp"><input valid-number  name="icmpCode" data-ng-model="icmpCode" class="form-control " autofocus type="text"></td>
                    <td>
                        <a  class="btn btn-info" data-ng-click="addRule()" ><span class="pe-7s-plus pe-lg font-bold m-r-xs" ></span>Add Rule</a>
                        <a data-ng-show="delete" class="btn btn-info" data-ng-click="openAddIsolatedNetwork('lg')"><span class="pe-7s-trash pe-lg font-bold m-r-xs"></span></a>
                    </td>
                </tr>
            </tbody>
        </table>
    <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
          <thead>
                <tr>
                    <th class="col-md-3 col-xs-3"></th>
                    <th class="col-md-2 col-xs-2"></th>
                    <th class="col-md-2 col-xs-2"></th>
                    <th class="col-md-2 col-xs-2"></th>
                    <th class="col-md-3 col-xs-3"></th>
                </tr>
            </thead>
            <tbody>
               <tr ng-repeat="rule in rules" class="font-bold text-center">
             	<td>{{rule.cidr}}</td>
		<td>{{rule.protocol}}</td>
                <td><div  data-ng-show=" (rule.startPort == '' || rule.startPort!='') ">{{rule.startPort}}</div> <div  data-ng-show=" (rule.icmpType=='' || rule.icmpType!='') ">{{rule.icmpType}}</div></td>
                <td><div data-ng-show=" (rule.endPort =='' || rule.endPort!='')">{{rule.endPort}} </div> <div data-ng-show="(rule.icmpCode=='' || rule.icmpCode!='')" >{{rule.icmpCode}}</div></td>
                <td>
                <a data-ng-click="deleteRules(rule.id,'Egress')"><span class="fa fa-trash"></span></a>

                </td>
	        </tr>
           deleteRules(rule.id,'Egress')
            </tbody>
    </table>



</div></div>
 -->