<div class="row" ng-controller="viewServerCtrl">
    <div class="col-lg-12">
        <div class="hpanel">
            <div class="panel-heading">
                Instance - {{ server.name}}
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-lg-3 animated-panel" style="animation-delay: 0.1s;">
                        <div class="hpanel stats">
                            <div class="panel-body h-150">
                                <div class="stats-title pull-left">
                                    <h4>Instance</h4>
                                </div>
                                <div class="stats-icon pull-right">
                                <i class="pe-7s-server fa-4x"></i>
                                </div>
                                
                                <div class="m-t-xl">
                                    <h5 class="text-info">{{ server.name }}</h5>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 animated-panel" style="animation-delay: 0.1s;">
                        <div class="hpanel stats">
                            <div class="panel-body h-150">
                                <div class="stats-title pull-left">
                                    <h4>Zone</h4>
                                </div>
                                <div class="stats-icon pull-right">
                                <i class="pe-7s-global fa-4x"></i>
                                </div>
                                <div class="m-t-xl">
                                <h4 class="text-info">{{ server.zone.name }}</h4>
                                <small>
                                    Description
                                </small>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 animated-panel" style="animation-delay: 0.1s;">
                        <div class="hpanel stats">
                            <div class="panel-body h-150">
                                <div class="stats-title pull-left">
                                    <h4>Template</h4>
                                </div>
                                <div class="stats-icon pull-right">
                                <i class="pe-7s-browser fa-4x"></i>
                                </div>
                                <div class="m-t-xl">
                                <h5 class="text-info">{{ server.template.name }}</h5>
                                <small>
                                    Description
                                </small>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 animated-panel" style="animation-delay: 0.1s;">
                        <div class="hpanel stats">
                            <div class="panel-body h-150">
                                <div class="stats-title pull-left">
                                    <h4>Compute Offering</h4>
                                </div>
                                <div class="stats-icon pull-right">
                                <i class="pe-7s-diskette fa-4x"></i>
                                </div>
                                <div class="m-t-xl">
                                <h5 class="text-info">{{ server.computeOffering.name }}</h5>
                                <small>
                                    1vCPU@2Ghz 1GB RAM
                                </small>
                                </div>
                                <span class="btn btn-xs btn-info pull-right">Update</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 animated-panel" style="animation-delay: 0.1s;">
                        <div class="hpanel stats">
                            <div class="panel-body h-150">
                                <div class="stats-title pull-left">
                                    <h4>Disk Offering</h4>
                                </div>
                                <div class="stats-icon pull-right">
                                <i class="pe-7s-monitor fa-4x"></i>
                                </div>
                                <div class="m-t-xl">
                                <h5 class="text-info">{{ server.dataDiskOffering.name }}</h5>
                                <small>
                                    {{ server.dataDiskOffering }} 5GB 
                                </small>
                                </div>
                                <span class="btn btn-xs btn-info pull-right">Update</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 animated-panel" style="animation-delay: 0.1s;">
                        <div class="hpanel stats">
                            <div class="panel-body h-150">
                                <div class="stats-title pull-left">
                                    <h4>Network</h4>
                                </div>
                                <div class="stats-icon pull-right">
                                    <i class="pe-7s-network fa-4x"></i>
                                </div>
                                <div class="m-t-xl">
                                    <h5 class="text-info">{{ server.network.name }}</h5>
                                    <small>
                                        Description
                                    </small>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    
                </div>
            </div>
        </div>
    </div>
</div>