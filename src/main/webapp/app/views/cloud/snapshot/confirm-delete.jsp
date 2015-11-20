<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="inmodal" >
    <div class="modal-header">
        <panda-modal-header hide-zone="false" page-icon="fa fa-warning" page-title="<fmt:message key="delete.confirmation" bundle="${msg}" />"></panda-modal-header>
        <!--<h2 class="modal-title" id="myModalLabel">Confirm Detach Volume</h2>-->
    </div>

    <div class="modal-body">
        <div class=" row">
            <div class="form-group has-error col-md-3 col-sm-3  col-xs-3">

                <img src="images/warning.png" alt="">
            </div>
            <div class="form-group has-error col-md-9 col-sm-9  col-xs-9 m-t-md">
                <p ><fmt:message key="are.you.sure.do.you.want.to.delete" bundle="${msg}" /> </p>
            </div>


        </div>

    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default " ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
        <button type="button" class="btn btn-default btn-danger2" ng-click="ok(deleteObject)" data-dismiss="modal"><fmt:message key="common.ok" bundle="${msg}" /></button>

    </div>
</div>




