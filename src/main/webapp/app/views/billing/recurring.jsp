<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div class="row text-center p-sm" ng-controller="billingCtrl">

    <div style="animation-delay: 0.5s;" class="col-md-6 m-t-sm ">
                <div class="hpanel no-padding">
                    <div class="panel-body">
                        <div class="stats-title pull-left">
                            <h4><fmt:message key="recurring.item.cost" bundle="${msg}" /></h4>
                        </div>
                        <div class="stats-icon pull-right">
                            <i class="pe-7s-graph1 fa-4x"></i>
                        </div>
                        <div class="m-t-xl">
                            <h1 class="text-info m-b-lg"><app-currency></app-currency>0.00</h1>
                            <small>
                                <div class="pull-right m-l-sm"> <i class="fa pe-7s-server text-info"></i> <i class="fa-2x pe-7s-server text-info"></i> &nbsp;&nbsp;<p class="text-success"><fmt:message key="value.in" bundle="${msg}" /> <app-currency-label></app-currency-label></p></div>
                           20/JUL/2015-01/AUG/2015
                            </small>
                        </div>
                    </div>
                </div>
            </div>
     <div style="animation-delay: 0.5s;" class="col-md-6  m-t-sm">
                <div class="hpanel no-padding">
                    <div class="panel-body">
                        <div class="stats-title pull-left">
                            <h4><fmt:message key="custom.item.cost" bundle="${msg}" /></h4>
                        </div>
                        <div class="stats-icon pull-right">
                            <i class="pe-7s-monitor fa-4x" ></i>
                        </div>
                        <div class="m-t-xl">
                            <h1 class="text-info m-b-lg"><app-currency></app-currency>0.00</h1>
                            <small >
                                <div class="pull-right m-l-sm"> <i class="fa pe-7s-server text-info"></i> <i class="fa-2x pe-7s-server text-info"></i> &nbsp;&nbsp;<p class="text-success"><fmt:message key="value.in" bundle="${msg}" /> <app-currency-label></app-currency-label></p></div>
                            20/JUL/2015-01/AUG/2015
                            </small>
                        </div>
                    </div>
                </div>
            </div>
</div>
<div class="row p-sm " ng-controller="billingCtrl">
    <div class="col-lg-12 ">
        <div class="hpanel">
                <div class="panel-heading no-padding">

                </div>
                <div class="panel-body">
                <div class="dataTables_wrapper table-responsive form-inline dt-bootstrap no-footer" id="example2_wrapper"><div class="row"><div class="col-sm-6"><div id="example2_length" class="dataTables_length"><label><fmt:message key="show" bundle="${msg}" /> <select class="form-control input-sm" aria-controls="example2" name="example2_length"><option value="10">10</option><option value="25">25</option><option value="50">50</option><option value="100">100</option></select> <fmt:message key="entries" bundle="${msg}" /></label></div></div><div class="col-sm-6"><div class="dataTables_filter" id="example2_filter"><label><fmt:message key="search" bundle="${msg}" />:<input aria-controls="example2" placeholder="" class="form-control input-sm" type="search"></label></div></div></div><div class="row"><div class="col-sm-12"><table aria-describedby="example2_info" role="grid" id="example2" class="table table-striped table-bordered table-hover dataTable no-footer">
                <thead>
                <tr>
                        <th><fmt:message key="previous.balance" bundle="${msg}" /> (<app-currency-label></app-currency-label>)</th>
                        <th><fmt:message key="current.usage" bundle="${msg}" /> (<app-currency-label></app-currency-label>)</th>
                        <th><fmt:message key="recurring.item.cost" bundle="${msg}" /> (<app-currency-label></app-currency-label>)</th>
                        <th><fmt:message key="total.payable" bundle="${msg}" /> (<app-currency-label></app-currency-label>)</th>
                        <th><fmt:message key="status" bundle="${msg}" /></th>
                        <th><fmt:message key="action" bundle="${msg}" /></th>
                    </tr> </thead>
                <tbody>
              <tr role="row" data-ng-repeat="invoice in invoiceList" >
<!--                        <td>
                            <a class="text-primary"  title="View Instance" >{{ invoice.billno }}</a>
                        </td>
                        <td>
                            <a class="text-primary"  title="View Instance" >{{ invoice.invoiceno }}</a>
                        </td>
                        <td ng-class="(invoice.previousBalance === '0.00') ? '' : 'text-danger'">{{ invoice.previousBalance }}</td>
                        <td>{{ invoice.currentUsage }}</td>
                        <td class="text-info">{{ invoice.totalPayable }}</td>
                        <td >{{ invoice.paidAmount }}</td>
                        <td>{{ invoice.invoiceDate }}</td>
                         <td>
                            {{ invoice.paidDate }}
                        </td>
                        <td>
                            <label class="label label-warning" data-ng-if="invoice.paidDate === '---'">UNPAID</label>
                            <label class="label label-success" data-ng-if="invoice.paidDate !== '---'">PAID</label>
                        </td>
                        <td>
                            <a title="{{ instance.billno }}"><span class="fa fa-file-pdf-o text-danger"></span></a>
                        </td>-->
                    </tr></tbody>
                </table></div></div><div class="row"><div class="col-sm-6"><div aria-live="polite" role="status" id="example2_info" class="dataTables_info"></div></div><div class="col-sm-6"><div id="example2_paginate" class="dataTables_paginate paging_simple_numbers"><ul class="pagination"><li id="example2_previous" tabindex="0" aria-controls="example2" class="paginate_button previous disabled"><a href="#"><fmt:message key="common.previous" bundle="${msg}" /></a></li><li tabindex="0" aria-controls="example2" class="paginate_button active"><a href="#">1</a></li><li tabindex="0" aria-controls="example2" class="paginate_button "><a href="#">2</a></li><li tabindex="0" aria-controls="example2" class="paginate_button "><a href="#">3</a></li><li tabindex="0" aria-controls="example2" class="paginate_button "><a href="#">4</a></li><li tabindex="0" aria-controls="example2" class="paginate_button "><a href="#">5</a></li><li id="example2_next" tabindex="0" aria-controls="example2" class="paginate_button next"><a href="#"><fmt:message key="common.next" bundle="${msg}" /></a></li></ul></div></div></div></div>
                </div>
            </div>
    </div>
</div>
    .