<?php

namespace app\admins\controller;

use think\Controller;
use Util\data\Sysdb;

class Menu extends BaseAdmin
{
    // 菜单列表
    public function index()
    {
        $pid = (int)input('get.pid');//pid>0说明是子菜单，否则是最大级菜单

        $data['lists'] = $this->db->table('admin_menus')->where(['pid' => $pid])->lists();//页面根据pid来渲染的

        $backid = 0;
        if ($pid > 0) {
            $parent = $this->db->table('admin_menus')->where(['mid' => $pid])->item();
            $backid = $parent['pid'];
        }

        $this->assign('pid', $pid);//本层的pid，仅仅是判断是否显示返回上一级按钮
        $this->assign('backid', $backid);//上一级的pid
        $this->assign('data', $data);
        return $this->fetch();
    }

    // 保存
    public function save()
    {
        $pid = (int)input('post.pid');
        $ords = input('post.ords/a');
        $titles = input('post.titles/a');
        $controllers = input('post.controllers/a');
        $methods = input('post.methods/a');
        $ishiddens = input('post.ishiddens/a');
        $status = input('post.status/a');

        $data = [];
        foreach ($ords as $key => $value) {
            // 新增
            $data['pid'] = $pid;
            $data['ord'] = $value;
            $data['title'] = $titles[$key];
            $data['controller'] = $controllers[$key];
            $data['method'] = $methods[$key];
            $data['ishidden'] = isset($ishiddens[$key]) ? 1 : 0;
            $data['status'] = isset($status[$key]) ? 1 : 0;
//            dump($data);
            if ($key == 0 && $data['title']) {
                $this->db->table('admin_menus')->insert($data);
            }
            if ($key > 0 && $data['title'] == '' && $data['controller'] == '' && $data['method'] == '') {
                // 删除
                $this->db->table('admin_menus')->where(['mid'=>$key])->delete();
            }
            if ($key > 0 && $data['title']) {
                // 修改
                $this->db->table('admin_menus')->where(['mid'=>$key])->update($data);
            }
        }
        exit(json_encode(['code'=>0,'msg'=>'保存成功']));

    }

}
