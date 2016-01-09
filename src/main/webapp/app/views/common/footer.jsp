<%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

 <footer class="footer">
         <span class="pull-right">
            <fmt:message key="panda.cloud.management.portal" bundle="${msg}" />
        </span>
<fmt:message key="common.copyright" bundle="${msg}" /> © <fmt:message key="common.footer" bundle="${msg}" />.
 </footer>