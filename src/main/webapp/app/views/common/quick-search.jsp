<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="quick-search pull-right">
    <div class="input-group">
        <input data-ng-model="quickSearch" type="text" class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
        <span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
    </div>
</div>
