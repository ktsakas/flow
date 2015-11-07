var mongoose = require('mongoose');
var songsUtils = require('./songs.js');

mongoose.connect(process.env.MONGOLAB_URI || 'mongodb://localhost');

var Playlist = mongoose.model('Playlist', {
  name: String,
  user: String,
  songs: []
});

//TODO how to do body vs params?
//TODO what is playlist id? name?

exports.getAllPlaylistsForUser = function(req, res) {
	Playlist.find({
		user: req.params.userId
	}, function(err, playlists) {
		res.json(playlists);
		res.end();
	});
};

exports.getPlaylistForUser = function(req, res) {
	Playlist.findById(req.params.playlistId, function(err, playlist) {
		res.json(playlist);
		res.end();
	});
};

exports.createPlaylist = function(req, res) {
	Playlist.create({
		name: req.body.name,
		user: req.params.userId,
		songs: req.body.songs
	}, function(err, playlist) {
		if (err) return {
			error: "Failed to create user!"
		};

		res.json(playlist);
		res.end();
	});

	res.end();
};

exports.addSong = function(req, res) {
	Playlist.findById(req.params.playlistId, function(err, playlist) {
		if (err) return {
			error: "Failed to add song to playlist!"
		};

		//todo make playlist into array of songs
		var songs = [];

		//todo should vote count start at 0 or 1?
		songs.push(new songsUtils.Song(req.params.name, req.params.artist, 1, req.params.imageLink));

		songsUtils.assertValid(songs);

		res.json(JSON.stringify(songs));
		res.end();
	});
};

exports.incrementCount = function(req, res) {
	Playlist.findById(req.params.playlistId, function(err, playlist) {
		if (err) return {
			error: "Failed to add song to playlist!"
		};

		//todo make playlist into array of songs
		var songs = [];

		//todo should vote count start at 0 or 1?
		
		songsUtils.incrementCount(req.params.name, songs);

		res.json(JSON.stringify(songs));
		res.end();
	});
};