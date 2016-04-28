<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<form name="form.detachForsm">
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header hide-zone="false" page-icon="fa fa-ban" page-title="<fmt:message key="detach.iso" bundle="${msg}" />"></panda-modal-header>
            <!--<h2 class="modal-title" id="myModalLabel">Confirm Detach Volume</h2>-->
        </div>

        <div class="modal-body">
            <div class=" row">
                <div class="form-group has-error col-md-3 col-sm-3  col-xs-3">
					<span class="fa fa-3x fa-warning text-warning"></span>
                </div>
                <div class="form-group has-error col-md-9 col-sm-9  col-xs-9">
                    <p ><fmt:message key="please.confirm.that.you.want.to.detach.iso.from.this.instance" bundle="${msg}" />.</p>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default " ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
            <button type="submit" class="btn btn-default btn-danger2" ng-click="update()" data-dismiss="modal"><fmt:message key="common.ok" bundle="${msg}" /></button>
        </div>
    </div>
</form>