<?php

namespace app\admins\controller;

use think\Controller;
use Util\data\Sysdb;

/**
 * 后台首页
 * Class Home
 * @package app\admins\controller
 */
class Home extends BaseAdmin
{
    public function index()
    {
        $menus = false;
        $role = $this->db->table('admin_groups')->where(['gid' => $this->_admin['gid']])->item();
        if ($role) {
            $role['rights'] = (isset($role['rights']) && $role['rights']) ? json_decode($role['rights'], true) : [];
        }
        if ($role['rights']) {
            $where = 'mid in(' . implode(',', $role['rights']) . ') and ishidden = 0 and status=0';
            $menus = $this->db->table('admin_menus')->where($where)->cates('mid');
            $menus && $menus = $this->gettreeitems($menus);
        }
        $site = $this->db->table('sites')->where(['names'=>'site'])->item();
        $site && $site['values'] = json_decode($site['values']);

        $this->assign('site', $site);
        $this->assign('role', $role);
        $this->assign('menus', $menus);

        return $this->fetch();
    }

    public function welcome() {
        return $this->fetch();
    }


    // 分离菜单层级
    private function gettreeitems($items)
    {
        $tree = [];
        foreach ($items as $item) {
            if (isset($items[$item['pid']])) {
                $items[$item['pid']]['children'][] = &$items[$item['mid']];
            } else {
                $tree[] =  &$items[$item['mid']];
            }
        }
        return $tree;
    }
}
