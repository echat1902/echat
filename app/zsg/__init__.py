"""
张寿光
"""
from flask import Blueprint

zsg = Blueprint('zsg', __name__)
from .register import *
