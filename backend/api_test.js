var request = require('supertest');
var express = require('express');
var app = require('./index.js');
var models = require('./models.js');
var expect = require('chai').expect;
var Playlist = models.Playlist;

describe('GET /users/:user/playlists', function(){
	it('returns a playlist', function(done){
		request(app)
			.get('/users/ktsakas/playlists')
			.set('Accept', 'application/json')
			.expect(function (res) {
				expect(res.body).to.be.instanceof(Array);
				// expect(res.body).to.have.all.keys('bar', 'baz');
			})
			.expect(200, done);
	});
});