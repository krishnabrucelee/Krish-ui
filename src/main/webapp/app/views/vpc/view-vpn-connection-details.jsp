<%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />
<form name="form.detachForm" >
    <div class="inmodal" >
    <div class="modal-header">
		   <panda-modal-header page-title="<fmt:message
					key="common.details" bundle="${msg}" />" page-icon="fa-file-text fa" hide-zone="true">
		   </panda-modal-header>
        </div>
        <div class="modal-body" >
            <div class=" row">
                <div class="col-md-6 col-sm-12 col-xs-12">
                <table cellspacing="5" cellpadding="5"  class=" w-m table  table-hover table-striped table-mailbox table-bordered ">
                            <tr> <td><label><fmt:message key="common.id" bundle="${msg}" /></label></td> <td>{{ viewvpnconnection.uuid}}</td></tr>
                            <tr> <td><label><fmt:message key="common.passive" bundle="${msg}" /></label></td> <td>
                            <label class ="font-normal" data-ng-if="viewvpnconnection.passive == 0">No</label><label class ="font-normal" data-ng-if="viewvpnconnection.passive == 1" >Yes</label></td>
							</tr>
                            <tr>  <td><label><fmt:message key="ip.address" bundle="${msg}" /></label></td> <td>{{viewvpnconnection.vpnGateway.publicIpAddress}}</td></tr>
                            <tr>  <td><label><fmt:message key="gateway" bundle="${msg}" /></label></td> <td>{{viewvpnconnection.gateway}}</td></tr>
                            <tr>  <td><label><fmt:message key="cidr.list" bundle="${msg}" /></label></td> <td>{{viewvpnconnection.cIDR}}</td></tr>
                            <tr>  <td><label><fmt:message key="ipsec.preshared.Key" bundle="${msg}" /></label></td> <td>{{viewvpnconnection.ipsecPresharedKey}}</td></tr>
                            <tr>  <td><label><fmt:message key="common.ike.policy" bundle="${msg}" /></label></td> <td>{{viewvpnconnection.ikePolicy}}</td></tr>
                            <tr>  <td><label><fmt:message key="common.esp.policy" bundle="${msg}" /></label></td> <td>{{viewvpnconnection.espPolicy}}</td></tr>
                            </table>
                </div>
                <div class="col-md-6 col-sm-12 col-xs-12">
                <div class="table-responsive">
                        <table cellspacing="5" cellpadding="5"  class=" w-m table  table-hover table-striped table-mailbox table-bordered ">
							<tr>  <td><label><fmt:message key="common.ike.lifetime" bundle="${msg}" /></label></td> <td>{{viewvpnconnection.ikelifeTime}}</td></tr>
                            <tr>  <td><label><fmt:message key="common.esp.lifetime" bundle="${msg}" /></label></td> <td>{{viewvpnconnection.esplifeTime}}</td></tr>
							<tr>  <td><label><fmt:message key="common.dead.peer" bundle="${msg}" /></label></td> <td><label class ="font-normal" data-ng-if="viewvpnconnection.deadPeerDetection == 0">No</label><label class ="font-normal" data-ng-if="viewvpnconnection.deadPeerDetection == 1" >Yes</label></td></tr>
                            <tr>  <td><label><fmt:message key="common.force.udp.encapsulation" bundle="${msg}" /></label></td> <td><label class ="font-normal" data-ng-if="viewvpnconnection.forceEncapsulation == 0">No</label><label class ="font-normal" data-ng-if="viewvpnconnection.forceEncapsulation == 1" >Yes</label></td></tr>
                            <tr> <td><label><fmt:message key="common.status" bundle="${msg}" /></label></td> <td>{{ viewvpnconnection.status}}</td></tr>
                             <tr> <td><label><fmt:message key="common.date" bundle="${msg}" /></label></td><td>{{ viewvpnconnection.createdDateTime*1000 | date:'yyyy-MM-dd HH:mm:ss'}}</td></tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
                    <button type="button" class="btn btn-info " ng-click="cancel()" data-dismiss="modal"><fmt:message
						key="common.ok" bundle="${msg}" /></button>
        </div>
    </div>
</form>
