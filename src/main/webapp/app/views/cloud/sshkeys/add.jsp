

<form name="form.sshForm" ng-submit="submitForm()" >

    <div class="modal-header">
        <panda-modal-header hide-zone="true" page-icon="fa fa-key" page-title="Create SSH Key"></panda-modal-header>                
        <!--<div class=" font-bold">Create SSH Key </div>--> 

    </div>
    <div class="modal-body ">
        <div class="form-group has-error">

            <div>
                <input type="text" name="name" class="form-control"  ng-model="sshKey.name" placeholder="SSH Key Name" required>
                <p ng-show="form.sshForm.name.$invalid && !form.sshForm.name.$pristine" class="help-block">Enter SSH Key</p>
            </div>


        </div>
       
    </div>
     <div class="modal-footer">
            <button type="button" class="btn btn-default " ng-click="cancel()" data-dismiss="modal">Cancel</button>
            <button type="submit" class="btn btn-info" data-dismiss="modal" ng-disabled="form.sshForm.$invalid">Create</button>

        </div>
</form>




