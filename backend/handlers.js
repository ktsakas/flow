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

	console.log(req.body);
	console.log(req.params);

	// Make sure all songs have 0 votes

	Playlist.create({
		name: req.body.name,
		user: {
			name: req.body.userName,
			id: req.params.userId
		},
		songs: []
	}, function(err, playlist) {
		if (err) {
			console.log(err);
			res.json({
				error: "Failed to create user!"
			});
		} else {
			console.log('created playlist:', playlist);
			res.json(playlist);
		}

		res.end();
	});
};

exports.addSong = function(req, res) {
	console.log('received request to add song', req.params, req.body);

	var song = req.body;

	Playlist.findOne({
		_id: req.params.playlistId,
		'user.id': req.params.userId
	}, function(err, playlist) {
		if (err) {
			res.json({
				error: "Failed to add song to playlist!"
			});
			res.end();
		} else if (playlist) {
			console.log('adding song to playlist:', playlist);

			song.votes = 0;

			console.log('song to add:', song);
			console.log('songs list:', playlist.songs);


			var songs = playlist.songs;

			for (var i = 0; i < songs.length; i++) {
				if (songs[i].id == song.id || 
					(songs[i].name == song.name && songs[i].artist == song.artist)) {
					res.json({
						error: "Song already exists"
					});
					res.end();
					return;
				}
			}

			playlist.songs.push(song);
			playlist.save(function(err) {
				if (err) {
					res.json({
						error: "Failed to add new song!"
					});
				} else {
					res.json(playlist);
				}
				// if (err) return {
				// 	error: "Failed to add new song!"
				// };

				// res.json(playlist);
				res.end();
			});
		} else {
			res.end();
		}

	});
};

exports.incrementCount = function(req, res) {
	console.log('received request to incrementCount', req.params, req.body);
	Playlist.findOne({
		_id: req.params.playlistId,
		'user.id': req.params.userId
	}, function(err, playlist) {
		if (err) return {
			error: "Could not find the song!"
		};

		console.log('before', playlist.songs);

		var song = playlist.songs.id(req.params.songId);

		song.votes++;

		playlist.songs.sort(function(s1, s2) {
			return s2.votes - s1.votes;
		});

		console.log('after', playlist.songs);

		playlist.save(function(err) {
			if (err) return {
				error: "Failed to vote on song!"
			};

			res.json(playlist);
			res.end();
		});
	});
};