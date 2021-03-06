<%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

	<div class="row" data-ng-show="paginationObjects.totalItems > 10">
    <div class="col-sm-6">
	    <div class="col-sm-6 shown-page" data-ng-show="paginationObjects.totalItems > (((paginationObjects.currentPage - 1) * (paginationObjects.limit * 1)) + (paginationObjects.limit * 1))"><div class="dataTables_info" id="example1_info" role="status" aria-live="polite"><fmt:message key="showing" bundle="${msg}" /> {{ ((paginationObjects.currentPage - 1) * paginationObjects.limit) + 1}} <fmt:message key="to" bundle="${msg}" /> {{ ((paginationObjects.limit * paginationObjects.currentPage/paginationObjects.limit) * paginationObjects.limit)}} <fmt:message key="of" bundle="${msg}" /> {{ paginationObjects.totalItems}} <fmt:message key="entries" bundle="${msg}" /></div></div>

	    <div class="col-sm-6 shown-page" data-ng-hide="paginationObjects.totalItems > (((paginationObjects.currentPage - 1) * (paginationObjects.limit * 1)) + (paginationObjects.limit * 1))"><div class="dataTables_info" id="example1_info" role="status" aria-live="polite"><fmt:message key="showing" bundle="${msg}" /> {{ ((paginationObjects.currentPage - 1) * paginationObjects.limit) + 1}} <fmt:message key="to" bundle="${msg}" /> {{ paginationObjects.totalItems}} <fmt:message key="of" bundle="${msg}" /> {{ paginationObjects.totalItems}} <fmt:message key="entries" bundle="${msg}" /></div></div>
	    <div class="col-sm-6 shown-entry">
	        <div class="dataTables_length" id="example1_length"><label><fmt:message key="show" bundle="${msg}" />
	                <select data-ng-model="paginationObjects.limit" data-ng-change="lists(1); updatePagination(paginationObjects.limit)" aria-controls="example1" class="form-control input-sm test_pagination_dropdown">
	                    <option value="10">10</option>
	                    <option value="25">25</option>
	                    <option value="50">50</option>
	                    <option value="100">100</option>
	                </select> <fmt:message key="entries" bundle="${msg}" /></label>
	        </div>
	    </div>
    </div>
    <div class="col-sm-6"><div class="dataTables_paginate paging_simple_numbers" id="example1_paginate">
            <pagination boundary-links="true" total-items="paginationObjects.totalItems" items-per-page="paginationObjects.limit" max-size="5"  ng-model="paginationObjects.currentPage" ng-change="lists(paginationObjects.currentPage)" class="pagination-sm" previous-text="&lsaquo;" next-text="&rsaquo;" first-text="&laquo;" last-text="&raquo;"></pagination>
        </div>
    </div>

</div>
