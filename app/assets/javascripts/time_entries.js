$(document).ready(function(){

var currentdate = new Date();
$("#date_id").datepicker().on('changeDate', function(ev){
  $("#date_id").datepicker('hide');
});
$("#date_id").datepicker('setValue', currentdate);

$("#start_time_id").timepicker();
$("#end_time_id").timepicker();
});
