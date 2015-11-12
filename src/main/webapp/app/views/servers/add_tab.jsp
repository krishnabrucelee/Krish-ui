


<div class="inmodal">
    <div class="color-line"></div>
    <div class="modal-header">
        <h4 class="modal-title">Add Server</h4>
    </div>
    <div class="modal-body">
        <div class="row">
            <div class="col-lg-12">
                <div class="hpanel">
                    <div class="panel-body">
                        <form name="serverForm" method="POST" data-ng-submit="save(serverForm)" novalidate class="form-horizontal">
                            <div ng-show="step == 1" >
                                <div class="form-group" ng-class="{ 'has-error' : serverForm.name.$invalid && formSubmitted}">
                                    <label class="col-sm-4 control-label">Name</label>
                                    <div class="col-sm-8">
                                        <input required="true" type="text" name="name" data-ng-model="server.name" class="form-control" autofocus  data-ng-focus="showDescription('Instance', ' we provide the name for the instance')" >
                                        <span class="help-block m-b-none" ng-show="serverForm.name.$invalid && formSubmitted" >Name is required.</span>
                                    </div>

                                </div>
                                <a class="btn btn-info pull-right" ng-click="wizard.show(2)"> Next </a>
                            </div>
                            <div ng-show="step == 2" >
                                <div class="form-group" data-ng-class="{ 'has-error' : serverForm.zone.$invalid && formSubmitted}">
                                    <label class="col-sm-4 control-label" for="zone">Zone</label>

                                    <div class="col-sm-8">
                                        <select required="true" popover-placement="right" class="form-control" name="zone" data-ng-model="server.zone" data-id="zone" data-ng-options="zone.name for zone in serverElements.zoneList" data-ng-focus="showDescription('Zone', 'is equivalent to a datacenter. The zones in a region are typically located in close geographical proximity')">
                                            <option value="">Select</option>
                                        </select>
                                        <span class="help-block m-b-none" data-ng-show="serverForm.zone.$invalid && formSubmitted" >Select the zone.</span>

                                    </div>
                                </div>
                                <a class="btn btn-default" ng-click="wizard.show(1)"> Previous </a>
                                <a class="btn btn-info pull-right" ng-click="wizard.show(3)"> Next </a>
                            </div>
                            
                            <div ng-show="step == 3" >
                                <div class="form-group " data-ng-class="{ 'has-error' : serverForm.template.$invalid && formSubmitted}">
                                    <label class="col-sm-4 control-label">Template</label>
                                    <div class="col-sm-8">
                                        <select required="true" class="form-control" name="template" data-ng-model="server.template" data-ng-options="template.name for template in serverElements.templateList" data-ng-focus="showDescription('Template', 'is a set configuration of a virtual machines. we can create a VM\'s based on the list of templates')">
                                            <option value="">Select</option>
                                        </select>
                                        <span class="help-block m-b-none" data-ng-show="serverForm.template.$invalid && formSubmitted" >Select the template.</span>
                                    </div>
                                </div>
                                <a class="btn btn-default" ng-click="wizard.show(2)"> Previous </a>
                                <a class="btn btn-info pull-right" ng-click="wizard.show(4)"> Next </a>
                            </div>
                            <div ng-show="step == 4" >
                            <div class="form-group" data-ng-class="{ 'has-error' : serverForm.computeOffering.$invalid && formSubmitted}">
                                <label class="col-lg-4 control-label">Compute offering</label>
                                <div class="col-lg-8">
                                    <select required="true" class="form-control" name="computeOffering" data-ng-model="server.computeOffering" ng-options="computeOffering.name for computeOffering in serverElements.computeOfferingList" data-ng-focus="showDescription('Compute offerings', ' is a set configuration we provide the CPU, RAM, Guest networking, Tags ')">
                                        <option value="">Select</option>
                                    </select>
                                    <span class="help-block m-b-none" ng-show="serverForm.computeOffering.$invalid && formSubmitted" >Select the compute offering.</span>
                                </div>
                            </div>
                            <a class="btn btn-default" ng-click="wizard.show(3)"> Previous </a>
                                <a class="btn btn-info pull-right" ng-click="wizard.show(5)"> Next </a>
                            </div>
                            <div ng-show="step == 5" >
                                <div class="form-group" ng-class="{ 'has-error' : serverForm.diskOffering.$invalid && formSubmitted}">
                                    <label class="col-lg-4 control-label">Data Disk Offering</label>
                                    <div class="col-lg-8">
                                        <select required="true" class="form-control" name="diskOffering" data-ng-model="server.diskOffering" ng-options="diskOffering.name for diskOffering in serverElements.diskOfferingList" data-ng-focus="showDescription('Disk offerings', ' is a configuration contains the disk size and tags on the data disk')">
                                            <option value="">Select</option>
                                        </select>
                                        <span class="help-block m-b-none" ng-show="serverForm.diskOffering.$invalid && formSubmitted" >Select the disk offering.</span>
                                    </div>
                                </div>
                                <a class="btn btn-default" ng-click="wizard.show(4)"> Previous </a>
                                <a class="btn btn-info pull-right" ng-click="wizard.show(6)"> Next </a>
                            </div>
                            <div ng-show="step == 6" >
                                <div class="form-group"  ng-class="{ 'has-error' : serverForm.network.$invalid && formSubmitted}">
                                    <label class="col-sm-4 control-label">Network</label>
                                    <div class="col-lg-8">
                                        <select required="true" class="form-control" name="network" data-ng-model="server.network" ng-options="network.name for network in serverElements.networkList" data-ng-focus="showDescription('Network', ' administrator configured multiple network and we select one of the network')">
                                            <option value="">Select</option>
                                        </select>
                                        <span class="help-block m-b-none" ng-show="serverForm.network.$invalid && formSubmitted" >Select the network.</span>
                                    </div>
                                </div>
                            
                                <a class="btn btn-default" ng-click="wizard.show(4)"> Previous </a>
                                <button class="btn pull-right btn-info" type="submit"  >Create </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" ng-click="cancel()">Close</button>
    </div>
</div>

