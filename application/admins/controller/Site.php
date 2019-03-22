<?php
/**
 * 系统设置
 */

namespace app\admins\controller;

use think\Controller;
use Util\data\Sysdb;

class Site extends BaseAdmin
{
    public function index()
    {
        $site = $this->db->table('sites')->where(['names'=>'site'])->item();
        $site && $site['values'] = json_decode($site['values']);
        $this->assign('site', $site);
        return $this->fetch();
    }

    public function save(){
        $title = trim(input('post.title'));
        $url = trim(input('post.url'));
        $site = $this->db->table('sites')->where(['names'=>'site'])->item();
        if (!$site) {
            $this->db->table('sites')->insert(['names'=>'site','values'=>json_encode($title),'url'=>$url]);
        } else {
            $value['values'] = json_encode($title);
            $value['url'] = $url;
            $this->db->table('sites')->where(['names'=>'site'])->update($value);
        }
        exit(json_encode(['code'=>0,'msg'=>'保存成功']));
    }
}
