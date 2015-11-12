<div class="row">
    <div class="col-lg-7 col-md-7 col-sm-12 project-information">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-cloud m-r-xs"></i>Project Information</h3>
            </div>
            <div class="panel-body no-padding">
                <div class="row">
                    <div class="col-md-6 col-sm-6 border-right m-l-n-xxs h-260">
                        <ul class="list-group">
                            <li class="list-group-item">
                                <label for="projectInfoId" class="font-normal m-r-md">Project</label>
                                <div class="font-bold pull-right" id="projectInfoId">
                                    {{ projectInfo.id}} |
                                    <span class="m-l-xs text-info">{{ projectInfo.accountType.name}}</span> |
                                    <span class="m-l-xs" data-ng-class="projectInfo.status.name == 'ACTIVE' ? 'text-success': 'text - danger'">{{ projectInfo.status.name}}</span>
                                </div>
                            </li>
                            <li class="list-group-item">
                                <label for="projectInfoCardVerified" class="font-normal m-r-md">Card Verified</label>
                                <div class="font-bold pull-right" id="projectInfoCardVerified" data-ng-show="projectInfo.cardVerified">Verified</div>
                                <div class="font-bold pull-right" id="projectInfoCardVerified" data-ng-hide="projectInfo.cardVerified">Not Verified</div>
                            </li>
                            <li class="list-group-item">
                                <label for="projectInfoFirstName" class="font-normal m-r-md">First Name</label>
                                <div class="font-bold pull-right" id="projectInfoFirstName"> {{ projectInfo.firstName}}</td>
                            </li>
                            <li class="list-group-item">
                                <label for="projectInfoLastName" class="font-normal m-r-md">Last Name</label>
                                <div class="font-bold pull-right" id="projectInfoLastName"> {{ projectInfo.lastName}}</td>
                            </li>
                            <li class="list-group-item">
                                <label for="projectInfoUserName" class="font-normal m-r-md">User Name</label>
                                <div class="font-bold pull-right" id="projectInfoUserName"> {{ projectInfo.userName}}</td>

                            </li>


                        </ul>
                    </div>

                </div>




            </div>
        </div>
    </div>

</div>


 <div class="row panel-body" ng-controller="editProjectCtrl">
                <input class="hidden" checked type="checkbox"  ng-model="oneAtATime">

                <accordion close-others="oneAtATime">
                    <accordion-group is-open="status.basic">
                        <accordion-heading>
                            Project Information <i class="pull-right glyphicon" ng-class="{'glyphicon-chevron-down': status.basic, 'glyphicon-chevron-right': !status.basic}"></i>
                        </accordion-heading>
                        <div class="row">
                            <div class="col-md-7 col-sm-7 col-xs-7">
                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right">Username</span></label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <input  type="text" name="user" data-ng-model="profile.user" class="form-control" focus/>

                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right">Email</span></label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <input  type="text" name="email" data-ng-model="profile.email" class="form-control" readonly/>

                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right">Telephone</span></label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <input  type="text" name="telephone" data-ng-model="profile.telephone" class="form-control" readonly/>

                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right">Name</span></label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <input  type="text" name="name" data-ng-model="profile.name" class="form-control" focus/>

                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right">Company</span></label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <input  type="text" name="company" data-ng-model="profile.company" class="form-control" />

                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4 col-sm-4 col-xs-4"></div>
                                    <div class="col-md-6 col-sm-6 col-xs-6">
                                        <input  type="submit"   class="btn btn-info" value="Update"/>
                                    </div>
                                </div>

                            </div>


                        </div>
                    </accordion-group>
                    <accordion-group is-open="status.password">
                        <accordion-heading>
                            Users and Roles<i class="pull-right glyphicon" ng-class="{'glyphicon-chevron-down': status.password, 'glyphicon-chevron-right': !status.password}"></i>
                        </accordion-heading>
                        <div class="row">
                            <div  ng-include="'app/views/project/users.jsp'"></div>


                        </div> </accordion-group>

                </accordion>



            </div>
