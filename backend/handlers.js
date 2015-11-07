var models = require('./models.js');
var Playlist = models.Playlist;
var Song = models.Song;

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
	console.log(req.params.playlistId, req.params.userId);
	Playlist.findOne({
		_id: req.params.playlistId,
		user: req.params.userId
	}, function(err, playlist) {
		res.json(playlist);
		res.end();
	});
};

exports.createPlaylist = function(req, res) {
	// Make sure all songs have 0 votes
	var songs = req.body.songs || [];
	for (var i= 0; songs[i]; i++) songs[i].votes = 0;

	Playlist.create({
		name: req.body.name,
		user: req.params.userId,
		songs: songs
	}, function(err, playlist) {
		if (err) return {
			error: "Failed to create user!"
		};

		res.json(playlist);
		res.end();
	});
};

exports.addSong = function(req, res) {
	Playlist.findOne({
		_id: req.params.playlistId,
		user: req.params.userId
	}, function(err, playlist) {
		if (err) return {
			error: "Failed to add song to playlist!"
		};

		var song = req.params;
		song.votes = 0;
		playlist.push(song);
		playlist.save(function () {
			if (err) return {
				error: "Failed to add new song!"
			};
		});

		res.json(song);
		res.end();
	});
};

exports.incrementCount = function(req, res) {
	Playlist.findOne({
		_id: req.params.playlistId,
		user: req.params.userId
	}, function(err, playlist) {
		if (err) return {
			error: "Could not find the song!"
		};

		var song = playlist.songs.id(req.params.songId);
		song.votes++;
		song.save(function (err) {
			if (err) return {
				error: "Failed to vote on song!"
			};

			res.json(song);
			res.end();
		});
	});
};