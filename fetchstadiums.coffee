###
	Copyright 2012 David Pearson.
	All rights reserved.
###

fs=require "fs"
http=require "http"

connect=(host, path, cb) ->
	conn=http.createClient 80, host
	req=conn.request "GET", path, {"host":host, "User-Agent":"Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.A.B.C Safari/525.13"}
	req.addListener "response", (response) =>
		body=""

		response.addListener "data", (chunk) =>
			body+=chunk
		response.addListener "end", =>
			cb body, path
	req.end()

stadiums={}

connect "en.wikipedia.org", "/wiki/List_of_NFL_stadiums", (body, path) ->
	lines=body.toString().replace(/\n/g, "").split("</a></div></div></td><td><a href=\"")

	i=1
	done=0

	while i<lines.length
		url=lines[i].split("\" title=\"")[0]

		connect "en.wikipedia.org", url, (body, path) =>
			name=path.split("/wiki/")[1].replace(/_/g, " ").replace(/%26/g, "&")
			coords=body.toString().split("<span class=\"geo\">")[1].split("</span>")[0].split("; ")

			stadiums[name]={"lat":parseFloat(coords[0]), "long":parseFloat(coords[1])}

			done++
			if done==lines.length-1
				fs.writeFileSync "stadiums.json", JSON.stringify(stadiums)
		i++