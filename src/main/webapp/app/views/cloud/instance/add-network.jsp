<form name="networkForm" method="POST" data-ng-submit="addNetworkVM(networkForm)" novalidate >
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-custom-icon="images/network-icon-2.png"  page-title="Add Network to VM"></panda-modal-header>

        </div>
        <div class="modal-body">

            <div class="row">
                <div class="col-md-12">
                    <h6 class="text-left m-l-md ">
                        Please specify the network that you would like to add this VM to. A new NIC will be added for this network.
                    </h6>
                    <br/>
                    <!--<div class="hr-line-dashed"></div>-->
                    <div class="form-group" ng-class="{ 'text-danger' : networkForm.networkOffers.$invalid && formSubmitted}">

                        <div class="row" > 
                            <label class="col-md-offset-1 col-sm-offset-1  col-md-2 col-xs-3 col-sm-1 control-label ">Network<span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-xs-5 col-sm-5">
                                <select required="true" class="form-control input-group" name="networkOffers" 
                                        data-ng-model="network.networkOffers" data-ng-class="{'error': networkForm.networkOffers.$invalid && formSubmitted}"
                                        data-ng-options="networkOffers.name for networkOffers in networkList.networkOffers" >
                                    <option value="">Select</option>
                                </select> 
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="Select the network" ></i>
                                <div class="error-area" data-ng-show="networkForm.networkOffers.$invalid && formSubmitted" ><i  tooltip="Network is required" class="fa fa-warning error-icon"></i></div>
                            </div>

                        </div>
                    </div>


                </div>
            </div>
        </div>
        <div class="modal-footer">

            <a class="btn btn-default"  data-ng-click="cancel()">Cancel</a>
            <button class="btn btn-info" type="submit">Add</button>


        </div>
    </div>
</form>