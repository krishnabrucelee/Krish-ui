<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
  <div class="inmodal"  >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-cloud" page-title="Add VMs"></panda-modal-header>
        </div>
        <div class="modal-body">
        <div class="row">
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
                             <!-- <div  data-ng-if="instance.selected" > {{ instance.ipAddress}}</div> -->
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
                                     <input type="radio" icheck data-ng-model="instance.selected" data-ng-checked="setVM(instance)" value ="{{instance.name}}"  name="selectvm">
                                 </div>
                            </label>
                        </td>
                    </tr>
                    </tbody>
                </table>
                </div>
            </div>
        </div>
        </div>
        </div>
      <div class="modal-footer">
			<get-loader-image data-ng-show="showLoader"></get-loader-image>
            <a class="btn btn-default"  data-ng-click="cancel()">Cancel</a>
            <a class="btn btn-info" data-ng-click="portforwardSave(instances)">Apply</a>
      </div>
  </div>