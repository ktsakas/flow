var express = require('express');
var bodyParser = require('body-parser');
var passport = require('passport');
var FacebookStrategy = require('passport-facebook').Strategy;
var models = require('./models.js');

//local modules
var handlers = require('./handlers.js');

var app = express();
var port = process.env.PORT || 3000;

// Middleware to parse the body
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
  extended: true
}));

// Get all playlists for user -- done
app.get('/users/:userId/playlists', handlers.getAllPlaylistsForUser);

// Get playlist for user -- done
app.get('/users/:userId/playlists/:playlistId', handlers.getPlaylistForUser);

// Create playlist -- done
app.post('/users/:userId/playlists', handlers.createPlaylist);

// add a song to a playlist -- done
app.post('/users/:userId/playlists/:playlistId', handlers.addSong);

// increment the voteCount for a song in a playlist -- done
app.put('/users/:userId/playlists/:playlistId/songs/:songId', handlers.incrementCount);

app.get('/', function(req, res) {
  // console.log(req.params.test);

  res.send('Hello World!');
  res.end();
});

app.listen(port, function() {
  console.log('Server listening on port: %s', port);
});

module.exports = app;