<div class="row">
    <div class="col-md-12 col-sm-12">
        <div class="hpanel">

            <div class="panel-body">

                <div class="form-group" ng-class="{
                                            'has-error'
                                            : configForm.applicationURL.$invalid && formSubmitted}">
                    <div class="row">
                        <label class="col-md-3 col-sm-3 control-label">Application URL:
                            <span class="text-danger">*</span>
                        </label>

                        <div class="col-md-5 col-sm-5">
                            <input required="true" type="text" name="applicationURL" data-ng-model="config.applicationURL" class="form-control" >
                            <span class="help-block m-b-none" ng-show="configForm.applicationURL.$invalid && formSubmitted" >Application URL is required.</span>


                        </div>

                    </div>
                </div>
                <div class="form-group" ng-class="{
                                            'has-error'
                                            : configForm.host.$invalid && formSubmitted}">
                    <div class="row">
                        <label class="col-md-3 col-sm-3 control-label">Host:
                            <span class="text-danger">*</span>
                        </label>

                        <div class="col-md-5 col-sm-5">
                            <input required="true" type="text" name="host" data-ng-model="config.host" class="form-control" >
                            <span class="help-block m-b-none" ng-show="configForm.host.$invalid && formSubmitted" >Host is required.</span>


                        </div>

                    </div>
                </div>
                <div class="form-group" ng-class="{
                                            'has-error'
                                            : configForm.username.$invalid && formSubmitted}">
                    <div class="row">
                        <label class="col-md-3 col-sm-3 control-label">Username:
                            <span class="text-danger">*</span>
                        </label>

                        <div class="col-md-5 col-sm-5">
                            <input required="true" type="text" name="host" data-ng-model="config.username" class="form-control" >
                            <span class="help-block m-b-none" ng-show="configForm.username.$invalid && formSubmitted" >Username is required.</span>


                        </div>

                    </div>
                </div>
                <div class="form-group" ng-class="{
                                            'has-error'
                                            : configForm.password.$invalid && formSubmitted}">
                    <div class="row">
                        <label class="col-md-3 col-sm-3 control-label">Password:
                            <span class="text-danger">*</span>
                        </label>

                        <div class="col-md-5 col-sm-5">
                            <input required="true" type="text" name="password" data-ng-model="config.password" class="form-control" >
                            <span class="help-block m-b-none" ng-show="configForm.password.$invalid && formSubmitted" >Password is required.</span>


                        </div>

                    </div>
                </div>
                <div class="form-group" ng-class="{
                                            'has-error'
                                            : configForm.port.$invalid && formSubmitted}">
                    <div class="row">
                        <label class="col-md-3 col-sm-3 control-label">Port:
                            <span class="text-danger">*</span>
                        </label>

                        <div class="col-md-5 col-sm-5">
                            <input required="true" type="text" name="port" data-ng-model="config.port" class="form-control" >
                            <span class="help-block m-b-none" ng-show="configForm.port.$invalid && formSubmitted" >Port is required.</span>


                        </div>

                    </div>
                </div>
                <div class="form-group" ng-class="{
                                            'has-error'
                                            : configForm.ssl.$invalid && formSubmitted}">
                    <div class="row">
                        <label class="col-md-3 col-sm-3 control-label">SSL:
                            <span class="text-danger">*</span>
                        </label>

                        <div class="col-md-5 col-sm-5">
                           <label> <input icheck type="checkbox" data-ng-model="config.ssl"> </label>
                            </div>

                    </div>
                </div>
                <div class="form-group" ng-class="{
                                            'has-error'
                                            : configForm.from.$invalid && formSubmitted}">
                    <div class="row">
                        <label class="col-md-3 col-sm-3 control-label">From:
                            <span class="text-danger">*</span>
                        </label>

                        <div class="col-md-5 col-sm-5">
                            <input required="true" type="text" name="from" data-ng-model="config.from" class="form-control" >
                            <span class="help-block m-b-none" ng-show="configForm.from.$invalid && formSubmitted" >From is required.</span>


                        </div>

                    </div>
                </div>
                 <div class="form-group" ng-class="{
                                            'has-error'
                                            : configForm.senderName.$invalid && formSubmitted}">
                    <div class="row">
                        <label class="col-md-3 col-sm-3 control-label">Sender Name:
                            <span class="text-danger">*</span>
                        </label>

                        <div class="col-md-5 col-sm-5">
                            <input required="true" type="text" name="senderName" data-ng-model="config.senderName" class="form-control" >
                            <span class="help-block m-b-none" ng-show="configForm.senderName.$invalid && formSubmitted" >Sender Name is required.</span>


                        </div>

                    </div>
                </div>
            </div>
        </div>


    </div>
</div>