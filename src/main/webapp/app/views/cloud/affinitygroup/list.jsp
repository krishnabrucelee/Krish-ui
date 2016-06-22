<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div ng-controller="affinityGroupListCtrl">
    <div class="hpanel">
        <div class="panel-heading">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="pull-left dashboard-btn-area">
                    	<div class="dashboard-box pull-left">
  							<div class="instance-border-content-normal">
                             <span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message key="common.total" bundle="${msg}" /></span>
                             <b class="pull-left">{{affinityGroupList.Count}}</b>
                             <div class="clearfix"></div>
                             </div>
                         </div>
                         <a class="btn btn-info font-bold"  ng-click="createAffinityGroup('md')"  data-backdrop="static" data-keyboard="false"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span><fmt:message key="add.new.affinity.group" bundle="${msg}" /></a>
                         <a class="btn btn-info" data-ng-click="list(1)"  title="<fmt:message key="common.refresh" bundle="${msg}"/>"><span class="fa fa-refresh fa-lg "></span></a>
                    </div>
                    <div class="pull-right dashboard-filters-area">
                    <form data-ng-submit="searchList(affinityGroupSearch)">
                            <div class="quick-search pull-right m-r-sm">
								<div class="input-group">
									<input data-ng-model="affinityGroupSearch" id="affinity_group_list_search" type="text" valid-characters class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
								   	 <span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
								</div>
							</div>
                            <span class="pull-right m-r-sm" data-ng-show="global.sessionValues.type == 'ROOT_ADMIN'">
								<select
									class="form-control input-group col-xs-5" name="domainView"
									data-ng-model="domainView"
									data-ng-change="selectDomainView(domainView)"
									data-ng-options="domainView.name for domainView in formElements.domainList">
									<option value=""> <fmt:message key="common.domain.filter" bundle="${msg}" /></option>
								</select>
							</span>
							<span class="pull-right m-r-sm" data-ng-if="global.sessionValues.type == 'DOMAIN_ADMIN'">
								<select
									class="form-control input-group col-xs-5" name="departmentView"
									data-ng-model="departmentView"
									data-ng-change="selectDepartmentView(departmentView)"
									data-ng-options="departmentView.userName for departmentView in departmentList">
									<option value=""> <fmt:message key="common.department.filter" bundle="${msg}" /></option>
								</select>
							</span>
                            <div class="clearfix"></div>
                            <span class="pull-right m-l-sm m-t-sm">
                            </span>
                            </form>
                        </div>
                </div>
                <div class="clearfix"></div>
            </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12 ">

                    <div data-ng-show = "showLoader" style="margin: 1%">
    				  		<get-loader-image data-ng-show="showLoader"></get-loader-image>
      						</div>
                        <div data-ng-hide="showLoader" class="table-responsive">
                        <div class="white-content">
                            <table cellspacing="1" cellpadding="1" class="table dataTable table-bordered table-striped">
                                <thead>
                                    <tr>
								    	<th class="col-md-2 col-sm-2" data-ng-click="changeSort('name',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='name'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.name" bundle="${msg}" /> </th>
										<th class="col-md-2 col-sm-3" data-ng-click="changeSort('affinityGroupType.type',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='affinityGroupType.type'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.type" bundle="${msg}" /></th>
										<th class="col-md-1 col-sm-2"><fmt:message key="common.action" bundle="${msg}" /></th>
									</tr>
                                </thead>
                                <tbody data-ng-hide="affinityGroupList.length > 0">
                                        <tr>
                                            <td class="col-md-6 col-sm-6" colspan="5"><fmt:message key="common.no.records.found" bundle="${msg}" />!!</td>
                                        </tr>
                                </tbody>
                                <tbody data-ng-show="affinityGroupList.length > 0">
                                    <tr data-ng-repeat="affinityGroup in filteredCount = (affinityGroupList  | filter:quickSearch | orderBy:sort.column:sort.descending)">
                                        <td>
                                            {{ affinityGroup.name}}
                                        </td>
                                        <td>
                                            {{ affinityGroup.affinityGroupType.type}}
                                        </td>
                                        <td>
											<a class="icon-button" title="<fmt:message key="common.delete" bundle="${msg}" />" data-ng-click="delete('sm', affinityGroup)"><span class="fa fa-trash"></span></a>
											<div class="btn-group action-menu">
	                                            <span>
	                                                <a title="<fmt:message key="view.instance" bundle="${msg}" />" data-ng-click="getInstance(affinityGroup)" class="fa fa-eye dropdown-toggle" data-toggle="dropdown" ></a>
	                                                <ul data-ng-show="formElements.instanceList.length > 0" class="dropdown-menu pull-right">
	                                                    <img src="images/dropdown-arw2.png" border="0" class="vol-dropdown-arw">
	                                                    <li data-ng-repeat="instance in formElements.instanceList">
	                                                    <a title="<fmt:message key="view.instance" bundle="${msg}" />" class="affinity-text-info" id="instances_display_name_button"
	                                                    ui-sref="cloud.list-instance.view-instance({id: {{ instance.id}}})">{{instance.name}}</a>
	                                                    </li>
	                                                </ul>
	                                            </span>
                                            </div>
										</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        <pagination-content></pagination-content>
    </div>
</div>