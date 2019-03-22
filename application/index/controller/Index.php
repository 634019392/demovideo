<?php

namespace app\index\controller;

use think\Controller;
use Util\data\Sysdb;

class Index extends Controller
{
    public function __construct()
    {
        parent::__construct();
//        $this->_admin = session('admin');
//        // 未登录的用户不允许访问
//        if (!$this->_admin) {
//            header('Location: /admins.php/admins/account/login');
//            exit;
//        }
//        $this->assign('admin', $this->_admin);
        // 判断用户是否有权限
        $this->db = new Sysdb;

    }

    // 前端首页
    public function index()
    {
        // 幻灯片(类轮播图)
        $slide_list = $this->db->table('slide')->where(['type' => 0])->order('ord desc')->limit(10)->lists();
        // 导航标签
        $channel_list = $this->db->table('video_label')->where(['flag' => 'channel'])->order('ord asc')->pages(24);

        // 今日焦点（此处渲染）
        $today_hot_list = $this->db->table('video')->where(['channel_id' => 2, 'status' => 1])->pages(14);
        // 今日焦点（轮播图）
        $today_hot_img = $this->db->table('slide')->where(['type' => 1])->order('ord desc')->limit(4)->lists();
        $left_wait_arr = $this->db->table('video')->where(['channel_id' => 2, 'status' => 1])->order('id desc')->limit('0,14')->lists();
        $today_video_list['left'] = $this->regroup_arr($left_wait_arr);
        $today_video_list['right'] = $this->db->table('video')->where(['channel_id' => 2, 'status' => 1])->order('id desc')->limit('15,10')->lists();
        $today_video_list['right'] = array_chunk($today_video_list['right'],2);

        // 综艺（轮播图）
        $variety_img = $this->db->table('slide')->where(['type' => 2])->order('ord desc')->limit(2)->lists();
        $variety_list['list'] = $this->db->table('video')->where(['channel_id' => 3, 'status' => 1])->order('id desc')->limit('0,10')->lists();
        // 综艺（精彩推荐）
        $variety_wonderful_recommendation = $this->db->table('video')->where(['channel_id' => 3, 'status' => 1])->order('pv desc')->lists();

        // 电影（列表）
        $movie_list = $this->db->table('video')->where(['channel_id' => 21, 'status' => 1])->order('id desc')->limit('0,15')->lists();
        // 电影榜
        $movie_wonderful_recommendation = $this->db->table('video')->where(['channel_id' => 21, 'status' => 1])->order('pv desc')->limit('0,10')->lists();

        // 网站设置
        $site_list = $this->db->table('sites')->lists();

        $this->assign('today_hot_img', $today_hot_img);
        $this->assign('channel_list', $channel_list['lists']);
        $this->assign('today_hot_list', $today_hot_list['lists']);
        $this->assign('today_video_list', $today_video_list);
        $this->assign('variety_img', $variety_img);
        $this->assign('variety_list', $variety_list['list']);
        $this->assign('variety_wonderful_recommendation', $variety_wonderful_recommendation);
        $this->assign('movie_list', $movie_list);
        $this->assign('movie_wonderful_recommendation', $movie_wonderful_recommendation);
        $this->assign('site_list', $site_list);
        $this->assign('data', $slide_list);
        return $this->fetch();//使用静态模板
    }

    // 筛选页面
    public function cate()
    {
        $data['label_channel'] = (int)input('get.label_channel');
        $data['label_charge'] = (int)input('get.label_charge');
        $data['label_area'] = (int)input('get.label_area');

        $channel_list = $this->db->table('video_label')->where(['flag' => 'channel'])->cates('id');
        $charge_list = $this->db->table('video_label')->where(['flag' => 'charge'])->cates('id');
        $area_list = $this->db->table('video_label')->where(['flag' => 'area'])->cates('id');

        $data['pageSize'] = 6;
        $data['page'] = max(1, (int)input('get.page'));
        $where['status'] = 1;
        if ($data['label_channel']) {
            $where['channel_id'] = $data['label_channel'];
        }
        if ($data['label_charge']) {
            $where['charge_id'] = $data['label_charge'];
        }
        if ($data['label_area']) {
            $where['area_id'] = $data['label_area'];
        }
        $data['data'] = $this->db->table('video')->where($where)->pages($data['pageSize']);

        $this->assign('data', $data);
        $this->assign('channel_list', $channel_list);
        $this->assign('charge_list', $charge_list);
        $this->assign('area_list', $area_list);
        return $this->fetch();
    }

    // 视频播放页
    public function video()
    {
        // 视频id
        $id = (int)input('get.id');
        $video = $this->db->table('video')->where(['id' => $id])->item();

        //进入一次播放页面，对应视频的播放量+1
        $this->db->table('video')->where(['id' => $id])->update(['pv'=>($video['pv']+1)]);

        $this->assign('video', $video);
        return $this->fetch();
    }

