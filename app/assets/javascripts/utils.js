function displayFormErrors(data, form){
  if(form){
    $(form).find(".form-group.has-error").removeClass("has-error").find(".help-block").html("");
  }
  if(data.errors != undefined ){
    $.each(data.errors, function(field, errorMsg) {
      $("#"+field).closest(".form-group").addClass("has-error").find(".help-block").html(errorMsg.join(", "));
    });
  }
}
