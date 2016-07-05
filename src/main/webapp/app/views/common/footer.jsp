<%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<footer class="footer" data-ng-controller="headerCtrl">
	<div class="col-md-4 col-sm-12 text-left">
		{{themeSettingsList.themeFooterLeft}}
	</div>
	<div class="col-md-4 col-sm-12">
		<ul class="footer-custom-links text-center">
			<li data-ng-repeat="theme in themeSettingsList.footers" data-ng-if="theme.url != null">

				<a class="label-menu-corner" target="_blank" href="http://{{theme.url}}">{{theme.name}}</a>
			</li>
		</ul>
	</div>
	<div class="col-md-4 col-sm-12 text-right">
		{{themeSettingsList.themeFooterRight}}
	</div>
</footer>