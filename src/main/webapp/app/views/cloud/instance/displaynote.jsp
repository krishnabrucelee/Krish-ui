<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<form name="noteForm" >
    <div class="inmodal" >

        <div class="modal-header">
            <panda-modal-header hide-zone="true" page-icon="fa-file-text fa" page-title="<fmt:message key="display.note" bundle="${msg}" />"></panda-modal-header>
        </div>
        <div class="modal-body ">
            <div class="form-group has-error">
                <div data-ng-model="instance.instanceNote" readonly>{{instance.instanceNote}}
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-info " ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.ok" bundle="${msg}" /></button>

        </div>
    </div>
</form>




