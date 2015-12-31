<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<form name="ipform" ng-controller="networksCtrl" >
<div class="inmodal"  >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-trash"  page-title="Delete Rule"></panda-modal-header>
        </div>
        <div class="modal-body">
            
            <div class="row text-left indent lh-30" >
                <div class="form-group has-error col-md-2 col-sm-2  col-xs-2 " >

                    <img src="images/warning.png" alt="">
                </div>
                
               Please confirm that you want to delete rule.

                
            </div>

         <!--    <div class="text-center" data-ng-show="deleteRule">
                <span>Please wait</span><br/>
                <span><img src="images/loading-bars.svg" /> </span>
            </div> -->
        
        </div>

        <div class="modal-footer" >

            <span class="pull-right">
                <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="cancel()">No</button>
                <button type="button" class="btn btn-info" ng-click="doDelete()">Yes</button>
            </span>

        </div>
      
    </div>
</form>