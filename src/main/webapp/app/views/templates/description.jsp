<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<!--<div data-ng-include src="'views/templates/upload.html'"></div>-->
<div class="hpanel" ng-controller="templatesCtrl">
    <div class="panel-body">
        <div class="row " >


            <div class="col-md-3 col-sm-4 col-xs-12" >

                <div class="border-content ">

                    <div class="row m-b-sm">
<!--                         <img src="images/os/{{templateInfo.imageName}}_logo.png" alt="" height="80" width="80" class="center-block">
 -->                    </div>
                        <div class="row m-b-sm">
                            <div class="col-md-4 col-sm-6 col-xs-4">OS Type</div>
                            <div class="col-md-8 col-sm-6 col-xs-8">{{templateInfo.imageName}}</div>
                        </div>
                        <div class="row m-b-sm">
                            <div class="col-md-4 col-sm-6 col-xs-4">Zone</div>
                            <div class="col-md-8 col-sm-6 col-xs-8">Advanced</div>
                        </div>
                        <div class="row m-b-sm">
                            <div class="col-md-4 col-sm-6 col-xs-4">Hypervisor</div>
                            <div class="col-md-8 col-sm-6 col-xs-8">Xenserver</div>
                        </div>
                        <div class="row m-b-sm">
                            <div class="col-md-4 col-sm-6 col-xs-4">Cost</div>
                            <div class="col-md-8 col-sm-6 col-xs-8"><app-currency-label></app-currency-label> <span class="font-bold text-danger ng-binding">{{templateInfo.price}} / month</span></div>
                        </div>

                     <div class="row m-b-sm">
                        <div class="col-md-6 col-sm-6 col-xs-6">
                            <button class="btn btn-info btn-sm" title="Launch"><i class="fa fa-power-off"></i> Launch</button>
                        </div>
                        <div class="col-md-6 col-sm-6 col-xs-6">
                            <a class="text-info font-bold pull-right" ui-sref="templates.index"  title="Back"><i class="pe-7s-back pe-2x"/></a>
                        </div>
                    </div>

                </div>
            </div>
            <div class="col-md-9 col-sm-8 col-xs-12 text-justify">

                <div class=" ">
                    <h3 ><b>{{templateInfo.description}}</b></h3>
                    <b>{{templateInfo.name}}</b>
                    <div data-ng-include src="templateInfo.content"></div>
                </div>
            </div>
        </div>
    </div>
</div>