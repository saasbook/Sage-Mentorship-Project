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



function getLocation_checkout() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition_checkout, showError);
  } 
}
function showPosition_checkout(position) {
var latitude = position.coords.latitude;
var longitude = position.coords.longitude;
document.location.replace(window.location.href.replace('#','') + "/checkout_loc"+"?la=" +latitude + "&lo="+longitude);
}

function getLocation_checkin() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition_checkin, showError);
  } 
}

function showPosition_checkin(position) {
var latitude = position.coords.latitude;
var longitude = position.coords.longitude;
document.location.replace(window.location.href.replace('#','') + "/checkin_loc"+"?la=" +latitude + "&lo="+longitude);
}

function showError() {
    alert("Please allow location and Refresh page to Check-In"); 
}





