{
  initComponent: function(){
    // calling superclass's initComponent
    this.callParent();
    var stats = this.queryById('user_stats');
    if (stats != undefined){
      stats.updateStats();
    }

    if( this.queryById('user_profiles')){
      this.queryById('user_profiles').disable();
    }

    if( this.queryById('user_logs')){
      this.queryById('user_logs').disable();
      //update user stats
      var store = this.queryById('user_logs').getStore()
      store.on('load', function (store, records, operation, success){
        if( this.queryById('user_stats') ){
          this.queryById('user_stats').updateStats();
        }
      }, this);

    }
    if( this.queryById('user_stats') ){
      this.queryById('user_stats').disable();
    }

    // setting the 'rowclick' event
    var view = this.getComponent('users').getView();
    view.on('itemclick', function(view, record){
      // The beauty of using Ext.Direct: calling 3 endpoints in a row, which results in a single call to the server!
      this.selectUser({user_id: record.get('id')});

      if( this.queryById('user_profiles')){
        this.queryById('user_profiles').getStore().load();
        this.queryById('user_profiles').enable();
      }
      if( this.queryById('user_logs')){
        this.queryById('user_logs').getStore().load();
        this.queryById('user_logs').enable();
      }
      if( this.queryById('user_stats') ){
        this.queryById('user_stats').updateStats();
        this.queryById('user_stats').enable();
      }
    }, this);
  }
}
