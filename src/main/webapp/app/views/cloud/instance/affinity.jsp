<form name="affinityForm" method="POST" data-ng-submit="save(affinityForm)" novalidate class="form-horizontal" >
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-link" page-title="Create new affinity group"></panda-modal-header>

        </div>
        <div class="modal-body">
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group" ng-class="{ 'text-danger' : affinityForm.name.$invalid && formSubmitted}">
                        <div class="row">
                            <label  class="col-md-3 col-xs-12 col-sm-3 control-label">Name 
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <input required="true" type="text" name="name" data-ng-model="affinity.name" class="form-control" data-ng-class="{'error': affinityForm.name.$invalid && formSubmitted}" >
                                <div class="error-area" data-ng-show="affinityForm.name.$invalid && formSubmitted" ><i  tooltip="Name is required" class="fa fa-warning error-icon"></i></div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group" ng-class="{ 'text-danger' : affinityForm.description.$invalid && formSubmitted}">
                        <div class="row">
                            <label class="col-md-3 col-xs-12 col-sm-3 control-label">Description 
                            </label>
                            <div class="col-md-8 col-xs-12 col-sm-8">
                                <textarea class="form-control" cols="12" rows="3" id="comment" name="reason" data-ng-model="reasondetails" required></textarea>
                            </div>

                        </div>
                    </div>

                    <!--<div class="hr-line-dashed"></div>-->
                    <div class="form-group" ng-class="{ 'text-danger' : affinityForm.type.$invalid && formSubmitted}">

                        <div class="row" > 
                            <label class="col-md-3 col-xs-12 col-sm-3 control-label">Type 
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <select required="true" class="form-control input-group" name="type" data-ng-model="affinity.type = 'host-anti-affinity'" data-ng-class="{'error': affinityForm.type.$invalid && formSubmitted}" >
                                    <option value="host-anti-affinity">host anti-affinity</option>
                                </select> 
                            <div class="error-area" data-ng-show="affinityForm.type.$invalid && formSubmitted" ><i  tooltip="Type is required" class="fa fa-warning error-icon"></i></div>
                            </div>

                        </div>
                    </div>

                    <!--<div class="hr-line-dashed"></div>-->
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <a class="btn btn-default"  data-ng-click="cancel()">Cancel</a>
            <button class="btn btn-info" type="submit">Add</button>


        </div>
    </div>
</form>