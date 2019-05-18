from flask import render_template,request

from exct import socketio
from .models import *
from . import szh
from app.common.funs import *
from flask_socketio import emit,join_room,leave_room
import json,time


# app目录
app_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
# 当前时间戳(毫秒)
mill_time = get_mill_time()
# 上传文件目录
upload_path = chk_path(os.path.join(app_dir, 'static', 'upload'))

#存储用户socket的字典
USERROOM_DICT = {}

# 示例
# 本地测试访问地址 http://localhost:5000/interGroup
@szh.route('/interGroup')
def add_fri():
    return '进入群成功'


@socketio.on("send_msg")
def msg_manager(data):
    send_list = []
    recv_dict = {}
    user_no = data["user_no"]#获取发送者易号
    send_user_id = query_user_id(user_no)#获取当前用户id
    int_time = int(time.time())
    if data["content_type"] == 1: # 1文本内容
        if data["group_id"] == 0:  # 私聊
            send_list = [data["recv_user_no"][0]]#要私聊的用户易号
            send_user_nickname = query_user_self_nink_name(send_user_id)#发送者的用户昵称
            recv_dict = client_recv_model(user_no,send_user_nickname, data["content"], 1,int_time)#要发送的数据
        else:  # /其他群id
            send_user_nickname = query_user_groupnick_name(send_user_id)#获取发送者的群用户昵称
            list_user_id = query_group_userid(data["group_id"])#获取该群群员id列表
            send_list = get_grouplist_recv_userno(list_user_id)#将群员id列表转换为易号列表
            recv_dict = client_recv_model(user_no,send_user_nickname, data["content"], 1,int_time,data["group_id"],data["recv_user_no"])#要发送的数据
    special_id_list = get_special_str(data["recv_user_no"])
    save_into_record(data, send_user_id, special_id_list,int_time)#将消息存入记录表
    for name in send_list:#易号即房间号
        try:
            emit("recv_msg",recv_dict,room=name)
        except Exception as e:
            pass
            # print("该用户不在线，发送失败")



@socketio.on("connect")
def connect(msg):
    user_no = msg["user_no"]
    join_room(user_no)#触发事件加入用户易号名房间，实现一人一房间

    return_msg = json.dumps("succes")#此处应进行未接受消息处理
    emit("connect_status",return_msg)


@socketio.on("leave")
def connect(msg):
    room = msg["user_no"]
    leave_room(room)#触发事件时离开房间








# 文件上传
@szh.route('/file/upload/<now_time>', methods=['POST'])
def upload_part(now_time):  # 接收前端上传的一个分片
    task = request.form.get('task_id')  # 获取文件的唯一标识符
    chunk = request.form.get('chunk', 0)  # 获取该分片在所有分片中的序号
    filename = '%s%s' % (task, chunk)  # 构造该分片的唯一标识符
    upload_file = request.files['file']
    path = chk_path(os.path.join(upload_path, str(now_time)))
    file_name = os.path.join(path, filename)
    upload_file.save(file_name)  # 保存分片到本地
    return json.dumps({})


@szh.route('/file/merge', methods=['GET'])
def upload_success():  # 按序读出分片内容，并写入新文件
    target_filename = request.args.get('filename')  # 获取上传文件的文件名
    task = request.args.get('task_id')  # 获取文件的唯一标识符
    now_time = request.args.get('now_time')
    path = chk_path(os.path.join(upload_path, str(now_time)))
    upload_file = os.path.join(path, target_filename)

    chunk = 0  # 分片序号
    with open(upload_file, 'wb') as target_file:  # 创建新文件
        while True:
            try:
                filename = os.path.join(upload_path, str(now_time), task + str(chunk))
                source_file = open(filename, 'rb')  # 按序打开每个分片
                target_file.write(source_file.read())  # 读取分片内容写入新文件
                source_file.close()
            except IOError as msg:
                break

            chunk += 1
            os.remove(filename)  # 删除该分片，节约空间

    return json.dumps({})