<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
    <thead>
        <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Zone</th>
            <th>CIDR</th>
            <th>State</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <tr data-ng-repeat="network in networkList| filter: quickSearch">
            <td>
                <a class="text-info" ui-sref="cloud.list-network.view-network({id: {{ network.id}}})"  title="View Network" >{{ network.name}}</a>
            </td>
            <td>{{ network.displayText}} </td>
            <td>{{ network.zone.name}} </td>
            <td>{{ network.cIDR}} </td>
            <td><label class="label label-success text-center text-white"> {{ network.status}} </label></td>

            <td>
                <a class="icon-button" title="Edit">
                    <span class="fa fa-edit m-r"> </span>
                </a>
                <a class="icon-button" title="Delete"  ><span class="fa fa-trash"></span></a>
            </td>
        </tr>
    </tbody>
</table>