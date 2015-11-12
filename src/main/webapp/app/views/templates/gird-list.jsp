<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12 ">
        <div class="pull-left">
            <div class="pull-left">
                <a title="Grid View" class="btn btn-info" data-ng-click="listView = !listView"  data-ng-class="!listView ? 'disabled' : ''" > <i class="fa fa-th-large" /></a>
                <a title="List View"  class="btn btn-info" data-ng-click="listView = !listView" data-ng-class="listView ? 'disabled' : ''" > <i class="fa fa-list" /></a>
            </div>
        </div>
        <div class="pull-right">
            <panda-quick-search></panda-quick-search>
            <div class="clearfix"></div>

            <span class="pull-right m-l-sm m-t-sm">
                <a  class="btn btn-info" data-ng-click="uploadTemplateContainer()"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span> Register Template</a>

                <a  class="btn btn-info" title="Refresh"><span class="fa fa-refresh fa-lg "></span></a>
            </span>
        </div>
    </div>
    <div class="clearfix"></div>
</div>