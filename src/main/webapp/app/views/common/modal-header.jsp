<%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="row">
    <div class="col-md-8 font-bold">
        <span class="ver-align-mid"><i class="{{ pageIcon }} pe-lg" data-ng-hide="pageCustomIcon" title="{{ pageTitle }}"></i>
        	<span data-ng-if="pageCustomIcon">
            <img data-ng-src="pageCustomIcon" style="width:22px; height:22px;"  alt="{{pageTitle}}">
            </span>
        </span>
        <span class="ver-align-mid" >{{ pageTitle }}</span>
    </div>

    <div class="col-md-4">
        <div class="pull-right font-extra-bold" >
            <span data-ng-hide="hideZone"  class="ver-align-mid"  title="Zone"><i class="fa fa-map-marker m-r-xsm" ></i> {{ global.zone.name}}</span>
            <a class="close-container" href="javascript:void(0);" data-ng-click="cancel()" ><img src="images/close3.png" alt="Close" /></a>
        </div>
    </div>
</div>