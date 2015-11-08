var mongoose = require('mongoose');
mongoose.connect(process.env.MONGOLAB_URI || 'mongodb://localhost');

var SongSchema = exports.SongSchema = mongoose.Schema({
	name: String,
	artist: String,
	votes: Number,
	imageLink: String,
	songLink: String
});

var UserSchema = exports.UserSchema = mongoose.Schema({
	name: String,
	id: String
});

var PlaylistSchema = exports.PlaylistSchema = mongoose.Schema({
	name: String,
	user: UserSchema,
	songs: [SongSchema]
});


exports.Playlist = mongoose.model('Playlist', PlaylistSchema);