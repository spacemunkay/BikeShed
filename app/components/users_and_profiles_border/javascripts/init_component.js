{
  initComponent: function(){
    // calling superclass's initComponent
    this.callParent();
    var stats = this.getComponent('user_stats');
    if (stats != undefined){
      stats.updateStats();
    }

    // setting the 'rowclick' event
    var view = this.getComponent('users').getView();
    view.on('itemclick', function(view, record){
      // The beauty of using Ext.Direct: calling 3 endpoints in a row, which results in a single call to the server!
      this.selectUser({user_id: record.get('id')});
      this.getComponent('user_profiles').getStore().load();
      this.getComponent('user_logs').getStore().load();
    }, this);
  }
}
