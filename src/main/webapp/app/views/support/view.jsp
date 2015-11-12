<form data-ng-controller="supportListCtrl">
    <div class="hpanel"> 
        <div class="panel-heading">
            <div class="row">
                <div class="col-md-12 col-sm-12">


                    <span class="pull-right" >
                        <a class="btn btn-info" title="Delete " data-ng-click="delete()" ><span class="fa fa-trash"></span> Delete</a>
                        <a class="btn btn-info" title="Archive" data-ng-click="archive()" ><span class="fa fa-file-archive-o"></span> Archive</a>

                        <a class="btn btn-info" ui-sref="support.view-ticket" title="Refresh" ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
                    </span>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>

        <div class="col-md-3 col-sm-3 ">
            <div class="panel-body">

                <div class="form-group" >
                    <div class="row" > 
                        <label class="col-md-6 col-sm-6 control-label" >ID:

                        </label>
                        <div class="col-md-6 col-sm-6 ">
                            <span class=" text-center">1 </span>



                        </div>

                    </div>
                </div>
                <div class="form-group" >
                    <div class="row" > 
                        <label class="col-md-6 col-sm-6 control-label" >Department:

                        </label>
                        <div class="col-md-6 col-sm-6 ">
                            <span class=" text-center">Testing Team </span>



                        </div>

                    </div>
                </div>
                <div class="form-group" >
                    <div class="row" > 
                        <label class="col-md-6 col-sm-6 control-label" >Subject:

                        </label>
                        <div class="col-md-6 col-sm-6 ">
                            <span class=" text-center">I need VM </span>



                        </div>

                    </div>
                </div>
                <div class="form-group" >
                    <div class="row" > 
                        <label class="col-md-6 col-sm-6 control-label" >Priority:

                        </label>
                        <div class="col-md-6 col-sm-6 ">
                            <span class=" text-center">High </span>



                        </div>

                    </div>
                </div> 
            </div>
        </div>
        <div class="col-md-9 col-sm-9 ">

            <div class="panel-body">

                <div class="form-group" >
                    <div class="row" > 
                        <label class="col-md-2 col-sm-2 control-label" >Description:

                        </label>
                        <div class="col-md-10 col-sm-10 ">
                            <span class=" text-center">"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"
                            </span>



                        </div>

                    </div>
                </div>                
            </div>



        </div></div>
</form>