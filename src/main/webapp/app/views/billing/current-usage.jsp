<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div class="row" ng-controller="billingCtrl">
    <div class="col-lg-12 ">
        <div class="hpanel">
            <div class="panel-heading">


            </div>
            <div class="col-lg-4 m-b-none">
                <div class="panel-body">
                    <div heading="Static Header, initially expanded" class="panel panel-default ng-isolate-scope">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <span class="ng-binding" ng-class="{'text-muted': isDisabled}"><fmt:message key="zone.charges" bundle="${msg}" />
                                    <span class="pull-right medium"> <i class="fa fa-clock-o medium"> </i> 29/07/2015 </span>
                                </span>
                            </h4>
                        </div>

                    </div>
                    <div class="panel-body list">

                        <div class="list-item-container">
                            <div class="list-item h-100">
                                <h3 class="no-margins font-extra-bold text-info"><fmt:message key="advanced" bundle="${msg}" /></h3>
                                    <small><fmt:message key="total.usage" bundle="${msg}" /></small>
                                <h3>
                                    <div class="pull-right font-bold"><app-currency class="text-primary"></app-currency> 168.00 </div>
                                </h3>
                            </div>
                            <div class="list-item h-100">
                                <h3 class="no-margins font-extra-bold text-info"><fmt:message key="misc" bundle="${msg}" /></h3>
                                <small><fmt:message key="misc.usage" bundle="${msg}" /></small>
                                <h3><div class="pull-right font-bold"><app-currency class="text-primary"></app-currency> 100.00 </div></h3>
                            </div>
                            <div class="list-item h-100">
                                <h3 class="no-margins font-extra-bold text-primary"><fmt:message key="common.total" bundle="${msg}" /> </h3>
                                <small><fmt:message key="total.charge" bundle="${msg}" /></small>
                                <h3>
                                    <div class="pull-right font-bold"><app-currency class="text-primary"></app-currency> 268.00 </div>
                                </h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-8 no-padding m-b-none ">
                <div class="panel-body">
                    <div heading="Static Header, initially expanded" class="panel panel-default ng-isolate-scope">
                        <div class="panel-heading">
                            <span class="pull-right medium"> <i class="fa fa-clock-o medium"> </i> 29/07/2015 </span>
                            <h4 class="panel-title">
                                <span class="ng-binding" ng-class="{'text-muted': isDisabled}"><fmt:message key="common.total.charges" bundle="${msg}" /></span>
                            </h4>
                        </div>
                    </div>

                    <div class="row m-sm">  <div style="animation-delay: 0.4s;" class="col-lg-4 animated-panel no-padding"> <div class="hpanel"> <div class="panel-body text-center h-100"> <i class="pe-7s-cart fa-4x text-danger"></i> <h3 class="m-xs text-danger">31.00</h3>  </div> <div class="panel-footer"> <h5 class="font-extra-bold no-margins text-center text-danger"> <fmt:message key="previous.balance" bundle="${msg}" /> </h5>   </div>  </div>
                        </div>
                        <div class="col-lg-1"><p class="fa fa-4x text-danger m-t-lg"> - </p> </div>
                        <div style="animation-delay: 0.4s; " class="col-lg-3 animated-panel no-padding">  <div class="hpanel">   <div class="panel-body text-center h-100"> <i class="pe-7s-cart fa-4x text-success"></i> <h3 class="m-xs text-success">0.00</h3>  </div> <div class="panel-footer"> <h5 class="font-extra-bold no-margins text-center text-success"> <fmt:message key="payments" bundle="${msg}" /> </h5>   </div>  </div> </div>
                        <div class="col-lg-1"><p class="fa fa-2x text-info m-t-xxl"> + </p> </div>
                        <div style="animation-delay: 0.4s;" class="col-lg-3 animated-panel no-padding">  <div class="hpanel">   <div class="panel-body text-center h-100"> <i class="pe-7s-cart fa-4x text-primary"></i> <h3 class="m-xs text-primary">268.00</h3>  </div> <div class="panel-footer"> <h5 class="font-extra-bold no-margins text-center text-primary"> <fmt:message key="current.charge" bundle="${msg}" /> </h5>   </div>  </div> </div>
                    </div>
                    <div class="row">
                        <div style="animation-delay: 0.4s;" class="col-lg-4 text-center h-100 ">  </div>

                        <div style="animation-delay: 0.4s;" class="col-lg-8 text-center h-100 ">  <div class="text-center text-info"> <h2 class="m-b-xs "><fmt:message key="total.payable" bundle="${msg}" /></h2> <p class="font-bold text-success"><i class="fa pe-7s-server text-danger"></i>&nbsp;&nbsp;<fmt:message key="value.in" bundle="${msg}" /> <app-currency-label></app-currency-label></p> <div class="m"> </div> <h3> 299.00 </h3><a class="active" href="#"><div class="panel-title fa-3x pull-right large m-md" style="background: #ddd; padding:15px;"> <i class="fa fa-file-pdf-o text-danger"></i> <fmt:message key="download" bundle="${msg}" /></div></a>    </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>