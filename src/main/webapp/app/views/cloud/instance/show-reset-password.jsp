<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<form name="forms" method="POST" data-ng-submit="update(forms)" novalidate>
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header hide-zone="false" page-icon="fa fa-ban" page-title="<fmt:message key="common.password" bundle="${msg}" />"></panda-modal-header>
        </div>

        <div class="modal-body">
         <div class="form-group" ng-class="{ 'text-danger' : forms.password.$invalid && formSubmitted}">
             <div class=" row">
             <div class="form-group col-md-2 col-sm-2  "></div>
                <div class="form-group col-md-7 col-sm-7  col-xs-6">
                   <label class="m-l-sm font-normal" for="show"> <fmt:message key="vm.password" bundle="${msg}" /> : {{instance.vncPassword}}</label>
                </div>
            </div>
		</div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default " ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
        </div>
    </div>

</form>