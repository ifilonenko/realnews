doAuth = function(e) {
  e.preventDefault();
  form = e.target
  $alerts = $(form).siblings('.Alerts')
  $alerts.addClass('Hidden').html('')
  var formInfo = $(form).serialize();
  var path = $(form).attr('action')
  $.ajax({
    url: path,
    type: 'POST',
    data: formInfo,
    dataType: 'json',
    success: function (resp) { 
      if (!resp.success) {
        $alerts.removeClass('Hidden').html(resp.alerts)
      } else {
        window.location = resp.route
      };
    }
  });  
};
$(document).on('submit', '#new_user', doAuth);
$(document).on('submit', '#user_login', doAuth);