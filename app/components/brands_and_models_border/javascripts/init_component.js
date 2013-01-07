{
  initComponent: function(){
    // calling superclass's initComponent
    this.callParent();

    // setting the 'rowclick' event
    var view = this.getComponent('bike_brands').getView();
    view.on('itemclick', function(view, record){
      // The beauty of using Ext.Direct: calling 3 endpoints in a row, which results in a single call to the server!
      this.selectBikeBrand({bike_brand_id: record.get('id')});
      this.getComponent('bike_models').getStore().load();
    }, this);
  }
}
