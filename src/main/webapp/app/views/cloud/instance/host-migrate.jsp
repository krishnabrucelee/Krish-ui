<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<form name="hostForm" method="POST" data-ng-submit="update(hostForm)" novalidate >
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-ban"  page-title="<fmt:message key="migrate.one.host.to.another" bundle="${msg}" />"></panda-modal-header>

        </div>
        <div class="modal-body">

            <div class="row">
                <div class="col-md-12">
                    <h6 class="text-left m-l-md ">
                       <fmt:message key="please.specify.the.host.that.you.would.like.to.migrate.with.this.vm" bundle="${msg}" />.
                    </h6>
                    <br/>
                    <!--<div class="hr-line-dashed"></div>-->
                    <div class="form-group" ng-class="{ 'text-danger' : hostForm.hostlist.$invalid && formSubmitted}">

                        <div class="row" >
                            <label class="col-md-offset-1 col-sm-offset-1  col-md-2 col-xs-3 col-sm-1 control-label "><fmt:message key="common.host" bundle="${msg}" /><span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-xs-5 col-sm-5">
                                <select required="true" class="form-control input-group" name="hostlist"
                                        data-ng-model="host" data-ng-class="{'error': hostForm.hostlist.$invalid && formSubmitted}"
                                        data-ng-options="host.name for host in hostLists" >
                                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                </select>
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="host.is.required.to.migrate" bundle="${msg}" />" ></i>
                                <div class="error-area" data-ng-show="hostForm.hostlist.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="host.is.required.to.migrate" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                            </div>

                        </div>
                    </div>


                </div>
            </div>
        </div>
        <div class="modal-footer">

            <a class="btn btn-default"  data-ng-click="cancel()"><fmt:message key="common.cancel" bundle="${msg}" /></a>
            <button class="btn btn-info" type="submit"><fmt:message key="common.add" bundle="${msg}" /></button>


        </div>
    </div>
</form>