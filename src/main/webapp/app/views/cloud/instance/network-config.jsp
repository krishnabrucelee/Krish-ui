<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div data-ng-controller="networkCtrl">

<div class="row" >

        <div class="col-md-12">
            <div class="row">
                <div class="col-md-12 col-sm-12">
                      <span class="pull-right">
                            <a class="btn btn-info" data-ng-click="addNetworkToVM()"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span><fmt:message key="add.network.to.vm" bundle="${msg}" /></a>
                      </span>
                      <h4>
                          <fmt:message key="instance.network.manager" bundle="${msg}" />
                      </h4>
                      <hr class="m-t-xs">
                  </div>
                </div>

            <div class="network-manager-area">
                <div class="clearfix"></div>
                <div class="network pull-left">
                    <div class="panel panel-info">
                        <div class="panel-body  text-info text-center">
                            <img src="images/network_icon.jpg" alt="Storage" />
                            <h5 class="m-t-md"><b class="ng-binding">{{instanceDetails}}</b></h5>
                        </div>
                    </div>
                </div>
                <div class="network-manager pull-right">
                    <div class="hpanel">
                        <div class=" vertical-container" animate-panel child="vertical-timeline-block" delay="3">
                            <div class="v-timeline  vertical-timeline-block" data-ng-class="{'timeline-primary' : network.isDefault == 'YES'}"  data-ng-repeat="network in networkList" >
                                <div class="h-timeline">
                                    <div class="vertical-timeline-content">

                                        <div class="timeline-title">
                                            NIC {{ $index + 1}}  <span class="pull-right">  {{ network.isDefault == "YES" ? "(Default)" : "" }}</span>
                                       </div>
                                        <div class="row">
                                            <div class="col-md-12">

                                                <div class="p-sm">
                                                    <div class="pull-left">
                                                        <div class="media">
                                                            <div class="media-image pull-left ">
                                                                <!--<i class="pe-7s-network pe-4x"></i>-->
                                                                <img src="images/network-icon-2.png" alt="Storage" />
                                                            </div>
                                                             <div class="pull-right">
                                                                    <div class="btn-group">
                                                                        <button class="btn btn-sm m-t-md dropdown-toggle" data-ng-class="$index == 0 ? 'btn-info' : 'btn-default'" data-toggle="dropdown"><i class="fa fa-cog"></i> <fmt:message key="configure" bundle="${msg}" /></button>
                                                                        <ul class="dropdown-menu pull-right">
                                                                            <li data-ng-show="network.isDefault== 'NO'"><a href="javascript:void(0);" title="Set as Default" data-ng-click="setAsDefault($event)"><span class="pe-7s-tools font-bold m-xs"></span> <fmt:message key="set.as.default" bundle="${msg}" /></a></li>
                                                                             <li ><a href="javascript:void(0);" title="<fmt:message key="set.as.default" bundle="${msg}" />" data-ng-click="removeNicToVM(networkForm,network)"><span class="fa-remove fa  font-bold m-xs"></span> <fmt:message key="remove" bundle="${msg}" /></a></li>
                                                                             <li ><a href="javascript:void(0);" title="<fmt:message key="set.as.default" bundle="${msg}" />" data-ng-click="updateNicToVM(networkForm,network)"><span class="fa-edit fa  font-bold m-xs"></span> <fmt:message key="common.update" bundle="${msg}" /></a></li>

                                                                        </ul>
                                                                        <div class="clearfix"></div>
                                                                    </div>

                                                                </div>

                                                            <div class="media-body">

                                                                <div class="row-fluid">
                                                                    <div class="span12 field-box p-xxs"><label class="headerLabel m-r-xs"><fmt:message key="network.name" bundle="${msg}" />:</label><a href="#/user/network/view/2">{{network.name}}</a></div>
                                                                    <div class="span12 field-box p-xxs"><label class="headerLabel m-r-xs"><fmt:message key="id" bundle="${msg}" />:</label><span id="nicId">{{network.id}}</span></div>
                                                                    <div class="span12 field-box p-xxs"><label class="headerLabel m-r-xs"><fmt:message key="common.type" bundle="${msg}" />:</label><span>{{network.networkType}}</span></div>
                                                                    <div class="span12 field-box p-xxs"><label class="headerLabel m-r-xs"><fmt:message key="iP.address" bundle="${msg}" />:</label><span>{{instance.ipAddress}}</span></div>
                                                                    <div class="span12 field-box p-xxs"><label class="headerLabel m-r-xs"><fmt:message key="gateway" bundle="${msg}" />:</label><span>{{network.gateway}}</span></div>
                                                                    <div class="span12 field-box p-xxs"><label class="headerLabel m-r-xs"><fmt:message key="netmask" bundle="${msg}" />:</label><span>{{network.netmask}}</span></div>
                                                                    <div class="span12 field-box p-xxs"><label class="headerLabel m-r-xs"><fmt:message key="is.default" bundle="${msg}" />:</label><span data-ng-class="network.isDefault== 'YES' ? 'text-info' : 'text-default' ">{{network.isDefault}}</span></div>
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
                </div>
            </div>
        </div>
</div>
    </div>
