$(document).ready(function(){

  var currentdate = new Date();
  $("#date_id").datepicker().on('changeDate', function(ev){
    $("#date_id").datepicker('hide');
  });
  $("#date_id").datepicker('setValue', currentdate);

  $("#start_time_id").timepicker();
  $("#end_time_id").timepicker();

  $("#add_time_entry_submit").click(function(){
    date = $("#date_id").val();
    start_date = new Date(date + " " + $("#start_time_id").val());
    end_date = new Date(date + " " + $("#end_time_id").val());

    forward = $("#add_time_entry_submit").data("forward");

    // If a bike is selected, forward to the bike
    // checklist.
    bike_id = parseInt($("#bike_id").val());
    if( bike_id > 0 ){
      forward = "/task_lists/" + bike_id + "/edit";
    }

    json_data = { time_entries: [{
        start_date:    start_date.toISOString(),
        end_date:      end_date.toISOString(),
        log_action_id: parseInt($('input[name=action_id]:checked').val()),
        bike_id:       bike_id,
        description:   $("#description_id").val(),
      }]};

    $.ajax({
      url: $("#add_time_entry_submit").data("url"),
      type: "POST",
      data: JSON.stringify(json_data),
      contentType: 'application/json',
      dataType: "json",
      success: function(data, status, xhr){
        window.location = forward;
      },
      error: function(data, status ){
        displayFormErrors(data.responseJSON);
      }
    });
  });
});
