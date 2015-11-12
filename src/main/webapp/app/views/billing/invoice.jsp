
<div class="row" ng-controller="billingCtrl">
    <div class="col-lg-12 m-l-sm m-r-sm m-b-sm">
        <div class="hpanel">
                <div class="panel-heading">
                    
                </div>
                <div class="panel-body">
                <div class="dataTables_wrapper table-responsive form-inline dt-bootstrap no-footer" id="example2_wrapper"><div class="row"><div class="col-sm-6"><div id="example2_length" class="dataTables_length"><label>Show <select class="form-control input-sm" aria-controls="example2" name="example2_length"><option value="10">10</option><option value="25">25</option><option value="50">50</option><option value="100">100</option></select> entries</label></div></div><div class="col-sm-6"><div class="dataTables_filter" id="example2_filter"><label>Search:<input aria-controls="example2" placeholder="" class="form-control input-sm" type="search"></label></div></div></div><div class="row"><div class="col-sm-12"><table aria-describedby="example2_info" role="grid" id="example2" class="table table-striped table-bordered table-hover dataTable no-footer">
                <thead>
                <tr>
                        <th>Invoice No</th>
                        <th>Previous Balance (<app-currency-label></app-currency-label>)</th>
                        <th>Payments (<app-currency-label></app-currency-label>)</th>
                        <th>Current Usage (<app-currency-label></app-currency-label>)</th>
                        <th>Total Payable (<app-currency-label></app-currency-label>)</th>
                        <th>Previous Invoice Date</th>
                        <th>Invoice Date</th>
                        <th>Action</th>
                    </tr> </thead>
                <tbody>
              <tr role="row" data-ng-repeat="invoice in invoiceList">
                        <td>
                            <a class="text-primary" ui-sref="cloud.view-instance({id: {{ invoice.invoiceno }}})"  title="View Instance" >{{ invoice.invoiceno }}</a>
                        </td>
                        <td ng-class="(invoice.previousBalance === '0.00') ? '' : 'text-danger'">{{ invoice.previousBalance }}</td>
                        <td ng-class="(invoice.payments === '0.00') ? '' : 'text-success'">{{ invoice.payments }}</td>
                        <td>{{ invoice.currentUsage }}</td>
                        <td class="text-info">{{ invoice.totalPayable }}</td>
                        <td>
                            {{ invoice.previousInvoiceDate }}
                        </td>
                        <td>{{ invoice.invoiceDate }}</td>
                        <td>
                            <a title="{{ instance.invoiceno }}"><span class="fa fa-file-pdf-o text-danger"></span></a>
                        </td>
                    </tr></tbody>
                </table></div></div><div class="row"><div class="col-sm-6"><div aria-live="polite" role="status" id="example2_info" class="dataTables_info"></div></div><div class="col-sm-6"><div id="example2_paginate" class="dataTables_paginate paging_simple_numbers"><ul class="pagination"><li id="example2_previous" tabindex="0" aria-controls="example2" class="paginate_button previous disabled"><a href="#">Previous</a></li><li tabindex="0" aria-controls="example2" class="paginate_button active"><a href="#">1</a></li><li tabindex="0" aria-controls="example2" class="paginate_button "><a href="#">2</a></li><li tabindex="0" aria-controls="example2" class="paginate_button "><a href="#">3</a></li><li tabindex="0" aria-controls="example2" class="paginate_button "><a href="#">4</a></li><li tabindex="0" aria-controls="example2" class="paginate_button "><a href="#">5</a></li><li id="example2_next" tabindex="0" aria-controls="example2" class="paginate_button next"><a href="#">Next</a></li></ul></div></div></div></div>
                </div>
            </div>
    </div>
</div>
    .