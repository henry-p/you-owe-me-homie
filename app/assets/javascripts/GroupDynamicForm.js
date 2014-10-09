$(document).ready(function() {
  var emailCount = 0;

  $('#add-member').click(function(event) {
    // event.preventDefault();
    var newField = buildEmailField(emailCount);
    emailCount += 1;
    $("#group-form-submit").before(newField);
  })
});

var buildEmailField = function(count) {
  return "<input name='users[" + count + "]' type='text' placeholder='Email'/>"
}
