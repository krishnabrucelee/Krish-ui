<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="language" value="${not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />
<!DOCTYPE html>
<html lang="${language}">
<head>
<!-- Redirect to login when passing the wrong URL -->
<script>
    var pageUrl = window.location.href;
    if(pageUrl.indexOf("index#/login") > -1 || pageUrl.endsWith("index#/")) {
        var contextPath = '<%= request.getContextPath() %>';
        var baseUrl = window.location.protocol + "//" + window.location.host + contextPath + '/login';
        window.location = baseUrl;
    }
</script>
<script type="text/javascript">
    var USER_CONTEXT_PATH = "<%=request.getContextPath()%>";
</script>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Page title set in pageTitle directive -->
<title id="pandaAppPageTitle" page-title></title>
<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
<link rel="shortcut icon" type="image/x-icon"  href=""  data-fav-icon-url="" />
<!-- build:css(.) styles/vendor.css -->
<!-- bower:css -->
<link rel="stylesheet"
    href="bower_components/angular-notify/dist/angular-notify.min.css" />
<link rel="stylesheet"
    href="bower_components/fontawesome/css/font-awesome.css" />
<link rel="stylesheet"
    href="bower_components/metisMenu/dist/metisMenu.css" />
<link rel="stylesheet" href="bower_components/animate.css/animate.css" />
<link rel="stylesheet"
    href="bower_components/sweetalert/lib/sweet-alert.css" />
<link rel="stylesheet"
    href="bower_components/fullcalendar/dist/fullcalendar.min.css" />
<link rel="stylesheet"
    href="bower_components/bootstrap/dist/css/bootstrap.css" />
<link rel="stylesheet"
    href="bower_components/summernote/dist/summernote.css" />
<link rel="stylesheet" href="bower_components/ng-grid/ng-grid.min.css" />
<link rel="stylesheet"
    href="bower_components/angular-ui-tree/dist/angular-ui-tree.min.css" />
<link rel="stylesheet"
    href="bower_components/bootstrap-tour/build/css/bootstrap-tour.min.css" />
<link rel="stylesheet"
    href="bower_components/datatables_plugins/integration/bootstrap/3/dataTables.bootstrap.css" />
<link rel="stylesheet"
    href="bower_components/angular-xeditable/dist/css/xeditable.css" />
<link rel="stylesheet"
    href="bower_components/ui-select/dist/select.min.css" />
<link rel="stylesheet"
    href="bower_components/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.min.css" />
<link rel="stylesheet"
    href="bower_components/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css" />
<link rel="stylesheet"
    href="bower_components/blueimp-gallery/css/blueimp-gallery.min.css" />
<link rel="stylesheet" type="text/css" href="bower_components/angular-jqplot/jquery.jqplot.min.css" />
<link rel="stylesheet" type="text/css" href="bower_components/jquery-ui/themes/smoothness/jquery-ui.css" />
<!-- endbower -->
<!-- endbuild -->

<!-- build:css({.tmp,app}) styles/style.css -->
<link rel="stylesheet"
    href="fonts/pe-icon-7-stroke/css/pe-icon-7-stroke.css" />
<link rel="stylesheet" href="fonts/pe-icon-7-stroke/css/helper.css" />
<link rel="stylesheet" href="fonts/pe-icon-7-stroke/fonts/cJZKeOuBrn4kERxqtaUH3VtXRa8TVwTICgirnJhmVJw.woff2" />
<link rel="stylesheet" href="fonts/pe-icon-7-stroke/fonts/DXI1ORHCpsQm3Vp6mXoaTegdm0LZdjqr5-oayXSOefg.woff2" />
<link rel="stylesheet" href="fonts/pe-icon-7-stroke/fonts/k3k702ZOKiLJc3WVjuplzOgdm0LZdjqr5-oayXSOefg.woff2" />
<link rel="stylesheet" href="fonts/pe-icon-7-stroke/fonts/MTP_ySUJH_bn48VBG8sNSugdm0LZdjqr5-oayXSOefg.woff2" />
<link rel="stylesheet" href="styles/style.css">
<link rel="stylesheet" href="styles/css">
<link rel="stylesheet" href="styles/custom-style.css">
<link rel="stylesheet" href="styles/page-loader.css">

