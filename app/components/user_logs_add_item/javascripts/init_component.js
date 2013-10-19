{
  initComponent: function(){
    // calling superclass's initComponent
    this.callParent();

    var panel = this;
    var theForm = this.getForm();

    console.log(theForm);

    var hoursInput = Ext.getCmp('user_logs_add_form_hours');

    console.log(hoursInput);

    hoursInput.on('change', function(e){
      console.log('I am changing');
    });

  }

}
