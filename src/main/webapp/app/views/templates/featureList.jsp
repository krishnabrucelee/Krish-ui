<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

    <div class="">
    <div class="">
	<div class="col-md-12 col-sm-12" >
		<div class="pull-right dashboard-filters-area" id="instances_quick_search">
						<form data-ng-submit="searchFeaturedList(templateFeaturedListSearch)">
							<div class="quick-search pull-right">
								<div class="input-group">
									<input data-ng-model="templateFeaturedListSearch" id="featured_list_search" type="text" valid-characters class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
								   	<span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
								</div>
							</div>
							<div class="clearfix"></div>
							<span class="pull-right m-l-sm m-t-sm">
							</span>
						</form>
						</div>
	</div>
</div>

        <div class="col-md-12 col-sm-12" >
            <div class="hpanel">
                <div class="white-content">
                    <div class="table-responsive">
                        <table cellspacing="1" cellpadding="1" class="table table-bordered dataTable table-striped">
                            <thead>
                                <tr>
                            <th class="col-md-2 col-sm-2"  data-ng-click="changeSorts('name',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='name'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.name" bundle="${msg}" /></th>
                            <th class="col-md-1 col-sm-1"  data-ng-click="changeSorts('size',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='size'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.size" bundle="${msg}" />(<fmt:message key="common.gb" bundle="${msg}" />)</th>
                            <th class="col-md-1 col-sm-1"  data-ng-click="changeSorts('status',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='status'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.status" bundle="${msg}" /></th>
                            <th class="col-md-1 col-sm-1"  data-ng-click="changeSorts('templateOwner.userName',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='templateOwner.userName'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="template.owner" bundle="${msg}" /></th>
                            <th class="col-md-1 col-sm-1"  data-ng-click="changeSorts('createdDateTime',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='createdDateTime'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="register.date" bundle="${msg}" /></th>
                            <th class="col-md-1 col-sm-1"  data-ng-click="changeSorts('format',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='format'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.format" bundle="${msg}" /></th>
                            <th class="col-md-1 col-sm-1"  data-ng-click="changeSorts('hvm',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='hvm'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.hvm" bundle="${msg}" /></th>
                            <th class="col-md-1 col-sm-1"  data-ng-click="changeSorts('passwordEnabled',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='passwordEnabled'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="password.enabled" bundle="${msg}" /></th>
                            <th class="col-md-1 col-sm-1"  data-ng-click="changeSorts('dynamicallyScalable',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='dynamicallyScalable'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="dynamically.scalable" bundle="${msg}" /></th>
							<th class="col-md-1 col-sm-1"><fmt:message key="common.action" bundle="${msg}" /></th>
                            </tr>
                            </thead>
                             <tbody data-ng-hide="featuredList.length > 0">
                               <tr>
                                   <td class="col-md-6 col-sm-6" colspan="10"><fmt:message key="common.no.records.found" bundle="${msg}" />!!</td>
                               </tr>
                           </tbody>
                            <tbody data-ng-show="featuredList.length > 0">
                                <tr data-ng-if="template.share && template.featured" data-ng-repeat="template in filteredCount = (featuredList| filter:quickSearch | orderBy:sort.column:sort.descending)">
                                    <td>
                                        <a data-ng-click="showDescription(template)">
                                          <img data-ng-show="template.osCategory.name.indexOf('Windows') > -1" src="images/os/windows_logo.png" alt="" height="35" width="35" class="m-r-5" >
                       					   <img data-ng-show="template.osCategory.name.indexOf('CentOS') > -1" src="images/os/centos_logo.png" alt=""   height="35" width="35" class="m-r-5" >
                        				   <img data-ng-show="template.osCategory.name.indexOf('Ubuntu') > -1" src="images/os/ubuntu_logo.png" alt="" height="35" width="35" class="m-r-5" >
                                           <img data-ng-show="template.osCategory.name.indexOf('RedHat') > -1" src="images/os/redhat_logo.png" alt="" height="35" width="35" class="m-r-5" >
                       					   <img data-ng-show="template.osCategory.name.indexOf('Debian') > -1" src="images/os/debian_logo.png" alt="" height="35" width="35" class="m-r-5 " >
                       					   <img data-ng-show="template.osCategory.name.indexOf('SUSE') > -1" src="images/os/suse-logo.png" alt="" height="35" width="35" class="m-r-5 " >
                					       <img data-ng-show="template.osCategory.name.indexOf('Oracle') > -1" src="images/os/oracle-os.png" alt="" height="35" width="35" class="m-r-5 " >
                					       <img data-ng-show="template.osCategory.name.indexOf('Novel') > -1" src="images/os/novell-os.png" alt="" height="35" width="35" class="m-r-5 " >
                					       <img data-ng-show="template.osCategory.name.indexOf('Unix') > -1" src="images/os/unix-logo.png" alt="" height="35" width="35" class="m-r-5 " >
                       					    {{ template.name }}
                                        </a>
                                    </td>
                                    <td>{{ global.Math.round((template.size / global.Math.pow(2, 30)),2) }}</td>
                                    <td>{{ template.status }}</td>
                                    <td>{{ template.templateOwner.userName || " - " }}</td>
                                    <td>{{ template.createdDateTime *1000 | date:'yyyy-MM-dd HH:mm:ss'}}</td>
                                    <td>{{ template.format }}</td>
                                    <td>{{ template.hvm || " - "}}</td>
                                    <td>{{ (template.passwordEnabled) ? "Yes" : "No"}}</td>
                                    <td>{{ (template.dynamicallyScalable) ? "Yes" : "No" }}</td>
                                    <td>
                                        <button data-ng-if="template.status == 'ACTIVE'" title="<fmt:message key="common.launch" bundle="${msg}" />" class="btn btn-info btn-sm pull-right" data-ng-click="openAddInstance(template)"><i class="fa fa-power-off"></i> <fmt:message key="common.launch" bundle="${msg}" /></button>
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
