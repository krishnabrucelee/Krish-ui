
<div class="row" ng-controller="instanceCtrl">
    <div class="col-lg-12">
        <div class="hpanel">
            <div class="panel-heading">
                <div panel-tools></div>
                Server List
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
                    <thead>
                    <tr>
                        <th>S.No</th>
                        <th>Name</th>
                        <th>Zone</th>
                        <th>Template</th>
                        <th>Compute Offering</th>
                        <th>Disk Offering</th>
                        <th>State</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr data-ng-repeat="server in serverList">
                        <td>{{ $index + 1 }}</td>
                        <td>{{ server.name }}</td>
                        <td>{{ server.zone.name }}</td>
                        <td>{{ server.template.name }}</td>
                        <td>{{ server.computeOffering.name }}</td>
                        <td>{{ server.diskOffering.name }}</td>
                        <td>{{ server.state }}</td>
                        <td><a href="#/server/view/{{ server.id }}" class="btn btn-info">View</a></td>
                    </tr>
                    </tbody>
                </table>
                </div>
            </div>
        </div>
    </div>
</div>
    .