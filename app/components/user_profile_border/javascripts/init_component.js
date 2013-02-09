{
  initComponent: function(){
    // calling superclass's initComponent
    this.callParent();
    this.getComponent('user_stats').updateStats();

    var store = this.getComponent('user_logs').getStore()
    store.on('load', function (store, records, operation, success){
        this.getComponent('user_stats').updateStats();
      }, this);
  }
}
