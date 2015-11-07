var express = require('express');
var mongoose = require('mongoose');
var passport = require('passport');
var FacebookStrategy = require('passport-facebook').Strategy;
var app = express();
var PORT = 8080;

mongoose.connect('mongodb://localhost');//'localhost:27017');
var Playlist = mongoose.model('Playlist', {
	name: String,
	user: String,
	songs: []
});

// Get all playlists for user
app.get('/users/:userId/playlists', function (req, res) {
	Playlist.find({
		user: req.params.userId
	}, function (err, playlist) {
		console.log(playlist);
	});
});

// Get playlists for user
app.get('/playlists/:playlistId', function (req, res) {

});

// Create playlist
app.post('/users/:userId/playlists', function (req, res) {
	Playlist.create({
		name: 'playlist1',
		user: req.params.userId,
		songs: ['Song1', 'Song2']
	}, function (err, playlist) {
		if (err) return { error: "Failed to create user!" };

		console.log(playlist);
	});
});

app.get('/:test', function (req, res) {
	console.log(req.params.test);

	res.send('Hello World!');
});

app.listen(PORT, function () {
	console.log('Server listening on port: %s', PORT);
});