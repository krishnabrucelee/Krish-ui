<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />
<!-- This is content container for nested view in UI-Router-->
<!-- You can put here any constant element in app content for example: Page title or breadcrum -->

<!-- Header -->
<ng-include id="header" src="global.getViewPageUrl('common/header.jsp')"></ng-include>

<!-- Navigation -->
<ng-include id="menu" src="global.getViewPageUrl('common/navigation.jsp')"></ng-include>

<!-- Main Wrapper -->
<div id="wrapper">
    <div class="content">
        <div ui-view>
            <div ng-controller="domainListCtrl">
                <div class="hpanel">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-md-12 col-sm-12 col-xs-12 ">
                                <div class="pull-left">

                                </div>
                                <div class="pull-right">
                                    <panda-quick-search></panda-quick-search>
                                    <div class="clearfix"></div>
                                    <span class="pull-right m-l-sm m-t-sm">
                                        <a class="btn btn-info" data-ng-click="addDomain('lg',domain)"><span class="pe-7s-add-user pe-lg font-bold m-r-xs"></span>Add Company</a>
                                        <a class="btn btn-info " ui-sref="project.home" title="Refresh"  ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
                                    </span>
                                </div>

                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12 ">
                            <div class="white-content">
                                <div class="table-responsive">
                                    <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped ">
                                        <thead>
                                        <tr>

                                        <th>Company Name</th>
                                        <th>Portal User Name</th>
                                        <th>Head Quarters</th>
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>Action</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                            <tr data-ng-class="{'bg-row text-white' : domain.isSelected == true }"  data-ng-repeat="domain in domainList| filter: quickSearch">

                                                <td>{{domain.name}}</td>
                                                <td>{{domain.portalUserName}}</td>
                                                <td>{{domain.cityHeadquarter}}</td>
                                                <td>{{domain.hod.email}}</td>
                                                <td>{{domain.phone}}</td>
                                                <td>
                                                <a class="icon-button" title="<fmt:message key="common.edit" bundle="${msg}" />" data-ng-click="edit('lg', domain)">
                                                    <span class="fa fa-edit"> </span>
                                                </a>
                                                <a class="icon-button" title="<fmt:message key="common.delete" bundle="${msg}" />" data-ng-click="delete('sm', domain)" ><span class="fa fa-trash"></span></a>
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
    </div>
</div>