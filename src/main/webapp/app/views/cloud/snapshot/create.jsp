<div data-ng-hide="createSnapshot">
<form name="snapshotForm" data-ng-submit="validateSnapshot(snapshotForm)" method="post" novalidate="" data-ng-controller="addSnapshotCtrl" >

    <div class="inmodal" >
         <div class="modal-header">
            <panda-modal-header page-icon="fa fa-database" page-title="List of Available Disk"></panda-modal-header>

        </div>

    <div class="modal-body">
        <div class="row"  >
            <div class="col-md-12">
                <div class="text-center">Click on the volume name you want to snapshot.</div>

<div class="table-responsive">
                    <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                        <th class="col-md-2 col-sm-2">Volume Name</th>
                        <th class="col-md-2 col-sm-2">Instance Name</th>

                        <th class="col-md-2 col-sm-2">Volume Type</th>

                    </tr>
                    </thead>
                    <tbody>
                    <tr data-ng-repeat="volume in volumesList">
                        <td>
                           <a  ng-click="updatePageStatus('md', volume)"> {{ volume.name }}</a>
                        </td>
                        <td>
                            North China
                        </td>

                         <td>
                          {{ volume.volumeType }}
                        </td>

                    </tr>
                    </tbody>
                </table>
                </div>




        </div>
        </div></div>


    <div class="modal-footer">
        <div>
<span class="pull-right">
                <h4 class="text-danger price-text m-l-lg">
                    <app-currency></app-currency>0.10 <span>/ hour</span> <span>/GB</span>
                </h4>
            </span>
        </div></div></div>
</form>
</div>

<div data-ng-include src="'app/views/cloud/snapshot/download-snapshot.jsp'" data-ng-show="createSnapshot"></div>





