"""
退出登录模块
"""
from flask import session, request, redirect

from . import zsg


@zsg.route('/logout')
def logout():
    """
    退出登录视图函数
    :return: 重定向到首页，清除cookie
    """

    # 当用户退出时，从cookie中取出user_no
    user_no = request.cookies['user_no']
    # 删除后端session中的登录信息
    del session[str(user_no)]
    # 重定向到首页
    resp = redirect('/index')
    # 删除cookie中的登陆信息
    resp.delete_cookie('user_no')

    return resp
