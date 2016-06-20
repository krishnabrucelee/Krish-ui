<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<form name="editRuleForm" data-ng-submit="updateRule(editRuleForm,loadBalancer)" novalidate>
    <div class="modal-header">
        <panda-modal-header hide-zone="false" page-icon="fa fa-warning" page-title="<fmt:message key="edit.rule" bundle="${msg}" />"></panda-modal-header>
    </div>

    <div class="modal-body">
        <div class="row">
            <div class=" col-md-2 col-sm-4  col-xs-4">
             <div class="form-group row">
           		<label class="control-label "><fmt:message
											key="common.name" bundle="${msg}" /><span class="text-danger">*</span></label>
		 	</div>
            <div class="form-group row">
           		<label class="control-label "><fmt:message
											key="common.algorithm" bundle="${msg}" /></label>
		   </div>
           </div>
            <div class=" col-md-6 col-sm-6  col-xs-6 ">
             	<div class="form-group row ">
             	<input required ="true" type="text" name="name" data-ng-model="loadBalancer.name"  class="form-control" data-ng-class="{'error': editRuleForm.name.$invalid && formSubmitted}"  >
				<div class="error-area"
											data-ng-show="editRuleForm.name.$invalid && formSubmitted">
											<i ng-attr-tooltip="{{ editRuleForm.name.errorMessage || '<fmt:message key="name.is.required" bundle="${msg}" />' }}"
												class="fa fa-warning error-icon">
											</i>
										</div>             </div>
             <div class="form-group row">
             	<select required ="true" class="form-control" name="protocol" data-ng-model="loadBalancer.algorithm" data-ng-init="algorithms = networkLists.algorithms[0]" data-ng-change="selectProtocol(algorithms.name)" data-ng-options="algorithms.name for algorithms in dropnetworkLists.algorithms" > <option value=""><fmt:message key="common.select" bundle="${msg}" /></option></select>
             </div>
            </div>
		</div>
        </div>
    <div class="modal-footer">
    			<get-loader-image data-ng-if="showLoader"></get-loader-image>
            <button type="button" data-ng-hide="showLoader" class="btn btn-default "  ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
       <button class="btn btn-info" data-ng-hide="showLoader" type="submit" ><fmt:message key="common.update" bundle="${msg}" /></button>
    </div>
</form>



