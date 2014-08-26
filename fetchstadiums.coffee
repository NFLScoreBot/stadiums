###
	Copyright 2012-2014 David Pearson.
	All rights reserved.
###

fs = require "fs"
http = require "http"

connect = (host, path, cb) ->
	opts =
		host : host
		"User-Agent" : "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.A.B.C Safari/525.13"
		path : path
		method : "GET"

	req = http.request opts, (response) ->
		body = ""

		response.setEncoding "utf8"

		response.on "data", (chunk) ->
			body += chunk
		response.on "end", ->
			cb body, path
	req.end()

stadiums = {}

connect "en.wikipedia.org", "/wiki/List_of_NFL_stadiums", (body, path) ->
	lines = body.toString()
		.replace /\n/g, ""
		.split "</a></td><th scope=\"row\"><a href=\""

	i = 1
	done = 0

	while i < lines.length
		url = lines[i].split("\" title=\"")[0]
		console.log url

		connect "en.wikipedia.org", url, (body, path) ->
			name = path.split("/wiki/")[1].replace(/_/g, " ").replace(/%26/g, "&")
			coords = body.toString().split("<span class=\"geo\">")[1].split("</span>")[0].split("; ")

			stadiums[name] =
				lat  : parseFloat coords[0]
				long : parseFloat coords[1]

			console.log name + ":"
			console.log stadiums[name]

			done += 1
			if done is lines.length - 1
				fs.writeFileSync "stadiums.json", JSON.stringify(stadiums)
		i += 1