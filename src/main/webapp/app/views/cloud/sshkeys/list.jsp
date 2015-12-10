<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div ng-controller="sshkeyListCtrl">
    <div class="hpanel">
        <div class="panel-heading">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="pull-left">
                    </div>
                    <div class="pull-right">
                        <div class="quick-search">
							<div class="input-group">
								<input data-ng-model="sshkeySearch" type="text" class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
							   	 <span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
							</div>
						</div>
                        <span class="pull-right m-l-sm m-t-sm m-b-sm">
                            <a class="btn btn-info"  ng-click="createSSHKey('md')"  data-backdrop="static" data-keyboard="false"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span><fmt:message key="create.ssh.key.pair" bundle="${msg}" /></a>
                            <a class="btn btn-info" ui-sref="cloud.list-ssh" href="#/sshkeys/list" title="<fmt:message key="common.refresh" bundle="${msg}" />"  ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
                        </span>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12 ">
                <pagination-content></pagination-content>
                    <div class="white-content">
                        <div class="table-responsive">
                            <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
								    	<th class="col-md-2 col-sm-2"><fmt:message key="common.name" bundle="${msg}" /> </th>
										<th class="col-md-2 col-sm-3"><fmt:message key="common.company" bundle="${msg}" /></th>
										<th class="col-md-2 col-sm-5"><fmt:message key="common.account" bundle="${msg}" /></th>
										<th class="col-md-3 col-sm-2"><fmt:message key="common.private.key" bundle="${msg}" /></th>
										<th class="col-md-1 col-sm-2"><fmt:message key="common.action" bundle="${msg}" /></th>
									</tr>
                                </thead>
                                <tbody>
                                    <tr data-ng-repeat="sshkey in sshkeyList  | filter:sshkeySearch">
                                        <td>
                                            {{ sshkey.name}}
                                        </td>
                                        <td>
                                            {{ sshkey.department.domain.name}}
                                        </td>
                                        <td>
                                            {{ sshkey.department.userName }}
                                        </td>
                                        <td>
                                        	{{ sshkey.privatekey}}
                                        </td>
                                        <td><a class="icon-button" title="<fmt:message key="common.view.instance" bundle="${msg}" />"> <span class="fa fa-eye"></span></a>
											<a class="icon-button" title="<fmt:message key="common.delete" bundle="${msg}" />" data-ng-click="delete('sm', sshkey)"><span class="fa fa-trash"></span></a>
										</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <pagination-content></pagination-content>
                </div>
            </div>
        </div>
    </div>
</div>