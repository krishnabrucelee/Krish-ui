<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<form name="resourceAllocationForm" data-ng-submit="save(resourceAllocationForm)" method="post" novalidate="" data-ng-controller="resourceAllocationCtrl">

    <div class="row">
        <div class="col-md-12 col-sm-12">
            <div class="hpanel">
                <div class="panel-heading">

                    <div class="clearfix"></div>
                </div>
                <div class="panel-body">
                    <div class="col-md-12 col-sm-12 m-b-md border-bottom">
						<input type="hidden" data-ng-model="resourceQuota.domain" />
<!-- 						<input type="hidden" data-ng-model="type" /> -->

                        <div class="col-md-4 col-sm-4" data-ng-if="type == 'department-quota'" >
                            <div class="form-group">

                                <div class="row">
                                    <label class="col-md-4 col-sm-4 control-label"><fmt:message key="common.department" bundle="${msg}" />:
                                    </label>
                                    <div class="col-md-8 col-sm-8">
                                        <!-- <select   class="form-control input-group" name="department" data-ng-disabled="true" data-ng-model="resourceQuota.department" ng-options="department.userName for department in departmentList" >
                                            <option value="">Select</option>
                                        </select> -->
                                       <label> {{resourceQuota.department.userName}}</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                          <div class="col-md-4 col-sm-4" data-ng-if="type == 'project-quota'">
                            <div class="form-group">
                                <div class="row" >
                                    <label class="col-md-4 col-sm-4 control-label"><fmt:message key="common.project" bundle="${msg}" />:
                                    </label>
                                    <div class="col-md-8 col-sm-8">

                                        <!-- <select  class="form-control input-group"  data-ng-disabled="true"  name="project"   data-ng-model="resourceQuota.project" ng-options="project.name for project in projectList" >
                                            <option value="">Select</option>
                                        </select> -->
                                          <label> {{resourceQuota.project.name}}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
				<get-loader-image data-ng-show="showLoader"></get-loader-image>

				<div class="row" data-ng-if="resource=='domain'|| type == 'domain-quota' || resource=='department' || resource=='project'" >
						<div class="col-md-8 col-sm-8">
							<table cellspacing="1" cellpadding="1" class="table table-bordered table-striped" >
			                    <thead class="bg-info">
			           		<tr data-ng-if="resource=='domain'|| type == 'domain-quota'">
			                    <th  class="text-center">
                                	<label> Quota Type</label></th>
                                	<th  class="text-center">Limit</th>
			                        <th>
			                        	<label> Department Available</label>
			                        </th>
			                        <th>
			                        	<label> Project Available</label>
			                        </th>
			                    </tr>
			           <tr data-ng-if="resource=='department'">
			                    <th  class="text-center">
                                	<label> Quota Type</label></th>
                                	<th  class="text-center">Limit</th>
			                        <th  class="text-center">
			                        	<label> Domain Available</label>
			                        </th>
			                        <th  class="text-center">
			                        	<label> Project Available</label>
			                        </th>
			                    </tr>
			          <tr data-ng-if="resource=='project'">
			                    <th  class="text-center">
                                	<label> Quota Type</label></th>
                                	<th  class="text-center">Limit</th>
			                        <th  class="text-center">
			                        	<label> Domain Available</label>
			                        </th>
			                        <th  class="text-center">
			                        	<label> Department Available</label>
			                        </th>
			                    </tr>
			                    </thead>
			                    <tbody>
			                    <tr>
			  						<td>
			                         	<label><fmt:message key="max.volumes" bundle="${msg}" />:
		                                  	<span class="text-danger">*</span></label>
	                                </td>
	                                <td>
	                                	<div class="col-md-8 col-sm-8">
		                                  <input required="true" type="text" valid-integer name="Volume" data-ng-model="resourceQuota.Volume"  class="form-control" data-ng-class="{'error': resourceAllocationForm.Volume.$invalid && formSubmitted}">
		                                  <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.volumes.to.be.allocated" bundle="${msg}" />" ></i>
		                                  	<div class="error-area" data-ng-show="resourceAllocationForm.Volume.$invalid && formSubmitted" >
		                                  		<i  ng-attr-tooltip="{{ resourceAllocationForm.Volume.errorMessage || '<fmt:message key="max.volumes.are.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
	      		         					</div>
      		         					</div>
		   							</td>
									<td>
                                		<div data-ng-if="resource=='domain' || type == 'domain-quota'" >
											<label><span>{{resourceDepartmentCount.Volume || '-' }}</span></label>
                                		</div>
                                 		<div data-ng-if="resource=='department'" >
											<label>
												<span data-ng-if="(resourceDomainCount.Volume - resourceDepartmentCount.Volume) < -1 ">{{'0'}}</span>
												<span data-ng-if="(resourceDomainCount.Volume - resourceDepartmentCount.Volume) >= -1 ">{{(resourceDomainCount.Volume - resourceDepartmentCount.Volume) || '-' }}</span>
                               				</label>
                                		</div>
                                   		<div data-ng-if="resource=='project'" >
											<label>
												<span data-ng-if="(resourceDomainCount.Volume - resourceDepartmentCount.Volume) < -1 ">{{'0'}}</span>
												<span data-ng-if="(resourceDomainCount.Volume - resourceDepartmentCount.Volume) >= -1 ">{{(resourceDomainCount.Volume - resourceDepartmentCount.Volume) || '-' }}</span>
                                			</label>
                                		</div>

								</td>
			    				<td>
                                	<div data-ng-if="resource=='domain' || type == 'domain-quota'" >
										<label>
											<span>{{resourceProjectCount.Volume || '-' }}</span>
										</label>
                                	</div>
                                 	<div data-ng-if="resource=='department'" >
										<label>
											<span>{{resourceProjectCount.Volume || '-' }}</span>
										</label>
                                	</div>
                                   	<div data-ng-if="resource=='project'" >
										<label>
											<span data-ng-if="(resourceDepartmentCount.Volume - resourceProjectCount.Volume) < -1 ">{{'0'}}</span>
											<span data-ng-if="(resourceDepartmentCount.Volume - resourceProjectCount.Volume) >= -1 ">{{(resourceDepartmentCount.Volume - resourceProjectCount.Volume) || '-' }}</span></b></label>
                                		</label>
                                	</div>
							</td>
			       		</tr>
	                    <tr>
	                        <td>
	                        	<label><fmt:message key="max.user.vms" bundle="${msg}" />:
                                   <span class="text-danger">*</span>
                               	</label>
                            </td>
                            <td>
                                <div class="col-md-8 col-sm-8">
                                    <input required="true" type="text" valid-integer is-number name="Instance" data-ng-model="resourceQuota.Instance"  class="form-control" data-ng-class="{'error': resourceAllocationForm.Instance.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.user.vms.to.be.allocated" bundle="${msg}" />"></i>
                                    <div class="error-area" data-ng-show="resourceAllocationForm.Instance.$invalid && formSubmitted" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.Instance.errorMessage || '<fmt:message key="max.user.vms.are.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
	                        </td>
			                <td>
								<div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
										<span>{{resourceDepartmentCount.Volume || '-' }}</span>
									</label>
                                </div>
                                 <div data-ng-if="resource=='department'" >
                                	<label>
										<span data-ng-if="(resourceDomainCount.Volume - resourceDepartmentCount.Volume) < -1 ">{{'0'}}</span>
										<span data-ng-if="(resourceDomainCount.Volume - resourceDepartmentCount.Volume) >= -1 ">{{(resourceDomainCount.Volume - resourceDepartmentCount.Volume) || '-' }}</span>
									</label>
                                </div>
                                   <div data-ng-if="resource=='project'" >
                                	<label>
										<span data-ng-if="(resourceDomainCount.Volume - resourceDepartmentCount.Volume) < -1 ">{{'0'}}</span>
										<span data-ng-if="(resourceDomainCount.Volume - resourceDepartmentCount.Volume) >= -1 ">{{(resourceDomainCount.Volume - resourceDepartmentCount.Volume) || '-' }}</span>
									</label>
                                </div>
			                </td>
			             	<td>
							<div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
										<span>{{resourceProjectCount.Volume || '-' }}</span>
									</label>
                                </div>
                                 <div data-ng-if="resource=='department'" >
                                	<label>
										<span>{{resourceProjectCount.Volume || '-' }}</span>
									</label>
                                </div>
                                   <div data-ng-if="resource=='project'" >
                                	<label>
										<span data-ng-if="(resourceDepartmentCount.Volume - resourceProjectCount.Volume) < -1 ">{{'0'}}</span>
										<span data-ng-if="(resourceDepartmentCount.Volume - resourceProjectCount.Volume) >= -1 ">{{(resourceDepartmentCount.Volume - resourceProjectCount.Volume) || '-' }}</span>
									</label>
                                </div>

							</td>
			           	</tr>
			 			<tr>
			            	<td>
                                <label><fmt:message key="max.templates" bundle="${msg}" />:
                                    <span class="text-danger">*</span>
                                	</label>
                            </td>
                            <td>
                                <div class="col-md-8 col-sm-8">
                                    <input required="true" type="text" valid-integer name="Template" data-ng-model="resourceQuota.Template"  class="form-control" data-ng-class="{'error': resourceAllocationForm.Template.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.templates.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="resourceAllocationForm.Template.$invalid && formSubmitted" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.Template.errorMessage || '<fmt:message key="max.templates.are.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
							</td>
							<td>
                                <div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
										<span>{{resourceDepartmentCount.Template || '-' }}</span>
									</label>
                                </div>
                                <div data-ng-if="resource=='department'" >
                                	<label>
										<span data-ng-if="(resourceDomainCount.Template - resourceDepartmentCount.Template) < -1 ">{{'0'}}</span>
										<span data-ng-if="(resourceDomainCount.Template - resourceDepartmentCount.Template) >= -1 ">{{(resourceDomainCount.Template - resourceDepartmentCount.Template) || '-' }}</span>
									</label>
                                </div>
                                  <div data-ng-if="resource=='project'" >
                                	<label>
										<span data-ng-if="(resourceDomainCount.Template - resourceDepartmentCount.Template) < -1 ">{{'0'}}</span>
										<span data-ng-if="(resourceDomainCount.Template - resourceDepartmentCount.Template) >= -1 ">{{(resourceDomainCount.Template - resourceDepartmentCount.Template) || '-' }}</span>
									</label>
                                </div>
							</td>
			            	<td>
                                <div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
										<span>{{resourceProjectCount.Template || '-' }}</span>
									</label>
                                </div>
                                <div data-ng-if="resource=='department'" >

                                	<label>
										<span>{{resourceProjectCount.Template || '-' }}</span>
									</label>
                                </div>
                                  <div data-ng-if="resource=='project'" >
                                	<label>
										<span data-ng-if="(resourceDepartmentCount.Template - resourceProjectCount.Template) < -1 ">{{'0'}}</span>
										<span data-ng-if="(resourceDepartmentCount.Template - resourceProjectCount.Template) >= -1 ">{{(resourceDepartmentCount.Template - resourceProjectCount.Template) || '-' }}</span>
									</label>
                                </div>
			            	</td>
			        	</tr>
			       		<tr>
			    			<td>
                                <label><fmt:message key="max.networks" bundle="${msg}" />:
                                    <span class="text-danger">*</span>
                                	</label>
                            </td>
                            <td>
                                <div class="col-md-8 col-sm-8">
                                    <input required="true" type="text" valid-integer name="Network" data-ng-model="resourceQuota.Network"  class="form-control" data-ng-class="{'error': resourceAllocationForm.Network.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.networks.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="resourceAllocationForm.Network.$invalid && formSubmitted" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.Network.errorMessage || '<fmt:message key="max.networks.are.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
							</td>
			             	<td>
								<div  data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
										<span>{{resourceDepartmentCount.Network || '-' }}</span>
									</label>
                                </div>
                                 <div data-ng-if="resource=='department'" >
                                	<label>
										<span data-ng-if="(resourceDomainCount.Network - resourceDepartmentCount.Network) < -1 ">{{'0'}}</span>
										<span data-ng-if="(resourceDomainCount.Network - resourceDepartmentCount.Network) >= -1 ">{{(resourceDomainCount.Network - resourceDepartmentCount.Network) || '-' }}</span>
									</label>
                                </div>
                                  <div data-ng-if="resource=='project'">
                                	<label>
										<span data-ng-if="(resourceDomainCount.Network - resourceDepartmentCount.Network) < -1 ">{{'0'}}</span>
										<span data-ng-if="(resourceDomainCount.Network - resourceDepartmentCount.Network) >= -1 ">{{(resourceDomainCount.Network - resourceDepartmentCount.Network) || '-' }}</span>
									</label>
                                </div>
							</td>
			        		<td>
								<div  data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
										<span>{{resourceProjectCount.Network || '-' }}</span>
									</label>
                                </div>
                                 <div data-ng-if="resource=='department'" >
                                	<label>
										<span>{{resourceProjectCount.Network || '-' }}</span>
									</label>
                                </div>
                                  <div data-ng-if="resource=='project'" >
                                	<label>
										<span data-ng-if="(resourceDepartmentCount.Network - resourceProjectCount.Network) < -1 ">{{'0'}}</span>
										<span data-ng-if="(resourceDepartmentCount.Network - resourceProjectCount.Network) >= -1 ">{{(resourceDepartmentCount.Network - resourceProjectCount.Network) || '-' }}</span>
									</label>
                                </div>
							</td>
			          	</tr>
			            <tr>
			           		<td>

                               <label><fmt:message key="max.snapshots" bundle="${msg}" />:
                                    <span class="text-danger">*</span>
                                </label>
                          </td>
                            <td>
                                <div class="col-md-8 col-sm-8">
                                    <input required="true" type="text" valid-integer name="Snapshot" data-ng-model="resourceQuota.Snapshot"  class="form-control" data-ng-class="{'error': resourceAllocationForm.Snapshot.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.snapshots.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="resourceAllocationForm.Snapshot.$invalid && formSubmitted" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.Snapshot.errorMessage || '<fmt:message key="max.snapshots.are.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
			           		</td>
			                <td>
                                 <div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
										<span>{{resourceDepartmentCount.Snapshot || '-' }}</span>
									</label>
                                </div>
                                <div data-ng-if="resource=='department'" >
                                	<label>
										<span data-ng-if="(resourceDomainCount.Snapshot - resourceDepartmentCount.Snapshot) < -1 ">{{'0'}}</span>
										<span data-ng-if="(resourceDomainCount.Snapshot - resourceDepartmentCount.Snapshot) >= -1 ">{{(resourceDomainCount.Snapshot - resourceDepartmentCount.Snapshot) || '-' }}</span>
									</label>
                                </div>
                                <div data-ng-if="resource=='project'" >
                                	<label>
										<span data-ng-if="(resourceDomainCount.Snapshot - resourceDepartmentCount.Snapshot) < -1 ">{{'0'}}</span>
										<span data-ng-if="(resourceDomainCount.Snapshot - resourceDepartmentCount.Snapshot) >= -1 ">{{(resourceDomainCount.Snapshot - resourceDepartmentCount.Snapshot) || '-' }}</span>
									</label>
                                </div>
			                </td>
			             	<td>
  								<div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                               		<label>
										<span>{{resourceProjectCount.Snapshot || '-' }}</span>
									</label>
                                </div>
                                <div data-ng-if="resource=='department'" >
                                	<label>
										<span>{{resourceProjectCount.Snapshot || '-' }}</span>
									</label>
                                </div>
                                <div data-ng-if="resource=='project'" >
                                	<label>
										<span data-ng-if="(resourceDepartmentCount.Snapshot - resourceProjectCount.Snapshot) < -1 ">{{'0'}}</span>
										<span data-ng-if="(resourceDepartmentCount.Snapshot - resourceProjectCount.Snapshot) >= -1 ">{{(resourceDepartmentCount.Snapshot - resourceProjectCount.Snapshot) || '-' }}</span></b></label>
                                </div>
			             	</td>
			          	</tr>
			            <tr>
			               	<td>
								<label><fmt:message key="max.public.ips" bundle="${msg}" />:
                                    <span class="text-danger">*</span>
                                	</label>
                            </td>
                            <td>
                                <div class="col-md-8 col-sm-8">
                                    <input required="true" type="text" valid-integer name="IP" data-ng-model="resourceQuota.IP"  class="form-control" data-ng-class="{'error': resourceAllocationForm.IP.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.public.ips.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="resourceAllocationForm.IP.$invalid && formSubmitted" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.IP.errorMessage || '<fmt:message key="max.public.ips.are.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                    </div>
							</td>
			                <td>
                                    <div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
									<span>{{resourceDepartmentCount.IP || '-' }}</span>
									</b></label>
                                </div>
                                  <div data-ng-if="resource=='department'" >
                                	<label>
									<span data-ng-if="(resourceDomainCount.IP - resourceDepartmentCount.IP) < -1 ">{{'0'}}</span>
									<span data-ng-if="(resourceDomainCount.IP - resourceDepartmentCount.IP) >= -1 ">{{(resourceDomainCount.IP - resourceDepartmentCount.IP) || '-' }}</span>
									</b></label>
                                </div>
                                 <div data-ng-if="resource=='project'" >
                                	<label>
									<span data-ng-if="(resourceDomainCount.IP - resourceDepartmentCount.IP) < -1 ">{{'0'}}</span>
									<span data-ng-if="(resourceDomainCount.IP - resourceDepartmentCount.IP) >= -1 ">{{(resourceDomainCount.IP - resourceDepartmentCount.IP) || '-' }}</span>
									</b></label>
                                </div>
			                </td>
			                <td>
                                    <div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
									<span>{{resourceProjectCount.IP || '-' }}</span></b></label>
                                </div>
                                  <div data-ng-if="resource=='department'" >
                                	<label>
									<span>{{resourceProjectCount.IP || '-' }}</span></b></label>
                                </div>
                                 <div data-ng-if="resource=='project'" >
                                	<label>
									<span data-ng-if="(resourceDepartmentCount.IP - resourceProjectCount.IP) < -1 ">{{'0'}}</span>
									<span data-ng-if="(resourceDepartmentCount.IP - resourceProjectCount.IP) >= -1 ">{{(resourceDepartmentCount.IP - resourceProjectCount.IP) || '-' }}</span></b></label>
                                </div>
							</td>
			          	</tr>
			          	<tr>
			               	<td>
								<label><fmt:message key="max.vpcs" bundle="${msg}" />:
                                    <span class="text-danger">*</span>
                               		</label>
                                </td>
                            <td>
                                <div class="col-md-8 col-sm-8">
                                    <input required="true" type="text" valid-integer name="VPC" data-ng-model="resourceQuota.VPC"  class="form-control" data-ng-class="{'error': resourceAllocationForm.VPC.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.vpcs.to.be.allocated" bundle="${msg}" />"></i>
                                    <div class="error-area" data-ng-show="resourceAllocationForm.VPC.$invalid && formSubmitted" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.VPC.errorMessage || '<fmt:message key="max.vpcs.are.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
							</td>
			                <td>
                                <div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
									<span>{{resourceDepartmentCount.VPC || '-' }}</span>
									</b></label>
                                </div>
                                <div data-ng-if="resource=='department'">
                                	<label>
									<span data-ng-if="(resourceDomainCount.VPC - resourceDepartmentCount.VPC) < -1 ">{{'0'}}</span>
									<span data-ng-if="(resourceDomainCount.VPC - resourceDepartmentCount.VPC) >= -1 ">{{(resourceDomainCount.VPC - resourceDepartmentCount.VPC) || '-' }}</span>
									</b></label>
                                </div>
                                <div data-ng-if="resource=='project'" >
                                	<label>
									<span data-ng-if="(resourceDomainCount.VPC - resourceDepartmentCount.VPC) < -1 ">{{'0'}}</span>
									<span data-ng-if="(resourceDomainCount.VPC - resourceDepartmentCount.VPC) >= -1 ">{{(resourceDomainCount.VPC - resourceDepartmentCount.VPC) || '-' }}</span>
									</b></label>
                                </div>
			                </td>
			                <td>
                                <div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
									<span>{{resourceProjectCount.VPC || '-' }}</span></b></label>
                                </div>
                                <div data-ng-if="resource=='department'" >
                                	<label>
									<span>{{resourceProjectCount.VPC || '-' }}</span></b></label>
                                </div>
                                <div data-ng-if="resource=='project'" >
                                	<label>
									<span data-ng-if="(resourceDepartmentCount.VPC - resourceProjectCount.VPC) < -1 ">{{'0'}}</span>
									<span data-ng-if="(resourceDepartmentCount.VPC - resourceProjectCount.VPC) >= -1 ">{{(resourceDepartmentCount.VPC - resourceProjectCount.VPC) || '-' }}</span></b></label>
                                </div>
							</td>
			          	</tr>
			          	<tr>
			               	<td>
                                <label><fmt:message key="max.cpu.cores" bundle="${msg}" />:
                                    <span class="text-danger">*</span>
                                </label>
							</td>
                            <td>
                                <div class="col-md-8 col-sm-8">
                                    <input required="true" type="text" valid-integer name="CPU" data-ng-model="resourceQuota.CPU"  class="form-control" data-ng-class="{'error': resourceAllocationForm.CPU.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.cpu.cores.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="resourceAllocationForm.CPU.$invalid && formSubmitted" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.CPU.errorMessage || '<fmt:message key="max.cpu.cores.are.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i></div>
                                </div>
							</td>
			                <td>
                                 <div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
									<span>{{resourceDepartmentCount.CPU || '-' }}</span>
									</b></label>
                                </div>
                                  <div data-ng-if="resource=='department'" >
                                	<label>
									<span data-ng-if="(resourceDomainCount.CPU - resourceDepartmentCount.CPU) < -1 ">{{'0'}}</span>
									<span data-ng-if="(resourceDomainCount.CPU - resourceDepartmentCount.CPU) >= -1 ">{{(resourceDomainCount.CPU - resourceDepartmentCount.CPU) || '-' }}</span>
									</b></label>
                                </div>
                                 <div data-ng-if="resource=='project'" >
                                	<label>
									<span data-ng-if="(resourceDomainCount.CPU - resourceDepartmentCount.CPU) < -1 ">{{'0'}}</span>
									<span data-ng-if="(resourceDomainCount.CPU - resourceDepartmentCount.CPU) >= -1 ">{{(resourceDomainCount.CPU - resourceDepartmentCount.CPU) || '-' }}</span>
									</b></label>
                                </div>
			                </td>
			                <td>
                                 <div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
									<span>{{resourceProjectCount.CPU || '-' }}</span></b></label>
                                </div>
                                  <div data-ng-if="resource=='department'" >
                                	<label>
									<span>{{resourceProjectCount.CPU || '-' }}</span></b></label>
                                </div>
                                 <div data-ng-if="resource=='project'" >
                                	<label>
									<span data-ng-if="(resourceDepartmentCount.CPU - resourceProjectCount.CPU) < -1 ">{{'0'}}</span>
									<span data-ng-if="(resourceDepartmentCount.CPU - resourceProjectCount.CPU) >= -1 ">{{(resourceDepartmentCount.CPU - resourceProjectCount.CPU) || '-' }}</span></b></label>
                                </div>
							</td>
			          	</tr>
			          	<tr>
			               	<td>
                                <label><fmt:message key="max.memory" bundle="${msg}" /> (MiB):
                                    <span class="text-danger">*</span>
                                </label>
							</td>
                            <td>
                                <div class="col-md-8 col-sm-8">
                                    <input required="true" type="text" valid-integer name="Memory" data-ng-model="resourceQuota.Memory"  class="form-control" data-ng-class="{'error': resourceAllocationForm.Memory.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.memory.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="resourceAllocationForm.Memory.$invalid && formSubmitted" >
                                    <i  ng-attr-tooltip="{{ resourceAllocationForm.Memory.errorMessage || '<fmt:message key="max.memory.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i></div>
                                </div>
							</td>
			                <td>
                                  <div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
									<span>{{resourceDepartmentCount.Memory || '-' }}</span>
									</b></label>
                                </div>
                                  <div data-ng-if="resource=='department'" >
                                	<label>
									<span data-ng-if="(resourceDomainCount.Memory - resourceDepartmentCount.Memory) < -1 ">{{'0'}}</span>
									<span data-ng-if="(resourceDomainCount.Memory - resourceDepartmentCount.Memory) >= -1 ">{{(resourceDomainCount.Memory - resourceDepartmentCount.Memory) || '-' }}</span>
									</b></label>
                                </div>
                                <div data-ng-if="resource=='project'" >
                                	<label>
									<span data-ng-if="(resourceDomainCount.Memory - resourceDepartmentCount.Memory) < -1 ">{{'0'}}</span>
									<span data-ng-if="(resourceDomainCount.Memory - resourceDepartmentCount.Memory) >= -1 ">{{(resourceDomainCount.Memory - resourceDepartmentCount.Memory) || '-' }}</span>
									</b></label>
                                </div>
			                </td>
			                <td>
                                  <div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
									<span>{{resourceProjectCount.Memory || '-' }}</span></b></label>
                                </div>
                                  <div data-ng-if="resource=='department'" >
                                	<label>
									<span>{{resourceProjectCount.Memory || '-' }}</span></b></label>
                                </div>
                                <div data-ng-if="resource=='project'" >
                                	<label>
									<span data-ng-if="(resourceDepartmentCount.Memory - resourceProjectCount.Memory) < -1 ">{{'0'}}</span>
									<span data-ng-if="(resourceDepartmentCount.Memory - resourceProjectCount.Memory) >= -1 ">{{(resourceDepartmentCount.Memory - resourceProjectCount.Memory) || '-' }}</span></b></label>
                                </div>
							</td>
			          	</tr>
			          	<tr>
			               	<td>
								<label><fmt:message key="max.primary" bundle="${msg}" /> (GiB):
                                    <span class="text-danger">*</span>
                                </label>
							</td>
                            <td>
                                <div class="col-md-8 col-sm-8">
                                    <input required="true" type="text" valid-integer name="PrimaryStorage" data-ng-model="resourceQuota.PrimaryStorage"  class="form-control" data-ng-class="{'error': resourceAllocationForm.PrimaryStorage.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.primary.storage.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="resourceAllocationForm.PrimaryStorage.$invalid && formSubmitted" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.PrimaryStorage.errorMessage || '<fmt:message key="max.primary.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
							</td>
			                <td>
								<div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
									<span>{{resourceDepartmentCount.PrimaryStorage || '-' }}</span>
									</b></label>
                                </div>
                                <div data-ng-if="resource=='department'" >
                                	<label>
									<span data-ng-if="(resourceDomainCount.PrimaryStorage - resourceDepartmentCount.PrimaryStorage) < -1 ">{{'0'}}</span>
									<span data-ng-if="(resourceDomainCount.PrimaryStorage - resourceDepartmentCount.PrimaryStorage) >= -1 ">{{(resourceDomainCount.PrimaryStorage - resourceDepartmentCount.PrimaryStorage) || '-' }}</span>
									</b></label>
                                </div>
                                   <div data-ng-if="resource=='project'" >
                                	<label>
									<span data-ng-if="(resourceDomainCount.PrimaryStorage - resourceDepartmentCount.PrimaryStorage) < -1 ">{{'0'}}</span>
									<span data-ng-if="(resourceDomainCount.PrimaryStorage - resourceDepartmentCount.PrimaryStorage) >= -1 ">{{(resourceDomainCount.PrimaryStorage - resourceDepartmentCount.PrimaryStorage) || '-' }}</span>
									</b></label>
                                </div>
			                </td>
			                <td>
								<div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
									<span>{{resourceProjectCount.PrimaryStorage || '-' }}</span></b></label>
                                </div>
                                <div data-ng-if="resource=='department'" >
                                	<label>
									<span>{{resourceProjectCount.PrimaryStorage || '-' }}</span></b></label>
                                </div>
                                   <div data-ng-if="resource=='project'" >
                                	<label>
									<span data-ng-if="(resourceDepartmentCount.PrimaryStorage - resourceProjectCount.PrimaryStorage) < -1 ">{{'0'}}</span>
									<span data-ng-if="(resourceDepartmentCount.PrimaryStorage - resourceProjectCount.PrimaryStorage) >= -1 ">{{(resourceDepartmentCount.PrimaryStorage - resourceProjectCount.PrimaryStorage) || '-' }}</span></b></label>
                                </div>
							</td>
			          	</tr>
			            <tr>
			               	<td>
								<label><fmt:message key="max.secondary" bundle="${msg}" /> (GiB):
                                    <span class="text-danger">*</span>
                                </label>
							</td>
                            <td>
                                <div class="col-md-8 col-sm-8">
                                    <input required="true" type="text" valid-integer name="SecondaryStorage" data-ng-model="resourceQuota.SecondaryStorage"  class="form-control" data-ng-class="{'error': resourceAllocationForm.SecondaryStorage.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.secondary.storage.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="resourceAllocationForm.SecondaryStorage.$invalid && formSubmitted" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.SecondaryStorage.errorMessage || '<fmt:message key="max.secondary.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i></div>
                                </div>
							</td>
			                <td>
                             <div data-ng-if="resource=='domain'|| type == 'domain-quota'">
                                	<label>
									<span>{{resourceDepartmentCount.SecondaryStorage || '-'}}</span>
									</label>
                                </div>
                                <div data-ng-if="resource=='department'" >
                                	<label>
									<span data-ng-if="(resourceDomainCount.SecondaryStorage - resourceDepartmentCount.SecondaryStorage) < -1 ">{{'0'}}</span>
									<span data-ng-if="(resourceDomainCount.SecondaryStorage - resourceDepartmentCount.SecondaryStorage) >= -1 ">{{(resourceDomainCount.SecondaryStorage - resourceDepartmentCount.SecondaryStorage) || '-'}}</span>
									</label>
                                </div>
                                 <div data-ng-if="resource=='project'">
                                	<label>
									<span data-ng-if="(resourceDomainCount.SecondaryStorage - resourceDepartmentCount.SecondaryStorage) < -1 ">{{'0'}}</span>
									<span data-ng-if="(resourceDomainCount.SecondaryStorage - resourceDepartmentCount.SecondaryStorage) >= -1 ">{{(resourceDomainCount.SecondaryStorage - resourceDepartmentCount.SecondaryStorage) || '-'}}</span>
									</label>
                                </div>
			                </td>
			                <td>
                             <div data-ng-if="resource=='domain'|| type == 'domain-quota'" >
                                	<label>
									<span>{{resourceProjectCount.SecondaryStorage || '-'}}</span></label>
                                </div>
                                <div data-ng-if="resource=='department'">
                                	<label>
									<span>{{resourceProjectCount.SecondaryStorage || '-'}}</span></label>
                                </div>
                                 <div data-ng-if="resource=='project'" >
                                	<label>
									<span data-ng-if="(resourceDepartmentCount.SecondaryStorage - resourceProjectCount.SecondaryStorage) < -1 ">{{'0'}}</span>
									<span data-ng-if="(resourceDepartmentCount.SecondaryStorage - resourceProjectCount.SecondaryStorage) >= -1 ">{{(resourceDepartmentCount.SecondaryStorage - resourceProjectCount.SecondaryStorage) || '-'}}</span></label>
                                </div>
							</td>
			          	</tr>
			           	<tr>
			        		<td colspan="4">
														<div class="form-group">
							<div class="row">
