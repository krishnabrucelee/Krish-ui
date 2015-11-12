<form name="noteForm" data-ng-submit="update(noteForm)" ng-controller="instanceListCtrl">
    <div class="inmodal" >

        <div class="modal-header">
            <panda-modal-header hide-zone="true" page-icon="fa fa-edit" page-title="Edit Note"></panda-modal-header>
        </div>
        <div class="modal-body ">
            <div class="form-group has-error">
                <div>
                    <textarea placeholder="" class="form-control" cols="18" rows="3" id="comment" name="reason"  data-ng-model="instance.instanceNote"  ></textarea>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn btn-info" type="submit" ng-disabled="form.noteForm.$invalid" data-dismiss="modal" >Update</button>

            <!--<button type="button" class="btn btn-info " ng-click="cancel()" data-dismiss="modal">OK</button>-->

        </div>
    </div>
</form>




