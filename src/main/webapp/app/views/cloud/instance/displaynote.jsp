<form name="noteForm" ng-controller="instanceListCtrl">
    <div class="inmodal" >

        <div class="modal-header">
            <panda-modal-header hide-zone="true" page-icon="fa-file-text fa" page-title="Display Note"></panda-modal-header>
        </div>
        <div class="modal-body ">
            <div class="form-group has-error">
                <div>
                    <textarea placeholder="" class="form-control" cols="18" rows="3" id="comment" name="reason"  data-ng-model="instance.instanceNote" readonly ></textarea>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-info " ng-click="cancel()" data-dismiss="modal">OK</button>

        </div>
    </div>
</form>




