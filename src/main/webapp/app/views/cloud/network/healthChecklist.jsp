<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div class="inmodal" >
    <div class="modal-header">
        <panda-modal-header hide-zone="false" page-icon="fa fa-warning" page-title="Health Check Wizard<%-- <fmt:message key="health.check.wizard" bundle="${msg}" /> --%>"></panda-modal-header>
    </div>

    <div class="modal-body">
      <div class=" row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="table-responsive">
                        <table cellspacing="5" cellpadding="5"  class=" w-m table  table-hover  table-mailbox table-bordered ">
                           <label class="font-normal text-success">  Health Check Configuration Option :</label>
                            <tr>  <td class="col-md-6"><label>Ping Path :<%-- <fmt:message key="common.name" bundle="${msg}" /> --%></label></td> <td class="col-md-6"><input  type="text" name="name" data-ng-model="load.name"  class="form-control" ></td></tr>
                            </table>
                            <table cellspacing="5" cellpadding="5"  class=" w-m table  table-hover table-striped table-mailbox table-bordered ">
                            <label class="font-normal text-success" >Health Check Advanced Option</label>
                            <tr> <td class="col-md-6"><label>Response Timeout (in sec) :</label></td> <td class="col-md-6"><input  type="text" name="name" data-ng-model="load.name"  class="form-control" ></td></tr>
                            <tr> <td class="col-md-6"><label>Health Check Interval (in sec) :</label></td> <td class="col-md-6"><input  type="text" name="name" data-ng-model="load.name"  class="form-control" ></td></tr>
                            <tr> <td class="col-md-6"><label>Healthy Threshold :</label></td> <td class="col-md-6"><input  type="text" name="name" data-ng-model="load.name"  class="form-control" ></td></tr>
                            <tr> <td class="col-md-6"><label>Unhealthy Threshold :</label></td> <td class="col-md-6"><input  type="text" name="name" data-ng-model="load.name"  class="form-control" ></td></tr>

                        </table>
                    </div>
                </div>

            </div>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn btn-default " ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
        <button type="button" class="btn btn-info" ng-click="ok(deleteObject)" data-dismiss="modal"><fmt:message key="common.create" bundle="${msg}" /></button>
    </div>
</div>