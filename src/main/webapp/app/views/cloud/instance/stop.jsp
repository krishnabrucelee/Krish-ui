<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<form name="form.detachForsm">
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header hide-zone="false" page-icon="fa fa-ban" page-title="Stop instance"></panda-modal-header>
            <!--<h2 class="modal-title" id="myModalLabel">Confirm Detach Volume</h2>-->
        </div>

        <div class="modal-body">
            <div class=" row">
                <div class="form-group has-error col-md-3 col-sm-3  col-xs-3">

                    <img src="images/warning.png" alt="">
                </div>
                <div class="form-group has-error col-md-9 col-sm-9  col-xs-9 m-t-md">
                    <p >Please confirm that you want to stop this instance.</p>
                </div>


            </div>

        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default " ng-click="cancel()" data-dismiss="modal">Cancel</button>
            <button type="submit" class="btn btn-default btn-danger2" ng-click="vmStop(item)" data-dismiss="modal">Ok</button>

        </div>
    </div>

</form>