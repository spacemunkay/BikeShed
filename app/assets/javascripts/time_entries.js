$(document).ready(function(){

  $("#date_id").datetimepicker({format: 'MM/DD/YYYY'})

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

    //FIXME: Ideally, we'd submit the dates as ISO, but I can't figure out
    // how to get Netzke to render UTC dates correctly (it calls to_json
    // somewhere and drops off the timezone).  For the time being, save dates
    // in locale like Netzke.
    json_data = { time_entries: [{
        start_date:    $.format.date(start_date, "dd-MM-yyyy hh:mm a"),
        end_date:      $.format.date(end_date, "dd-MM-yyyy hh:mm a"),
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

  $(".work_entry-delete-btn").click(function(){
    row = $(this).closest("tr");
    entry_id = row.data("id");
    start_date = row.data("start_date");
    duration = row.data("duration");
    description = row.data("description");
    $("#work_entry_start_date").html(start_date);
    $("#work_entry_duration").html(duration);
    $("#work_entry_description").html(description);
    $("#confirmation_delete").data("entry_id", entry_id);
  });

  $("#confirmation_delete").click(function(){
    entry_id = $(this).data("entry_id");
    url = $("#confirmation_delete").data("url") + entry_id;
    $.ajax({
      url: url,
      type: "delete",
      contentType: 'application/json',
      success: function(data, status, xhr){
        location.reload();
      },
      error: function(data, status ){
        displayFormErrors(data.responseJSON);
      }
    });
  });
});
