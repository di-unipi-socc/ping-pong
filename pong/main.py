from __future__ import print_function

from time import sleep

from flask import Flask

app = Flask(__name__)

@app.route("/")
def work():
    return 'Pong server running!'

@app.route("/ping")
def ping():
    sleep(app.config.get('WAIT', 0))
    return "pong"


if __name__ == '__main__':
    # Load configuration from file
    app.config.from_pyfile('conf.cfg')
    port = app.config.get('PORT', 80)
    
    # Start HTTP server
    app.run(host='0.0.0.0', port=port, debug=False)
