var express = require('express');
var app = require('./index.js');
var request = require('supertest')(app);
var models = require('./models.js');
var expect = require('chai').expect;
// Playlist fields
var PlaylistFields = Object.keys(models.PlaylistSchema.paths);

describe('POST /users/:user/playlists', function() {
	it('creates a playlist', function (done) {
		request
			.post('/users/ktsakas/playlists')
			.send({
				name: 'test playlist'
			}).
			.expect(function (res) {
				expect(res.body).to.have.all.keys(PlaylistFields);
			})
			.expect(200, done);
	});
});

describe('GET /users/:user/playlists', function() {
	it('returns a playlist', function (done) {
		request
			.get('/users/ktsakas/playlists')
			.expect(function (res) {
				expect(res.body).to.be.instanceof(Array);
				expect(res.body[0]).to.have.all.keys(PlyalistFields);
			})
			.expect(200, done);
	});
});