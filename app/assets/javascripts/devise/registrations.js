$(document).ready(function(){
  var MIN_LEN = 3;
  var MAX_SUBMITS = 3;
  var submit_count = 0;

  var checkContacts = function() {
      submit_count += 1;
      //IDs of contact info
      var contact_info_ids = [
          "user_email",
          "user_user_profiles_attributes_0_addrStreet1",
          "user_user_profiles_attributes_0_addrCity",
          "user_user_profiles_attributes_0_addrState",
          "user_user_profiles_attributes_0_addrZip",
          "user_user_profiles_attributes_0_phone"
      ];

      var contact_vals = "";
      //see if any contact info exists
      for( var index in contact_info_ids){
          contact_vals += $("#"+contact_info_ids[index]).val();
      }
      if( contact_vals.length >= MIN_LEN || submit_count > MAX_SUBMITS){

          if( submit_count == MAX_SUBMITS + 1 ){
              alert("Fine.");
          }
          return true;

      }else{

          switch(submit_count){
              case 1:
                  alert("It appears you have not entered any contact information.  " +
                      "Please do.");
                  break;
              case 2:
                  alert("It is highly recommended that you enter at least one form of" +
                      " contact information.  It is in your best interest.");
                  break;
              case 3:
                  alert("If something happens to your bicycle, we will not be able to" +
                      " notify you.  Please enter at least one form of contact.");
                  break;
              default:
                  alert("Please enter at least one form of contact.");
          }
          return false;
      }
  };

  var checkValid = function() {
      var errors = {};
      var hasErrors = false;
      ["username", "first_name", "last_name"].forEach(function(requiredField) {
          if(!$("#user_" + requiredField).val().trim()) {
              errors["user_" + requiredField] = ["can't be blank"];
              hasErrors = true;
          }
      });

      if($("#user_password").val().length < 6) {
          errors["user_password"] = ["is too short (minimum is 6 characters)"];
          hasErrors = true;
      }

      if($("#user_password").val() != $("#user_password_confirmation").val()) {
          errors["user_password_confirmation"] = ["confirmation doesn't match password"];
          hasErrors = true;
      }

      displayFormErrors({errors: errors}, "#new_user");

      return !hasErrors;
  };

  $("input[name=commit]").click(function(e){
      return checkContacts() && checkValid();
  });
});
