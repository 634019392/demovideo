<?php
/**
 * 幻灯片管理
 */

namespace app\admins\controller;

use think\Controller;
use Util\data\Sysdb;

class Slide extends BaseAdmin
{
    // 首页首屏
    public function index()
    {
        $data = $this->db->table('slide')->where(['type' => 0])->lists();
        $this->assign('data', $data);
        return $this->fetch();
    }

    // 添加幻灯片,带id则为编辑
    public function add_first()
    {
        $id = (int)input('get.id');
        $data['item'] = $this->db->table('slide')->where(['id' => $id])->item();
        $this->assign('data', $data);
        return $this->fetch();
    }

    // 保存幻灯片
    public function save()
    {
        $id = (int)input('post.id');
        $data['ord'] = (int)input('post.ord');
        $data['descript'] = trim(input('post.descript'));
        $data['type'] = (int)(input('post.type'));
        $data['title'] = trim(input('post.title'));
        $data['url'] = trim(input('post.url'));
        $data['img'] = trim(input('post.img'));

        if ($data['title'] == '') {
            exit(json_encode(['code' => 1, 'msg' => '幻灯片名称不能为空']));
        }
        if ($data['url'] == '') {
            exit(json_encode(['code' => 1, 'msg' => '幻灯片地址不能为空']));
        }
        if ($data['img'] == '') {
            exit(json_encode(['code' => 1, 'msg' => '幻灯片图片不能为空']));
        }
        if ($id) {
            $this->db->table('slide')->where(['id' => $id])->update($data);
        } else {
            $this->db->table('slide')->insert($data);
        }
        exit(json_encode(['code' => 0, 'msg' => '保存成功']));

    }

    // 删除
    public function delete()
    {
        $id = (int)input('post.id');
        $res = $this->db->table('slide')->where(['id'=>$id])->delete();
        if (!$res) {
            exit(json_encode(['code'=>1,'msg'=>'删除失败']));
        }
        exit(json_encode(['code'=>0,'msg'=>'删除成功']));
    }

///////////////
    // 今日焦点轮播
    public function index_today_focus()
    {
        $data = $this->db->table('slide')->where(['type' => 1])->lists();
        $this->assign('data', $data);
        return $this->fetch();
    }

    // 添加今日焦点轮播,带id则为编辑
    // ps:页面隐藏域要跟随修改,保存路径跟随修改
    public function add_first_today_focus()
    {
        $id = (int)input('get.id');
        $data['item'] = $this->db->table('slide')->where(['id' => $id])->item();
        $this->assign('data', $data);
        return $this->fetch();
    }
//////////

    // 综艺轮播
    public function index_variety()
    {
        $data = $this->db->table('slide')->where(['type' => 2])->lists();
        $this->assign('data', $data);
        return $this->fetch();
    }

    // 综艺轮播添加，带id即为编辑
    // ps:页面隐藏域要跟随修改,保存路径跟随修改
    public function add_first_variety()
    {
        $id = (int)input('get.id');
        $data['item'] = $this->db->table('slide')->where(['id' => $id])->item();
        $this->assign('data', $data);
        return $this->fetch();
    }

}
