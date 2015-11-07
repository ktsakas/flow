var express = require('express');
var mongoose = require('mongoose');
var app = express();

var Playlist = mongoose.model('Playlist', {
	name: String,
	user: String,
	songs: []
});

// Get all playlists for user
app.get('/users/:user_id/playlists', function (req, res) {
	
});

// Get playlists for user
app.get('/playlists/:playlist_id', function (req, res) {

});

// Create playlist
app.post('/users/:user_id/playlists', function (req, res) {

});

app.get('/', function (req, res) {
	res.send('Hello World!');
});

app.listen(8080, function () {
  var host = server.address().address;
  var port = server.address().port;

	console.log('Server listening on port: %s', port);
});