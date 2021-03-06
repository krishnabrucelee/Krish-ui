<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div class="row m-t-sm">
    <div class="col-md-12 col-lg-6 col-xs-12 col-sm-12 template-panel-area" data-ng-repeat="templateObj in template.templateList|orderBy:template.name | filter: quickSearch">
        <div class="hpanel">


            <div class="panel-body p-xs template-panel" data-ng-class="templateObj.openDescription ? 'template-panel-active': ''">
                <div class="row">
                    <div class="col-md-12 col-sm-12">
                        <div class="font-extra-bold pull-right" title="Zone">
                            <a href="#" title="Share"><i class="pe-7s-share font-extra-bold"></i> </a>
                            <a href="#" title="Edit"><i class="pe-7s-note m-l-md font-extra-bold"></i> </a>
                            <a href="#"  title="Delete"><i class="pe-7s-trash font-extra-bold m-l-md"></i></a>
                            <a  title="Properties" data-ng-click="showDescription(templateObj)"><i class="pe-7s-keypad font-extra-bold m-l-md"></i></a>
                            <i class="fa fa-map-marker m-l-md" ></i> {{ global.zone.name}}
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-2 col-sm-2">
<img data-ng-show="templateObj.imageName.indexOf('windows') > -1" src="images/os/windows_logo.png" alt="" height="80" width="80" class="m-r-5" >
                        <img data-ng-show="templateObj.imageName.indexOf('linux') > -1" src="images/os/ubuntu_logo.png" alt="" height="80" width="80" class="m-r-5" >                    </div>
                    <div class="col-md-7 col-sm-7 ">
                        <div class="row">

                            <!--<div class="col-md-10 col-sm-10">-->
                            <!--<button class="btn btn-info btn-sm pull-right" title="Properties">Properties</button>-->
                            <div class="col-md-8 col-sm-6">
                                <div class="row">


                                    <h4>{{ templateObj.name}}</h4><h5 class="text-success">Version:{{ templateObj.version}}</h5>
                                </div>
                            </div>

                            <!--</div>-->
                        </div>
                        <div class="row">
                            <div class="col-md-12 col-sm-12">
                                <div class="small  m-b-sm " data-ng-hide="templateObj.openDescription">
                                    {{ templateObj.description}}.
                                </div>
                                <div class="small text-justify"  data-ng-include src="templateObj.content" data-ng-show="templateObj.openDescription"></div>

                                <a class="text-info font-bold  " data-ng-click="openDescription($index)"><span data-ng-class="templateObj.openDescription ? 'pe-7s-angle-up-circle' : 'pe-7s-angle-down-circle'" class="pe-lg font-bold m-r-xs"></span> details</a>


                            </div>
                        </div>

                    </div>
                    <div class="col-md-3 col-sm-3">


                        <div class="row m-t-md">
                            <div class="col-md-12 col-sm-12 ">
                                <span data-ng-show="templateObj.price > 0" class="font-bold text-danger pricing-text pull-right">{{ templateObj.price | currency: global.settings.currency }} / Month</span>
                                <span data-ng-hide="templateObj.price > 0" class="font-bold text-success pricing-text pull-right">FREE</span>
                            </div>
                        </div>

                        <div class="row m-t-md" >

                            <div class="col-md-12 col-sm-12 col-xs-12 ">
                                <button class="btn btn-info btn-sm pull-right" title="Launch VM"><i class="fa fa-power-off"></i> Launch</button>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

