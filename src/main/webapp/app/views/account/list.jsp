<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />
<div ui-view>
            <div ng-controller="accountListCtrl">
                <div class="hpanel">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-md-12 col-sm-12 col-xs-12 ">
                            <div class="pull-left dashboard-btn-area">
								<div class="dashboard-box pull-left">
	     							<div class="instance-border-content-normal">
	                                <span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message key="common.total" bundle="${msg}" /></span>
	                                <b class="pull-left">{{accountList.Count}}</b>
	                                <div class="clearfix"></div>
	                                </div>
	                            </div>
	                            <div class="dashboard-box pull-left">
	                      			<div class="instance-border-content-normal">
	                                <span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message key="common.active" bundle="${msg}" /></span>
	                                <b data-ng-show="global.sessionValues.type == 'ROOT_ADMIN'" class="pull-left">{{(activeUsers | filter:{status:'ENABLED', domainId:domainView.id}:true).length}}</b>
	                                <b data-ng-show="global.sessionValues.type != 'ROOT_ADMIN'" class="pull-left">{{(activeUsers | filter:{status:'ENABLED'}).length}}</b>
	                                <div class="clearfix"></div>
	                                </div>
	                            </div>
	                            <div class="dashboard-box pull-left">
	                                 <div class="instance-border-content-normal">
	                                <span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message key="common.inactive" bundle="${msg}" /></span>
	                                <b data-ng-show="global.sessionValues.type == 'ROOT_ADMIN'" class="pull-left">{{(activeUsers | filter:{status:'DISABLED', domainId:domainView.id}:true).length}}</b>
	                                <b data-ng-show="global.sessionValues.type != 'ROOT_ADMIN'" class="pull-left">{{(activeUsers | filter:{status:'DISABLED'}).length}}</b>
	                                <div class="clearfix"></div>
	                                </div>
	                            </div>
	                            <a has-permission="CREATE_USER" id="accounts_add_button" class="btn btn-info font-bold" data-ng-click="addUser('lg')"><span class="pe-7s-add-user pe-lg font-bold m-r-xs"></span><fmt:message key="add.user" bundle="${msg}" /></a>
	                            <a class="btn btn-info" data-ng-click="list(1)" id="accounts_refresh_button" title="<fmt:message key="common.refresh" bundle="${msg}" />"  ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
							</div>
                                <div class="pull-right dashboard-filters-area">
                                   <form data-ng-submit="searchList(userSearch)">
									<div class="quick-search pull-right">
									<div class="input-group">
										<input data-ng-model="userSearch" id="account_list_search" type="text" valid-characters class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
								   		<span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
									</div>
									</div>
                                    <span class="pull-right m-r-sm" data-ng-show="global.sessionValues.type == 'ROOT_ADMIN'">
										<select
											class="form-control input-group col-xs-5" name="domainView"
											data-ng-model="domainView" id = "accounts_domain_filter"
											data-ng-change="selectDomainView(domainView)"
											data-ng-options="domainView.name for domainView in accountElements.domainList">
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
<%-- 							<span class="pull-right m-r-sm" data-ng-if="global.sessionValues.type == 'USER'">
								<select
									class="form-control input-group col-xs-5" name="userView"
									data-ng-model="userView"
									data-ng-change="selectProjectView(userView)"
									data-ng-options="userView.name for userView in projectList">
									<option value=""> <fmt:message key="common.project.filter" bundle="${msg}" /></option>
								</select>
							</span> --%>

                                    <div class="clearfix"></div>
                                    <span class="pull-right m-l-sm m-t-sm"></span>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" id="accounts_pagination_container">
                        <div class="col-md-12 col-sm-12 col-xs-12 ">
                            <div class="white-content">
                               <div data-ng-show = "showLoader" style="margin: 1%">
    				  		<get-loader-image data-ng-show="showLoader"></get-loader-image>
      						</div>
      						<div  data-ng-hide="showLoader" class="table-responsive">
                                    <table cellspacing="1" cellpadding="1" id="accounts_table" class="table table-bordered dataTable table-striped ">
                                        <thead>
                                        <tr>
                                        <th  data-ng-click="changeSort('userName',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='userName'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="user.name" bundle="${msg}" /></th>
                                     	<th  data-ng-click="changeSort('departmentUserName',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='departmentUserName'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.department" bundle="${msg}" /></th>
                                     	<th  data-ng-click="changeSort('domainName',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='domainName'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.domain" bundle="${msg}" /></th>
                                     	<th  data-ng-click="changeSort('type',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='type'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="user.type" bundle="${msg}" /></th>
                                       	<th  data-ng-click="changeSort('roleName',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='roleName'? 'sorting_desc' : 'sorting_asc' "><fmt:message key="common.roles" bundle="${msg}" /></th>
                                     	<th  data-ng-click="changeSort('email',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='email'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.email" bundle="${msg}" /></th>
                                     	<th  data-ng-click="changeSort('status',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='status'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.status" bundle="${msg}" /></th>
										<th><fmt:message key="common.action" bundle="${msg}" /></th>
                                        </tr>
                                        </thead>
                                        <tbody data-ng-hide="accountList.length > 0">
		                                    <tr>
		                                        <td class="col-md-7 col-sm-7" colspan="10"><fmt:message key="common.no.records.found" bundle="${msg}" />!!</td>
		                                    </tr>
		                                </tbody>
                                        <tbody data-ng-show="accountList.length > 0">
                                            <tr  data-ng-repeat="account in filteredCount = accountList">
                                                <td>
                                                    <a class="text-info" >{{ account.userName}}</a>
                                               </td>
                                                <td>{{account.departmentUserName}}</td>
                                                <td>{{account.domainName}}</td>
                                                <td>{{account.type}}</td>
                                                <td>{{account.roleName || '-'}}</td>
                                                <td>{{account.email || '-'}}</td>
                                                <td>
 												<label class="badge badge-success p-xs" data-ng-if="account.status == 'ENABLED'"> <fmt:message key="common.enabled" bundle="${msg}" /> </label>
                	                            <label class="badge badge-danger p-xs" data-ng-if="account.status == 'DISABLED'"> <fmt:message key="common.disabled" bundle="${msg}" /> </label>
                	                            <label class="badge badge-danger p-xs" data-ng-if="account.status == 'DELETED'"> <fmt:message key="common.deleted" bundle="${msg}" /> </label>

                                                </td>
                                                <td>
                                                <input type="hidden" id="accounts_unique_{{account.id}}" data-unique-field="{{account.domainName}}-{{account.departmentUserName}}-{{ account.userName}}" class="test_accounts_unique">
                                                <a class="icon-button test_accounts_edit_user_button" id="accounts_edit_user_button_{{account.id}}" data-unique-field="{{account.domainName}}-{{account.departmentUserName}}-{{ account.userName}}"
													has-permission="EDIT_USER"
													title="<fmt:message key="edit.user" bundle="${msg}" />"
													data-ng-click="editUser('md',account.id)">
														<span class="fa fa-edit m-r"> </span>
												</a>
												 <a class="icon-button test_accounts_reset_password_button" id="accounts_reset_password_button_{{account.id}}" data-unique-field="{{account.domainName}}-{{account.departmentUserName}}-{{ account.userName}}" has-permission="RESET_USER_PASSWORD"
													title="<fmt:message key="reset.password" bundle="${msg}" /> "
													data-ng-click="resetPassword('md',account.id)"><span class="fa-key fa font-bold m-r"></span>
													</a>
												 <a data-ng-if="global.sessionValues.type =='DOMAIN_ADMIN'"
												 data-ng-hide = "global.sessionValues.type =='DOMAIN_ADMIN' && account.type == 'DOMAIN_ADMIN'"
													class="icon-button test_accounts_delete_user_button" id="accounts_delete_user_button_{{account.id}}" data-unique-field="{{account.domainName}}-{{account.departmentUserName}}-{{ account.userName}}"
													has-permission="DELETE_USER"
													title="<fmt:message key="common.delete" bundle="${msg}" /> "
													data-ng-click="deleteUser('sm',account.id)"><span
														class="fa fa-trash"></span></a>

												 <a data-ng-if="global.sessionValues.type =='ROOT_ADMIN'"
												   data-ng-hide = "account.type == 'ROOT_ADMIN'"
												   id="accounts_delete_user_button_{{account.id}}" data-unique-field="{{account.domainName}}-{{account.departmentUserName}}-{{ account.userName}}"
													class="icon-button test_accounts_delete_user_button" has-permission="DELETE_USER"
													title="<fmt:message key="common.delete" bundle="${msg}" /> "
													data-ng-click="deleteUser('sm',account.id)"><span
														class="fa fa-trash"></span></a>

												  <a data-ng-if="global.sessionValues.type =='USER' "
												   data-ng-hide = "account.type == 'DOMAIN_ADMIN' || global.sessionValues.userName == '{{account.userName}}'"
													class="icon-button test_accounts_delete_user_button"
													id="accounts_delete_user_button_{{account.id}}" data-unique-field="{{account.domainName}}-{{account.departmentUserName}}-{{ account.userName}}"
													has-permission="DELETE_USER"
													title="<fmt:message key="common.delete" bundle="${msg}" /> "
													data-ng-click="deleteUser('sm',account.id)"><span
														class="fa fa-trash"></span>
												</a>

                                        		  <a class = "test_accounts_enable_user_button" data-ng-if="global.sessionValues.type =='ROOT_ADMIN'" data-ng-show = "account.type != 'ROOT_ADMIN' && account.status == 'DISABLED' "
												  id="accounts_enable_user_button_{{account.id}}" data-unique-field="{{account.domainName}}-{{account.departmentUserName}}-{{ account.userName}}"
												  has-permission="ENABLE_USER" data-ng-click="activating(account.id)"><span class="pe-7s-user pe-lg font-bold m-r-xs" title="Enable User"></span></a>

                                        		  <a data-ng-if="global.sessionValues.type =='ROOT_ADMIN'" data-ng-show = "account.type != 'ROOT_ADMIN' && account.status == 'ENABLED' "
												   class = "test_accounts_disable_user_button"
                                        		  id="accounts_disable_user_button_{{account.id}}" data-unique-field="{{account.domainName}}-{{account.departmentUserName}}-{{ account.userName}}"
                                        		  has-permission="DISABLE_USER" data-ng-click="revoking(account.id)" ><span class="pe-7s-delete-user pe-lg font-bold m-r-xs" title="Disable User"></span>
                                        		  </a>

                                        		 <a class = "test_accounts_enable_user_button" data-ng-if="global.sessionValues.type =='DOMAIN_ADMIN'" data-ng-show = "account.type != 'DOMAIN_ADMIN' && account.status == 'DISABLED' "
												  id="accounts_enable_user_button_{{account.id}}" data-unique-field="{{account.domainName}}-{{account.departmentUserName}}-{{ account.userName}}"
												  has-permission="ENABLE_USER" data-ng-click="activating(account.id)"><span class="pe-7s-user pe-lg font-bold m-r-xs" title="Enable User"></span></a>

                                        		  <a data-ng-if="global.sessionValues.type =='DOMAIN_ADMIN'" data-ng-show = "account.type != 'DOMAIN_ADMIN' && account.status == 'ENABLED' "
												   class = "test_accounts_disable_user_button"
                                        		  id="accounts_disable_user_button_{{account.id}}" data-unique-field="{{account.domainName}}-{{account.departmentUserName}}-{{ account.userName}}"
                                        		  has-permission="DISABLE_USER" data-ng-click="revoking(account.id)" ><span class="pe-7s-delete-user pe-lg font-bold m-r-xs" title="Disable User"></span>
                                        		  </a>

                                        		   <a class = "test_accounts_enable_user_button" data-ng-if="global.sessionValues.type =='USER'" data-ng-show = "global.sessionValues.userName != '{{account.userName}}' && account.status == 'DISABLED' && account.type !='DOMAIN_ADMIN'"
												  id="accounts_enable_user_button_{{account.id}}" data-unique-field="{{account.domainName}}-{{account.departmentUserName}}-{{ account.userName}}"
												  has-permission="ENABLE_USER" data-ng-click="activating(account.id)"><span class="pe-7s-user pe-lg font-bold m-r-xs" title="Enable User"></span></a>

                                        		  <a data-ng-if="global.sessionValues.type =='USER'" data-ng-show = "global.sessionValues.userName != '{{account.userName}}' && account.status == 'ENABLED' && account.type !='DOMAIN_ADMIN'"
												   class = "test_accounts_disable_user_button"
                                        		  id="accounts_disable_user_button_{{account.id}}" data-unique-field="{{account.domainName}}-{{account.departmentUserName}}-{{ account.userName}}"
                                        		  has-permission="DISABLE_USER" data-ng-click="revoking(account.id)" ><span class="pe-7s-delete-user pe-lg font-bold m-r-xs" title="Disable User"></span>
                                        		  </a>
												 </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                          <pagination-content></pagination-content>
                        </div>
                    </div>
                </div>
            </div>
        </div>
	<div id="footer" ng-include="'app/views/common/footer.jsp'"></div>
