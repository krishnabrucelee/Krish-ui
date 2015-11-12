<md-dialog aria-label="Volume Snapshot">
  <form>
  <md-toolbar style="background-color: #71B1D1 !important;">
    <div class="md-toolbar-tools">
        <h4><span class="p-xs nowrap"><i class="fa medium fa-camera-retro"></i></span> Take Snapshot</h4>
      <span flex></span>
      <md-button class="md-icon-button" ng-click="answer('not applicable')">
        <md-icon class="pe-2x pe-7s-close" aria-label="Close dialog"></md-icon>
      </md-button>
    </div>
  </md-toolbar>
  <md-dialog-content >
    <div class="fa-1x">
      <p class="text-primary">
          Please confirm that you want to take a snapshot of this volume.</p>
      <span class="text-center text-nowrap text-danger">
          <span> Pricing:-</span> $0.095 per GB-month of data stored
      </span>
    </div>


   
  </md-dialog-content>
  <div class="md-actions m-t-md" layout="row">
   
    <md-button class="btn-primary" ng-click="answer('not useful')">
     Yes
    </md-button>
    <md-button ng-click="answer('useful')" style="margin-right:20px;">
     No
    </md-button>
  </div>
  </form>
</md-dialog>


