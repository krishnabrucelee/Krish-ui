

<form name="archiveForm" data-ng-submit="validateArchive(archiveForm)" method="post" novalidate="" data-ng-controller="addTicketCtrl" >

    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-file-archive-o" page-title="Archive Ticket"></panda-modal-header>

        </div>

        <div class="modal-body">
            <div class=" row">
                <div class="form-group has-error col-md-3 col-sm-3  col-xs-3">

                    <img src="images/warning.png" alt="">
                </div>
                <div class="form-group has-error col-md-9 col-sm-9  col-xs-9 m-t-md">
                    <p>Please confirm that you want to archive this ticket </p>
                </div>


            </div>

        </div>

        <div class="modal-footer">
            <button type="button" class="btn btn-default " ng-click="cancel()" data-dismiss="modal">No</button>
            <button class="btn btn-info" type="submit">Yes</button>
            


        </div>
    </div>
</form>




