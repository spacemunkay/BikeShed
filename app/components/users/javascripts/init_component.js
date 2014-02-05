{
  initComponent: function(){
    // calling superclass's initComponent
    this.callParent();

    //due to Netzke bug, :min_chars attribute doesn't work
    var min_char_columns = ["bike__shop_id"]
    Ext.each(min_char_columns, function(column, index) {
      Ext.ComponentManager.get(column).editor.minChars = 1;
    });

    this.getView().on('itemclick', function(view, record){
      // The beauty of using Ext.Direct: calling 3 endpoints in a row, which results in a single call to the server!
      this.selectCustomer({customer_id: record.get('id'), customer_type: 'User'});
    }, this);
  },
  onResetPassword: function(record){
    user = record.data;
    Ext.Msg.confirm(
      "Reset Password",
      "Are you sure you want to reset "+user.first_name+" "+user.last_name+"'s password?",
      function(butt_id){
        if( butt_id === "yes" ){
          $.ajax({
            type: 'POST',
            url: '/api/v1/reset',
            dataType: 'json',
            contentType: 'application/json',
            processData: false,
            data: JSON.stringify({"user_id": user.id}),
            complete: function() { },
            success: function(data) {
              Ext.Msg.alert("Success", "New Password: "+data.password);
            },
            error: function(data,textStatus) {
              Ext.Msg.alert( "Error", JSON.parse(data.responseText)["errors"][0]);
            }
          });
        }
      });
  }
}
