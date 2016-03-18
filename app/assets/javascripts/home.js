"use strict";
// Function to find user's location
// GET home#user_location
var find_location = function() {
  // Prevent consecutive calls
  var has_loaded = false;
  if (navigator.geolocation) {
    navigator.geolocation.watchPosition(function(position) {
      var latitude = position.coords.latitude;
      var longitude = position.coords.longitude;
      if (has_loaded === false) {
        $.ajax({
          type: 'GET',
          url: '/user_location',
          dataType: 'JSONP',
          data: { coordinates: {lat: latitude, lon: longitude}}
        });
        has_loaded = true;
      }
    }, function (error) {
      if (error.code == error.PERMISSION_DENIED) {
        var location_error = document.createElement('div');
        location_error.innerHTML = "Geo location services appear to be disabled on your device.";
        location_error.id = "location_permissions_error";
        $('body').appendChild(location_error);
      }
      });
    }
  };