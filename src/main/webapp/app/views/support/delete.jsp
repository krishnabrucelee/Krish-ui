

<form name="deleteForm" data-ng-submit="validateDelete(deleteForm)" method="post" novalidate="" data-ng-controller="addTicketCtrl" >

    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header hide-zone="false" page-icon="fa fa-trash pe-lg" page-title="Delete Ticket"></panda-modal-header>

        </div>

        <div class="modal-body">
            <div class=" row">
                <div class="form-group has-error col-md-3 col-sm-3  col-xs-3">

                    <img src="images/warning.png" alt="">
                </div>
                <div class="form-group has-error col-md-9 col-sm-9  col-xs-9 m-t-md">
                    <p>Are you sure do you want to delete ?</p>
                </div>


            </div>

        </div>

        <div class="modal-footer">
            <button type="button" class="btn btn-default " ng-click="cancel()" data-dismiss="modal">Cancel</button>
            <button class="btn btn-default btn-danger2" type="submit">Ok</button>
            


        </div>
    </div>
</form>




