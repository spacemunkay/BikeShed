{
  initComponent: function(){
    // calling superclass's initComponent
    this.callParent();
    // TESTTING
    //due to Netzke bug, :min_chars attribute doesn't work
    var min_char_columns = [
      "user_action__purpose"
    ];

    // Ext.each(min_char_columns, function(column, index) {
    //   Ext.ComponentManager.get(column).editor.minChars = 1;
    // });

    var view = this.getView();

    view.on('itemclick', function(view, record){
      console.log('clicking ');
      // The beauty of using Ext.Direct: calling 3 endpoints in a row, which results in a single call to the server!
      // console.log('Old record', record);
    }, this);

    view.on('itemupdate', function(record, index, node){
      console.log('Updating item');
      // if('end_date' in record.data.modified){
      //   console.log('start', record.data.start_date);
      //   console.log('end', record.data.end_date);
      // }else if('start_date' in record.data.modified){

      // }
    }, this);

    // var hoursInput = Ext.getCmp('user_logs_add_form_hours-inputEl');

    // console.log(hoursInput);

    // hoursInput.on('change', function(field, newValue, oldValue){
    //   console.log('Hours changing...', newValue);
    // });

  },

  addNewItem: function(e){
    e.fireEvent('click', {});
    console.log(e);
    console.log('Adding new item');
  }

}
