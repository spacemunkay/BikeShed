//when signed out, or session expires forward to sign in page
Ext.Ajax.on('requestexception', function(conn, response, options) {
  if (response.status === 401) { window.location = '/users/sign_in'; }
}, this);

