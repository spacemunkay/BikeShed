{
  initComponent: function(){
    // calling superclass's initComponent
    this.callParent();

    var panel = this;
    var theForm = this.getForm();
    var startInput = Ext.getCmp('user_logs_add_form_start');
    var hoursInput = Ext.getCmp('user_logs_add_form_hours');
    var endInput = Ext.getCmp('user_logs_add_form_end');
    var startdate = startInput.items.items[0];
    var starttime = startInput.items.items[1];
    var enddate = endInput.items.items[0];
    var endtime = endInput.items.items[1];

    startdate.on('change', function(e){
      var hours = hoursInput.getValue();
      var startTime = starttime.getValue();
      var calculatedEndTime = Ext.Date.add(new Date(startTime), Ext.Date.HOUR, parseInt(hours));

      endtime.setValue(calculatedEndTime);
      enddate.setValue(calculatedEndTime);
    });

    starttime.on('change', function(e){
      var hours = hoursInput.getValue();
      var startTime = starttime.getValue();
      var calculatedEndTime = Ext.Date.add(new Date(startTime), Ext.Date.HOUR, parseInt(hours));

      endtime.setValue(calculatedEndTime);
      enddate.setValue(calculatedEndTime);
    });

    hoursInput.on('change', function(e){
      var hours = hoursInput.getValue();
      var startTime = starttime.getValue();
      var calculatedEndTime = Ext.Date.add(new Date(startTime), Ext.Date.HOUR, parseInt(hours));

      endtime.setValue(calculatedEndTime);
      enddate.setValue(calculatedEndTime);
    });

  }

}
