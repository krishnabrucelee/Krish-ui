<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<form name="ipform" >
<div class="inmodal"  >
        <div class="modal-header">
            <panda-modal-header page-custom-icon="images/ip-icon-big.png"  page-title="Acquire IP"></panda-modal-header>
        </div>
        <div class="modal-body">

            <div class="row text-left indent lh-30" data-ng-hide="acquiringIP ">
                <div class="form-group has-error col-md-2 col-sm-2  col-xs-2 " >

                    <span class="fa fa-3x fa-warning text-warning"></span>
                </div>

               Please confirm that you want to Acquire an IP.

               <div data-ng-class=" agree != true && actionAcquire  ? 'text-danger' : ''">

                   <input id="agree" icheck type="checkbox" name="agree" value="yes" class="input-mini p-md m-r-lg "  data-ng-model="agree"/>
                   <label class="m-l-sm font-normal" for="agree">I agree to the Terms and conditions </label>
               </div>

            </div>

            <div class="text-center" data-ng-show="acquiringIP">
                <span>Please wait</span><br/>
                <span><img src="images/loading-bars.svg" /> </span>
            </div>

        </div>

        <div class="modal-footer" data-ng-hide="acquiringIP">
			 <div class="form-group">
                            <div class="col-md-12 col-sm-12">
                             <span class="pull-left">
                        <h4 class="text-danger price-text m-l-lg">
                            <app-currency></app-currency>{{miscellaneousList[0].costperGB }} <span>/IP/day</span>
                        </h4>
                    </span>
            <span class="pull-right">
                <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="cancel()">No</button>
                <button type="button" class="btn btn-info" ng-click="acquire(network)">Yes</button>
            </span>
</div>
        </div>

    </div>
</form>