var mongoose = require('mongoose');
mongoose.connect(process.env.MONGOLAB_URI || 'mongodb://localhost');

var Song = exports.Song = mongoose.model('Song', {
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
	songs: [Song]
});