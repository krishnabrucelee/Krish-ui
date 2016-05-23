<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

  <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header id="vpc_add_vm_page_title" page-icon="fa fa-cloud" page-title="<fmt:message key="add.vm" bundle="${msg}" />"></panda-modal-header>
        </div>
        <div class="modal-body">
        <div class="row">
        <div class="hpanel">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-md-3 col-sm-3 col-xs-3 ">
                        <div class="quick-search">
                            <div class="input-group">
                                <input id="vpc_add_vm_quick_search" data-ng-model="instanceSearch" type="text" class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
                                <span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
                            </div>
                        </div>
                    </div>
                </div>
               <div class="clearfix"></div>
            </div>

            <div class="white-content">
                <div class="table-responsive">
                    <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped" id="vpc_add_vm_table">
                    <thead>
                    <tr>
                        <th><fmt:message key="common.name" bundle="${msg}" /> </th>
                        <th><fmt:message key="common.internal.name" bundle="${msg}" /></th>
                        <th><fmt:message key="common.display.name" bundle="${msg}" /></th>
                        <th><fmt:message key="common.zone" bundle="${msg}" /></th>
                        <th><fmt:message key="common.state" bundle="${msg}" /></th>
                        <th><fmt:message key="common.select" bundle="${msg}" /></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr data-ng-repeat="instancesList in portvmList | filter: instanceSearch">
                        <td>
                            <a id="vpc_add_vm_display_name_button" class="text-info">{{ instancesList.vmInstance.displayName }}</a>
                             <div data-ng-show="instancesList.port">
                            	<select id="vpc_add_vm_ip_address" required="true" class="form-control input-group" name="ipAddress" data-ng-model="instancesList.ipAddress"  data-ng-options="ipAddress.guestIpAddress for ipAddress in portIPLists">
                             	<option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                            	</select>
                            </div>
                        </td>
                  		 <td>{{ instancesList.vmInstance.instanceInternalName}}</td>
                        <td>{{ instancesList.vmInstance.displayName }}</td>
                        <td>{{ instancesList.vmInstance.zone.name}}
                         <input type="hidden" data-ng-model="instances.zoneName" value="{{ instancesList.vmInstance.zone.name }}"/></td>
                        <td>
                            <label class="label label-success" data-ng-if="instancesList.vmInstance.status == 'RUNNING'">{{instancesList.vmInstance.status}}</label>
                            <label class="label label-danger" data-ng-if="instancesList.vmInstance.status == 'STOPPED'">{{instancesList.vmInstance.status}}</label>
                        </td>
                         <td>
                            <label class="">
                                 <div  style="position: relative;" >
<!--                                      <input type="radio" name="select" data-ng-model="instancesList.port" data-ng-click="portIPList(instancesList.vmInstance.id, portvmList, $index)"  >
 -->                                 <input id="vpc_add_vm_port" type="radio" icheck name="select" data-ng-model="instancesList.port" data-ng-value="true" data-ng-change="portIPList(instancesList.vmInstance.id,portvmList, $index)">

 </div>
                            </label>
                        </td>
                    </tr>
                    </tbody>
                </table>
                 <button id="vpc_add_vm_status_running_button" class="btn btn-xs btn-success btn-circle" data-ng-if="instance.vmInstance.status == 'RUNNING'" title="{{ instance.vmInstance.status}}"></button>
	             <button id="vpc_add_vm_status_stopped_button" class="btn btn-xs btn-danger btn-circle" data-ng-if="instance.vmInstance.status == 'STOPPED'"  title="{{ instance.vmInstance.status}}"></button>
	             <button id="vpc_add_vm_status_starting_button" class="btn btn-xs btn-warning btn-circle" data-ng-if="instance.vmInstance.status == 'STARTING'"  title="{{ instance.vmInstance.status}}"></button>
	             <button id="vpc_add_vm_status_error_button" class="btn btn-xs btn-danger btn-circle" data-ng-if="instance.vmInstance.status == 'ERROR'"  title="{{ instance.vmInstance.status}}"></button>
				 <button id="vpc_add_vm_status_stopping_button" class="btn btn-xs btn-warning btn-circle" data-ng-if="instance.vmInstance.status == 'STOPPING'"  title="{{ instance.vmInstance.status}}">&nbsp</button>
	             <button id="vpc_add_vm_status_expunging_button" class="btn btn-xs btn-danger btn-circle" data-ng-if="instance.vmInstance.status == 'EXPUNGING'"  title="{{ instance.vmInstance.status}}"></button>
	             <button id="vpc_add_vm_status_destroyed_button" class="btn btn-xs btn-danger btn-circle" data-ng-if="instance.vmInstance.status == 'DESTROYED'"  title="{{ instance.vmInstance.status}}"></button>
                </div>
            </div>
        </div>
        </div>
        </div>
      <div class="modal-footer">
			<get-loader-image data-ng-show="showLoader"></get-loader-image>
            <a class="btn btn-default" id="vpc_add_vm_cancel_button" data-ng-hide="showLoader" data-ng-click="cancel()"><fmt:message key="common.cancel" bundle="${msg}" /></a>
            <a class="btn btn-info" id="vpc_add_vm_add_button" data-ng-hide="showLoader" type="submit" data-ng-click="portforwardSave(portvmList)"><fmt:message key="common.add" bundle="${msg}" /></a>
      </div>
  </div>