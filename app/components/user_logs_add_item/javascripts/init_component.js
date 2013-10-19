{
  initComponent: function(){
    // calling superclass's initComponent
    this.callParent();

    var panel = this;
    var theForm = this.getForm();
    var startInput = Ext.getCmp('user_logs_add_form_start');
    var timeInput = Ext.getCmp('user_logs_add_form_time');
    var unitsInput = Ext.getCmp('user_logs_add_form_units');
    var endInput = Ext.getCmp('user_logs_add_form_end');
    var startdate = startInput.items.items[0];
    var starttime = startInput.items.items[1];
    var enddate = endInput.items.items[0];
    var endtime = endInput.items.items[1];

    startdate.on('change', function(e){
      var hours = timeInput.getValue();
      var startTime = starttime.getValue();

      if('Mins' === unitsInput.getValue()){
        var calculatedEndTime = Ext.Date.add(new Date(startTime), Ext.Date.MINUTE, parseInt(hours));
      }else{
        var calculatedEndTime = Ext.Date.add(new Date(startTime), Ext.Date.HOUR, parseInt(hours));
      }

      endtime.setValue(calculatedEndTime);
      enddate.setValue(calculatedEndTime);
    });

    starttime.on('change', function(e){
      var hours = timeInput.getValue();
      var startTime = starttime.getValue();

      if('Mins' === unitsInput.getValue()){
        var calculatedEndTime = Ext.Date.add(new Date(startTime), Ext.Date.MINUTE, parseInt(hours));
      }else{
        var calculatedEndTime = Ext.Date.add(new Date(startTime), Ext.Date.HOUR, parseInt(hours));
      }


      endtime.setValue(calculatedEndTime);
      enddate.setValue(calculatedEndTime);
    });

    timeInput.on('change', function(e){
      var hours = timeInput.getValue();
      var startTime = starttime.getValue();

      if('Mins' === unitsInput.getValue()){
        var calculatedEndTime = Ext.Date.add(new Date(startTime), Ext.Date.MINUTE, parseInt(hours));
      }else{
        var calculatedEndTime = Ext.Date.add(new Date(startTime), Ext.Date.HOUR, parseInt(hours));
      }

      endtime.setValue(calculatedEndTime);
      enddate.setValue(calculatedEndTime);
    });

    unitsInput.on('change', function(e){
      var hours = timeInput.getValue();
      var startTime = starttime.getValue();

      if('Mins' === unitsInput.getValue()){
        var calculatedEndTime = Ext.Date.add(new Date(startTime), Ext.Date.MINUTE, parseInt(hours));
      }else{
        var calculatedEndTime = Ext.Date.add(new Date(startTime), Ext.Date.HOUR, parseInt(hours));
      }

      endtime.setValue(calculatedEndTime);
      enddate.setValue(calculatedEndTime);
    });

  }

}
