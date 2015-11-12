<form name="form.userForm" ng-submit="submitForm()" >

    <div class="modal-content">


        <div class="modal-header">
            <panda-modal-header hide-zone="true" page-icon="fa fa-pie-chart" page-title="Quota Limt"></panda-modal-header>                
        </div>
        <div class="modal-body">
            <div class=" row">
                
                <div >
                    <label class="form-group col-md-4 col-sm-4  col-xs-12">{{ quotaReason.title }} </label>

                </div>
                <div class="form-group col-md-3 col-sm-3  col-xs-12">
                    Available : {{quotaReason.options[1].value }}
                </div>
                <div class="form-group col-md-2  col-sm-2  col-xs-12">
                    Used : {{quotaReason.options[0].value }}
                </div>
                <div class="form-group has-error col-md-3  col-sm-3  col-xs-12 m-t-n-xs">
                    <input type="text" name="needed" valid-number  class="form-control input-small"  ng-model="name" placeholder="Needed" required>
                    <p ng-show="form.userForm.name.$invalid && !form.userForm.name.$pristine" class="help-block">Quota Limit should not be blank</p>
                </div>
            </div>
            <div class="form-group has-error">
                <textarea placeholder="Reason" class="form-control" cols="18" rows="3" id="comment" name="reason" ng-model="reasondetails" required></textarea>
                <p ng-show="form.userForm.reason.$invalid && !form.userForm.reason.$pristine" class="help-block"><span class="error">Details Required.</span></p>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default " ng-click="cancel()" data-dismiss="modal">Cancel</button>
            <button type="submit" class="btn btn-info" data-dismiss="modal" ng-disabled="form.userForm.$invalid">Request</button>

        </div>
    </div>

</form>