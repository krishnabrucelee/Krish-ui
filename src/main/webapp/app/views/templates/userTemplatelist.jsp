<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />
        <div class="col-md-12 col-sm-12" >
            <div class="hpanel">
                <div class="white-content">
                    <div class="table-responsive">
                        <table cellspacing="1" cellpadding="1" class="table table-bordered dataTable table-striped">
                            <thead>
                                <tr>
                            <th class="col-md-2 col-sm-2"  data-ng-click="changeSortings('name',paginationObject.currentPage,userListTemplateType.name)" data-ng-class="sort.descending && sort.column =='name'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.name" bundle="${msg}" /></th>
                            <th class="col-md-1 col-sm-1"  data-ng-click="changeSortings('size',paginationObject.currentPage,userListTemplateType.name)" data-ng-class="sort.descending && sort.column =='size'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.size" bundle="${msg}" />(<fmt:message key="common.gb" bundle="${msg}" />)</th>
                            <th class="col-md-1 col-sm-1"  data-ng-click="changeSortings('status',paginationObject.currentPage,userListTemplateType.name)" data-ng-class="sort.descending && sort.column =='status'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.status" bundle="${msg}" /></th>
                            <th class="col-md-1 col-sm-1"  data-ng-click="changeSortings('userName',paginationObject.currentPage,userListTemplateType.name)" data-ng-class="sort.descending && sort.column =='templateOwner.userName'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="template.owner" bundle="${msg}" /></th>
                            <th class="col-md-1 col-sm-1"  data-ng-click="changeSortings('createdDateTime',paginationObject.currentPage,userListTemplateType.name)" data-ng-class="sort.descending && sort.column =='createdDateTime'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="register.date" bundle="${msg}" /></th>
                            <th class="col-md-1 col-sm-1"  data-ng-click="changeSortings('format',paginationObject.currentPage,userListTemplateType.name)" data-ng-class="sort.descending && sort.column =='format'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.format" bundle="${msg}" /></th>
                            <th class="col-md-1 col-sm-1"  data-ng-click="changeSortings('hvm',paginationObject.currentPage,userListTemplateType.name)" data-ng-class="sort.descending && sort.column =='hvm'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.hvm" bundle="${msg}" /></th>
                            <th class="col-md-1 col-sm-1"  data-ng-click="changeSortings('passwordEnabled',paginationObject.currentPage,userListTemplateType.name)" data-ng-class="sort.descending && sort.column =='passwordEnabled'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="password.enabled" bundle="${msg}" /></th>
                            <th class="col-md-1 col-sm-1"  data-ng-click="changeSortings('dynamicallyScalable',paginationObject.currentPage,userListTemplateType.name)" data-ng-class="sort.descending && sort.column =='dynamicallyScalable'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="dynamically.scalable" bundle="${msg}" /></th>
							<th class="col-md-1 col-sm-1"><fmt:message key="common.action" bundle="${msg}" /></th>
                            </tr>
                            </thead>
                            <tbody data-ng-hide="userTemplateList.length > 0">
                               <tr>
                                   <td class="col-md-6 col-sm-6" colspan="10"><fmt:message key="common.no.records.found" bundle="${msg}" />!!</td>
                               </tr>
                           </tbody>
                            <tbody data-ng-show="userTemplateList.length > 0">
                            <tr data-ng-repeat="template in filteredCount = (userTemplateList| filter:quickSearch | orderBy:sort.column:sort.descending)">
                                    <td>
                                        <a data-ng-click="showDescription(template)">
                                          <img data-ng-show="template.osCategoryName.indexOf('Windows') > -1" src="images/os/windows_logo.png" alt="" height="35" width="35" class="m-r-5" >
                       					   <img data-ng-show="template.osCategoryName.indexOf('CentOS') > -1" src="images/os/centos_logo.png" alt=""   height="35" width="35" class="m-r-5" >
                        				   <img data-ng-show="template.osCategoryName.indexOf('Ubuntu') > -1" src="images/os/ubuntu_logo.png" alt="" height="35" width="35" class="m-r-5" >
                                           <img data-ng-show="template.osCategoryName.indexOf('RedHat') > -1" src="images/os/redhat_logo.png" alt="" height="35" width="35" class="m-r-5" >
                       					   <img data-ng-show="template.osCategoryName.indexOf('Debian') > -1" src="images/os/debian_logo.png" alt="" height="35" width="35" class="m-r-5 " >
                       					   <img data-ng-show="template.osCategoryName.indexOf('SUSE') > -1" src="images/os/suse-logo.png" alt="" height="35" width="35" class="m-r-5 " >
                					       <img data-ng-show="template.osCategoryName.indexOf('Oracle') > -1" src="images/os/oracle-os.png" alt="" height="35" width="35" class="m-r-5 " >
                					       <img data-ng-show="template.osCategoryName.indexOf('Novel') > -1" src="images/os/novell-os.png" alt="" height="35" width="35" class="m-r-5 " >
                					       <img data-ng-show="template.osCategoryName.indexOf('Unix') > -1" src="images/os/unix-logo.png" alt="" height="35" width="35" class="m-r-5 " >
                       					    {{ template.name }}
                                        </a>
                                    </td>
                                    <td>{{ global.Math.round((template.size / global.Math.pow(2, 30)),2) }}</td>
                                    <td>{{ template.status }}</td>
                                    <td>{{ template.userName || " - " }}</td>
                                    <td>{{ template.createdDateTime *1000 | date:'yyyy-MM-dd HH:mm:ss'}}</td>
                                    <td>{{ template.format }}</td>
                                    <td>{{ template.hvm || " - "}}</td>
                                    <td>{{ (template.passwordEnabled) ? "Yes" : "No"}}</td>
                                    <td>{{ (template.dynamicallyScalable) ? "Yes" : "No" }}</td>
                                    <td>
                                        <a class="icon-button text-center test_instances_stop_vm_button" title="<fmt:message key="common.launch" bundle="${msg}" />" data-ng-click="openAddInstance(template.id)"><i class="fa fa-power-off"></i></a>
                                    	<a has-permission ="EDIT_TEMPLATE"  class="icon-button test_applications_edit_button" title="<fmt:message key="common.edit" bundle="${msg}" />" data-ng-click="editTemplateContainer('lg', template.id)"> <span class="fa fa-edit"></span></a>
										<a has-permission= "DELETE_MY_TEMPLATE" class="icon-button test_applications_delete_button" title="<fmt:message key="common.delete" bundle="${msg}" />" data-ng-click="delete('sm', template.id)"><span class="fa fa-trash"></span></a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
              <pagination-content></pagination-content>
            </div>
        </div>
