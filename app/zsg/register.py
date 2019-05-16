import datetime
import hashlib
import random
import uuid

from flask import render_template, request, make_response, session

from app import db
from app.common.funs import ip2int, ret_sucess, ret_error
from app.tg.models import chkUserPwd
from . import zsg
from ..models import User


@zsg.route('/register', methods=['GET', 'POST'])
def register():
    """
    用户注册视图函数
    :return: get register.html
             post 错误信息/自动登录
    """

    if request.method == "GET":
        return render_template('register.html')
    else:
        # 从表单中获取用户名和密码
        user_name = request.form['user_name']
        if user_name == '':
            # 把错误信息返回给前端
            return ret_error("用户名不能为空", 101)

        user_pwd = request.form['user_pwd']
        if user_pwd == '':
            # 把错误信息返回给前端
            return ret_error("密码不能为空", 102)

        user_pwd_confirm = request.form['user_pwd_confirm']
        if user_pwd != user_pwd_confirm:
            # 把错误信息返回给前端
            return ret_error("两次密码不一致", 103)

        user = User.query.filter_by(user_nick_name=user_name).first()
        if user:
            # 把错误信息返回给前端
            return ret_error("该用户名已存在", 104)

        # 创建user实体
        user = User()
        user.user_no = gen_user_no()
        user.user_nick_name = user_name
        user.user_pwd = gen_user_pwd(user_pwd)
        user.add_time = gen_add_time()

        # 向数据库中插入数据
        try:
            db.session.add(user)
        except Exception as e_db_create:
            # 插入用户数据异常
            # 保存请求相关的信息和异常信息到日志文件中
            # 暂不实现，暂时打印到服务端控制台中
            print(e_db_create)
            # 把错误信息返回给前端
            return ret_error("该用户名已存在", 105)
        else:
            # 手动提交，注册中的自动登录部分需要从数据库中查找数据
            db.session.commit()

        # 自动登录
        return login(user_name, user_pwd, request.remote_addr)


def login(user_name, user_pwd, str_ip):
    # 从客户端获取用户ip
    str_ip = str_ip
    # 将ip转为int类型
    int_ip = ip2int(str_ip)
    user_name = user_name
    user_pwd = user_pwd
    # 查询数据库,判断用户名或密码是否正确
    res = chkUserPwd(user_name, user_pwd)

    # 更新用户ip
    User.query.filter_by(user_id=res.user_id).first().update(login_ip=int_ip)

    # 将用户信息存入session
    session[str(res.user_no)] = {'user_name': user_name, 'user_pwd': user_pwd}
    # 响应数据
    resp = make_response("<script>location.href = '/index?user_no=%s'</script>" % res.user_no)
    # 将用户易号存入cookie
    resp.set_cookie('user_no', str(res.user_no), 60 * 30)
    # 返回数据
    return resp


def gen_user_no():
    """
    生成user_no
    :return: user_no
    """

    # 生成随机数
    user_no_random = random.randint(1, 9)
    # 生成uuid
    user_no_uuid = uuid.uuid1().int
    # 获取当前时间
    user_no_time = datetime.datetime.now().strftime("%f")
    # 拼接随机数、时间与uuid的后2位
    user_no = str(user_no_random) + user_no_time + str(user_no_uuid)[-2:]

    return int(user_no)


def gen_user_pwd(user_pwd):
    '''
    生成user_pwd的md5值
    :param user_pwd: 用户输入的密码
    :return: user_pwd的md5值
    '''

    return hashlib.md5(user_pwd.encode('utf-8')).hexdigest()


def gen_add_time():
    """
    生成add_time
    :return: add_time
    """

    # 正常生成12位时间
    # 由于数据库中目前add_time为int，使用下标取前10位数字
    # 在修改数据库后请对代码进行修改
    return int(datetime.datetime.now().strftime("%Y%m%d%H%M%S")[:10])
