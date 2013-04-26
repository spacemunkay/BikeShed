{
  initComponent: function(){
    // calling superclass's initComponent
    this.callParent();

    // setting the 'rowclick' event
    var view = this.getComponent('bikes').getView();
    view.on('itemclick', function(view, record){
      // The beauty of using Ext.Direct: calling 3 endpoints in a row, which results in a single call to the server!
      this.selectBike({bike_id: record.get('id')});
      if( this.queryById('bike_logs') ){
        this.queryById('bike_logs').getStore().load();
        this.queryById('bike_logs').setReadOnly({}, function(arg, arg1, arg2){
          console.log(arg);
          console.log(this.getDockedItems());
          });
        this.queryById('bike_logs').setDisabled(true);
      }
      if( this.queryById('tasks') ){
        this.queryById('tasks').getStore().load();
      }
    }, this);
  }
}
