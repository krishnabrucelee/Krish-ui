<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <div class="row">

        <div class="col-md-12 col-sm-12">
            <div class="hpanel">
                <div class="panel-heading">
            </div>

                <div class="white-content">
                    <div class="table-responsive">
                        <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped table-hover table-mailbox">
                            <thead>
                                <tr>


                            <th class="col-md-2 col-sm-2">Name</th>
                            <th class="col-md-1 col-sm-1">Size</th>
                            <th class="col-md-1 col-sm-1">Status</th>
                            <th class="col-md-1 col-sm-1">Template Owner</th>
                            <th class="col-md-1 col-sm-1">Register Date</th>
                            <th class="col-md-1 col-sm-1">Format</th>
                            <th class="col-md-1 col-sm-1">HVM</th>
                            <th class="col-md-1 col-sm-1">Password Enabled</th>
                            <th class="col-md-1 col-sm-1">Dynamically Scalable</th>
                            <th class="col-md-1 col-sm-1">Action</th>

                            </tr>
                            </thead>
                            <tbody>
                                <tr data-ng-repeat="template in filteredCount = (template.templateList| filter:quickSearch)">
                                    <td>
                                        <a data-ng-click="showDescription(template)">
                                           <img data-ng-show="template.imageName.indexOf('windows') > -1" src="images/os/windows_logo.png" alt="" height="35" width="35" class="m-r-5" >
                       					   <img data-ng-show="template.imageName.indexOf('linux') > -1" src="images/os/ubuntu_logo.png" alt="" height="35" width="35" class="m-r-5" > {{ template.name }}
                                        </a>
                                    </td>
                                    <td>{{ template.size }}</td>
                                    <td>{{ template.status }}</td>
                                    <td>{{ template.owner }}</td>
                                    <td>{{ template.registerDate }}</td>
                                    <td>{{ template.format }}</td>
                                    <td>{{ template.hvm }}</td>
                                    <td>{{ template.passwordEnabled }}</td>
                                    <td>{{ template.dynamicallyScalable }}</td>
                                    <td>
                                        <button title="Launch" class="btn btn-info btn-sm pull-right"><i class="fa fa-power-off"></i> Launch</button>
                                    </td>

                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
