/*var express = require('express');
var app = express();
var server = require('http').createServer(app);
var io = require('socket.io')(server);
var ctrls = require('./controllers.js');
// var passport = require('passport');
// var FacebookStrategy = require('passport-facebook').Strategy;
var bodyParser = require('body-parser');
var port = process.env.PORT || 3000;

// Middleware to parse the body
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Routes
app.get('/users/:userId/playlists', ctrls.getUserPlaylists);
app.get('/playlists/:playlistId', ctrls.getPlaylist);
app.post('/users/:userId/playlists', ctrls.createPlaylist);

// Make sure the server is running
app.get('/', function (req, res) {
	res.send('API is working!');
	res.end();
});

app.use(express.static('.'));

// Run the server
server.listen(port, function () {
	console.log('Server listening on port: %s', port);
});*/

var io = require('socket.io')(3000);
io.on('connection', function (socket) {
	console.log("somebody connected");

	socket.on('event', function(data) {
		console.log(data);
	});
	socket.on('disconnect', function() {
		console.log("disconnnected");
	});
});

io.on('error', function() {
	console.log("errror");
});


/*var WebSocketServer = require('ws').Server
  , wss = new WebSocketServer({ port: 3000 });

wss.on('connection', function connection(ws) {
	console.log("connnected");
	ws.on('message', function incoming(message) {
		console.log('received: %s', message);
	});

	ws.send('something');
});*/

/*net = require('net');

// Keep track of the chat clients
var clients = [];

// Start a TCP Server
net.createServer(function (socket) {

  // Identify this client
  socket.name = socket.remoteAddress + ":" + socket.remotePort 

  // Put this new client in the list
  clients.push(socket);

  // Send a nice welcome message and announce
  socket.write("Welcome " + socket.name + "\n");
  broadcast(socket.name + " joined the chat\n", socket);

  // Handle incoming messages from clients.
  socket.on('data', function (data) {
    broadcast(socket.name + "> " + data, socket);
  });

  // Remove the client from the list when it leaves
  socket.on('end', function () {
    clients.splice(clients.indexOf(socket), 1);
    broadcast(socket.name + " left the chat.\n");
  });
  
  // Send a message to all clients
  function broadcast(message, sender) {
    clients.forEach(function (client) {
      // Don't want to send it to sender
      if (client === sender) return;
      client.write(message);
    });
    // Log it to the server output too
    process.stdout.write(message)
  }

}).listen(3000);*/