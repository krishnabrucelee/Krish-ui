<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
  <div class="inmodal" >

        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-cloud" page-title="<fmt:message key="add.vm" bundle="${msg}" />"></panda-modal-header>
        </div>
        <div class="modal-body">
        <div class="row">
        <div class="hpanel">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-md-3 col-sm-3 col-xs-3 ">
                        <div class="quick-search">
                            <div class="input-group">
                                <input data-ng-model="instanceSearch" type="text" class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
                                <span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
                            </div>
                        </div>
                    </div>

                </div>
               <div class="clearfix"></div>
            </div>

            <div class="white-content">
                <div class="table-responsive">
                    <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
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
                            <a class="text-info" >{{ instancesList.name }}</a>
                             <div  data-ng-if="selected === instancesList.id" >
                             <select  data-ng-if="selected == instancesList.id" required="true" class="form-control input-group" name="ipAddress" data-ng-model="ipAddress" data-ng-change = "instanceLists.ipAddress.guestIpAddress = ipAddress.guestIpAddress"   data-ng-options="ipAddress.guestIpAddress for ipAddress in portIPLists">
                             <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                             </select>

                             </div>

                        </td>
                  		 <td>{{ instancesList.instanceInternalName}}</td>
                        <td>{{ instancesList.displayName }}</td>
                        <td>{{ instancesList.zone.name }}
                         <input type="hidden" data-ng-model="instances.zoneName" value="{{ instancesList.zone.name }}"/></td>
                        <td>
                            <label class="label label-success" data-ng-if="instancesList.status == 'RUNNING'">{{instancesList.status}}</label>
                            <label class="label label-danger" data-ng-if="instancesList.status == 'STOPPED'">{{instancesList.status}}</label>
                        </td>
                         <td>
                            <label class="">
                                 <div  style="position: relative;" >
                                  <input type="radio" icheck name="select" data-ng-model="instancesList.port" data-ng-value="true" data-ng-change="portIPList(instancesList.id,portvmList, $index)"  >
                                     <!-- <input type="radio" icheck data-ng-model="port" name="name" data-ng-value="{{instancesList.id}}" data-ng-change="nicIPList(instancesList.id)"  > -->
                                 </div>
                            </label>

                        </td>
                    </tr>
                    </tbody>
                </table>
                </div>
            </div>
        </div>
        </div>
        </div>
      <div class="modal-footer">
			<get-loader-image data-ng-show="showLoader"></get-loader-image>
            <a class="btn btn-default" data-ng-hide="showLoader" data-ng-click="cancel()"><fmt:message key="common.cancel" bundle="${msg}" /></a>
            <a class="btn btn-info" data-ng-hide="showLoader" type="submit" data-ng-click="enableStaticNatSave(portvmList)"><fmt:message key="common.add" bundle="${msg}" /></a>
      </div>
  </div>