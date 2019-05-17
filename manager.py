# 管理和启动项目
from app import create_app
from flask import render_template, request, session, redirect, make_response, abort

from flask_socketio import SocketIO
import json

app = create_app()
socketio = SocketIO(app)

# @app.route('/')
# @app.route('/index/')
# def index():
#     return render_template('flasksocketio.html')


@socketio.on('imessage',namespace='/flasksocketio')
def test_message(message):
    socketio.emit('server_response',json.dumps({'data':message}),namespace='/flasksocketio')


# @socketio.on('single chat',namespace='/chat')
# def single_chat():
#     data = {'xm': 'hello'}
#     socketio.emit('server_response', data)


@socketio.on('connect')
def connect():
    pass


@socketio.on('disconnect')
def dis_connect():
    pass





if __name__ == '__main__':
    # app.run(host='0.0.0.0')
    socketio.run(app,debug=True)
