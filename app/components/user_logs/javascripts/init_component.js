{
  initComponent: function(){
    // calling superclass's initComponent
    this.callParent();

    //due to Netzke bug, :min_chars attribute doesn't work
    var min_char_columns = [
      "user_action__status"]
    Ext.each(min_char_columns, function(column, index) {
      Ext.ComponentManager.get(column).editor.minChars = 1;
    });
  }
}
