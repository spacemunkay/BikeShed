{
  initComponent: function(){
    // calling superclass's initComponent
    this.callParent();

    // setting the 'rowclick' event
    var view = this.getView();
    view.on('itemclick', function(view, record){
      // The beauty of using Ext.Direct: calling 3 endpoints in a row, which results in a single call to the server!
      this.selectBikeBrand({bike_brand_id: record.get('bike_brand__brand')});
    }, this);
  },
  colorBlock: function(value){
    return Ext.String.format('<div style="display:inline-block">{1}</div><div style="background-color:#{0};width:50px;height:10px;display:inline-block;margin:0 5px 0 5px;border:solid;border-color:gray;border-width:1px;"></div>', value, value);
  }
}
