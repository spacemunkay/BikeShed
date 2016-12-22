function displayFormErrors(data){
  if(data.errors != undefined ){
    $.each(data.errors, function(field, errorMsg) {
      $("#"+field).closest(".form-group").addClass("has-error");
      $("#"+field).siblings(".help-block").html(errorMsg);
    });
  }
}
