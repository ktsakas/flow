var express = require('express');
var bodyParser = require('body-parser');
var mongoose = require('mongoose');
var passport = require('passport');
var FacebookStrategy = require('passport-facebook').Strategy;
var app = express();
var PORT = process.env.PORT || 3000;

mongoose.connect('mongodb://localhost');//'localhost:27017');
var Playlist = mongoose.model('Playlist', {
	name: String,
	user: String,
	songs: []
});

// Middleware to parse the body
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Get all playlists for user
app.get('/users/:userId/playlists', function (req, res) {
	Playlist.find({
		user: req.params.userId
	}, function (err, playlists) {
		res.json(playlists);
		res.end();
	});
});

// Get playlists for user
app.get('/playlists/:playlistId', function (req, res) {
	Playlist.findById(req.params.playlistId, function (err, playlist) {
		res.json(playlist);
		res.end();
	});
});

// Create playlist
app.post('/users/:userId/playlists', function (req, res) {
	Playlist.create({
		name: req.body.name,
		user: req.params.userId,
		songs: req.body.songs
	}, function (err, playlist) {
		if (err) return { error: "Failed to create user!" };

		res.json(playlist);
		res.end();
	});

	res.end();
});

app.get('/', function (req, res) {
	// console.log(req.params.test);

	res.send('Hello World!');
	res.end();
});

app.listen(PORT, function () {
	console.log('Server listening on port: %s', PORT);
});