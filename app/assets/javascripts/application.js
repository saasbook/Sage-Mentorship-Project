// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .


var link= window.location.href

function getLocation_checkout() {
	var new_link = link + '/checkout'
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition_checkout);
  } else {
    alert("Please allow location");
  }
}
function showPosition_checkout(position) {
var latitude = position.coords.latitude;
var longitude = position.coords.longitude;
document.location.replace(link + "/checkout_loc"+"?la=" +latitude + "&lo="+longitude);
}

function getLocation_checkin() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition_checkin);
  } else {
    alert("Please allow location");
  }
}

function showPosition_checkin(position) {
var latitude = position.coords.latitude;
var longitude = position.coords.longitude;
document.location.replace(link + "/checkin_loc"+"?la=" +latitude + "&lo="+longitude);
}
