{
  updateStats: function(){
    // Call endpoint
    this.serverUpdate({}, function(){
      //success callback
    }, this);
  }
}
