<div class="row"> 
    <div class="col-md-8 font-bold">
        <span class="ver-align-mid"><i class="{{ pageIcon }} pe-lg" data-ng-hide="pageCustomIcon" title="{{ pageTitle }}"></i>
            <img src="{{pageCustomIcon}}" style="width:22px; height:22px;" data-ng-show="pageCustomIcon"  alt="{{pageTitle}}"> 
        </span>
        <span class="ver-align-mid" >{{ pageTitle }}</span>
    </div>
    
    <div class="col-md-4">
        <div class="pull-right font-extra-bold" >
            <span data-ng-hide="hideZone"  class="ver-align-mid"  title="Zone"><i class="fa fa-map-marker m-r-xsm" ></i> {{ global.zone.name}}</span>
            <a class="close-container" href="javascript:void(0);" data-ng-click="cancel()" ><img src="images/close3.png" alt="Close" /></a>
        </div>
    </div>
</div>