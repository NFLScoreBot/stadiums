## NFL Stadium Data ##

This repository provides both some data about NFL stadiums (generated from Wikipedia's pages on the subject) and a script to generate the output data.

### Using ###

The generated data is just JSON, and can be used as you would use any data in that format. Keys are stadium names, and the objects have both `lat` and `long` properties; the values of both are integers (South and West are negative).

Example stadium record:

		"Heinz Field": {
			"lat":40.44667,
			"long":-80.01583
		}

You can either download stadiums.json locally, or [you can fetch it over he network](https://raw.github.com/nflscorebot/stadiums/master/stadiums.json "https://raw.github.com/nflscorebot/stadiums/master/stadiums.json").

### Building the Data File ###

Simple! Just run `node bin/fetchstadiums.js` and you've got a shiny new `stadiums.json` file.

### Legal ###

`stadiums.json` is hereby released into the public domain. Where this is not possible, `stadiums.json` may be used and distributed completely freely, with no legal requirements whatsoever.

`fetchstadiums.coffee` and `fetchstadiums.js`, part of @NFLScoreBot, is provided to you under the following license:

	Copyright (c) 2012, David Pearson
	All rights reserved.

	Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

	Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
	Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.