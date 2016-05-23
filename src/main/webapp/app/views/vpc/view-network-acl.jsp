<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div class="row" data-ng-controller="vpcCtrl">
	<div class="col-md-12 col-sm-12">
		<div class="hpanel">
			<div class="panel-body">
				<div class="tab-content">
					<div class="row m-t-n-md">
						<ul class="nav nav-tabs"
							data-ng-init="formElements.category = 'Details'">
							<li class="active"><a id="vpc_view_network_acl_details_button" href="javascript:void(0)" data-ng-click="formElements.category = 'Details'"
								data-toggle="tab"> Details </a></li>
							<li class=""><a id="vpc_view_network_acl_acl_list_rules_button" href="javascript:void(0)"
								data-ng-click="formElements.category = 'ACL List Rules'"
								data-toggle="tab"> ACL List Rules </a></li>
						</ul>
					</div>
					<div class="tab-pane"
						data-ng-class="{'active' : formElements.category == 'Details'}"
						id="details">
						<div class="row" data-ng-include
							src="'app/views/vpc/network-acl-details.jsp'"></div>
					</div>
					<div class="tab-pane"
						data-ng-class="{'active' : formElements.category == 'ACL List Rules'}"
						id="aclListRules">
						<div class="row" data-ng-include
							src="'app/views/vpc/network-acl-list-rules.jsp'"></div>
					</div> <!-- ui-sref="vpc.network-acl.view-networkAcl-network-acl-details({id: {{ networkAcl.id }}, view: 'view'})" title="View Network">{{networkAcl.name}} -->
				</div>
			</div>
		</div>
	</div>
</div>