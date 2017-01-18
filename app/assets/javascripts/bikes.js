$('.btn').button();

$("#add_bike_form").ajaxForm({
    dataType: "json",
    success: function(data){
      window.location = data.bikes[0].id + "?add_bike=1";
    },
    error: function(data){
      displayFormErrors(data.responseJSON);
    }
})