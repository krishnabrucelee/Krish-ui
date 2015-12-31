<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="panel-heading">
    <div class="row">
        <div class="col-md-3 col-sm-3 col-xs-3 ">
            <div class="quick-search">
                <div class="input-group">
                    <input data-ng-model="networkSearch" type="text" class="form-control input-medium" placeholder="Quick Search" aria-describedby="quicksearch-go">
                    <span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
                </div>
            </div>
        </div>
        <div class="col-md-9 col-sm-9 col-xs-9">

        </div>
    </div>
    <div class="clearfix"></div>
</div>
<div class="white-content">
    <form >
<div class="table-responsive">
        <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Zone</th>
                    <th>State</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <a class="text-info " ui-sref="cloud.list-instance.view-instance({id: 2})" title="View Instance" href="#/instance/list/view/2">Northeast China - Liaoning</a>
                    </td>

                    <td >Liaoning </td>
                    <td>
                     <label class="label label-success ng-binding ng-scope" >Running</label><!-- end ngIf: instance.state == 'Running' -->
                    </td>
                    <td>
                           
                            <a class="icon-button" title="Stop" >
                                <span class="fa fa-ban m-r" ></span>
                            </a>
                            <a class="icon-button" title="Restart"  ><span class="fa fa-rotate-left"></span></a>
                            <a class="icon-button" title="View Console"><span class="fa-desktop fa m-xs"></span></a>
                    </td>

                </tr>
                <tr >
                    <td>
                        <a class="text-info ng-binding" ui-sref="cloud.list-instance.view-instance({id: 3})" title="View Instance" href="#/instance/list/view/3">East China - Shanghai</a>
                    </td>

                    <td >Shanghai </td>
                    <td>
                      <label class="label label-success ng-binding ng-scope" >Running</label><!-- end ngIf: instance.state == 'Running' -->
                                    </td>
                    <td>
                           
                            <a class="icon-button" title="Stop" >
                                <span class="fa fa-ban m-r" ></span>
                            </a>
                            <a class="icon-button" title="Reboot"  ><span class="fa fa-rotate-left"></span></a>
                            <a class="icon-button" title="View Console"><span class="fa-desktop fa m-xs"></span></a>
                    </td>

                </tr>
                
            </tbody>
        </table>
</div>
    </form>
</div>