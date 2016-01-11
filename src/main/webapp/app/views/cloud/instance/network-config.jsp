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

                            <a class="btn btn-info" has-permission="ADD_NETWORK_TO_VM" data-ng-click="addNetworkToVM(instance)"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span><fmt:message key="add.network.to.vm" bundle="${msg}" /></a>
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
                            <h5 class="m-t-md"><b class="ng-binding">{{instance.name}}</b></h5>
                        </div>
                    </div>
                </div>

                <div class="network-manager pull-right">
                    <div class="hpanel">
                        <div class=" vertical-container" animate-panel child="vertical-timeline-block" delay="3">
                            <div class="v-timeline  vertical-timeline-block" data-ng-class="{'timeline-primary' : network.isDefault == 'YES'}"  data-ng-repeat="nic in nicList" >
                                <div class="h-timeline">
                                    <div class="vertical-timeline-content">

                                        <div class="timeline-title">
                                            NIC  {{ $index + 1}}  <div class="pull-right" data-ng-if="nic.isDefault">(Default)</div>
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
                                                                    <div data-ng-if="!nic.isDefault" class="btn-group">
                                                                        <button class="btn btn-sm m-t-md dropdown-toggle" data-ng-class="$index == 0 ? 'btn-info' : 'btn-default'" data-toggle="dropdown"><i class="fa fa-cog"></i> <fmt:message key="configure" bundle="${msg}" /></button>
                                                                        <ul class="dropdown-menu pull-right">
                                                                            <li data-ng-show="nic.isDefault== 'true'"><a href="javascript:void(0);" title="Set as Default" data-ng-click="setAsDefault($event)"><span class="pe-7s-tools font-bold m-xs"></span> <fmt:message key="set.as.default" bundle="${msg}" /></a></li>
                                                                             <li ><a href="javascript:void(0);" has-permission="DELETE_NETWORK_TO_VM" title="<fmt:message key="set.as.default" bundle="${msg}" />" data-ng-click="removeNicToVM(nic)"><span class="fa-remove fa  font-bold m-xs"></span> <fmt:message key="remove" bundle="${msg}" /></a></li>
                                                                             <li ><a href="javascript:void(0);" has-permission="UPDATE_NETWORK_TO_VM" title="<fmt:message key="set.as.default" bundle="${msg}" />" data-ng-click="updateNicToVM(networkForm,nic)"><span class="fa-edit fa  font-bold m-xs"></span> <fmt:message key="common.update" bundle="${msg}" /></a></li>

                                                                        </ul>
                                                                        <div class="clearfix"></div>
                                                                    </div>

                                                                </div>

                                                            <div class="media-body">

                                                                <div class="row-fluid">
                                                                    <div class="span12 field-box p-xxs"><label class="headerLabel m-r-xs"><fmt:message key="network.name" bundle="${msg}" />:</label><a href="#/user/network/view/2">{{nic.network.name}}</a></div>
                                                                    <div class="span12 field-box p-xxs"><label class="headerLabel m-r-xs"><fmt:message key="id" bundle="${msg}" />:</label><span id="nicId">{{nic.uuid}}</span></div>
                                                                    <div class="span12 field-box p-xxs"><label class="headerLabel m-r-xs"><fmt:message key="common.type" bundle="${msg}" />:</label><span>{{nic.network.networkType}}</span></div>
                                                                    <div class="span12 field-box p-xxs"><label class="headerLabel m-r-xs"><fmt:message key="ip.address" bundle="${msg}" />:</label><span>{{nic.ipAddress}}</span></div>
                                                                    <div class="span12 field-box p-xxs"><label class="headerLabel m-r-xs"><fmt:message key="gateway" bundle="${msg}" />:</label><span>{{nic.gateway}}</span></div>
                                                                    <div class="span12 field-box p-xxs"><label class="headerLabel m-r-xs"><fmt:message key="netmask" bundle="${msg}" />:</label><span>{{nic.netMask}}</span></div>
                                                                    <div class="span12 field-box p-xxs"><label class="headerLabel m-r-xs"><fmt:message key="is.default" bundle="${msg}" />:</label><span data-ng-class="nic.isDefault== 'true' ? 'text-info' : 'text-default' ">{{nic.isDefault}}</span></div>
                                       <%--                              <div class="pull-right">
									<span class="pull-right m-l-sm m-t-sm"> <a class="btn btn-info" ui-sref="cloud.list-instance.view-instance-ipAddress"><fmt:message key="edit.secondary.ips" bundle="${msg}" /></a>
									</span>
								</div> --%>


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
