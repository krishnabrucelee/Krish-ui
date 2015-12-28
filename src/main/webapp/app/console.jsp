<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html data-ng-app="homer">
<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Page title set in pageTitle directive -->
<title page-title></title>
<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
<link rel="shortcut icon" type="image/x-icon" href="../favicon.ico" />

<!-- build:css(.) styles/vendor.css -->
<!-- bower:css -->
<link rel="stylesheet"
	href="../bower_components/bootstrap/dist/css/bootstrap.css" />

<!-- endbower -->
<!-- endbuild -->

<!-- build:css({.tmp,app}) styles/style.css -->
<link rel="stylesheet" href="../styles/iso.css">
<!-- endbuild -->

</head>
<body>
	<div class="blank" data-ng-controller="consoleCtrl">
		<div class="iso-header">
	<div class="console-container">
				<div class="pull-left">{{ consoleVm.name }} : {{ consoleVm.applicationName }}</div>
				<div class="pull-right">
					<div class="pull-left">
						<label>Select ISO :</label>
					</div>
					<div class="pull-left">
						<div class="form-group no-padding no-margins">
							<select required="true" class="form-control input-group"
								name="isolist" data-ng-model="isos"
								data-ng-class="{'error': isoForm.isolist.$invalid && formSubmitted}"
								data-ng-options="isos.name for isos in isoLists">
								<option value=""><fmt:message key="common.select"
										bundle="${msg}" /></option>
							</select>
						</div>
					</div>
					<button type="button" data-ng-show="consoleVm.status == 'Running' || consoleVm.status == 'Stopped'" data-ng-if="consoleVm.isoName === null" data-ng-click="attachISotoVM(consoleVm)" data-ng-disabled="attachIsoLabel == 'Attaching'" class="btn btn-primary pull-left btn-md">{{ attachIsoLabel }}</button>
					<button type="button" data-ng-show="consoleVm.status == 'Running' || consoleVm.status == 'Stopped'"  data-ng-if="consoleVm.isoName !== null" data-ng-click="detachISO(consoleVm)"  data-ng-disabled="detachIsoLabel == 'Ejecting'" class="btn btn-primary pull-left btn-md">{{ detachIsoLabel }}</button>
				</div>

			</div>
			<div class="console-container">
				<label>Note : Please click the below header and enter to activate the console</label>
			</div>
		</div>
		<div class="terminal-area">
			<div class="row">
				<div class="col-md-offset-2 col-md-8 col-sm-8">
					<iframe data-ng-src="{{ consoleUrl }}" width="800" height="450"
						id="iframe-container"></iframe>
				</div>
				<div class="col-md-2 col-sm-2"></div>
			</div>
		</div>
		<!-- <div class="iso-footer">
			<div class="console-container">
				<button type="submit" class="btn btn-default btn-md" id="">Ctrl+Alt+Delete</button>
				<button type="button" class="btn btn-warning pull-right" data-ng-show="consoleVm.status == 'Starting' || consoleVm.status == 'Stopping'"> {{ consoleVm.status }}</button>
				<button type="button"
					class="btn btn-danger btn-md pull-right" data-ng-show="consoleVm.status == 'Running'" data-ng-click="vmStop(consoleVm)" data-ng-disabled="instanceStopLabel == 'Stopping'">{{ instanceStopLabel }}</button>
				<button type="button"
					class="btn btn-success btn-start btn-md pull-right" data-ng-show="consoleVm.status == 'Stopped'" data-ng-click="vmStart(consoleVm)" data-ng-disabled="instanceStartLabel == 'Starting'">{{ instanceStartLabel }}</button>
			</div>
		</div> -->

	</div>
</body>

<script src="../bower_components/jquery/dist/jquery.min.js"></script>
<script src="../bower_components/jquery-ui/jquery-ui.min.js"></script>
<script src="../bower_components/angular/angular.min.js"></script>
<script src="../scripts/factories/globalConfig.js"></script>
<script src="../scripts/controllers/consoleController.js"></script>

<script>
	<!-- endbuild -->

		$('html').addClass("page-scroll");



		function scrollbarWidth() {
			var $inner = jQuery('<div style="width: 100%; height:200px;">test</div>'), $outer = jQuery(
					'<div style="width:200px;height:150px; position: absolute; top: 0; left: 0; visibility: hidden; overflow:hidden;"></div>')
					.append($inner), inner = $inner[0], outer = $outer[0];

			jQuery('body').append(outer);
			var width1 = inner.offsetWidth;
			$outer.css('overflow', 'scroll');
			var width2 = outer.clientWidth;
			$outer.remove();
			return (width1 - width2);
		}
	</script>
</html>