<!-- 	<link rel="stylesheet" href="scripts/test/bootstrap.min.css">-->


<!-- endbuild -->

</head>

<!-- Body -->
<!-- appCtrl controller with serveral data used in theme on diferent view -->
<!-- landing-scrollspy is directive for scrollspy used in landing page -->
<body ng-controller="appCtrl"
    class="{{$state.current.data.specialClass}}" landing-scrollspy tour
    backdrop="true">

   <input type="hidden" value="${REQUEST_PROTOCOL}" id="request_protocol" />
                         <input type="hidden" value="${REQUEST_PORT}" id="request_port" />
                         <input type="hidden" value="${REQUEST_FOLDER}" id="request_folder" />


             <input type="hidden" value="${WEBSOCKET}" id="websocket_debug" />

    <!-- Simple splash screen-->
    <!-- <div class="splash loading-screen">
        <div class="splash-title">
            <h1>Panda - User Console</h1>
            <p>Cloud Management Portal</p>

<get-loader-image></get-loader-image>
 </div>
    </div> -->

    <div class="splash loading-screen"> <div class="splash-title">
<h1><p id="p1"></p></h1>
<div class="loader-img-wrapper">
    <div class='uil-ripple-css' style='transform:scale(0.32);'><div></div><div></div></div>
</div></div>
</div>

    <!--[if lt IE 7]>
