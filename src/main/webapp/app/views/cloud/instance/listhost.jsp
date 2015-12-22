<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div>
  <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-plus-circle" page-title="<fmt:message key="host.information" bundle="${msg}" />"></panda-modal-header>
        </div>
        <div class="modal-body">
                        <div class="white-content">
    			
			 <div class="row">
                                    <div class="col-md-12">
                                        <table class="table table-bordered table-striped" cellspacing="0" cellpadding="0">
                                            <tbody>
											<tbody>
												<tr>
													<td><label
														class="col-md-8 col-sm-7 col-xs-4 control-label ">
														<fmt:message key="common.name" bundle="${msg}" />
														</label></td>
														<td>{{ instance.host.name}}</td>
												</tr>
											  <tr>
													<td><label
														class="col-md-8 col-sm-7 col-xs-4 control-label ">
														<fmt:message key="common.id" bundle="${msg}" />
														</label></td>
														<td>{{ instance.host.uuid}}</td>
												</tr>
											 <tr>
													<td><label
														class="col-md-8 col-sm-7 col-xs-4 control-label ">
														<fmt:message key="common.state" bundle="${msg}" />
														</label></td>
															<td>{{ instance.host.status}}</td>
												</tr>
											<tr>
													<td><label
														class="col-md-8 col-sm- col-xs-4 control-label ">
														<fmt:message key="host.ip.address" bundle="${msg}" />
														</label></td>
															<td>{{ instance.host.hostIpaddress}}</td>
												</tr>
												<tr>
													<td><label
														class="col-md-8 col-sm-7 col-xs-4 control-label ">
														<fmt:message key="common.hypervisor" bundle="${msg}" />
														</label></td>
												<td>{{ instance.hypervisor}}</td>

												</tr>
												<tr>
													<td><label
														class="col-md-8 col-sm-7 col-xs-4 control-label ">
														<fmt:message key="common.zone" bundle="${msg}" />
														</label></td>
													<td>{{ instance.zone.name }}</td>
												</tr>
												<tr>
												  <td><label
														class="col-md-8 col-sm-7 col-xs-4 control-label ">
														<fmt:message key="common.pod" bundle="${msg}" />
														</label></td>
														<td>{{ instance.host.pod.name }}</td>
												</tr>
												<tr>
													<td><label
														class="col-md-8 col-sm-7 col-xs-4 control-label ">
														<fmt:message key="common.cluster" bundle="${msg}" />
														</label></td>
													<td>{{ instance.host.cluster.name }}</td>	 

												</tr>
											   	<tr>
													<td><label
														class="col-md-8 col-sm-7 col-xs-4 control-label ">
														<fmt:message key="common.dedicated" bundle="${msg}" />
														</label></td>
													<td>{{ (instance.host.hostHighAvailablility) ? "Yes" : "No" }}</td>

												</tr>
											</tbody>
											</table>
											
												
												
		</div>
</div>

</div>
</div>
 <div class="modal-footer">
            <get-loader-image data-ng-show="showLoader"></get-loader-image>
             <button type="button" data-ng-hide="showLoader" class="btn btn-default " ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
          
        </div>
</div>
</div>


