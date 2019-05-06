from ..models import *
from sqlalchemy import or_
import hashlib


# 判断用户名或密码是否正确
def chkUserPwd(user_name, user_pwd):
    md = hashlib.md5(user_pwd.encode('utf-8'))
    user_pwd = md.hexdigest()
    res = db.session.query(User).filter(
        or_(User.user_nick_name == user_name, User.user_no == user_name, User.user_tel == user_name),
        User.user_pwd == user_pwd).first()
    if res:
        return res

    return False
