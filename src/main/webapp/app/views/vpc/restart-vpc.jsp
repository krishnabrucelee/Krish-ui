<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="inmodal" data-ng-contoller="vpcCtrl">
    <div class="modal-header">
        <panda-modal-header hide-zone="false" page-icon="fa fa-warning" page-title="Restart VPC"></panda-modal-header>
    </div>
    <div class="modal-body">
        <div class=" row">
            <div class="form-group has-error col-md-12 col-sm-12   m-t-md">
            Please confirm that you want to restart the VPC.<br/>
            Remark: making a non-redundant VPC redundant will force a clean up. The networks will not be available for a couple of minutes.
            </div>
        </div>
          <div class=" row">
            <div class="form-group  col-md-4 col-sm-4  col-xs-3">
                                 <fmt:message key="common.cleanup" bundle="${msg}" />
            </div>
            <div class="icheckbox_square-green form-group col-md-8 col-sm-8  col-xs-8 m-t-md">
						<input icheck type="checkbox" data-ng-model="cleanup">
             </div>
        </div>
        <div class=" row">
            <div class="form-group  col-md-4 col-sm-4  col-xs-3">
                                 Make redundant
            </div>
            <div class="icheckbox_square-green form-group col-md-8 col-sm-8  col-xs-8 m-t-md">
						<input icheck type="checkbox" data-ng-model="makeredunt">
             </div>
        </div>
    </div>
    <div class="modal-footer">
        <get-loader-image data-ng-show="showLoader"></get-loader-image>
        <button type="button" data-ng-hide="showLoader" class="btn btn-default "  data-ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
        <button type="button" data-ng-hide="showLoader" class="btn btn-info "   data-ng-click="ok(cleanup,makeredunt)" data-dismiss="modal"><fmt:message key="common.restart" bundle="${msg}" /></button>
    </div>
</div>




