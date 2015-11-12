<div class="row" data-ng-show="(paginationObject.totalItems >  (((paginationObject.currentPage - 1) * 10) + 10)) || paginationObject.currentPage > 1">
    <div class="col-sm-2" data-ng-show="paginationObject.totalItems > (((paginationObject.currentPage - 1) * 10) + 10)"><div class="dataTables_info" id="example1_info" role="status" aria-live="polite">Showing {{ ((paginationObject.currentPage - 1) * 10) + 1}} to {{ ((paginationObject.currentPage - 1) * 10) + 10}} of {{ paginationObject.totalItems}} entries</div></div>
    <div class="col-sm-2" data-ng-hide="paginationObject.totalItems > (((paginationObject.currentPage - 1) * 10) + 10)"><div class="dataTables_info" id="example1_info" role="status" aria-live="polite">Showing {{ ((paginationObject.currentPage - 1) * 10) + 1}} to {{ paginationObject.totalItems}} of {{ paginationObject.totalItems}} entries</div></div>
    <div class="col-sm-4">
        <div class="dataTables_length" id="example1_length"><label>Show 
                <select data-ng-model="paginationObject.limit" data-ng-change="list(1)" aria-controls="example1" class="form-control input-sm">
                    <option value="10">10</option>
                    <option value="25">25</option>
                    <option value="50">50</option>
                    <option value="100">100</option>
                </select> entries</label>
        </div>
    </div>
    <div class="col-sm-6"><div class="dataTables_paginate paging_simple_numbers" id="example1_paginate"> 
            <pagination boundary-links="true" total-items="paginationObject.totalItems" items-per-page="paginationObject.limit" max-size="5"  ng-model="paginationObject.currentPage" ng-change="list(paginationObject.currentPage)" class="pagination-sm" previous-text="&lsaquo;" next-text="&rsaquo;" first-text="&laquo;" last-text="&raquo;"></pagination>
        </div>
    </div>

</div>