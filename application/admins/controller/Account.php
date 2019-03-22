<?php

namespace app\admins\controller;

use think\Controller;
use Util\data\Sysdb;

class Account extends Controller
{
    public function login()
    {
        return $this->fetch();
    }

    public function dologin()
    {
        $username = trim(input('post.username'));
        $password = trim(input('post.password'));
        $verirycode = trim(input('post.verirycode'));
        if ($username == '') {
            exit(json_encode(['code' => 1, 'msg' => '用户名不能为空']));
        }
        if ($password == '') {
            exit(json_encode(['code' => 1, 'msg' => '密码不能为空']));
        }
        if ($verirycode == '') {
            exit(json_encode(['code' => 1, 'msg' => '验证码不能为空']));
        }
        if (!captcha_check($verirycode)) {
            exit(json_encode(['code' => 1, 'msg' => '验证码错误']));
        }
        $this->db = new Sysdb();
        $admin = $this->db->table('admins')->where(['username' => $username])->item();
        if (!$admin) {
            exit(json_encode(['code' => 1, 'msg' => '用户名不存在']));
        }
        if (md5($admin['username'] . $password) != $admin['password']) {
            exit(json_encode(['code' => 1, 'msg' => '密码输入错误']));
        }
        if ($admin['status'] == 1) {
            exit(json_encode(['code' => 1, 'msg' => '用户已被禁止使用']));
        }
        //设置登录用户,session使用了tp5的助手函数
        session('admin', $admin);
        exit(json_encode(['code' => 0, 'msg' => '登录成功']));
    }

    public function logout()
    {
        session('admin', null);
        exit(json_encode(['code' => 0, 'msg' => '退出成功']));
    }
}
