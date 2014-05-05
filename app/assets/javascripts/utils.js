function displayFormErrors(data){
  if( data.errors != undefined ){
    $.each( data.errors, function( field, errorMsg) {
      $("#"+field).parents(".control-group").addClass("error");
      $("#"+field).siblings(".help-block").html(errorMsg);
    });
  }
}
