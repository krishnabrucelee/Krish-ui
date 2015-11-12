

<form name="vmsnapshotForm" data-ng-submit="validateVMSnapshot(vmsnapshotForm)" method="post" novalidate="" data-ng-controller="addVMSnapshotCtrl" >

    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-custom-icon="images/vm-snapshot.png" page-title="Create VM Snapshot"><div class="row"> 
                    <div class="col-md-8 font-bold">
                        <span class="ver-align-mid"><i style="" class="pe-lg ng-hide" data-ng-hide="pageCustomIcon" title="Create VM Snapshot"></i>
                            <img src="images/vm-snapshot.png" style="width:22px; height:22px;" data-ng-show="pageCustomIcon" alt="Create VM Snapshot"> 
                        </span>
                        <span class="ver-align-mid ng-binding">Create VM Snapshot</span>
                    </div>

                    <div class="col-md-4">
                        <div class="pull-right font-extra-bold">
                            <span data-ng-hide="hideZone" class="ver-align-mid ng-binding" title="Zone"><i class="fa fa-map-marker m-r-xsm"></i> Beijing</span>
                            <a class="close-container" href="javascript:void(0);" data-ng-click="cancel()"><img src="images/close3.png" alt="Close"></a>
                        </div>
                    </div>
                </div></panda-modal-header>

        </div>

        <div class="modal-body">
            <div class="row"  > 
                <div class="col-md-12">

                    <div class="form-group" ng-class="{'text-danger': vmsnapshotForm.name.$invalid && formSubmitted}">
                        <div class="row" > 
                            <label class="col-md-3 col-sm-3 control-label" >Name
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-sm-5">
                                <input required="true" type="text" name="name" data-ng-model="vmsnapshot.name" class="form-control" data-ng-class="{'error':  vmsnapshotForm.name.$invalid && formSubmitted}"  >
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="Name of the instance" ></i>
                                <div class="error-area" data-ng-show="vmsnapshotForm.name.$invalid && formSubmitted" ><i  tooltip="Name is required" class="fa fa-warning error-icon"></i></div>
                            </div>

                        </div>
                    </div>
                    <div class="form-group" ng-class="{'text-danger': vmsnapshotForm.description.$invalid && formSubmitted}">
                        <div class="row" > 
                            <label class="col-md-3 col-sm-3 control-label" >Description
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-sm-5">
                                <input required="true" type="text" name="description" data-ng-model="vmsnapshot.description" class="form-control" data-ng-class="{'error':  vmsnapshotForm.name.$invalid && formSubmitted}"  >
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="Description of the instance" ></i>
                                <div class="error-area" data-ng-show="vmsnapshotForm.description.$invalid && formSubmitted" ><i  tooltip="Description is required" class="fa fa-warning error-icon"></i></div>
                            </div>

                        </div>
                    </div>
                    <div class="form-group" >
                        <div class="row" > 
                            <label class="col-md-3 col-sm-3 control-label" >Snapshot Memory

                            </label>
                            <div class="col-md-5 col-sm-5">
                                <label> <input icheck type="checkbox" data-ng-model="vmsnapshot.snapshotMemory"> </label>



                            </div>

                        </div>
                    </div>
                    <div class="form-group" ng-class="{'text-danger': vmsnapshotForm.instance.$invalid && formSubmitted}">
                        <div class="row" > 
                            <label class="col-md-3 col-sm-3 control-label" >Instance
                                <span class="text-danger">*</span>
                            </label>

                            <div class="col-md-5 col-sm-5 ">
                                <select required="true" class="form-control input-group" data-ng-class="{'error':  vmsnapshotForm.name.$invalid && formSubmitted}"  name="instance" data-ng-model="vmsnapshot.instance" ng-options="instance.name for instance in formElements.instanceList" >
                                    <option value="">Select</option>
                                </select>  
                                <div class="error-area" data-ng-show="vmsnapshotForm.instance.$invalid && formSubmitted" ><i  tooltip="Instance is required." class="fa fa-warning error-icon"></i></div>
                            </div>

                        </div>
                    </div>

                    <div class="form-group" >
                        <div class="row" > 
                            <label class="col-md-3 col-sm-3 control-label" >Note

                            </label>
                            <div class="col-md-9 col-sm-9 ">
                                <span class="text-danger text-center">You cannot attach or detach the storage volume, when the particular Instance have VM snapshots. </span>



                            </div>

                        </div>
                    </div>







                </div>
            </div>
        </div>


        <div class="modal-footer">
            <button type="button" class="btn btn-default " ng-click="cancel()" data-dismiss="modal">Cancel</button>
            <button class="btn btn-info" type="submit">Create</button>

        </div></div>
</form>




