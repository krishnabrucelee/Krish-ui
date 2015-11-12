<div class="row" data-ng-controller="instanceCtrl">
    <div class="hpanel">
        <div class="panel-body">
            <div class="col-lg-7 animated-panel">
                <div class="hpanel hblue">
                    <div class="panel-heading hbuilt">
                        Create Server <div class="badge badge-important"> Zone : {{ global.zone.name}} </div>
                    </div>
                    <div class="panel-body">
                        <div class="text-center m-b-md">
                            <a ng-class="{ 'btn-primary': step == stepCount, 'btn-default': step != stepCount}" class="btn btn-primary" ng-click="wizard.show(stepCount)" data-ng-repeat="stepCount in [1, 2, 3, 4, 5]">Step {{  stepCount }} </a>
                        </div>
                        <hr>
                        <form name="serverForm" method="POST" data-ng-submit="save(serverForm)" novalidate class="form-horizontal">
                            <div ng-show="step == 1" >
                                <div class="form-group" ng-class="{ 'has-error' : serverForm.name.$invalid && formSubmitted}">
                                    <label class="col-sm-4 control-label">Name</label>
                                    <div class="col-sm-8">
                                        <input required="true" type="text" name="name" data-ng-model="server.name" class="form-control" autofocus >
                                        <span class="help-block m-b-none" ng-show="serverForm.name.$invalid && formSubmitted" >Name is required.</span>
                                    </div>
                                    
                                    
                                    
                                    

                                </div>
                                <button type="button"  class="btn btn-info pull-right" ng-click="wizard.show(2)"> Next </button>
                            </div>


                            <div ng-show="step == 2" >
                                <div class="form-group " data-ng-class="{ 'has-error' : serverForm.template.$invalid && formSubmitted}">
                                    <label class="col-sm-4 control-label">Template</label>
                                    <div class="col-sm-8">
                                        <select required="true" class="form-control" name="template" data-ng-model="server.template" data-ng-options="template.name for template in serverElements.templateList" >
                                            <option value="">Select</option>
                                        </select>
                                        <span class="help-block m-b-none" data-ng-show="serverForm.template.$invalid && formSubmitted" >Select the template.</span>
                                    </div>
                                </div>
                                <button type="button"  class="btn btn-default" ng-click="wizard.show(1)"> Previous </button>
                                <button type="button"  class="btn btn-info pull-right" ng-click="wizard.show(3)"> Next </button>
                            </div>
                            <div ng-show="step == 3" >
                                <div class="form-group" data-ng-class="{ 'has-error' : serverForm.computeOffering.$invalid && formSubmitted}">
                                    <label class="col-lg-4 control-label">Compute offering</label>
                                    <div class="col-lg-8">
                                        <select required="true" class="form-control" name="computeOffering" data-ng-model="server.computeOffering" ng-options="computeOffering.name for computeOffering in serverElements.computeOfferingList" >
                                            <option value="">Select</option>
                                        </select>
                                        <span class="help-block m-b-none" ng-show="serverForm.computeOffering.$invalid && formSubmitted" >Select the compute offering.</span>
                                    </div>
                                </div>
                                <button type="button"  class="btn btn-default" ng-click="wizard.show(2)"> Previous </button>
                                <button type="button"  class="btn btn-info pull-right" ng-click="wizard.show(4)"> Next </button>
                            </div>
                            <div ng-show="step == 4" >
                                <div class="form-group" ng-class="{ 'has-error' : serverForm.diskOffering.$invalid && formSubmitted}">
                                    <label class="col-lg-4 control-label">Data Disk Offering</label>
                                    <div class="col-lg-8">
                                        <select required="true" class="form-control" name="diskOffering" data-ng-model="server.diskOffering" ng-options="diskOffering.name for diskOffering in serverElements.diskOfferingList" >
                                            <option value="">Select</option>
                                        </select>
                                        <span class="help-block m-b-none" ng-show="serverForm.diskOffering.$invalid && formSubmitted" >Select the disk offering.</span>
                                    </div>
                                </div>
                                <button type="button"  class="btn btn-default" ng-click="wizard.show(3)"> Previous </button>
                                <button type="button"  class="btn btn-info pull-right" ng-click="wizard.show(5)"> Next </button>
                            </div>
                            <div ng-show="step == 5" >
                                <div class="form-group"  ng-class="{ 'has-error' : serverForm.network.$invalid && formSubmitted}">
                                    <label class="col-sm-4 control-label">Network</label>
                                    <div class="col-lg-8">
                                        <select required="true" class="form-control" name="network" data-ng-model="server.network" ng-options="network.name for network in serverElements.networkList" >
                                            <option value="">Select</option>
                                        </select>
                                        <span class="help-block m-b-none" ng-show="serverForm.network.$invalid && formSubmitted" >Select the network.</span>
                                    </div>
                                </div>

                                <button type="button" class="btn btn-default" ng-click="wizard.show(4)"> Previous </button>
                                <button class="btn pull-right btn-info" type="submit"  >Create </button>
                            </div>
                        </form>
                        <div class="clearfix"></div>
                        <hr>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="hpanel hblue">
                                    <div class="panel-heading hbuilt">
                                        Summary
                                    </div>
                                    <div class="panel-body h-100">
                                        <div class="row">
                                            <div class="col-md-9">
                                                <h4>${{ total + server.template.price + server.computeOffering.price + server.diskOffering.price + server.network.price | number:2 }} / hr </h4>
                                            </div>
                                            <div class="col-md-3">
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <div class="col-lg-5 animated-panel">

                <div class="row" data-ng-show="server != null">
                    <div class="col-lg-12">
                        <div class="hpanel hblue">
                            <div class="panel-heading hbuilt">
                                Configurations
                            </div>

                            <div class="panel-body no-padding">
                                <ul class="list-group">
                                    <li class="list-group-item" data-ng-show="serverForm.zone.$valid">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="stats-title pull-left">
                                                    <h4>Zone</h4>
                                                    {{ server.zone.name}}
                                                </div>

                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item " data-ng-show="serverForm.template.$valid">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <h5>Template</h5>
                                                <label class="label label-success pull-right">${{ server.template.price}} / hr.</label>
                                                {{ server.template.name}}
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item " data-ng-show="serverForm.computeOffering.$valid">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <h5>Compute Offering</h5>
                                                <label class="label label-primary pull-right">${{ server.computeOffering.price}} / hr.</label>
                                                {{ server.computeOffering.name}}
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item " data-ng-show="serverForm.diskOffering.$valid">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <h5>Data disk offering</h5>
                                                <label class="label label-danger pull-right">${{ server.diskOffering.price}} / hr.</label>
                                                {{ server.diskOffering.name}}
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item " data-ng-show="serverForm.network.$valid">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <h5>Network</h5>
                                                <label class="label label-info pull-right">${{ server.network.price}} / hr.</label>
                                                {{ server.network.name}}
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
