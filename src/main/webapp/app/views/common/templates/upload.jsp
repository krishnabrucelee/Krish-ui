<form name="uploadTemplateForm" data-ng-submit="save(uploadTemplateForm)" method="post" novalidate="" >
<div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="pe-7s-upload" page-title="Upload Template"></panda-modal-header>
        </div>
        <div class="modal-body">
            <div class="row"  >
                <div class="col-md-9 col-sm-9 col-xs-9">
                    <div class="form-group" ng-class="{'has-error': uploadTemplateForm.name.$invalid && formSubmitted}">
                        <div class="row">
                            <label class="col-md-3 col-sm-3 control-label">Name<span class="text-danger">*</span></label>
                            <div class="col-md-6  col-sm-6 col-xs-6">
                                <input required="true" type="text" name="name" data-ng-model="template.name" class="form-control" >
                                <span class="help-block m-b-none" ng-show="uploadTemplateForm.name.$invalid && formSubmitted" >Template Name is required.</span>
                                <i tooltip="Name of the Template" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                            </div>
                        </div>
                    </div>


                    <div class="form-group" ng-class="{'has-error': uploadTemplateForm.description.$invalid && formSubmitted}">
                        <div class="row">
                            <label class="col-md-3 col-sm-3 control-label">Description<span class="text-danger">*</span></label>
                            <div class="col-md-6  col-sm-6 col-xs-6">
                                <input required="true" type="text" name="description" data-ng-model="template.description" class="form-control" >
                                <span class="help-block m-b-none" ng-show="uploadTemplateForm.description.$invalid && formSubmitted" >Description is required.</span>
                                <i  tooltip="Description of the Template" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                            </div>

                        </div>
                    </div>


                    <div class="form-group" ng-class="{'has-error': uploadTemplateForm.url.$invalid && formSubmitted}">
                        <div class="row">
                            <label class="col-md-3 col-sm-3 control-label">URL<span class="text-danger">*</span></label>
                            <div class="col-md-9 col-sm-9 col-xs-9">
                                <input required="true" type="text" name="url" data-ng-model="template.url" class="form-control" >
                                <span class="help-block m-b-none" ng-show="uploadTemplateForm.url.$invalid && formSubmitted" >URL is required.</span>
                                <i  tooltip="Management Server will download from the specified URL" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                            </div>
                        </div>
                    </div>



                    <div class="form-group" ng-class="{
                                            'has-error'
                                            : uploadTemplateForm.hypervisor.$invalid && formSubmitted}">
                        <div class="row">
                            <label class="col-md-3 col-sm-3 control-label" >Hypervisor<span class="text-danger">*</span>
                            </label>

                            <div class="col-md-6 col-sm-6">
                                <select required="true" class="form-control input-group" name="hypervisor" data-ng-model="template.hypervisor" ng-options="hypervisor.name for hypervisor in formElements.hypervisorList" >
                                    <option value="">Select</option>
                                </select>
                                <span class="help-block m-b-none" ng-show="uploadTemplateForm.hypervisor.$invalid && formSubmitted" >Hypervisor is required.</span>
                                <i tooltip="Choose the hypervisor" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                            </div>

                        </div>
                    </div>

                    <div class="form-group" data-ng-show="template.hypervisor.id == 3">
                        <div class="row">
                            <div class="col-md-6">
                                <label> <input icheck type="checkbox" ng-model="template.originalXsVersion"> Original XS Version is 6.1+ </label>
                            </div>
                            <div class="col-md-6">
                            </div>
                        </div>
                    </div>


                    <div class="form-group" data-ng-show="template.hypervisor.id == 4">
                        <div class="row" >
                            <label class="col-md-3 col-sm-3 col-xs-3 control-label" >Root disk controller</label>
                            <div class="col-md-9 col-sm-9 col-xs-9">
                                <select class="form-control input-group" name="rootDiskController" data-ng-model="template.rootDiskController" ng-options="rootDiskController.name for rootDiskController in template.hypervisor.rootDiskControllerList" >
                                    <option value="">No Thanks</option>
                                </select>
                                <i tooltip="Choose the Root disk controller"  class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>

                            </div>
                        </div>
                    </div>


                    <div class="form-group" data-ng-show="template.hypervisor.id == 4">
                        <div class="row" >
                            <label class="col-md-3 col-sm-3 col-xs-3 control-label" >NIC adapter type</label>
                            <div class="col-md-9 col-sm-9 col-xs-9">
                                <select  class="form-control input-group" name="nicType" data-ng-model="template.nicType" ng-options="nicType.name for nicType in template.hypervisor.nicTypeList" >
                                    <option value="">No Thanks</option>
                                </select>
                                <i tooltip="Choose the Nic adapter type list"   class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                            </div>

                        </div>
                    </div>


                    <div class="form-group" data-ng-show="template.hypervisor.id == 4">
                        <div class="row" >
                            <label class="col-md-3 col-sm-3 col-xs-3 control-label" >Keyboard type</label>
                            <div class="col-md-9 col-sm-9 col-xs-9">
                                <select  class="form-control input-group" name="format" data-ng-model="template.keyboardType" ng-options="keyboardType.name for keyboardType in template.hypervisor.keyboardTypeList" >
                                    <option value="">No Thanks</option>
                                </select>
                                <i tooltip="Choose the Keyboard type"   class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                            </div>

                        </div>
                    </div>


                    <div class="form-group"  ng-class="{
                                            'has-error'
                                            : uploadTemplateForm.format.$invalid && formSubmitted}">
                        <div class="row" >
                            <label class="col-md-3 col-sm-3 col-xs-3 control-label" >Format<span class="text-danger">*</span></label>
                            <div class="col-md-9 col-sm-9 col-xs-9">
                                <select required="true" class="form-control input-group" name="format" data-ng-model="template.format" ng-options="format.name for format in template.hypervisor.formatList" >
                                    <option value="">Select</option>

                                </select>
                                <span class="help-block m-b-none" ng-show="uploadTemplateForm.format.$invalid && formSubmitted" >Format is required.</span>
                                <i tooltip="Choose the Format"   class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="col-md-9 col-sm-9 col-xs-9">
					<div class="form-group" ng-class="{'text-danger': TemplateForm.osCategory.$invalid && formSubmitted}">
                            <div class="row" >
                                <label class="col-md-4 col-sm-3 col-xs-3 control-label" ><fmt:message key="template.oscategory" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-6  col-sm-7 col-xs-7">
                                    <select required="true" class="form-control input-group" name="osCategory" data-ng-change="categoryChange()" data-ng-model="templates.osCategory" ng-options="osCategory.name for osCategory in formElements.osCategoryList" data-ng-class="{'error': TemplateForm.osCategory.$invalid && formSubmitted}" >
                                        <option value="">Select</option>
                                    </select>
                                    <i tooltip="<fmt:message key="template.oscategory.tooltip" bundle="${msg}" />"  class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="TemplateForm.osCategory.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="template.oscategory.error" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                </div>
                            </div>
                        </div>


                    <div class="form-group" ng-class="{
                                            'has-error'
                                            : uploadTemplateForm.osType.$invalid && formSubmitted}">
                        <div class="row" >
                            <label class="col-md-3 col-sm-3 col-xs-3 control-label" >OS Type<span class="text-danger">*</span></label>
                            <div class="col-md-9 col-sm-9 col-xs-9">
                                <select required="true" class="form-control input-group" name="osType" data-ng-model="template.osType" ng-options="osType.name for osType in formElements.osTypeList" >
                                    <option value="">Select</option>
                                </select>
                                <span class="help-block m-b-none" ng-show="uploadTemplateForm.osType.$invalid && formSubmitted" >OS Type is required.</span>
                                <i tooltip="Choose the type"  class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-6 col-lg-6">
                                <label> <input icheck type="checkbox" ng-model="template.extractable"> Extractable </label>
                            </div>
                            <div class="col-md-6 col-lg-6">
                                <label> <input icheck type="checkbox" ng-model="template.passwordEnabled"> Password Enabled </label>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-6">
                                <label> <input icheck type="checkbox" ng-model="template.dynamicallyScalable"> Dynamically Scalable </label>
                            </div>
                            <div class="col-md-6">
                                <label> <input icheck type="checkbox" ng-model="template.share"> Share </label>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-6">
                                <label> <input icheck type="checkbox" ng-model="template.featured"> Featured </label>
                            </div>
                            <div class="col-md-6">
                                <label> <input icheck type="checkbox" ng-model="template.routing"> Routing </label>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-6">
                                <label> <input icheck type="checkbox" ng-model="template.hvm"> HVM </label>
                            </div>
                            <div class="col-md-6">
                            </div>
                        </div>
                    </div>

                    <div class="form-group" ng-class="{'has-error': uploadTemplateForm.rate.$invalid && formSubmitted}">
                        <div class="row">
                            <label class="col-md-3 col-sm-3 control-label">Rate Per GB<span class="text-danger">*</span></label>
                            <div class="col-md-9 col-sm-9 col-xs-9">
                                <input required="true" type="number" name="rate" data-ng-model="template.rate" class="form-control" >
                                <span class="help-block m-b-none" ng-show="uploadTemplateForm.rate.$invalid && formSubmitted" >Rate is required.</span>
                                <i  tooltip="Enter the rate"  class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div class="modal-footer">
            <div class="row">
                <div class="col-md-12  col-sm-12">
                    <span class="pull-right">
                        <a class="btn btn-default btn-outline"  data-ng-click="cancel()">Cancel</a>
                        <button class="btn btn-info" type="submit" ng-disabled="form.uploadTemplateForm.$invalid" >Register</button>
                    </span>
                </div>
            </div>
        </div>

    </div>
</form>