$("#index_logout").click(function(){
  $.ajax({
    type: "DELETE",
    url: $("#index_logout").data("url"),
    complete: function(){
      window.location.href="/";
    }
  });
});
