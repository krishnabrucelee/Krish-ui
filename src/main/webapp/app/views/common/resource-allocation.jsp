<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

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

				<div class="row" data-ng-if="resource=='domain'|| type == 'domain-quota' || resource=='department' || resource=='project'" >
						<div class="col-md-8 col-sm-8">
							<table cellspacing="1" cellpadding="1" class="table table-bordered table-striped" >
			                    <thead class="bg-info">
			           		<tr data-ng-if="resource=='domain'|| type == 'domain-quota'">
			                    <th  class="text-center">
                                	<label> <fmt:message key="quota.type" bundle="${msg}" /></label></th>
                                	<th  class="text-center"><fmt:message key="limit" bundle="${msg}" /></th>
			                        <th>
			                        	<label> <fmt:message key="minimum" bundle="${msg}" /></label>
			                        </th>
			                        <th>
			                        	<label> <fmt:message key="maximum" bundle="${msg}" /></label>
			                        </th>
			                    </tr>
			           <tr data-ng-if="resource=='department'">
			                    <th  class="text-center">
                                	<label> <fmt:message key="quota.type" bundle="${msg}" /></label></th>
                                	<th  class="text-center"><fmt:message key="department.limit" bundle="${msg}" /></th>
			                        <th>
			                        	<label> <fmt:message key="minimum" bundle="${msg}" /></label>
			                        </th>
			                        <th>
			                        	<label> <fmt:message key="maximum" bundle="${msg}" /></label>
			                        </th>
			                    </tr>
			          <tr data-ng-if="resource=='project'">
			                    <th  class="text-center">
                                	<label> <fmt:message key="quota.type" bundle="${msg}" /></label></th>
                                	<th  class="text-center"><fmt:message key="project.limit" bundle="${msg}" /></th>
			                       <th>
			                        	<label> <fmt:message key="minimum" bundle="${msg}" /></label>
			                        </th>
			                        <th>
			                        	<label> <fmt:message key="maximum" bundle="${msg}" /></label>
			                        </th>
			                    </tr>
			                    </thead>
			                    <tbody>

	                    <tr>
	                        <td>
	                        	<label><fmt:message key="max.user.vms" bundle="${msg}" />:
                                   <span class="text-danger">*</span>
                               	</label>
                            </td>
                            <td>
                                <div class="col-md-8 col-sm-8">
                                    <input required="true" type="text" valid-integer is-number name="Instance"
                                    data-ng-model="resourceQuota.Instance"  class="form-control"
                                    data-ng-class="{'error': (resourceAllocationForm.Instance.$invalid && formSubmitted || resourceAllocationField.Instance.$invalid)}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.user.vms.to.be.allocated" bundle="${msg}" />"></i>
                                    <div class="error-area" data-ng-show="((resourceAllocationForm.Instance.$invalid && formSubmitted) || resourceAllocationField.Instance.$invalid)" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.Instance.errorMessage || '<fmt:message key="max.user.vms.are.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
	                        </td>
			                <td>
								<div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
										<span>{{hasSumOfDomainMin.Instance || '0'}}</span>
									</label>
                                </div>
                                 <div data-ng-if="resource=='department'" >
                                	<label>
										<span>{{hasSumOfDepartmentMin.Instance || '0'}}</span>
									</label>
                                </div>
                                   <div data-ng-if="resource=='project'" >
                                	<label>
										<span>{{hasSumOfProjectMin.Instance || '0' }}</span>
									</label>
                                </div>
			                </td>
			             	<td>
							<div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
										<span>{{-1}}</span>
									</label>
                                </div>
                                 <div data-ng-if="resource=='department'" >
                                	<label>
										<span>{{hasSumOfDepartmentMax.Instance || '0' }}</span>
									</label>
                                </div>
                                   <div data-ng-if="resource=='project'" >
                                	<label>
										<span>{{hasSumOfProjectMax.Instance || '0' }}</span>
									</label>
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
                                    <input required="true" type="text" valid-integer name="CPU"
                                    data-ng-model="resourceQuota.CPU"  class="form-control"
                                    data-ng-class="{'error': (resourceAllocationForm.CPU.$invalid && formSubmitted  || resourceAllocationField.CPU.$invalid)}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.cpu.cores.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="((resourceAllocationForm.CPU.$invalid && formSubmitted)  || resourceAllocationField.CPU.$invalid)" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.CPU.errorMessage || '<fmt:message key="max.cpu.cores.are.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i></div>
                                </div>
							</td>
			                <td>
                                 <div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
									<span>{{hasSumOfDomainMin.CPU || '0' }}</span>
									</b></label>
                                </div>
                                  <div data-ng-if="resource=='department'" >
                                	<label>
									<span>{{hasSumOfDepartmentMin.CPU || '0' }}</span>
									</b></label>
                                </div>
                                 <div data-ng-if="resource=='project'" >
                                	<label>
									<span>{{hasSumOfProjectMin.CPU || '0' }}</span>
									</b></label>
                                </div>
			                </td>
			                <td>
                                 <div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
									<span>{{-1}}</span></b></label>
                                </div>
                                  <div data-ng-if="resource=='department'" >
                                	<label>
									<span>{{hasSumOfDepartmentMax.CPU || '0' }}</span></b></label>
                                </div>
                                 <div data-ng-if="resource=='project'" >
                                	<label>
									<span>{{hasSumOfProjectMax.CPU || '0' }}</span></b></label>
                                </div>
							</td>
			          	</tr>
			          	<tr>
			               	<td>
                                <label><fmt:message key="max.memory" bundle="${msg}" /> (GB):
                                    <span class="text-danger">*</span>
                                </label>
							</td>
                            <td>
                                 <div class="col-md-8 col-sm-8">
                                    <input required="true" type="text" valid-decimal name="Memory"
                                     data-ng-model="resourceQuota.Memory"  class="form-control"
                                     data-ng-class="{'error': (resourceAllocationForm.Memory.$invalid && formSubmitted || resourceAllocationField.Memory.$invalid)}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.memory.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="((resourceAllocationForm.Memory.$invalid && formSubmitted) || resourceAllocationField.Memory.$invalid)" >
                                    <i  ng-attr-tooltip="{{ resourceAllocationForm.Memory.errorMessage || '<fmt:message key="max.memory.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i></div>
                                </div>
							</td>
			                <td>
                                  <div data-ng-if="(resource=='domain' || type == 'domain-quota') && hasSumOfDomainMin.Memory != -1" >
                                	<label>
									<span>{{ global.Math.round((hasSumOfDomainMin.Memory),1) || '0' }}</span>
									</b></label>
                                  </div>
                                  <div data-ng-if="(resource=='domain' || type == 'domain-quota') && hasSumOfDomainMin.Memory == -1" >
                                	<label>
									<span>{{ hasSumOfDomainMin.Memory || '0' }}</span>
									</b></label>
                                  </div>
                                  <div data-ng-if="resource=='department' && hasSumOfDepartmentMin.Memory != -1" >
                                	<label>
									<span>{{ global.Math.round((hasSumOfDepartmentMin.Memory),1) || '0' }}</span>
									</b></label>
                                 </div>
                                 <div data-ng-if="resource=='department' && hasSumOfDepartmentMin.Memory == -1" >
                                	<label>
									<span>{{ hasSumOfDepartmentMin.Memory || '0' }}</span>
									</b></label>
                                 </div>
                                <div data-ng-if="resource=='project' && hasSumOfProjectMin.Memory != -1" >
                                	<label>
									<span>{{ global.Math.round((hasSumOfProjectMin.Memory),1) || '0' }}</span>
									</b></label>
                                </div>
                                <div data-ng-if="resource=='project' && hasSumOfProjectMin.Memory == -1" >
                                	<label>
									<span>{{ hasSumOfProjectMin.Memory || '0' }}</span>
									</b></label>
                                </div>
			                </td>
			                <td>
                                  <div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
									<span>{{-1}}</span></b></label>
                                  </div>
                                  <div data-ng-if="resource=='department' && hasSumOfDepartmentMax.Memory != -1" >
                                	<label>
									<span>{{ global.Math.round((hasSumOfDepartmentMax.Memory),1) || '0' }}</span></b></label>
                                  </div>
                                  <div data-ng-if="resource=='department' && hasSumOfDepartmentMax.Memory == -1" >
                                	<label>
									<span>{{ hasSumOfDepartmentMax.Memory || '0' }}</span></b></label>
                                  </div>
                                  <div data-ng-if="resource=='project' && hasSumOfProjectMax.Memory != -1" >
                                	<label>
									<span>{{ global.Math.round((hasSumOfProjectMax.Memory),1) || '0' }}</span></b></label>
                                  </div>
                                   <div data-ng-if="resource=='project' && hasSumOfProjectMax.Memory == -1" >
                                	<label>
									<span>{{ hasSumOfProjectMax.Memory || '0' }}</span></b></label>
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
                                    <input required="true" type="text" valid-integer name="Template"
                                    data-ng-model="resourceQuota.Template"  class="form-control"
                                    data-ng-class="{'error': (resourceAllocationForm.Template.$invalid && formSubmitted || resourceAllocationField.Template.$invalid)}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.templates.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="((resourceAllocationForm.Template.$invalid && formSubmitted) || resourceAllocationField.Template.$invalid)" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.Template.errorMessage || '<fmt:message key="max.templates.are.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
							</td>
							<td>
                                <div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
										<span>{{hasSumOfDomainMin.Template || '0'}}</span>
									</label>
                                </div>
                                <div data-ng-if="resource=='department'" >
                                	<label>
										<span>{{hasSumOfDepartmentMin.Template || '0' }}</span>
									</label>
                                </div>
                                  <div data-ng-if="resource=='project'" >
                                	<label>
										<span>{{hasSumOfProjectMin.Template || '0' }}</span>
									</label>
                                </div>
							</td>
			            	<td>
                                <div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
										<span>{{-1}}</span>
									</label>
                                </div>
                                <div data-ng-if="resource=='department'" >

                                	<label>
										<span>{{hasSumOfDepartmentMax.Template || '0' }}</span>
									</label>
                                </div>
                                  <div data-ng-if="resource=='project'" >
                                	<label>
										<span>{{hasSumOfProjectMax.Template || '0' }}</span>
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
                                    <input required="true" type="text" valid-integer name="Snapshot"
                                    data-ng-model="resourceQuota.Snapshot"  class="form-control"
                                    data-ng-class="{'error': (resourceAllocationForm.Snapshot.$invalid && formSubmitted  || resourceAllocationField.Snapshot.$invalid)}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.snapshots.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="((resourceAllocationForm.Snapshot.$invalid && formSubmitted)  || resourceAllocationField.Snapshot.$invalid)" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.Snapshot.errorMessage || '<fmt:message key="max.snapshots.are.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
			           		</td>
			                <td>
                                 <div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
										<span>{{hasSumOfDomainMin.Snapshot || '0' }}</span>
									</label>
                                </div>
                                <div data-ng-if="resource=='department'" >
                                	<label>
										<span>{{hasSumOfDepartmentMin.Snapshot || '0' }}</span>
									</label>
                                </div>
                                <div data-ng-if="resource=='project'" >
                                	<label>
										<span>{{hasSumOfProjectMin.Snapshot || '0' }}</span>
									</label>
                                </div>
			                </td>
			             	<td>
  								<div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                               		<label>
										<span>{{-1}}</span>
									</label>
                                </div>
                                <div data-ng-if="resource=='department'" >
                                	<label>
										<span>{{hasSumOfDepartmentMax.Snapshot || '0' }}</span>
									</label>
                                </div>
                                <div data-ng-if="resource=='project'" >
                                	<label>
										<span>{{hasSumOfProjectMax.Snapshot || '0' }}</span></b></label>
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
                                    <input required="true" type="text" valid-integer name="Network"
                                    data-ng-model="resourceQuota.Network"  class="form-control"
                                     data-ng-class="{'error': (resourceAllocationForm.Network.$invalid && formSubmitted  || resourceAllocationField.Network.$invalid)}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.networks.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="((resourceAllocationForm.Network.$invalid && formSubmitted)  || resourceAllocationField.Network.$invalid)" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.Network.errorMessage || '<fmt:message key="max.networks.are.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
							</td>
			             	<td>
								<div  data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
										<span>{{hasSumOfDomainMin.Network || '0' }}</span>
									</label>
                                </div>
                                 <div data-ng-if="resource=='department'" >
                                	<label>
										<span>{{hasSumOfDepartmentMin.Network || '0' }}</span>
									</label>
                                </div>
                                  <div data-ng-if="resource=='project'">
                                	<label>
										<span>{{hasSumOfProjectMin.Network || '0' }}</span>
									</label>
                                </div>
							</td>
			        		<td>
								<div  data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
										<span>{{-1}}</span>
									</label>
                                </div>
                                 <div data-ng-if="resource=='department'" >
                                	<label>
										<span>{{hasSumOfDepartmentMax.Network || '0' }}</span>
									</label>
                                </div>
                                  <div data-ng-if="resource=='project'" >
                                	<label>
										<span>{{hasSumOfProjectMax.Network || '0' }}</span>
									</label>
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
                                    <input required="true" type="text" valid-integer name="IP"
                                    data-ng-model="resourceQuota.IP"  class="form-control"
                                    data-ng-class="{'error': (resourceAllocationForm.IP.$invalid && formSubmitted  || resourceAllocationField.IP.$invalid)}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.public.ips.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="((resourceAllocationForm.IP.$invalid && formSubmitted)  || resourceAllocationField.IP.$invalid)" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.IP.errorMessage || '<fmt:message key="max.public.ips.are.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                    </div>
							</td>
			                <td>
                                    <div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
									<span>{{hasSumOfDomainMin.IP || '0' }}</span>
									</b></label>
                                </div>
                                  <div data-ng-if="resource=='department'" >
                                	<label>
									<span>{{hasSumOfDepartmentMin.IP || '0' }}</span>
									</b></label>
                                </div>
                                 <div data-ng-if="resource=='project'" >
                                	<label>
									<span>{{hasSumOfProjectMin.IP || '0' }}</span>
									</b></label>
                                </div>
			                </td>
			                <td>
                                    <div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
									<span>{{-1}}</span></b></label>
                                </div>
                                  <div data-ng-if="resource=='department'" >
                                	<label>
									<span>{{hasSumOfDepartmentMax.IP || '0' }}</span></b></label>
                                </div>
                                 <div data-ng-if="resource=='project'" >
                                	<label>
									<span>{{hasSumOfProjectMax.IP || '0' }}</span></b></label>
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
                                    <input required="true" type="text" valid-integer name="VPC"
                                    data-ng-model="resourceQuota.VPC"  class="form-control"
                                    data-ng-class="{'error': (resourceAllocationForm.VPC.$invalid && formSubmitted  || resourceAllocationField.VPC.$invalid)}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.vpcs.to.be.allocated" bundle="${msg}" />"></i>
                                    <div class="error-area" data-ng-show="((resourceAllocationForm.VPC.$invalid && formSubmitted)  || resourceAllocationField.VPC.$invalid)" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.VPC.errorMessage || '<fmt:message key="max.vpcs.are.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
							</td>
			                <td>
                                <div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
									<span>{{hasSumOfDomainMin.VPC || '0' }}</span>
									</b></label>
                                </div>
                                <div data-ng-if="resource=='department'">
                                	<label>
									<span>{{hasSumOfDepartmentMin.VPC || '0' }}</span>
									</b></label>
                                </div>
                                <div data-ng-if="resource=='project'" >
                                	<label>
									<span>{{hasSumOfProjectMin.VPC || '0' }}</span>
									</b></label>
                                </div>
			                </td>
			                <td>
                                <div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
									<span>{{-1 }}</span></b></label>
                                </div>
                                <div data-ng-if="resource=='department'" >
                                	<label>
									<span>{{hasSumOfDepartmentMax.VPC || '0' }}</span></b></label>
                                </div>
                                <div data-ng-if="resource=='project'" >
                                	<label>
									<span>{{hasSumOfProjectMax.VPC || '0' }}</span></b></label>
                                </div>
							</td>
			          	</tr>

			          	<tr>
			  						<td>
			                         	<label><fmt:message key="max.volumes" bundle="${msg}" />:
		                                  	<span class="text-danger">*</span></label>
	                                </td>
	                                <td>
	                                	<div class="col-md-8 col-sm-8">
		                                  <input required="true"
		                                  type="text" valid-integer name="Volume" data-ng-model="resourceQuota.Volume"
		                                  class="form-control"
		                                  data-ng-class="{'error': (resourceAllocationForm.Volume.$invalid && formSubmitted || resourceAllocationField.Volume.$invalid)}" >
		                                  <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.volumes.to.be.allocated" bundle="${msg}" />" ></i>
		                                  	<div class="error-area" data-ng-show="((resourceAllocationForm.Volume.$invalid && formSubmitted) || resourceAllocationField.Volume.$invalid)" >
		                                  		<i  ng-attr-tooltip="{{ resourceAllocationForm.Volume.errorMessage || '<fmt:message key="max.volumes.are.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
	      		         					</div>
      		         					</div>
		   							</td>
									<td>
                                		<div data-ng-if="resource=='domain' || type == 'domain-quota'" >
											<label><span>{{hasSumOfDomainMin.Volume || '0'}}</span></label>
                                		</div>
                                 		<div data-ng-if="resource=='department'" >
											<label>
												<span>{{hasSumOfDepartmentMin.Volume || '0'}}</span>
                               				</label>
                                		</div>
                                   		<div data-ng-if="resource=='project'" >
											<label>
												<span>{{hasSumOfProjectMin.Volume || '0' }}</span>
                                			</label>
                                		</div>

								</td>
			    				<td>
                                	<div data-ng-if="resource=='domain' || type == 'domain-quota'" >
										<label>
											<span>{{-1}}</span>
										</label>
                                	</div>
                                 	<div data-ng-if="resource=='department'" >
										<label>
											<span>{{hasSumOfDepartmentMax.Volume || '0' }}</span>
										</label>
                                	</div>
                                   	<div data-ng-if="resource=='project'" >
										<label>
											<span>{{hasSumOfProjectMax.Volume || '0' }}</span></b></label>
                                		</label>
                                	</div>
							</td>
			       		</tr>
			          	<tr>
			               	<td>
								<label><fmt:message key="max.primary" bundle="${msg}" /> (GB):
                                    <span class="text-danger">*</span>
                                </label>
							</td>
                            <td>
                                <div class="col-md-8 col-sm-8">
                                    <input required="true" type="text" valid-integer name="PrimaryStorage"
                                    data-ng-model="resourceQuota.PrimaryStorage"  class="form-control"
                                    data-ng-class="{'error': (resourceAllocationForm.PrimaryStorage.$invalid && formSubmitted || resourceAllocationField.PrimaryStorage.$invalid)}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.primary.storage.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="((resourceAllocationForm.PrimaryStorage.$invalid && formSubmitted) || resourceAllocationField.PrimaryStorage.$invalid)" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.PrimaryStorage.errorMessage || '<fmt:message key="max.primary.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
							</td>
			                <td>
								<div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
									<span>{{hasSumOfDomainMin.PrimaryStorage || '0' }}</span>
									</b></label>
                                </div>
                                <div data-ng-if="resource=='department'" >
                                	<label>
									<span>{{hasSumOfDepartmentMin.PrimaryStorage || '0' }}</span>
									</b></label>
                                </div>
                                   <div data-ng-if="resource=='project'" >
                                	<label>
									<span>{{hasSumOfProjectMin.PrimaryStorage || '0' }}</span>
									</b></label>
                                </div>
			                </td>
			                <td>
								<div data-ng-if="resource=='domain' || type == 'domain-quota'" >
                                	<label>
									<span>{{-1}}</span></b></label>
                                </div>
                                <div data-ng-if="resource=='department'" >
                                	<label>
									<span>{{hasSumOfDepartmentMax.PrimaryStorage || '0' }}</span></b></label>
                                </div>
                                   <div data-ng-if="resource=='project'" >
                                	<label>
									<span>{{hasSumOfProjectMax.PrimaryStorage || '0' }}</span></b></label>
                                </div>
							</td>
			          	</tr>
			            <tr>
			               	<td>
								<label><fmt:message key="max.secondary" bundle="${msg}" /> (GB):
                                    <span class="text-danger">*</span>
                                </label>
							</td>
                            <td>
                                <div class="col-md-8 col-sm-8">
                                    <input required="true" type="text" valid-integer name="SecondaryStorage"
                                    data-ng-model="resourceQuota.SecondaryStorage"  class="form-control"
                                    data-ng-class="{'error': (resourceAllocationForm.SecondaryStorage.$invalid && formSubmitted || resourceAllocationField.SecondaryStorage.$invalid)}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.secondary.storage.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="((resourceAllocationForm.SecondaryStorage.$invalid) && formSubmitted || resourceAllocationField.SecondaryStorage.$invalid)" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.SecondaryStorage.errorMessage || '<fmt:message key="max.secondary.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i></div>
                                </div>
							</td>
			                <td>
                             <div data-ng-if="resource=='domain'|| type == 'domain-quota'">
                                	<label>
									<span>{{hasSumOfDomainMin.SecondaryStorage || '0' }}</span>
									</label>
                                </div>
                                <div data-ng-if="resource=='department'" >
                                	<label>
									<span>{{hasSumOfDepartmentMin.SecondaryStorage || '0'}}</span>
									</label>
                                </div>
                                 <div data-ng-if="resource=='project'">
                                	<label>
									<span>{{hasSumOfProjectMin.SecondaryStorage || '0'}}</span>
									</label>
                                </div>
			                </td>
			                <td>
                             <div data-ng-if="resource=='domain'|| type == 'domain-quota'" >
                                	<label>
									<span>{{-1}}</span></label>
                                </div>
                                <div data-ng-if="resource=='department'">
                                	<label>
									<span>{{hasSumOfDepartmentMax.SecondaryStorage || '0'}}</span></label>
                                </div>
                                 <div data-ng-if="resource=='project'" >
                                	<label>
									<span>{{hasSumOfProjectMax.SecondaryStorage || '0'}}</span></label>
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
									<li class="list-group-item">-1 <fmt:message key="indicates" bundle="${msg}" />, <fmt:message key="unlimited" bundle="${msg}" />.</li>
									<li class="list-group-item"> 0 <fmt:message key="indicates" bundle="${msg}" />, <fmt:message key="no.quota.available" bundle="${msg}" />.</li>
									<li class="list-group-item"><fmt:message key="department.limit.note" bundle="${msg}" />. </li>
									<li class="list-group-item"><fmt:message key="project.limit.note" bundle="${msg}" />. </li>
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