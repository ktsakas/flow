var mongoose = require('mongoose');
mongoose.connect(process.env.MONGOLAB_URI || 'mongodb://localhost');

var SongSchema = mongoose.Schema({
	name: String,
	artist: String,
	votes: Number,
	imageURL: String
});

exports.Playlist = mongoose.model('Playlist', {
	name: String,
	user: {
		name: String,
		id: String
	},
	songs: [SongSchema]
});