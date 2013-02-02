{
  initComponent: function(){
    // calling superclass's initComponent
    this.callParent();

    // setting the 'rowclick' event
    var view = this.getComponent('user_transactions').getView();
    view.on('itemclick', function(view, record){
      // The beauty of using Ext.Direct: calling 3 endpoints in a row, which results in a single call to the server!
      this.selectTransaction({transaction_id: record.get('id')});
      this.getComponent('transaction_logs').getStore().load();
    }, this);
  }
}
