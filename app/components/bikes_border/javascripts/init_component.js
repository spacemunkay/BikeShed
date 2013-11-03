{
  initComponent: function(){
    // calling superclass's initComponent
    this.callParent();

    // setting the 'rowclick' event
    var view = this.getComponent('bikes').getView();

    //disable until a bike is clicked
    var bike_logs_comp = this.queryById('bike_logs');
    if( bike_logs_comp){
      bike_logs_comp.disable();
    }
    var bike_tasks_comp = this.queryById('tasks');
    if( bike_tasks_comp ){
      bike_tasks_comp.disable();
    }

    view.on('itemclick', function(view, record){
      // The beauty of using Ext.Direct: calling 3 endpoints in a row, which results in a single call to the server!
      this.selectBike({bike_id: record.get('id')});
      // query for these components again, can change if not visible because of accordian
      var bike_logs_comp = this.queryById('bike_logs');
      var bike_tasks_comp = this.queryById('tasks');
      if( bike_logs_comp ){
        bike_logs_comp.getStore().load();
        bike_logs_comp.enable();
      }
      if( bike_tasks_comp ){
        bike_tasks_comp.getStore().load();
        bike_tasks_comp.enable();
      }
    }, this);
  }
}
