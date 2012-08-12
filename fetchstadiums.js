// Generated by CoffeeScript 1.3.1

/*
	Copyright 2012 David Pearson.
	All rights reserved.
*/


(function() {
  var connect, fs, http, stadiums;

  fs = require("fs");

  http = require("http");

  connect = function(host, path, cb) {
    var conn, req,
      _this = this;
    conn = http.createClient(80, host);
    req = conn.request("GET", path, {
      "host": host,
      "User-Agent": "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.A.B.C Safari/525.13"
    });
    req.addListener("response", function(response) {
      var body;
      body = "";
      response.addListener("data", function(chunk) {
        return body += chunk;
      });
      return response.addListener("end", function() {
        return cb(body, path);
      });
    });
    return req.end();
  };

  stadiums = {};

  connect("en.wikipedia.org", "/wiki/List_of_NFL_stadiums", function(body, path) {
    var done, i, lines, url, _results,
      _this = this;
    lines = body.toString().replace(/\n/g, "").split("</a></div></div></td><td><a href=\"");
    i = 1;
    done = 0;
    _results = [];
    while (i < lines.length) {
      url = lines[i].split("\" title=\"")[0];
      connect("en.wikipedia.org", url, function(body, path) {
        var coords, name;
        name = path.split("/wiki/")[1].replace(/_/g, " ").replace(/%26/g, "&");
        coords = body.toString().split("<span class=\"geo\">")[1].split("</span>")[0].split("; ");
        stadiums[name] = {
          "lat": parseFloat(coords[0]),
          "long": parseFloat(coords[1])
        };
        done++;
        if (done === lines.length - 1) {
          return fs.writeFileSync("stadiums.json", JSON.stringify(stadiums));
        }
      });
      _results.push(i++);
    }
    return _results;
  });

}).call(this);