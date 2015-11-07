var io = require('socket.io')(server);

io.on('connection', function(socket) {
	console.log(socket);
	// socket.on('event', function(data) {});
	// socket.on('disconnect', function() {});
});

server.listen(port);