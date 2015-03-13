// marker start

var movies = new L.LayerGroup();

// Æon Flux
L.marker([52.5190, 13.3647])
	.bindPopup('<b>Æon Flux</b><br />Headquarter (Entry).<br /><a href="#">Image</a><br /><a href="#">Details</a>')
	.addTo(movies);
L.marker([52.4315, 13.5303])
	.bindPopup('<b>Æon Flux</b><br />Headquarter (Hallway).<br /><a href="#">Image</a><br /><a href="#">Details</a>')
	.addTo(movies);
L.marker([52.5751, 13.5455])
	.bindPopup('<b>Æon Flux</b><br />Headquarter (Inner court).<br /><a href="#">Image</a><br /><a href="#">Details</a>')
	.addTo(movies);

// Around the World in 80 Days
L.marker([52.5136, 13.3928])
	.bindPopup('<b>Around the World in 80 Days</b><br />Some place.<br /><a href="#">Image</a><br /><a href="#">Details</a>')
	.addTo(movies);

// V for Vendetta
L.marker([52.5136, 13.3922])
	.bindPopup('<b>V for Vendetta</b><br />Palace.<br /><a href="#">Image</a><br /><a href="#">Details</a>')
	.addTo(movies);

// marker end

var mbAttr = 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
	'<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
	'Imagery © <a href="http://mapbox.com">Mapbox</a>';
var mbUrl = 'https://{s}.tiles.mapbox.com/v3/{id}/{z}/{x}/{y}.png';

var grayscale = L.tileLayer(mbUrl, {id: 'examples.map-20v6611k', attribution: mbAttr});
var streets = L.tileLayer(mbUrl, {id: 'examples.map-i875mjb7', attribution: mbAttr});

var map = L.map('map', {
	center: [52.5162, 13.3778],
	zoom: 11,
	layers: [grayscale, movies]
});

var baseLayers = {
	"Grayscale": grayscale,
	"Streets": streets
};

var overlays = {
	"Movies": movies
};

L.control.layers(baseLayers, overlays).addTo(map);

// popup at mouse click
var popup = L.popup();

function onMapClick(e) {
	popup
		.setLatLng(e.latlng)
		.setContent("You clicked the map at " + e.latlng.toString())
		.openOn(map);
}

map.on('click', onMapClick);

