
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <div class="modal-header">
        <panda-modal-header hide-zone="false" page-icon="fa fa-warning" page-title="Edit Rule<%-- <fmt:message key="delete.confirmation" bundle="${msg}" /> --%>"></panda-modal-header>
    </div>

    <div class="modal-body">
        <div class="row">
            <div class=" col-md-2 col-sm-4  col-xs-4">
             <div class="form-group row">
           <label class="control-label ">Name</label>
		 </div>
            <div class="form-group row">
           <label class="control-label ">Algorithm</label>
		 </div>

            </div>
            <div class=" col-md-6 col-sm-6  col-xs-6 ">
             <div class="form-group row">
             <input type="text" name="name" data-ng-model="loadBalancer.name"  class="form-control" >

             </div>
             <div class="form-group row">
             <select  class="form-control" name="protocol" data-ng-model="loadBalancer.algorithms" data-ng-init="algorithms = networkLists.algorithms[0]" data-ng-change="selectProtocol(algorithms.name)" data-ng-options="algorithms.name for algorithms in dropnetworkLists.algorithms"><option value=""><fmt:message key="common.select" bundle="${msg}" /></option></select>
             </div>
            </div>

		</div>
        </div>


    <div class="modal-footer">
<!--         <get-loader-image data-ng-show="showLoader"></get-loader-image>
 -->
        <button type="button" data-ng-hide="showLoader" class="btn btn-default "  ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
        <button type="button" data-ng-hide="showLoader" class="btn btn-info "   ng-click="update()" data-dismiss="modal"><fmt:message key="common.update" bundle="${msg}" /></button>

    </div>





