<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<form name="deleteSnapshotForm" data-ng-submit="validateDeleteSnapshot(deleteSnapshotForm)" method="post" novalidate="" data-ng-controller="addVMSnapshotCtrl" >

    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-trash pe-lg" page-title="<fmt:message key="delete.snapshot" bundle="${msg}" />"></panda-modal-header>

        </div>

        <div class="modal-body">
            <div class=" row">
                <div class="form-group has-error col-md-3 col-sm-3  col-xs-3">

                    <img src="images/warning.png" alt="">
                </div>
                <div class="form-group has-error col-md-9 col-sm-9  col-xs-9 m-t-md">
                    <p><fmt:message key="please.confirm.that.you.want.to.delete.this.snapshot" bundle="${msg}" /> </p>
                </div>


            </div>

        </div>

        <div class="modal-footer">
            <button type="button" class="btn btn-default " ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.no" bundle="${msg}" /></button>
            <button class="btn btn-info" type="submit"><fmt:message key="common.yes" bundle="${msg}" /></button>



        </div>
    </div>
</form>




