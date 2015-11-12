    <div class="row">

        <div class="col-md-12 col-sm-12">
            <div class="hpanel">
                <div class="panel-heading">
                    

                    
                </div>

                <div class="white-content">
                    <div class="table-responsive">
                        <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped table-hover table-mailbox">
                            <thead>
                                <tr>

                                    
                            <th class="col-md-2 col-sm-2">Name</th>
                            <th class="col-md-1 col-sm-1">Size</th>
                            <th class="col-md-1 col-sm-1">Status</th>
                            <th class="col-md-1 col-sm-1">Template Owner</th>
                            <th class="col-md-1 col-sm-1">Register Date</th>
                            <th class="col-md-1 col-sm-1">Format</th>
                            <th class="col-md-1 col-sm-1">HVM</th>
                            <th class="col-md-1 col-sm-1">Password Enabled</th>
                            <th class="col-md-1 col-sm-1">Dynamically Scalable</th>
                            <th class="col-md-1 col-sm-1">Action</th>

                            </tr>
                            </thead>
                            <tbody>
                                <tr data-ng-repeat="template in template.templateList| filter:quickSearch">
                                    <td> 
                                        <a data-ng-click="showDescription(template)">
                                            <img src="images/os/{{template.imageName}}_logo.png" alt="" height="30" width="30" class="m-r" > {{ template.name }}
                                        </a>
                                    </td>
                                    <td>{{ template.size }}</td>
                                    <td>{{ template.status }}</td>
                                    <td>{{ template.owner }}</td>
                                    <td>{{ template.registerDate }}</td>
                                    <td>{{ template.format }}</td>
                                    <td>{{ template.hvm }}</td>
                                    <td>{{ template.passwordEnabled }}</td>
                                    <td>{{ template.dynamicallyScalable }}</td>
                                    <td>
                                        <button title="Launch" class="btn btn-info btn-sm pull-right"><i class="fa fa-power-off"></i> Launch</button>
                                    </td>

                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
