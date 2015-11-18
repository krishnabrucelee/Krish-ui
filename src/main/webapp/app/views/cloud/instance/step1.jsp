<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="row no-margins">
 	<div class="col-md-12 col-sm-12 no-padding">
		<div class="hpanel">
			<div class="panel-body  no-padding">
				<ul class="mailbox-list h-202 borders">
					<div class="row">
					<div class="scroll-220">
					<div class= "col-md-4 col-sm-4 m-t-sm">
						<div class="form-group">
							<div class="col-md-12 col-xs-12 col-sm-12 ">
								<span class="control-label"><fmt:message key="common.os.category" bundle="${msg}" />:</span>
							</div>
							<div class="col-md-12 col-xs-12 col-sm-12 p-xs">
								<select class="form-control input-group" name="osCategory"
									data-ng-model="instance.osCategory" ng-change="getTemplatesByFilters()"
									ng-options="osCategory.name for osCategory in formElements.osCategoryList">
									<option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
								</select>
							</div>
						</div>
						</div>
						<div class= "col-md-4 col-sm-4 m-t-sm">
						<div class="form-group">
							<div class=" ">
								<span class="control-label"><fmt:message key="common.os.version/release" bundle="${msg}" />:</span>
							</div>
							<div class="col-md-12 col-xs-12 col-sm-12 p-xs">
								<input class="form-control input-group" name="osVersion"
									data-ng-model="instance.osVersion" ng-change="getTemplatesByFilters()"/>
							</div>
						</div>
						</div>
						<div class= "col-md-4 col-sm-4 m-t-sm">
						<div class="form-group">
							<span class=" "><fmt:message key="common.architecture" bundle="${msg}" />: </span>
							<div class="m-t-sm">
								<label class=" "> <input icheck type="radio"
									data-ng-model="instance.architecture" ng-change="getTemplatesByFilters()" value="32" name="architecture">
									32Bit
								</label> <label class=" "> <input icheck type="radio"
									data-ng-model="instance.architecture" ng-change="getTemplatesByFilters()" value="64" name="architecture"
									data-ng-checked="true"> 64Bit
								</label>
							</div>
						</div>
						</div>
					</div>
					</div>
				</ul>
			</div>
		</div>
	</div>
	<div class="col-md-12 col-sm-12 no-padding no-margins">
		<div class="hpanel">
			<div class="panel-body  no-padding">
				<ul class="mailbox-list borders no-margins">
					<li class="border-bottom"><a href="javascript:void(0);"><fmt:message key="common.templates" bundle="${msg}" /></a>
					</li>
					<div class="scroll-220">
						<div class="row">
							<div class="col-md-12" >
								<div class="instance-templates"
									style="height: 246px; overflow-y: auto; overflow-x: hidden;">
									<div>
										<table cellspacing="1" cellpadding="1" class="table table-striped no-margins">
										<tr data-ng-show="formElements.templateList.length == 0">
											<td><fmt:message key="common.no.records.found" bundle="${msg}" /></td>
										</tr>
											<tr data-ng-repeat="templateObj in formElements.templateList">
												<td>
												<div class="col-md-3 col-sm-3">

											<img data-ng-show="templateObj.displayText.toLowerCase().indexOf('cent') > -1" src="images/os/centos_logo.png" alt="" height="25" width="25" class="m-r-5" >
											<img data-ng-show="templateObj.displayText.toLowerCase().indexOf('ubuntu') > -1" src="images/os/ubuntu_logo.png" alt="" height="25" width="25" class="m-r-5" >
											<img data-ng-show="templateObj.displayText.toLowerCase().indexOf('debian') > -1" src="images/os/debian_logo.png" alt="" height="25" width="25" class="m-r-5" >
											<img data-ng-show="templateObj.displayText.toLowerCase().indexOf('fedora') > -1" src="images/os/fedora_logo.png" alt="" height="25" width="25" class="m-r-5" >
											<img data-ng-show="templateObj.displayText.toLowerCase().indexOf('redhat') > -1" src="images/os/redhat_logo.png" alt="" height="25" width="25" class="m-r-5" >
											<img data-ng-show="templateObj.displayText.toLowerCase().indexOf('core') > -1" src="images/os/core_logo.png" alt="" height="25" width="25" class="m-r-5" >
											<img data-ng-show="templateObj.displayText.toLowerCase().indexOf('vynta') > -1" src="images/os/vynta_logo.png" alt="" height="25" width="25" class="m-r-5" >
  											<img data-ng-show="templateObj.displayText.toLowerCase().indexOf('windows') > -1" src="images/os/windows_logo.png" alt="" height="25" width="25" class="m-r-5" >
											<br>ver : <span class="text-success">{{templateObj.osVersion}}</span>
											</div>
											 <div class="col-md-8 col-sm-8"><label class="col-md-11 col-sm-11">{{templateObj.name}}</label><span class="col-md-11 col-sm-11">{{templateObj.displayText}}</span></div>
											 <div class="col-md-1 col-sm-1">
													<div class="form-group">
															<label class=" "> <input icheck type="radio"
																data-ng-model="templat" value="" data-ng-change="setTemplate(templateObj)"
																name="template">
															</label>

													</div>
											 </div>
												</td>
											</tr>
											</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</ul>
			</div>
		</div>
	</div>
</div>
