$(document).ready(function(){
  $("#checkin_menu").show();
  $("#checkin").click( function(e){
    var username = $("#user_email").val();
    var password = $("#user_password").val();
    $.ajax({
      type: 'POST',
      url: '/api/v1/checkin',
      dataType: 'json',
      contentType: 'application/json',
      processData: false,
      data: JSON.stringify({"username": username, "password": password }),
      complete: function() { },
      success: function(data) {
        alert("Checked IN!");
        $("#user_email").val('');
        $("#user_password").val('');
      },
      error: function(data,textStatus) {
        alert( "Error: " + JSON.parse(data.responseText)["error"]);
      }
    })
  });
  $("#checkout").click( function(e){
    var username = $("#user_email").val();
    var password = $("#user_password").val();
    $.ajax({
      type: 'POST',
      url: '/api/v1/checkout',
      dataType: 'json',
      contentType: 'application/json',
      processData: false,
      data: JSON.stringify({"username": username, "password": password }),
      complete: function() { },
      success: function(data) {
        alert("Checked OUT!");
        $("#user_email").val('');
        $("#user_password").val('');
      },
      error: function(data,textStatus) {
        alert( "Error: " + JSON.parse(data.responseText)["error"]);
      }
    })
  });
});
