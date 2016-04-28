<form name="form.detachForsm" data-ng-controller="volumeCtrl">
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header hide-zone="false" page-icon="fa fa-unlink" page-title="Detach Volume"></panda-modal-header>
            <!--<h2 class="modal-title" id="myModalLabel">Confirm Detach Volume</h2>-->
        </div>

        <div class="modal-body">
            <div class=" row">
                <div class="form-group has-error col-md-3 col-sm-3  col-xs-3">

                    <span class="fa fa-3x fa-warning text-warning"></span>
                </div>
                <div class="form-group has-error col-md-9 col-sm-9  col-xs-9">
                    <p >Are you sure do you want to detach ?</p>
                </div>


            </div>

        </div>
        <div class="modal-footer">
        <get-loader-image data-ng-show="showLoader"></get-loader-image>
            <button type="button" data-ng-hide="showLoader" class="btn btn-default " ng-click="cancel()" data-dismiss="modal">Cancel</button>
            <button type="submit" data-ng-hide="showLoader" class="btn btn-default btn-danger2" ng-click="detach()" data-dismiss="modal">Ok</button>

        </div>
    </div>

</form>