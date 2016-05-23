<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<form name="applicationForm" method="POST" data-ng-submit="addApplicationtoVM(applicationForm)" novalidate >
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-ban"  page-title="<fmt:message key="instance.application.assign" bundle="${msg}" />"></panda-modal-header>

        </div>
        <div class="modal-body">

            <div class="row">
                <div class="col-md-12">
                    <h6 class="text-left m-l-md ">
                      <fmt:message key="please.select.the.application.that.you.would.like.to.add.with.this.vm" bundle="${msg}" />.
                    </h6>
                    <br/>
                    <!--<div class="hr-line-dashed"></div>-->
                    <div class="form-group" ng-class="{ 'text-danger' : applicationForm.applist.$invalid && formSubmitted}">
						<div class="row  form-group required"
							ng-class="{ 'text-danger' : applicationForm.application.$invalid && formSubmitted}">
							<div class="col-md-5 col-xs-5 col-sm-5">
								<span class="control-label"><fmt:message
										key="application.name" bundle="${msg}" /><span title="<fmt:message key="common.required" bundle="${msg}" />"
									class="text-danger font-bold">*</span></span>

							</div>
							<div class="col-md-6 col-xs-6 col-sm-6">
								<input required="true" type="text" name="application"
									data-ng-model="application" class="form-control col-md-4"
									autofocus
									data-ng-class="{'error': applicationForm.application.$invalid && formSubmitted}">
								<i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"
									tooltip="<fmt:message key="name.of.the.application" bundle="${msg}" />"></i>
								<div class="error-area"
									data-ng-show="applicationForm.application.$invalid && formSubmitted">
									<i
										tooltip="<fmt:message key="application.name.is.required" bundle="${msg}" />"
										class="fa fa-warning error-icon"></i>
								</div>
							</div>
						</div>

						<div class="row  form-group required"
							ng-class="{ 'text-danger' : !applicationForm.applist && formSubmitted}">
							<div class="col-md-12 col-xs-12 col-sm-12">
								<span class="control-label"><fmt:message key="application.type" bundle="${msg}" /><span
									title="<fmt:message key="common.required" bundle="${msg}" />" class="text-danger font-bold">*</span></span> <i
									class="pe-7s-help1 pe-lg m-r-xs pull-right"
									tooltip="<fmt:message key="type.of.the.application" bundle="${msg}" />"></i>
								<div class="m-t-sm">
								<select required="true" multiple="multiple" class="form-control input-group" name="applist" data-ng-model="applications" ng-options="applications.type for applications in applicationLists" data-ng-class="{'error': applicationForm.applist.$invalid && formSubmitted}" >
				                <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
				                </select>
								</div>
							</div>
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