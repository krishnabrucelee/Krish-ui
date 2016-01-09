<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<form name="form.detachForm" >
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header hide-zone="false"  page-title="{{templateObj.name}}"></panda-modal-header>
        </div>
        <div class="modal-body" >
            <div class=" row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="table-responsive">
                        <table cellspacing="2" cellpadding="5"  class="table table-hover table-striped table-bordered ">
                            <tr> <td><label><fmt:message key="common.name" bundle="${msg}" /></label></td><td>{{ templateObj.name}}</td></tr>
                            <tr>  <td><label><fmt:message key="common.size" bundle="${msg}" /></label></td> <td>{{(templateObj.size / global.Math.pow(2, 30))}} GB</td></tr>
                            <tr> <td><label><fmt:message key="common.status" bundle="${msg}" /></label></td> <td>{{ templateObj.status}}</td></tr>
                            <tr>  <td><label><fmt:message key="template.owner" bundle="${msg}" /></label></td> <td>{{templateObj.owner || " - " }}</td></tr>
                            <tr> <td><label><fmt:message key="register.date" bundle="${msg}" /></label></td> <td>{{ templateObj.createdDateTime *1000 | date:'yyyy-MM-dd HH:mm:ss'}}</td></tr>
                            <tr> <td><label><fmt:message key="common.format" bundle="${msg}" /></label></td> <td>{{ templateObj.format}}</td></tr>
                            <tr> <td><label><fmt:message key="common.hvm" bundle="${msg}" /></label></td><td>{{ templateObj.hvm || " - " }}</td></tr>
                            <tr> <td><label><fmt:message key="password.enabled" bundle="${msg}" /></label></td><td>{{ (templateObj.passwordEnabled) ? "Yes" : "No"}}</td></tr>
                             <tr> <td><label><fmt:message key="dynamically.scalable" bundle="${msg}" /></label></td><td>{{ (templateObj.dynamicallyScalable) ? "Yes" : "No"}}</td></tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
                    <button type="button" class="btn btn-info " ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.ok" bundle="${msg}" /></button>
                </div>
    </div>

</form>