<p class="alert alert-danger">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
<![endif]-->

    <!-- Page view wrapper -->

    <div ui-view autoscroll="true"></div>

    <script src="bower_components/jquery/dist/jquery.min.js"></script>
    <script src="bower_components/jquery-ui/jquery-ui.min.js"></script>
    <script src="bower_components/slimScroll/jquery.slimscroll.min.js"></script>
    <script src="bower_components/angular/angular.min.js"></script>
    <script src="bower_components/angular/angular-cookies.js"></script>
    <script src="bower_components/angular-sanitize/angular-sanitize.min.js"></script>
    <script src="bower_components/angular-animate/angular-animate.min.js"></script>
    <script
        src="bower_components/angular-ui-router/release/angular-ui-router.min.js"></script>
    <script src="bower_components/angular-bootstrap/ui-bootstrap-tpls.js"></script>

    <script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="bower_components/jquery-flot/jquery.flot.js"></script>
    <script src="bower_components/jquery-flot/jquery.flot.time.js"></script>
        <script src="bower_components/jquery-flot/jquery.flot.tooltip.js"></script>
    <script src="bower_components/jquery-flot/jquery.flot.stack.js"></script>
    <script src="bower_components/jquery-flot/jquery.flot.resize.js"></script>
    <script src="bower_components/jquery-flot/jquery.flot.pie.js"></script>
    <script src="bower_components/flot.curvedlines/curvedLines.js"></script>
    <script src="bower_components/jquery.flot.spline/index.js"></script>
    <script src="bower_components/angular-flot/angular-flot.js"></script>
    <script src="bower_components/metisMenu/dist/metisMenu.min.js"></script>
    <script src="bower_components/iCheck/icheck.min.js"></script>
    <script src="bower_components/sparkline/index.js"></script>
    <script src="bower_components/chartjs/Chart.min.js"></script>
    <script src="bower_components/angles/angles.js"></script>
    <script src="bower_components/peity/jquery.peity.min.js"></script>
    <script src="bower_components/angular-peity/angular-peity.js"></script>
    <script src="bower_components/sweetalert/lib/sweet-alert.min.js"></script>
    <script src="bower_components/angular-notify/dist/angular-notify.js"></script>
    <script src="bower_components/angular-ui-utils/ui-utils.js"></script>
    <script src="bower_components/angular-ui-map/ui-map.js"></script>
    <script src="bower_components/moment/min/moment.min.js"></script>
    <script src="bower_components/fullcalendar/dist/fullcalendar.min.js"></script>
    <script src="bower_components/angular-ui-calendar/src/calendar.js"></script>
    <script src="bower_components/summernote/dist/summernote.min.js"></script>
    <script
        src="bower_components/angular-summernote/dist/angular-summernote.min.js"></script>
    <script src="bower_components/ng-grid/ng-grid-2.0.14.min.js"></script>
    <script
        src="bower_components/angular-ui-tree/dist/angular-ui-tree.min.js"></script>
    <script
        src="bower_components/bootstrap-tour/build/js/bootstrap-tour.min.js"></script>
    <script
        src="bower_components/angular-bootstrap-tour/dist/angular-bootstrap-tour.min.js"></script>
    <script
        src="bower_components/datatables/media/js/jquery.dataTables.min.js"></script>
    <script
        src="bower_components/datatables_plugins/integration/bootstrap/3/dataTables.bootstrap.min.js"></script>
    <script
        src="bower_components/angular-datatables/dist/angular-datatables.min.js"></script>
    <script
        src="bower_components/angular-xeditable/dist/js/xeditable.min.js"></script>
    <script src="bower_components/ui-select/dist/select.min.js"></script>
    <script
        src="bower_components/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.min.js"></script>
    <script
        src="bower_components/blueimp-gallery/js/jquery.blueimp-gallery.min.js"></script>
    <script src="bower_components/angular-ui-sortable/sortable.min.js"></script>
    <script
        src="bower_components/angular-local-storage/dist/angular-local-storage.js"></script>
    <script src="bower_components/angularjs-slider/rzslider.js"></script>
    <script src="bower_components/angular-filter/dist/angular-filter.js"></script>
    <script src="bower_components/sockjs/sockjs.min.js"></script>
    <script src="bower_components/stomp/lib/stomp.min.js"></script>
     <!-- Graph -->
	<script type="text/javascript" src="bower_components/angular-jqplot/jquery.jqplot.min.js"></script>
	<script type="text/javascript" src="bower_components/angular-jqplot/plugins/jqplot.dateAxisRenderer.min.js"></script>
	<script type="text/javascript" src="bower_components/angular-jqplot/plugins/jqplot.logAxisRenderer.min.js"></script>
	<script type="text/javascript" src="bower_components/angular-jqplot/plugins/jqplot.canvasTextRenderer.min.js"></script>
	<script type="text/javascript" src="bower_components/angular-jqplot/plugins/jqplot.canvasAxisTickRenderer.min.js"></script>
	<script type="text/javascript" src="bower_components/angular-jqplot/plugins/jqplot.highlighter.min.js"></script>
        <script type="text/javascript" src="bower_components/angular-jqplot/plugins/jqplot.cursor.min.js"></script>
        <script type="text/javascript" src="bower_components/angular-jqplot/plugins/jqplot.categoryAxisRenderer.min.js"></script>
        <script type="text/javascript" src="bower_components/angular-jqplot/plugins/jqplot.canvasAxisLabelRenderer.min.js"></script>
        <!-- endbuild -->

