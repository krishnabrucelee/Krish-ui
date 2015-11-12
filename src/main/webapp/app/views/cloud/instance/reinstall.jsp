<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<form name="form.detachForsm">
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header hide-zone="false" page-icon="fa fa-ban" page-title="Reboot instance"></panda-modal-header>
            <!--<h2 class="modal-title" id="myModalLabel">Confirm Detach Volume</h2>-->
        </div>

        <div class="modal-body">
            <div class=" row">
                <div class="form-group p-sm has-error col-md-2 col-sm-2  col-xs-3">

                    <img class="m-l-sm" src="images/warning.png" alt="">
                </div>
                <div class="form-group has-error col-md-10 col-sm-10  col-xs-9 m-t-md">
                    <p >NOTE: Proceed with caution. This will cause the VM to be reinstalled from the template; data on the root disk will be lost. Extra data volumes, if any, will not be touched.</p>
                </div>


            </div>

        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default " ng-click="cancel()" data-dismiss="modal">Cancel</button>
            <button type="submit" class="btn btn-default btn-danger2" ng-click="vmRestart(item)" data-dismiss="modal">Ok</button>

        </div>
    </div>

</form>