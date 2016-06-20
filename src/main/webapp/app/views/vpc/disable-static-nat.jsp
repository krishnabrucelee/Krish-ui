<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<form name="ipform" >
<div class="inmodal"  >
        <div class="modal-header">
            <panda-modal-header page-custom-icon="images/ip-icon-big.png"  page-title="<fmt:message key="disable.static.nat" bundle="${msg}" />"></panda-modal-header>
        </div>
        <div class="modal-body">

            <div class="row text-left indent lh-30" data-ng-hide="enableNat ">
                <div class="form-group has-error col-md-2 col-sm-2  col-xs-2 " >
                   <span class="fa fa-3x fa-warning text-warning"></span>
                </div>

               <fmt:message key="confirmation.to.disable.static.nat" bundle="${msg}" />.
            </div>
        </div>

        <div class="modal-footer" data-ng-hide="enableNat">

            <span class="pull-right">
                <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="cancel()"><fmt:message key="common.no" bundle="${msg}" /></button>
                <button type="button" class="btn btn-info" ng-click="disableStaticNat(vpc)"><fmt:message key="common.yes" bundle="${msg}" /></button>
            </span>

        </div>

    </div>
</form>