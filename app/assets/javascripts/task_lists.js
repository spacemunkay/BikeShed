$(".task_list_task").click(function(){
  $("#update_tasks_submit").removeClass("disabled");
});

$("#update_tasks_submit").click(function(){

  var tasks = [];
  $(".task_list_task").each(function(){
    tasks.push({
      id: parseInt($(this).data("id")),
      done: $(this).is(":checked")
    });
  });

  var json_data = {tasks: tasks};

  $.ajax({
    url: $("#update_tasks_submit").data("url"),
    type: "PUT",
    data: JSON.stringify(json_data),
    contentType: 'application/json',
    dataType: "json",
    success: function(data, status, xhr){
      //should re-render via JS, but for now reload
      location.reload();
    },
    error: function(data, status ){
      alert("An error occured updating tasks");
      //displayFormErrors(data.responseJSON);
    }
  });
});
