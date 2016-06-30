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
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="table-responsive">
                        <table cellspacing="5" cellpadding="5"  class=" w-m table  table-hover table-striped table-mailbox table-bordered ">
                            <tr>  <td><label><fmt:message key="ip.address" bundle="${msg}" /></label></td> <td>{{viewsitevpn.publicIpAddress}}</td></tr>
                            <tr> <td><label><fmt:message key="common.id" bundle="${msg}" /></label></td> <td>{{ viewsitevpn.uuid}}</td></tr>
                            <tr> <td><label><fmt:message key="common.company" bundle="${msg}" /></label></td> <td>{{ viewsitevpn.domain.name}}</td></tr>
                            <tr> <td><label><fmt:message key="common.department" bundle="${msg}" /></label></td><td>{{ viewsitevpn.department.userName}}</td></tr>
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