<%-- 						  <label class="col-sm-1 col-md-1 control-label"><fmt:message key="note" bundle="${msg}" /> :</label>
                            <div class="col-sm-4 col-md-3">
                                <div class="well ">
                              <fmt:message key="common.quota.note.display" bundle="${msg}" />
                                </div>
                            </div> --%>
								<get-loader-image data-ng-show="showLoader"></get-loader-image>
								<div class="col-md-4 col-sm-5" data-ng-hide="showLoader">
									<a class="btn btn-default btn-outline"
										data-ng-if="type == 'department-quota'" ui-sref="department""><fmt:message
											key="common.cancel" bundle="${msg}" /></a> <a
										class="btn btn-default btn-outline"
										data-ng-if="type == 'project-quota'" ui-sref="projects""><fmt:message
											key="common.cancel" bundle="${msg}" /> </a>

									<button data-ng-if="type == 'department-quota'"
										class="btn btn-info" has-permission="DEPARTMENT_QUOTA_EDIT"
										data-ng-hide="showLoader" type="submit">
										<fmt:message key="common.update" bundle="${msg}" />
									</button>
									<button data-ng-if="type == 'project-quota'"
										class="btn btn-info" has-permission="PROJECT_QUOTA_EDIT"
										type="submit">
										<fmt:message key="common.update" bundle="${msg}" />
									</button>
								</div>
							</div>
						</div>
			        		</td>
			        	</tr>
			        </tbody>
			                </table>
						</div>
						<div class="col-md-4 col-sm-4">
							<div class="alert alert-info">
								<label class="control-label"><fmt:message key="note" bundle="${msg}" /> :</label>
								<ul class="list-group">
									<li class="list-group-item">-1 indicates, Unlimited limit.</li>
									<li class="list-group-item"> 0 indicates, No quota available.</li>
									<li class="list-group-item">Department limit should not exceed company limit. </li>
									<li class="list-group-item">Project limit should not exceed department limit. </li>
								</ul>
							</div>
						</div>
					</div>
					</div>

				</div>
            </div>


        </div>
    </div>
    </form>