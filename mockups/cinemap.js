var map = L.map('map').setView([52.5162, 13.3778], 11);

L.tileLayer('https://{s}.tiles.mapbox.com/v3/{id}/{z}/{x}/{y}.png', {
	maxZoom: 18,
	attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
		'<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
		'Imagery © <a href="http://mapbox.com">Mapbox</a>',
	id: 'examples.map-i875mjb7'
}).addTo(map);

// marker start

// Æon Flux
L.marker([52.5190, 13.3647]).addTo(map)
	.bindPopup('<b>Æon Flux</b><br />Headquarter (Entry).<br /><a href="#">Image</a><br /><a href="#">Details</a>');
L.marker([52.4315, 13.5303]).addTo(map)
	.bindPopup('<b>Æon Flux</b><br />Headquarter (Hallway).<br /><a href="#">Image</a><br /><a href="#">Details</a>');
L.marker([52.5751, 13.5455]).addTo(map)
	.bindPopup('<b>Æon Flux</b><br />Headquarter (Inner court).<br /><a href="#">Image</a><br /><a href="#">Details</a>');

// Around the World in 80 Days
L.marker([52.5136, 13.3928]).addTo(map)
	.bindPopup('<b>Around the World in 80 Days</b><br />Some place.<br /><a href="#">Image</a><br /><a href="#">Details</a>');

// V for Vendetta
L.marker([52.5136, 13.3922]).addTo(map)
	.bindPopup('<b>V for Vendetta</b><br />Palace.<br /><a href="#">Image</a><br /><a href="#">Details</a>');

// marker end

var popup = L.popup();

function onMapClick(e) {
	popup
		.setLatLng(e.latlng)
		.setContent("You clicked the map at " + e.latlng.toString())
		.openOn(map);
}

map.on('click', onMapClick);


