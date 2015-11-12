<div ng-controller="configurationCtrl">
    <div class="row">
        <div class="col-md-12 col-sm-12">
            <h4 >
                Compute Offer
            </h4>
            <hr class="m-t-xs">
        </div>
    </div>
    <div class="row">
        <div class="col-md-7 col-sm-7 col-xs-12">



            <div class="row">
                <div class="col-md-12">
                    <div class="btn-group" data-toggle="buttons">
                        <label data-ng-init="computeOffer.type = computeOfferElements.type[0]" data-ng-click="changePlan(offerType)"
                               class="btn m-r-xs w-sm" data-ng-class="computeOffer.type.id == offerType.id ? 'btn-info' : 'btn - default'" data-ng-repeat="offerType in computeOfferElements.type">
                            {{ offerType.name}}
                        </label> 
                    </div>
                </div>
            </div>

            <div class="row m-t-md"> 
                <div class="col-md-10 col-sm-10 col-xs-10">

                    <form name="computeOfferForm" method="POST" data-ng-submit="save(computeOfferForm)" novalidate class="form-horizontal">
                        <div class="form-group" ng-class="{ 'text-danger' : computeOfferForm.plan.$invalid && formSubmitted}">
                            <label class="col-sm-4 control-label">Select Plan
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-sm-6">
                                <select required="true" class="form-control input-group" name="plan" 
                                        data-ng-model="computeOffer.plan" data-ng-class="{'error': computeOfferForm.plan.$invalid && formSubmitted}"
                                        data-ng-options="plan.name for plan in computeOffer.type.planList" >
                                    <option value="">Select</option>
                                </select>
                                <div class="error-area" data-ng-show="computeOfferForm.plan.$invalid && formSubmitted" ><i  tooltip="Plan is required" class="fa fa-warning error-icon"></i></div>
                            </div>

                        </div>


                        <div data-ng-show="computeOffer.plan.name == 'Custom'" >
                            <div class="row m-b-xl" ng-class="{ 'text-danger' : computeOfferForm.ram.$modelValue <= 0 && formSubmitted}"> 
                                <label class="col-md-3 col-sm-3 control-label">RAM :</label>
                                <div class="col-md-5 col-sm-5">
                                    <rzslider rz-slider-model="instance.computeOffer.ram.value" rz-slider-floor="instance.computeOffer.ram.floor" rz-slider-ceil="instance.computeOffer.ram.ceil" rz-slider-always-show-bar="true"></rzslider>
                                </div>

                                <div class="col-md-3 col-sm-3 digit-2-width">
                                    <div class="input-group">
                                        <input class="form-control" name="ram" 
                                               valid-number  
                                               data-ng-min="{{ instance.computeOffer.ram.floor}}" 
                                               data-ng-max="{{ instance.computeOffer.ram.ceil}}" type="text"   
                                               data-ng-model="instance.computeOffer.ram.value">
                                        <span class="input-group-addon" id="basic-addon2">GB</span>
                                    </div>
                                </div>
                            </div>
                            <div class="row m-b-xl" ng-class="{ 'text-danger' : computeOfferForm.cpuCore.$modelValue <= 0 && formSubmitted}"> 
                                <label class="col-md-3 col-sm-3 control-label">CPU Cores :</label>
                                <div class="col-md-5 col-sm-5">
                                    <rzslider rz-slider-model="instance.computeOffer.cpuCore.value" rz-slider-floor="instance.computeOffer.cpuCore.floor" rz-slider-ceil="instance.computeOffer.cpuCore.ceil" rz-slider-always-show-bar="true"></rzslider>
                                </div>
                                <div class="col-md-3 col-sm-3 digit-2-width">
                                    <div class="input-group">
                                        <input valid-number  
                                               data-ng-min="{{ instance.computeOffer.cpuCore.floor}}" 
                                               data-ng-max="{{ instance.computeOffer.cpuCore.ceil}}" type="text"  
                                               class="form-control" name="cpuCore" 
                                               data-ng-model="instance.computeOffer.cpuCore.value">
                                        <span class="input-group-addon">Core</span>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="form-group">
                            <label class="col-sm-4 control-label">Note</label>
                            <div class="col-sm-8">
                                <div class="well">

                                    Your Instance must be stopped before attempting to resize the compute offer.

                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-8 col-sm-offset-4">
                                <a class="btn btn-default"  ui-sref="cloud.list-instance">Cancel</a>
                                <button class="btn btn-info" type="submit"  >Resize</button>
                            </div>
                        </div>
                    </form>

                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-4 col-sm-5 pull-right">

            <div class="panel panel-info">

                <div class="panel-heading">
                    <h3 class="panel-title"><i class="fa fa-list m-r-sm"></i>Summary</h3>
                </div>
                <div class="panel-body no-padding">

                    <table class="table table-condensed" cellspacing="1" cellpadding="1">
                        <tbody>
                            <tr>
                                <td class="p-xs col-md-4 col-sm-4"><b>CPU</b></td>
                                <td class="p-xs col-md-8 col-sm-8">2 vCPU's</td>
                            </tr>
                            <tr>
                                <td class="p-xs col-md-4 col-sm-4"><b>RAM</b></td>
                                <td class="p-xs col-md-8 col-sm-8">4096MB of memory</td>
                            </tr>
                            <tr>
                                <td class="p-xs col-md-4 col-sm-4"><b>System Disk</b></td>
                                <td class="p-xs col-md-8 col-sm-8">20.0GB</td>
                            </tr>
                            <tr>
                                <td class="p-xs col-md-4 col-sm-4"><b>Network</b></td>
                                <td class="p-xs col-md-8 col-sm-8">1000GB</td>
                            </tr>
                            <tr>
                                <td class="p-xs col-md-4 col-sm-4"><b>Bandwidth</b></td>
                                <td class="p-xs col-md-8 col-sm-8">10 MB/s</td>
                            </tr>
                            <tr>
                                <td class="p-xs col-md-4 col-sm-4"><b>Disk IO</b></td>
                                <td class="p-xs col-md-8 col-sm-8">Good</td>
                            </tr>
                            <tr>
                                <td colspan="2" class="p-xs">
                                    <h4 class="text-danger price-text">
                                        <app-currency></app-currency>0.10 <span>/ hour</span>   <small class="text-right text-muted m-l-sm">(<app-currency></app-currency>7.2 / month)</small>
                                    </h4>
                                </td>
                            </tr>
                        </tbody>
                    </table>


                </div>
            </div>
        </div>
    </div>


    <div class="row">
        <div class="col-md-12 col-sm-12">
            <h4>
                Affinity Group (optional)
            </h4>
            <hr class="m-t-xs">
        </div>
    </div>

    <div class="row">
        <div class="col-md-7 col-sm-7 col-xs-12">

            <div class="row m-t-md"> 
                <div class="col-md-10 col-sm-10 col-xs-10">

                    <form name="affinityForm" method="POST" data-ng-submit="saveAffinity(affinityForm)" novalidate class="form-horizontal">
                        <div class="form-group" ng-class="{ 'text-danger' : affinityForm.group.$invalid && affinitySubmitted}">
                            <label class="col-sm-4 control-label">Select Group
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-sm-5">
                                <select required="true" class="form-control input-group" name="group" 
                                        data-ng-model="affinity.group" data-ng-class="{'error': affinityForm.group.$invalid && affinitySubmitted}"
                                        data-ng-options="group.name for group in affinityElements.groupList" >
                                    <option value="">Select</option>
                                </select>
                                <div class="error-area" data-ng-show="affinityForm.group.$invalid && affinitySubmitted" ><i  tooltip="Group is required" class="fa fa-warning error-icon"></i></div>
                            </div>
                            <div class="col-sm-3">
                                <a class="btn btn-info" data-ng-click="addAffinityGroup('md')"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span>Add new affinity</a>
                            </div>

                        </div>


                        <div class="form-group">
                            <label class="col-sm-4 control-label">Note</label>
                            <div class="col-sm-8">
                                <div class="well">
                                    Your Instance must be stopped before attempting to change the affinity group.

                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-8 col-sm-offset-4">
                                <a class="btn btn-default"  ui-sref="cloud.list-instance">Cancel</a>
                                <button class="btn btn-info" type="submit"  >Ok</button>
                            </div>
                        </div>
                    </form>

                </div>
            </div>
        </div>
        <div class="col-md-5">

        </div>
    </div>
</div>
