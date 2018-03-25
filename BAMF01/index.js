var http = require('http');
var fs = require('fs');
var dt = require('./module1'); //Call module
http.createServer(function (req, res) {
  //Open a file on the server and return it's content:
  fs.readFile('web/index.html', function(err, data) {
    res.writeHead(200, {'Content-Type': 'text/html'});
    res.write(data);
    return res.end();
  });
}).listen(3000);
