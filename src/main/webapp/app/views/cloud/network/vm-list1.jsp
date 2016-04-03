<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
  <div class="inmodal" ng-controller="networksCtrl"   >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-cloud" page-title="Add VMs"></panda-modal-header>
            
        </div>
        <div class="modal-body">
            <div class="row">
                
<div  ng-controller="networksCtrl">
        <div class="hpanel">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-md-3 col-sm-3 col-xs-3 ">
                        <div class="quick-search">
                            <div class="input-group">
                                <input data-ng-model="instanceSearch" type="text" class="form-control input-medium" placeholder="Quick Search" aria-describedby="quicksearch-go">
                                <span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
                            </div>
                        </div>
                    </div>
                   
                </div>
               <div class="clearfix"></div>
            </div>
            
            <div class="white-content">
                <div class="table-responsive">
                    <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
                    <thead>
                    <tr>
                         <th>Name </th>
                       <th>Internal Name</th>
                        <th>Display Name</th>
                        <th>Zone</th>
                        <th>State</th>
                        <th>Select</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr data-ng-repeat="instance in vmList | filter: instanceSearch">
                        <td>
                            <a class="text-info" >{{ instance.name }}</a>
                             <div  data-ng-if="instance.selected" > {{ instance.ipAddress}}</div>
                            <input type="hidden" data-ng-model="instances.id" value="{{ instance.id }}"/>
                            <input type="hidden" data-ng-model="instances.name" value="{{ instance.name }}"/>
                        </td>
                  		 <td>{{ instance.instanceInternalName}}</td>
                        <td>{{ instance.displayName }}</td>
                        <td>{{ instance.zone.name }}  
                         <input type="hidden" data-ng-model="instances.zoneName" value="{{ instance.zone.name }}"/></td>
                        <td>
                            <label class="label label-success" data-ng-if="instance.status == 'Running'">{{ instance.status }}</label>
                            <label class="label label-danger" data-ng-if="instance.status == 'Stopped'">{{ instance.status }}</label>
                           <input type="hidden" data-ng-model="instance.status" value="{{ instance.status }}"/>
                        </td>
                         <td>
                            <label class="">
                      <div  style="position: relative;" >
                                 <input type="radio" icheck data-ng-model="instance.selected" value ="{{instance.name}}"  name="selectvm">
                             </div>
                            </label>
                            <!--<label class=""> <div class="icheckbox_square-green" style="position: relative;"><input icheck="" type="checkbox" ng-model="template.extractable" class="ng-pristine ng-untouched ng-valid" style="position: absolute; opacity: 0;"><ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background-color: rgb(255, 255, 255); border: 0px; opacity: 0; background-position: initial initial; background-repeat: initial initial;"></ins></div> Extractable </label>-->
                        </td>
                    </tr>
                    </tbody>
                </table>
                </div>
            </div>
        </div>
    </div>
            </div></div>
  <div class="modal-footer">
            
         
            <a class="btn btn-default"  data-ng-click="cancel()">Cancel</a>
            <a class="btn btn-info" data-ng-click="addPort()">Apply</a>


        </div>
  </div>