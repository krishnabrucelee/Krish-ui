<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<form name="noteForm" data-ng-submit="update(noteForm)" ng-controller="instanceListCtrl">
    <div class="inmodal" >

        <div class="modal-header">
            <panda-modal-header hide-zone="true" page-icon="fa fa-edit" page-title="<fmt:message key="edit.note" bundle="${msg}" />"></panda-modal-header>
        </div>
        <div class="modal-body ">
            <div class="form-group has-error">
                <div>
                    <textarea placeholder="" class="form-control" cols="18" rows="3" id="comment" name="reason"  data-ng-model="instance.instanceNote"  ></textarea>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn btn-info" type="submit" ng-disabled="form.noteForm.$invalid" data-dismiss="modal" ><fmt:message key="common.update" bundle="${msg}" /></button>

            <!--<button type="button" class="btn btn-info " ng-click="cancel()" data-dismiss="modal">OK</button>-->

        </div>
    </div>
</form>




