{
  //this will give a 401 error, but made 401 exceptions forward to 'users/sign_in'
  onSignOut: function(){
    Ext.Ajax.request({
       url: '/users/sign_out',
       method: 'DELETE'
    });
  }
}
