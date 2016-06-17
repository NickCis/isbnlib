#!/usr/bin/env python

# Comment me out for the example to work
import isbnlib
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return ''.join(['<img src="/static/{}.png">'.format(img)
                    for img in ['tux', 'tux1', 'tux2', 'tux3', 'tux4',
                                'tux5', 'tux6', 'tux7', 'tux8']])

if __name__ == '__main__':
    app.run(debug=True)
