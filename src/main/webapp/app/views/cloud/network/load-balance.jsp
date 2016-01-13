<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div data-ng-controller="networksCtrl">
<div class="white-content" >
    <form name="loadform" method="POST" novalidate data-ng-submit="openAddVM(loadform)">

        <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th class="col-md-2 col-xs-2">Name</th>
                    <th class="col-md-1 col-xs-1">Public Port</th>
                    <th class="col-md-1 col-xs-1">Private Port</th>
                    <th class="col-md-2 col-xs-2">Algorithm</th>
                    <th class="col-md-1 col-xs-2">Stickiness</th>
                    <th class="col-md-1 col-xs-2">Health Check</th>
                    <th class="col-md-1 col-xs-2">Add VMs</th>
                    <th class="col-md-1 col-xs-2">State</th>
                    <th class="col-md-2 col-xs-2">Action</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><input required="true"  type="text" name="name" data-ng-model="load.name"  class="form-control" ><span class="text-center text-danger" data-ng-show="loadform.name.$invalid && loadFormSubmitted"> * Required</span></td>
                    <td><input required="true" valid-number data-ng-model="publicPort"  data-ng-min="1" data-ng-max="65535"   type="text" name="publicPort" class="form-control " autofocus > <span class="text-center text-danger" data-ng-show="loadform.publicPort.$invalid && loadFormSubmitted"> *Required</span></td>
                    <td><input required="true" valid-number  data-ng-model="privatePort"  data-ng-min="1" data-ng-max="65535"   type="text" name="privatePort"  class="form-control " autofocus > <span class="text-center text-danger" data-ng-show="loadform.privatePort.$invalid && loadFormSubmitted"> *Required</span></td>
                    <td><select required="true"  class="form-control" name="protocol" data-ng-model="algorithms" data-ng-init="algorithms = networkLists.algorithms[0]" data-ng-change="selectProtocol(algorithms.name)" data-ng-options="algorithms.name for algorithms in dropnetworkLists.algorithms"><option value=""><fmt:message key="common.select" bundle="${msg}" /></option></select>
                    <span class="text-center text-danger" data-ng-show="loadform.protocol.$invalid && loadFormSubmitted"> *Required</span> </td>
                    <td><a  class="btn btn-info" ng-click="createStickiness('md')">Configure</a></td>
                    <td><a  class="btn btn-info" ng-click="healthCheck(loadform)">Configure</a></td>
                    <td><input  class="btn btn-info" type="submit" value="Add VM"></td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
    <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
          <thead>
                <tr>
                    <th class="col-md-2 col-xs-2"></th>
                    <th class="col-md-1 col-xs-1"></th>
                    <th class="col-md-1 col-xs-1"></th>
                    <th class="col-md-2 col-xs-2"></th>
                    <th class="col-md-1 col-xs-2"></th>
                    <th class="col-md-1 col-xs-2"></th>
                    <th class="col-md-1 col-xs-2"></th>
                    <th class="col-md-1 col-xs-2"></th>
                    <th class="col-md-2 col-xs-2"></th>
                    
                </tr>
            </thead>
            <tbody>
                            
               <tr ng-repeat-start="rule in rulesList" class="font-bold text-center" >
                <td> 
                <button data-ng-if="rule.expanded" data-ng-click="rule.expanded = false">-</button>
                <button data-ng-if="!rule.expanded" data-ng-click="rule.expanded = true">+</button>
                {{rule.name}}  </td>
                <td>{{rule.startPort}}</td>
                <td>{{rule.endPort}}</td>
                <td>{{rule.algorithm}}</td>
                <td><a  class="btn btn-info" data-ng-click="createStickiness('md')">Configure</a></td>
                <td><a  class="btn btn-info" data-ng-click="healthChecklist()">Configure</a></td>
                <td><a  class="btn btn-info" data-ng-click="openAddVMlist()">Add VM</a></td>
                <td>Active</td>
                <td>
                <a class="icon-button"  data-ng-click="editrule('md', rule)" title="<fmt:message key="common.edit" bundle="${msg}" />"
				    >
				<span class="fa fa-edit m-r"> </span> </a> 
												
		        <a class="icon-button"  title="<fmt:message key="common.delete" bundle="${msg}" /> "
					data-ng-click="deleteRules(rule.id,'LB')"><span	class="fa fa-trash"></span></a>
		
                </td>
                </tr>
                 <tr ng-if="rule.expanded" ng-repeat-end="">
                 <td > {{rule.name}}</td>
                  <td>{{rule.endPort}}</td>
                <td>{{rule.algorithm}}</td>
                 <td>x</td>
                 </tr>
                 </tbody>
    </table>
    
    </form>


</div></div>

