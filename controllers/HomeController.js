'use strict';

angular
    .module('app')
    .controller('HomeController', ['$scope', '$rootScope', '$timeout', function($scope, $rootScope, $timeout) {
    	var cities = [{
		  city: 'Toronto',
		  desc: 'This is the best city in the world!',
		  lat: 43.7000,
		  long: -79.4000
		}, {
		  city: 'New York',
		  desc: 'This city is aiiiiite!',
		  lat: 40.6700,
		  long: -73.9400
		}, {
		  city: 'Chicago',
		  desc: 'This is the second best city in the world!',
		  lat: 41.8819,
		  long: -87.6278
		}, {
		  city: 'Los Angeles',
		  desc: 'This city is live!',
		  lat: 34.0500,
		  long: -118.2500
		}, {
		  city: 'Las Vegas',
		  desc: 'Sin City...\'nuff said!',
		  lat: 36.0800,
		  long: -115.1522
		}];

		var mapOptions = {
	      zoom: 4,
	      center: new google.maps.LatLng(40.0000, -98.0000),
	      mapTypeId: google.maps.MapTypeId.TERRAIN
	    };

	    $scope.mySlides = [
	    	{
	    		class: 'grey-teaser1',
	    		title: 'Auto Transport Services',
	    		text: 'Fast, friendly service from coast to coast.'
	    	},
	    	{
	    		class: 'grey-teaser2',
	    		title: 'Your Auto Shipping Solution',
	    		text: 'We transport cars, trucks, vans and motorcycles.'
	    	},
	    	{
	    		class: 'grey-teaser5',
	    		title: '5-Star Rated!',
	    		text: 'Moving cars safely and efficiently'
	    	}
	    ];


        // Toggle visibility on the success / error messages
	    if (window.location.href.indexOf('response=success') >= 0) {
	        $scope.success = true;
	    }

	    if (window.location.href.indexOf('response=error') >= 0) {
	        $scope.error = true;
	    }

	    $timeout(function() {
	    	$scope.map = new google.maps.Map(document.getElementById('map'), mapOptions);

		    $scope.markers = [];

		    var infoWindow = new google.maps.InfoWindow();

		    var createMarker = function(info) {

		      var marker = new google.maps.Marker({
		        map: $scope.map,
		        position: new google.maps.LatLng(info.lat, info.long),
		        title: info.city
		      });
		      marker.content = '<div class="infoWindowContent">' + info.desc + '</div>';

		      google.maps.event.addListener(marker, 'click', function() {
		        infoWindow.setContent('<h2>' + marker.title + '</h2>' + marker.content);
		        infoWindow.open($scope.map, marker);
		      });

		      $scope.markers.push(marker);
		    }

		    for (var i = 0; i < cities.length; i++) {
		      createMarker(cities[i]);
		    }

		    $scope.openInfoWindow = function(e, selectedMarker) {
		      e.preventDefault();
		      google.maps.event.trigger(selectedMarker, 'click');
		    };
	    }, 500);
    }]);