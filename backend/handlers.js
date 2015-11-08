var models = require('./models.js');
var Playlist = models.Playlist;


exports.getAllPlaylistsForUser = function(req, res) {
	console.log('received request to get all playlists');

	Playlist.find({
		'user.id': req.params.userId
	}, function(err, playlists) {
		console.log('found playlists:', playlists);
		res.json(playlists);
		res.end();
	});
};

exports.getPlaylistForUser = function(req, res) {
	console.log('received request to get playlist');

	console.log(req.params.playlistId, req.params.userId);
	Playlist.findOne({
		_id: req.params.playlistId,
		'user.id': req.params.userId
	}, function(err, playlist) {
		console.log('found playlist:', playlist);
		res.json(playlist);
		res.end();
	});
};

exports.createPlaylist = function(req, res) {
	console.log('received request to create playlist');

	// Make sure all songs have 0 votes

	Playlist.create({
		name: req.body.name,
		user: {
			name: req.body.userName,
			id: req.params.userId
		},
		songs: req.body.songs || []
	}, function(err, playlist) {
		if (err) return {
			error: "Failed to create user!"
		};

		console.log('created playlist:', playlist);

		res.json(playlist);
		res.end();
	});
};

exports.addSong = function(req, res) {
	Playlist.findOne({
		_id: req.params.playlistId,
		'user.id': req.params.userId
	}, function(err, playlist) {
		if (err) return {
			error: "Failed to add song to playlist!"
		};

		console.log('adding song to playlist:', playlist);

		var song = req.body;
		song.votes = 0;

		console.log('song to add:', song);
		console.log('songs list:', playlist.songs);
		console.log('type of songs list:', typeof playlist.songs);

		playlist.songs = [];
		playlist.songs.push(song);
		playlist.save(function(err) {
			if (err) return {
				error: "Failed to add new song!"
			};

			res.json(playlist);
			res.end();
		});


	});
};

exports.incrementCount = function(req, res) {
	Playlist.findOne({
		_id: req.params.playlistId,
		'user.id': req.params.userId
	}, function(err, playlist) {
		if (err) return {
			error: "Could not find the song!"
		};

		var song = playlist.songs.id(req.params.songId);
		song.votes++;

		song.save(function(err) {
			if (err) return {
				error: "Failed to vote on song!"
			};

			res.json(song);
			res.end();
		});
	});
};