<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<form name="form.detachForsm">
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header hide-zone="false" page-icon="fa fa-ban" page-title="Show/Reset password of instance"></panda-modal-header>
            <!--<h2 class="modal-title" id="myModalLabel">Confirm Detach Volume</h2>-->
        </div>

        <div class="modal-body">
            <div class=" row">
             <div class="form-group col-md-2 col-sm-2  "></div>
                <div class="form-group col-md-4 col-sm-4  col-xs-6">
                   <input id="show" icheck type="checkbox" name="show" value="yes" class="input-mini p-md"  data-ng-model="show"/>
                   <label class="m-l-sm font-normal" for="show"> Show Password </label>
                </div>
                <div class="form-group col-md-4 col-sm-4  col-xs-6">
                   <input id="reset" icheck type="checkbox" name="reset" value="yes" class="input-mini p-md"  data-ng-model="reset"/>
                   <label class="m-l-sm font-normal" for="reset"> Reset Password </label>
                </div>
            </div>

        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default " ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
            <button type="submit" class="btn btn-default btn-danger2" ng-click="vmDestroy(item)" data-dismiss="modal"><fmt:message key="common.ok" bundle="${msg}" /></button>

        </div>
    </div>

</form>