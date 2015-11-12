<form name="volumeForm" data-ng-submit="validateVolume(volumeForm)" method="post" novalidate="" data-ng-controller="uploadVolumeCtrl">
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-cloud-upload" page-title="Upload Volume"></panda-modal-header>                
        </div>
        <div class="modal-body">
            <div class="row"  > 
                <div class="col-md-12">


                    <div class="form-group" ng-class="{
                                            'text-danger'
                                            : volumeForm.name.$invalid && formSubmitted}">
                        <div class="row">
                            <label class="col-md-3 col-sm-3 control-label">Name<span class="text-danger">*</span> 
                            </label>
                            <div class="col-md-5 col-sm-5">
                                <input required="true" type="text" name="name" data-ng-model="volume.name" class="form-control" data-ng-class="{'error': volumeForm.name.$invalid && formSubmitted}" >
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="Name of the disk" ></i>
                                <div class="error-area" data-ng-show="volumeForm.name.$invalid && formSubmitted" ><i  tooltip="Name is Required" class="fa fa-warning error-icon"></i></div>

                            </div>

                        </div>
                    </div>



                    <div class="form-group" ng-class="{'text-danger': volumeForm.format.$invalid && formSubmitted}">
                        <div class="row" > 
                            <label class="col-md-3 col-sm-3 control-label" >Format
                                <span class="text-danger">*</span>
                            </label>

                            <div class="col-md-5 col-sm-5">
                                <select required="true" class="form-control input-group" data-ng-class="{'error': volumeForm.format.$invalid && formSubmitted}" name="format" data-ng-model="volume.format" ng-options="format.name for format in formElements.formatList" >
                                    <option value="">Select</option>
                                </select>  
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="Volume file format" ></i>
                                <div class="error-area" data-ng-show="volumeForm.format.$invalid && formSubmitted" ><i  tooltip="Format is Required" class="fa fa-warning error-icon"></i></div>
                            </div>

                        </div>
                    </div>


                    <div class="form-group" ng-class="{
                                            'text-danger'
                                            : volumeForm.url.$invalid && formSubmitted}">
                        <div class="row">
                            <label class="col-md-3 col-sm-3 control-label" tooltip="URL for the disk file">URL
                                <span class="text-danger">*</span>
                            </label>

                            <div class="col-md-5 col-sm-5">
                                <input required="true" type="text" name="url" data-ng-model="volume.url" class="form-control" data-ng-class="{'error': volumeForm.url.$invalid && formSubmitted}" >
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="URL for the disk file" ></i>
                                <div class="error-area" data-ng-show="volumeForm.url.$invalid && formSubmitted" ><i  tooltip="Url is Required" class="fa fa-warning error-icon"></i></div>

                            </div>

                        </div>
                    </div>


                    <div class="form-group">
                        <div class="row">
                            <label class="col-md-3 col-sm-3 control-label">MD5 checksum </label>

                            <div class="col-md-5 col-sm-5">
                                <input type="text" name="md5checksum" data-ng-model="volume.md5checksum" class="form-control" >
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="MD5 Checksum" ></i>

                            </div>

                        </div>
                    </div>





                </div>
            </div>
        </div>
        <div class="modal-footer">
            <span class="pull-left">
                <h4 class="text-danger price-text m-l-lg">
                    <app-currency></app-currency>0.10 <span>/ hour</span>   <small class="text-right text-muted m-l-sm">(<app-currency></app-currency>7.2 / month)</small>
                </h4>
            </span>
            <a class="btn btn-default"  data-ng-click="cancel()">Cancel</a>
            <button class="btn btn-info" type="submit">Upload</button>
        </div>
    </div>

</form>