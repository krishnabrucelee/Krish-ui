<table  cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
    <thead>
        <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Domain</th>
            <th>Account</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <tr data-ng-repeat="network in networkList| filter: quickSearch">
            <td>
                <a class="text-info" ui-sref="cloud.list-network.view-network({id: {{ network.id}}})"  title="View Network" >{{ network.namea}}</a>
            </td>
            <td>{{ network.displayTexta}} </td>
            <td>{{ network.domain.naame}} </td>
            <td>{{ network.accounat}} </td>

            <td>
                <a class="icon-button" title="Edit">
                    <span class="fa fa-edit m-r"> </span>
                </a>
              <a class="icon-button" title="Delete "  ><span class="fa fa-trash"></span></a>
            </td>
        </tr>
    </tbody>
</table>