

<form name="supportForm" data-ng-submit="validateTicket(supportForm)" method="post" novalidate="" data-ng-controller="addTicketCtrl" >

    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa-ticket fa" page-title="Add Ticket"></panda-modal-header>

        </div>

        <div class="modal-body">
            <div class="row"  >
                <div class="col-md-12">
                    <div class="form-group" ng-class="{'text-danger': supportForm.department.$invalid && formSubmitted}">
                        <div class="row" >
                            <label class="col-md-3 col-sm-3 control-label" >Department
                                <span class="text-danger">*</span>
                            </label>

                            <div class="col-md-5 col-sm-5">

                                <select required="true" class="form-control input-group" data-ng-class="{'error': supportForm.department.$invalid && formSubmitted}" name="department" data-ng-model="support.department" ng-options="department.name for department in formElements.departmentList" >
                                    <option value="">Select</option>
                                </select>
                                <div class="error-area" data-ng-show="supportForm.department.$invalid && formSubmitted" ><i  tooltip="Department is Required" class="fa fa-warning error-icon"></i></div>
                            </div>

                        </div>
                    </div>

                    <div class="form-group" ng-class="{'text-danger': supportForm.priority.$invalid && formSubmitted}">
                        <div class="row" >
                            <label class="col-md-3 col-sm-3 control-label" >Priority
                                <span class="text-danger">*</span>
                            </label>

                            <div class="col-md-5 col-sm-5 ">
                                <select required="true" class="form-control input-group" data-ng-class="{'error': supportForm.priority.$invalid && formSubmitted}" name="priority" data-ng-model="support.priority" ng-options="priority.name for priority in formElements.priorityList" >
                                    <option value="">Select</option>
                                </select>
                                <div class="error-area" data-ng-show="supportForm.priority.$invalid && formSubmitted" ><i  tooltip="Priority is Required" class="fa fa-warning error-icon"></i></div>
                            </div>

                        </div>
                    </div>
                    <div class="form-group" ng-class="{
                                            'text-danger'
                                            :supportForm.subject.$invalid && formSubmitted}">
                        <div class="row">
                            <label class="col-md-3 col-sm-3 control-label">Subject
                                <span class="text-danger">*</span>
                            </label>

                            <div class="col-md-5 col-sm-5">
                                <input required="true" type="text" name="subject" data-ng-model="support.subject" class="form-control" data-ng-class="{'error': supportForm.subject.$invalid && formSubmitted}">
                                <div class="error-area" data-ng-show="supportForm.subject.$invalid && formSubmitted" ><i  tooltip="Subject is Required" class="fa fa-warning error-icon"></i></div>
                            </div>

                        </div>
                    </div>
                    <div class="form-group" ng-class="{
                                            'text-danger'
                                            :supportForm.content.$invalid && formSubmitted}">
                        <div class="row">
                            <label class="col-md-3 col-sm-3 control-label">Content
                                <span class="text-danger">*</span>
                            </label>

                            <div class="col-md-7 col-sm-7">

                                <textarea rows="4" required="true" type="text" name="content" data-ng-model="support.content" class="form-control" data-ng-class="{'error': supportForm.content.$invalid && formSubmitted}"></textarea>
                                <div class="error-area" data-ng-show="supportForm.content.$invalid && formSubmitted" ><i  tooltip="Content is Required" class="fa fa-warning error-icon"></i></div>


                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="modal-footer">
            <button type="button" class="btn btn-default " ng-click="cancel()" data-dismiss="modal">Cancel</button>
            <button class="btn btn-info" type="submit">Send</button>

        </div></div>
</form>




