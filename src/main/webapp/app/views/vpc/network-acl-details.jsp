<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />
<div data-ng-if="global.webSocketLoaders.networkDeleteAclLoader" class="overlay-wrapper">
    <img data-ng-if="global.webSocketLoaders.networkDeleteAclLoader" src="images/loading-bars.svg" class="inner-loading" />
</div>
<!-- Header -->

    <div class="content" ui-view >
    	<div data-ng-controller="vpcCtrl">
    	<div data-ng-if="global.webSocketLoaders.vpcLoader" class="overlay-wrapper">
        <get-show-loader-image data-ng-show="global.webSocketLoaders.vpcLoader"></get-show-loader-image>

 </div>

 		<div data-ng-if="networkAclList.vpcId != null" class="col-lg-3 col-md-3 col-sm-4 pull-right">
			<div class="panel panel-info">
				<div class="panel-heading">
					<h3 class="panel-title">
						<i class="fa fa-bolt"></i>&nbsp;&nbsp;
						<fmt:message key="quick.actions" bundle="${msg}" />
					</h3>
				</div>
				<div class="panel-body no-padding">
					<ul class="list-group">
						<li class="list-group-item"><a
							title=" <fmt:message key="delete.acl.list" bundle="${msg}" />"
							 data-ng-click="deleteAclList('sm', networkAclList)" id="vpc_delete_acl_list_button" type="submit"><span
								class="fa-trash fa font-bold m-xs"></span> <fmt:message
									key="delete.acl.list" bundle="${msg}" /></a></li>
					</ul>
				</div>
			</div>
		</div>

            <div class="row" >
                <div class="col-md-8">
                    <div class="panel panel-default">
                    	<div class="panel-heading">
							<h3 class="panel-title"><fmt:message key="network.acl.details" bundle="${msg}" /></h3>
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
<%--         					<button class="btn btn-danger" data-ng-hide="showLoader" data-ng-if="networkAclList.vpcId != null" data-ng-click="deleteAclList('sm', networkAclList)"type="submit">
					<fmt:message key="common.delete" bundle="${msg}" />
				</button> --%>
    	</div>
    </div>

    <div id="footer" ng-include="'app/views/common/footer.jsp'"></div>