<script type="text/javascript">
var REQUEST_PROTOCOL = document.getElementById("request_protocol").value;
    if(REQUEST_PROTOCOL == "" || typeof(REQUEST_PROTOCOL) == "undefined" || REQUEST_PROTOCOL == null) {
        REQUEST_PROTOCOL = "http";
    }

    var REQUEST_PORT = document.getElementById("request_port").value;
    if(REQUEST_PORT != "" && typeof(REQUEST_PORT) != "undefined" && REQUEST_PORT != null) {
        REQUEST_PORT = ":" + REQUEST_PORT;
    }

    var REQUEST_FOLDER = document.getElementById("request_folder").value;
    if(REQUEST_FOLDER == "" || typeof(REQUEST_FOLDER) == "undefined" || REQUEST_FOLDER == null) {
        REQUEST_FOLDER = "/";
    }
    var WEBSOCKET_DEBUG = document.getElementById("websocket_debug").value;
    if(WEBSOCKET_DEBUG == "" || typeof(WEBSOCKET_DEBUG) == "undefined" || WEBSOCKET_DEBUG == null) {
        WEBSOCKET_DEBUG = false;
    }
    </script>
    <!-- build:js({.tmp,app}) scripts/scripts.js -->
    <script src="scripts/angular-momentjs.js"></script>
    <script src="scripts/moment-timezone.js"></script>
    <script type="text/javascript" src="scripts/js"></script>
    <script src="scripts/homer.js"></script>
    <script src="scripts/app.js"></script>
    <script src="scripts/config.js"></script>
    <script src="scripts/filters/props.js"></script>
    <script src="scripts/directives/directives.js"></script>
    <script src="scripts/controllers/main.js"></script>
    <script src="scripts/factories/sweet-alert.js"></script>
    <script src="bower_components/iCheck/icheck.min.js"></script>

    <script src="scripts/directives/touchSpin.js"></script>
    <script src="scripts/directives/customSelect.js"></script>

    <script src="scripts/controllers/resourceAllocationController.js"></script>
    <script src="scripts/controllers/instance/indexController.js"></script>
    <script src="scripts/controllers/instance/viewController.js"></script>
    <script src="scripts/controllers/instance/listController.js"></script>
    <script src="scripts/controllers/instance/configurationController.js"></script>
    <script src="scripts/controllers/instance/affinityController.js"></script>
    <script src="scripts/controllers/instance/storageController.js"></script>
    <script src="scripts/controllers/instance/monitorController.js"></script>
    <script src="scripts/controllers/instance/Monitor_jqplot.js"></script>
    <script src="scripts/controllers/instance/networkController.js"></script>
    <script src="scripts/controllers/instance/secondaryipController.js"></script>
    <script src="scripts/controllers/vpcController.js"></script>
    <script src="scripts/controllers/departmentController.js"></script>
    <script src="scripts/controllers/rolesController.js"></script>
    <script src="scripts/controllers/domainController.js"></script>
    <script src="scripts/controllers/reportCtrl.js"></script>
    <script src="scripts/controllers/activityController.js"></script>
    <script src="scripts/controllers/volumeController.js"></script>
    <script src="scripts/controllers/services/serviceController.js"></script>
    <script src="scripts/controllers/billingController.js"></script>
    <script src="scripts/controllers/quotaLimitController.js"></script>
    <script src="scripts/controllers/templateController.js"></script>
    <script src="scripts/controllers/sshkeyController.js"></script>
    <script src="scripts/controllers/affinityGroupController.js"></script>
    <script src="scripts/controllers/networkController.js"></script>
    <script src="scripts/controllers/supportController.js"></script>
    <script src="scripts/controllers/snapshotController.js"></script>
    <script src="scripts/controllers/profileController.js"></script>
    <script src="scripts/controllers/projectController.js"></script>
    <script src="scripts/controllers/accountController.js"></script>
    <script src="scripts/controllers/applicationController.js"></script>
    <script src="scripts/controllers/paymentController.js"></script>
    <script src="scripts/constants/appConstants.js"></script>
    <script src="scripts/factories/appService.js"></script>
    <script src="scripts/factories/utilService.js"></script>
    <script src="scripts/factories/loginService.js"></script>
    <script src="scripts/factories/interceptor.js"></script>
    <script src="scripts/factories/promiseAjax.js"></script>
    <script src="scripts/factories/globalConfig.js"></script>
    <script src="scripts/factories/dialogService.js"></script>
    <script src="scripts/factories/volumeService.js"></script>
    <script src="scripts/factories/crudService.js"></script>
    <script src="scripts/factories/modalService.js"></script>
    <script src="scripts/factories/monitorService.js"></script>
    <script src="scripts/factories/monitorService-jqplot.js"></script>
    <script src="scripts/factories/Search.js"></script>
    <script src="scripts/factories/webSocket.js"></script>
    <script src="scripts/factories/webSocketService.js"></script>
    <script src="scripts/factories/rememberMeService.js"></script>
    <script src="scripts/controllers/headerController.js"></script>
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

</body>
</html>


<script type="text/javascript">



var re = new RegExp("splashTitleUser" + "=([^;]+)");
//var re = new RegExp("splashTitle" + "!#$%&'()*+-./:<=>?@[]^_`{|}~");
var value = re.exec(document.cookie);
var text = unescape(value[1]);
        //var splashTitle = splashText[1].split(';');
        document.getElementById("p1").innerHTML = text;
        //document.write(unescape(value[1]));

    </script>
