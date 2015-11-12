<table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
    <thead>
        <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Zone</th>
            <th>CIDR</th>
            <th>State</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <tr data-ng-repeat="network in networkList| filter: quickSearch">
            <td>
                <a class="text-info" ui-sref="cloud.list-network.view-network({id: {{ network.id}}})"  title="View Network" >{{ network.name}}</a>
            </td>
            <td>{{ network.displaytext}} </td>
            <td>{{ network.zonename}} </td>
            <td>{{ network.cidr}} </td>
            <td><label class="label label-success text-center text-white"> {{ network.state}} </label></td>

            <td>
                <a class="icon-button" title="Edit">                    
                    <span class="fa fa-edit m-r"> </span>
                </a>
                <a class="icon-button" title="Delete"  ><span class="fa fa-trash"></span></a>
            </td>
        </tr>
    </tbody>
</table>