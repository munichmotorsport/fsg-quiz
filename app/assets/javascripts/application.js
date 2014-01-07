// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery_nested_form
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .

$('.dropdown-menu').find('form').click(function (e) {
    e.stopPropagation();
  });

$.fn.timedDisable = function(seconds) {
  if(seconds == 0 || seconds == null) {
    return $(this);
  }
  return $(this).each(function() {
    $(this).attr('disabled', 'disabled');
    var disabledElem = $(this);
    var originalText = disabledElem.attr('value');
    disabledElem.attr('value', 'Wait ' + seconds + ' seconds');
    var interval = setInterval(function() {
      disabledElem.attr('value', 'Wait ' + --seconds + ' Seconds');
      if (seconds == "0") {
        disabledElem.removeAttr('disabled')
            .attr('value', originalText);
        clearInterval(interval);
      }
    }, 1000);
  });
};

$(function() {
  var delay = parseInt($('#submitBtn').data('delay'));
  $('#submitBtn').timedDisable(delay);
});