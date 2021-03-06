# 管理和启动项目
from app import create_app

from flask_socketio import SocketIO

app = create_app()
socketio = SocketIO(app)

if __name__ == '__main__':
    socketio.run(app, debug=True)