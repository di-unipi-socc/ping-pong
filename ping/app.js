/* jshint esversion: 6 */

const express = require('express');
const path = require('path');
const logger = require('morgan');
const debug = require('debug')('app:main');
const bodyParser = require('body-parser');
const request = require('request');
const config = require('config');

const app = express();

// get configuration
const PROXY = 'http://' + (config.has('proxy') ? config.get('proxy') : '127.0.0.1:3000');

debug(`Proxy enpoint: ${PROXY}`);

app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, 'public')));


function sendPing(cb) {
  request.get(`${PROXY}/ping`, (error, response, body) => {
    if (error || body != 'pong'){
      debug('error:', error, body);
      return cb(error || 'error');
    }
    debug(`Send ping to ${PROXY} status ${response.statusCode}.`);
    cb (null, body);
  });
}

app.get('/ping', (req, res, next) => {
  sendPing((err, body) => {
    if (err) return next(new Error('Proxy error'));
    res.send(body);
  });
});

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handler
app.use(function(err, req, res, next) {
  debug(err);
  
  // set locals, only providing error in development
  error = req.app.get('env') === 'development' ? err : {};

  // send the error page
  res.status(error.status || 500);
  res.send(error.message || 'error');
});

module.exports = app;
