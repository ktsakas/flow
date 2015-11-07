var request = require('supertest');
var express = require('express');
var app = express();

describe('GET /users/:user/playlists', function(){
	it('returns a playlist', function(done){
		request(app)
			.get('/users/ktsakas/playlists')
			.set('Accept', 'application/json')
			.expect('Content-Type', /json/)
			.expect(function (res) {
				console.log("what");
			})
			.expect(200, done);
	})
})