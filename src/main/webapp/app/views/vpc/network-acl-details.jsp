<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- Header -->

    <div class="content" ui-view >
    	<div data-ng-controller="vpcCtrl">
    	<div data-ng-if="global.webSocketLoaders.vpcLoader" class="overlay-wrapper">
                		            <img data-ng-if="global.webSocketLoaders.vpcLoader" src="images/loading-bars.svg" class="inner-loading" />
 </div>

            <div class="row" >
                <div class="col-md-8">
                    <div class="panel panel-default">
                    	<div class="panel-heading">
							<h3 class="panel-title">Network Acl details</h3>
						</div>
						<div class="panel-body p-md">
							<table cellspacing="1" cellpadding="1" class="table table-condensed table-striped">
								<tbody>
									<tr>
										<td><b> <fmt:message key="common.name" bundle="${msg}" /></b></td>
										<td>{{networkAclList.name}}</td>
									</tr>
									<tr>
										<td><b> <fmt:message key="common.description" bundle="${msg}" /></b></td>
										<td>{{networkAclList.description}}
									</td>
									</tr>
									<tr>
										<td><b><fmt:message key="id" bundle="${msg}" /></b></td>
										<td>{{networkAclList.uuid}}</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
                </div>
        	</div>
        					<button class="btn btn-danger" data-ng-hide="showLoader" data-ng-if="networkAclList.vpcId != null" data-ng-click="deleteAclList('sm', networkAclList)"type="submit">
					<fmt:message key="common.delete" bundle="${msg}" />
				</button>
    	</div>
    </div>

    <div id="footer" ng-include="'app/views/common/footer.jsp'"></div>