    /**
     * 调用静态页面模板
     * @return mixed
     */
    public function build_fetch()
    {
        $path_str = substr($_SERVER["PHP_SELF"], 0, 1);//判断路径第一个字符是否是斜杠
        if ($path_str == '/') {
            $result_file_path = str_replace(['/index.php', request()->action()], '', $_SERVER["PHP_SELF"]);
            if ($result_file_path == '') {// 如果为空则默认是首页
                $result_file_path = '/index/index/';
            }
            $result_file_path = substr($result_file_path, 1);//移除斜杠后的部分静态页面路径
        } else {
            $result_file_path = str_replace(['/index.php', request()->action()], '', $_SERVER["PHP_SELF"]);//部分静态页面路径
        }

        $result_file_path = preg_replace('/index/', 'index/view', $result_file_path, 1);//结果路径对应控制器的html
        $result_file = request()->action() . '.html';
        define('HTML_PATH', $_SERVER["DOCUMENT_ROOT"] . '/html/' . $result_file_path);//静态页面的全路径
//        //echo APP_PATH.$result_file_path.$result_file;exit;//显示案例：E:\phpstudy\WWW\video\public/../application/index/view/index/aa.html
        if (file_exists(HTML_PATH . $result_file)) {
            if (time() - filemtime(HTML_PATH . $result_file) <= 60) {
                return $this->fetch(HTML_PATH . $result_file);
            } else {
                $this->buildHtml($result_file, HTML_PATH, APP_PATH . $result_file_path . $result_file);
                return $this->fetch(HTML_PATH . $result_file);
            }
        } else {
            $this->buildHtml($result_file, HTML_PATH, APP_PATH . $result_file_path . $result_file);
            return $this->fetch(HTML_PATH . $result_file);
        }
    }


    /**
     * 创建静态页面   
     * @access protected   
     * @param string $htmlfile 生成的静态文件名称   
     * @param string $htmlpath 生成的静态文件路径
     * @param string $templateFile 指定要调用的模板文件
     * 默认为空 由系统自动定位模板文件
     * @return mixed
     */
    private function buildHtml($htmlfile = '', $htmlpath = '', $templateFile = '')
    {
        $content = $this->fetch($templateFile);
        $htmlfile = $htmlpath . $htmlfile;
        $File = new \think\template\driver\File();
        $File->write($htmlfile, $content);
        return $content;
    }

    /**
     * 重装符合前端格式的数组
     * @param $wait_arr // 重装数组拿取数据的数组
     * @param array $result_arr // 自定义组装数组，也是返回数组
     * @return array
     */
    private function regroup_arr($wait_arr,$result_arr = []) {
        $i = 0;
        foreach ($wait_arr as $k=>$v) {
            $i++;
            if ($i<=2) {
                if ($i % 2 == 1) {
                    if (empty(array_slice($wait_arr, $i-1, 1))) {
                        continue;
                    } else {
                        $result_arr[0] = array_slice($wait_arr, $i-1, 1)[0];
                        $result_arr[0]['child'] = [];
                    }
                } else {
                    if (empty(array_slice($wait_arr, $i-1, 1))) {
                        continue;
                    } else {
                        $result_arr[1] = array_slice($wait_arr, $i-1, 1)[0];
                        $result_arr[1]['child'] = [];
                    }
                }
            } else {
                if ($i % 2 == 1) {
                    if (count($result_arr[0]['child'])<3) {
                        $key = count($result_arr[0]['child']);
                        $result_arr[0]['child'][$key] = [];
                        if (!empty(array_slice($wait_arr, $i-1, 1))) {
                            array_push($result_arr[0]['child'][$key],array_slice($wait_arr, $i-1, 1)[0]);
                        } else {
                            continue;
                        }

                        if (count($result_arr[0]['child'][$key]) < 2) {
                            $dan_arr = array_slice($wait_arr, $i+5, 1);
                            if (!empty($dan_arr)) {
                                array_push($result_arr[0]['child'][$key],$dan_arr[0]);
                            } else {
                                continue;
                            }
                        }
                    }
                } else {
                    if (count($result_arr[1]['child'])<3) {
                        $key = count($result_arr[1]['child']);
                        $result_arr[1]['child'][$key] = [];
                        if (!empty(array_slice($wait_arr, $i-1, 1))) {
                            array_push($result_arr[1]['child'][$key],array_slice($wait_arr, $i-1, 1)[0]);
                        } else {
                            continue;
                        }
                        if (count($result_arr[1]['child'][$key]) < 2) {
                            $shuang_arr = array_slice($wait_arr, $i+5, 1);
                            if (!empty($shuang_arr)) {
                                array_push($result_arr[1]['child'][$key],$shuang_arr[0]);
                            } else {
                                continue;
                            }
                        }
                    }
                }
            }
        }
        return $result_arr;
    }

}
