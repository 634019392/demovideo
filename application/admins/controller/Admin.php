<?php

namespace app\admins\controller;

use think\Controller;
use Util\data\Sysdb;

/**
 * 管理员管理
 * Class Admin
 * @package app\admins\controller
 */
class Admin extends BaseAdmin
{
    // 管理员列表
    public function index()
    {
        $data['list'] = $this->db->table('admins')->lists();
        // 加载角色
        $data['groups'] = $this->db->table('admin_groups')->cates('gid');
        $this->assign('data', $data);
        return $this->fetch();
    }

    // 添加管理员
    public function add($id)
    {
        $id = (int)input('get.id');
        // 加载管理员
        $data['item'] = $this->db->table('admins')->where(['id' => $id])->item();
        // 加载角色
        $data['groups'] = $this->db->table('admin_groups')->cates('gid');
        $this->assign('data', $data);
        return $this->fetch();
    }

    // 保存管理员
    public function save()
    {
        $id = (int)input('post.id');
        $data['username'] = trim(input('post.username'));
        $data['gid'] = (int)input('post.gid');
        $password = trim(input('post.password'));
        $data['truename'] = trim(input('post.truename'));
        $data['status'] = (int)trim(input('post.status'));

        if (!$data['username']) {
            exit(json_encode(['code' => 1, 'msg' => '用户名不能为空']));
        }
        if (!$data['gid']) {
            exit(json_encode(['code' => 1, 'msg' => '请选择角色']));
        }
        if ($id == 0 && !$password) {
            exit(json_encode(['code' => 1, 'msg' => '密码不能为空']));
        }
        if (!$data['truename']) {
            exit(json_encode(['code' => 1, 'msg' => '姓名不能为空']));
        }

        if ($password) {
            //密码处理
            $data['password'] = md5($data['username'] . $password);
        }

        $res = true;//空编辑会返回0，给个默认true
        if ($id == 0) {
            // 检查用户是否已存在
            $item = $this->db->table('admins')->where(['username' => $data['username']])->item();
            if ($item) {
                exit(json_encode(['code' => 1, 'msg' => '该用户已存在']));
            }
            // 保存用户
            $data['add_time'] = time();
            $res = $this->db->table('admins')->insert($data);
        } else {
            $this->db->table('admins')->where(['id' => $id])->update($data);
        }

        if (!$res) {
            exit(json_encode(['code' => 1, 'msg' => '保存失败']));
        }
        exit(json_encode(['code' => 0, 'msg' => '保存成功']));
    }

    public function delete()
    {
        $id = (int)input('post.id');
        $res = $this->db->table('admins')->where(['id'=>$id])->delete();
        if (!$res) {
            exit(json_encode(['code'=>1,'msg'=>'删除失败']));
        }
        exit(json_encode(['code'=>0,'msg'=>'删除成功']));
    }
}
