{
  initComponent: function(){
    // calling superclass's initComponent
    this.callParent();

    // setting the 'rowclick' event
    var user_view = this.getComponent('users').getView();
    var customer_view = this.getComponent('customers').getView();
    user_view.on('itemclick', function(view, record){
      // The beauty of using Ext.Direct: calling 3 endpoints in a row, which results in a single call to the server!
      console.log("user: " + record.get('id') );
      this.selectCustomer({customer_id: record.get('id'), customer_type: 'User'});
    }, this);
    customer_view.on('itemclick', function(view, record){
      console.log("user: " + record.get('id') );
      this.selectCustomer({customer_id: record.get('id'), customer_type: 'Customer'});
    }, this);
  }
}
