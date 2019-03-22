<?php

namespace app\admins\controller;

use think\Controller;
use Util\data\Sysdb;

/**
 * 标签管理
 * Class Labels
 * @package app\admins\controller
 */
class Labels extends BaseAdmin
{
    // 频道管理
    public function channel()
    {
        $channel = $this->db->table('video_label')->where(['flag' => 'channel'])->lists();
        $this->assign('data', $channel);
        return $this->fetch();
    }

    // 资费
    public function charge()
    {
        $charge = $this->db->table('video_label')->where(['flag' => 'charge'])->lists();
        $this->assign('data', $charge);
        return $this->fetch();
    }

    // 地区
    public function area()
    {
        $area = $this->db->table('video_label')->where(['flag' => 'area'])->lists();
        $this->assign('data', $area);
        return $this->fetch();
    }

    public function save()
    {
        $flag = trim(input('post.flag'));
        $ords = input('post.ords/a');
        $titles = input('post.titles/a');
        $status = input('post.status/a');

        $data = [];
        foreach ($ords as $key => $value) {
            // 新增
            $data['flag'] = $flag;
            $data['ord'] = $value;
            $data['title'] = $titles[$key];
            $data['status'] = isset($status[$key]) ? 1 : 0;
//            dump($data);
            if ($key == 0 && $data['title']) {
                $this->db->table('video_label')->insert($data);
            }
            if ($key > 0) {
                if ($data['title'] == '') {
                    // 删除
                    $this->db->table('video_label')->where(['id'=>$key])->delete();
                } else {
                    // 修改
                    $this->db->table('video_label')->where(['id'=>$key])->update($data);
                }
            }
        }
        exit(json_encode(['code'=>0,'msg'=>'保存成功']));
    }
}