<?php
namespace app\admins\controller;
use think\Controller;
use Util\data\Sysdb;

class Test extends Controller
{
    function __construct()
    {
        $this->db = new Sysdb();
    }

    public function index()
    {
        $res = $this->db->table('admins')->field('id,username')->lists();
        dump($res);
        $res2 = $this->db->table('admins')->field('id,username')->cates('username');
        dump($res2);
    }

}
