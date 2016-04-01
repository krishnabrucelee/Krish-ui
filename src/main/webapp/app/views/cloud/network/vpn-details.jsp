<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    <div class="white-content" >
    <div data-ng-if="global.webSocketLoaders.vpnLoader" class="overlay-wrapper">
    <img data-ng-if="global.webSocketLoaders.vpnLoader" src="images/loading-bars.svg" class="inner-loading" width="64" height="64" style="margin: 10%"/>
</div>
        <div class="hpanel">
            <div class="panel-heading">
                <div class="row" >
                    <div class="col-md-12 col-sm-12 pull-left m-b-sm">
                        <span><fmt:message key="vpn.currently.enabled.and.can.be.accessed" bundle="${msg}" /> {{ipDetails.publicIpAddress}} </span>
                    </div>
                    <div class="col-md-12 col-sm-12 pull-left m-b-sm">
                        <span><fmt:message key="vpn.preshared.key" bundle="${msg}" /> :
                        <button href="javascript:void(0);" title="<fmt:message key="show.pre.shared.key" bundle="${msg}" />" data-ng-click="showVpnKey(ipDetails)"><span class="fa-key fa font-bold m-xs"></span> <fmt:message key="show.pre.shared.key" bundle="${msg}" /></button> </span>
                    </div>
                </div>
            </div>
         </div>

		 <form name="vpnform" method="POST" novalidate data-ng-submit="addVpnUser(vpnform, user)">
         <table cellspacing="1" cellpadding="1"
                class="table table-bordered table-striped">
             <thead>
                 <tr>
                     <th class="col-md-3 col-xs-3"><fmt:message key="common.username" bundle="${msg}" /></th>
		    <th class="col-md-3 col-xs-3"><fmt:message key="password" bundle="${msg}" /></th>
		    <th class="col-md-3 col-xs-3"><fmt:message key="common.action" bundle="${msg}" /></th>
                 </tr>
             </thead>
             <tbody>
                 <tr>
                     <td><input required="true" type="text" name="userName"
                                data-ng-model="user.userName" class="form-control"><span
                                class="text-center text-danger"
                                data-ng-show="vpnform.userName.$invalid && vpnFormSubmitted">
                             * Required</span></td>
                     <td><input required="true" type="password" name="password"
                                data-ng-model="user.password" class="form-control"><span
                                class="text-center text-danger"
                                data-ng-show="vpnform.password.$invalid && vpnFormSubmitted">
                             * Required</span></td>
                     <td>
                     <img src="images/loading-bars.svg" data-ng-if="showLoader" width="30" height="30" />
                     <input data-ng-if = "!showLoader" class="btn btn-info" type="submit" value="<fmt:message key="common.add" bundle="${msg}" />">
		             </td>
                 </tr>
             </tbody>
         </table>
         </form>
         <table cellspacing="1" cellpadding="1"
                class="table table-bordered table-striped">
             <thead>
                 <tr>
                     <th class="col-md-6 col-xs-6"></th>
		    <th class="col-md-3 col-xs-3"></th>
                 </tr>
             </thead>
             <tbody>
                 <tr data-ng-repeat="vpnUser in vpnUsersList" class="font-bold text-center">
                     <td>{{vpnUser.userName}}</td>
                     <td><a class="icon-button"
                                 title="<fmt:message key="common.delete" bundle="${msg}" /> "
                                 data-ng-click="deleteVpnUser('sm', vpnUser)"><span
                                 class="fa fa-trash"></span></a></td>
                 </tr>
             </tbody>
         </table>
    </div>
