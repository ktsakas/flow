exports.Song = Song;
exports.assertValid = assertSongsValid;
exports.incrementVote = incrementVoteForSong;


function Song(name, artist, voteCount, imageLink) {
	this.name = name;
	this.artist = artist;
	this.voteCount = voteCount;
	this.imageLink = imageLink;
}

function isSortedByVoteCount(songs) {
	for (var i = 0; i < songs.length - 1; i++) {
		if (songs[i].voteCount < songs[i + 1].voteCount) {
			return false;
		}
	}
	return true;
}

function containsDuplicates(songs) {
	var names = {};

	for (var i = 0; i < songs.length; i++) {
		if (names[songs[i].name]) {
			return true;
		}
		names[songs[i].name] = true;
	}

	return false;
}

function assertSongsValid(songs) {
	console.assert(isSortedByVoteCount(songs), 'songs array is not sorted by voteCount');
	console.assert(!containsDuplicates(songs), 'songs array contains duplicate songs');
}

function incrementVoteForSong(songName, songs) {
	var temp;
	for (var i = 0; i < songs.length; i++) {
		if (songs[i].name == songName) {
			songs[i].voteCount++;

			//ensure sort is preserved
			while (i > 0) {
				if (songs[i - 1].voteCount >= songs[i].voteCount) {
					//then the array is properly sorted
					return;
				}
				//otherwise swap the songs so that they are in the right order
				temp = songs[i - 1];
				songs[i - 1] = songs[i];
				songs[i] = temp;
				i--;
			}
			return;
		}
	}
	console.error("song of name \"%s\" not found");
}