<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="row" data-ng-controller="quotaLimitCtrl">
    <div class="col-lg-12" >
        <div class="hpanel" >
            <div class="page-heading">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="pull-right ">
                        <panda-quick-search></panda-quick-search>
                        	<div class="clearfix"></div>
                                <span class="pull-right m-l-sm m-t-sm">
                                	<a class="btn btn-info" ui-sref="cloud.quota-limit" title="<fmt:message key="common.refresh" bundle="${msg}" /> " ui-sref-opts="{reload: true}" ><span class="fa fa-refresh fa-lg"></span></a>
                                </span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel-body m-t-sm" >
                <div class="text-center">
                    <div class="row" >

                        <div class="col-md-6 col-sm-6 col-lg-3 col-xs-6" data-ng-repeat="quota in quotaLimitData | filter: quotaLimitSearch">

                            <div class="panel panel-default">
                                <div class="panel-body p-xs">
                                    <div class="row">

                                        <div class="panel-group">
                                            <div class="row" >
                                                <b><p ng-bind="quota.title"></p></b>
                                            </div>
                                            <div class="col-md-6 col-sm-6 col-xs-12">

                                                <div class="row quota-limit">
                                                    <canvas  donutchart options="quotaChartOptions" data="quota.options" width="100" height="80">
                                                    </canvas>
                                                </div>

                                            </div>

                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <div class="row">
                                                    <div class="col-md-5 col-sm-5 col-xs-5">

                                                        Used</div>
                                                    <div class="col-md-7 col-sm-7 col-xs-7"> : {{quota.options[1].value}} </div>
                                                </div>
                                                <div class="row m-b-sm" >
                                                    <div class="col-md-5 col-sm-5 col-xs-5">
                                                        Available</div>
                                                    <div class="col-md-7 col-sm-7 col-xs-7"> : {{quota.options[0].value}} </div>
                                                </div>

                                             <!--    <div class="row" >
                                                    <div class="col-md-12">
                                                        <a href="javascript:void(0);" title="Request" class="btn btn-sm btn-default-focus pull-right" data-toggle="modal" ng-click="showForm(quota)" data-target="#smallModal" data-backdrop="static" data-keyboard="false">Request</a>
                                                    </div>
                                                </div> -->
                                            </div>

                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>


                </div>
            </div>
        </div>
    </div>
</div>
