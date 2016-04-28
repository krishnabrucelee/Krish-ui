

<form name="volumeForm" method="POST" data-ng-hide="downloads" data-ng-submit="save(volumeForm)" novalidate class="form-horizontal" data-ng-controller="volumeCtrl">
    <div class="inmodal"  >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-cloud-download"  page-title="Download Volume"></panda-modal-header>
        </div>
        <div class="modal-body">
            <div class="row" data-ng-hide="downloadLoding || downloading">

                 <div class="form-group has-error col-md-3 col-sm-3  col-xs-3">

                    <span class="fa fa-3x fa-warning text-warning"></span>
                </div>
                <div class="form-group has-error col-md-8 col-sm-8  col-xs-8"><p>Please confirm that you want to download this volume.</p></div>
            </div>

            <div class="text-center" data-ng-show="downloadLoding">
                <img src="images/loading-bars.svg" />
            </div>
            <div class="text-center" data-ng-show="downloading">
                Please click <a  ng-click="downloadLink('#/volume/list')">http://localhost:8383/jade-art/app/data-12 </a>to download volume
            </div>

        </div>

        <div class="modal-footer" data-ng-hide="downloading">

            <span class="pull-right">
                <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="cancel()">No</button>
                <button type="button" class="btn btn-info" ng-click="download()">Yes</button>
            </span>

        </div>
        <div class="modal-footer" data-ng-show="downloading">

            <span class="pull-right">
                <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="cancel()">Close</button>
            </span>

        </div>
    </div>
</form>