<?php
/**
 * 影片管理
 */

namespace app\admins\controller;

use think\Controller;
use think\Log;
use Util\data\Sysdb;

class Video extends BaseAdmin
{
    // 影片列表
    public function index()
    {
        $data['pageSize'] = 15;
        $data['page'] = max(1, (int)input('get.page'));

        $where = [];
        $data['wd'] = trim(input('get.wd'));
        $data['wd'] && $where = 'title like"%' . $data['wd'] . '%"';
        $data['data'] = $this->db->table('video')->where($where)->order('id desc')->pages($data['pageSize']);

        $label_ids = [];
        foreach ($data['data']['lists'] as $item) {
            !in_array($item['channel_id'], $label_ids) && $label_ids[] = $item['channel_id'];
            !in_array($item['charge_id'], $label_ids) && $label_ids[] = $item['charge_id'];
            !in_array($item['area_id'], $label_ids) && $label_ids[] = $item['area_id'];
        }
        $label_ids && $data['labels'] = $this->db->table('video_label')->where('id in(' . implode(',', $label_ids) . ')')->cates('id');
        $this->assign('data', $data);
        return $this->fetch();
    }

    // 添加影片
    public function add()
    {
        $data['channel'] = $this->db->table('video_label')->where(['flag' => 'channel'])->lists();
        $data['charge'] = $this->db->table('video_label')->where(['flag' => 'charge'])->lists();
        $data['areas'] = $this->db->table('video_label')->where(['flag' => 'area'])->lists();

        $id = (int)input('get.id');
        $data['item'] = $this->db->table('video')->where(['id' => $id])->item();

        $this->assign('data', $data);
        return $this->fetch();
    }

    public function save()
    {
        $id = (int)input('post.id');
        $data['title'] = trim(input('post.title'));
        $data['channel_id'] = (int)(input('post.channel_id'));
        $data['charge_id'] = (int)(input('post.charge_id'));
        $data['area_id'] = (int)(input('post.area_id'));
        $data['img'] = trim(input('post.img'));
        $data['url'] = trim(input('post.url'));
        $data['keywords'] = trim(input('post.keywords'));
        $data['desc'] = trim(input('post.desc'));
        $data['status'] = trim(input('post.status'));

        if ($data['title'] == '') {
            exit(json_encode(['code' => 1, 'msg' => '影片名称不能为空']));
        }
        if ($data['url'] == '') {
            exit(json_encode(['code' => 1, 'msg' => '影片地址不能为空']));
        }

        if ($id) {
            $this->db->table('video')->where(['id' => $id])->update($data);
        } else {
            $data['add_time'] = time();
            $this->db->table('video')->insert($data);
        }
        exit(json_encode(['code' => 0, 'msg' => '保存成功']));
    }

    // 删除
    public function delete()
    {
        $id = (int)input('post.id');
        $res = $this->db->table('video')->where(['id' => $id])->delete();
        if (!$res) {
            exit(json_encode(['code' => 1, 'msg' => '删除失败']));
        }
        exit(json_encode(['code' => 0, 'msg' => '删除成功']));
    }

    // 图片上传
    public function upload_img()
    {
        $file = request()->file('file');
        if ($file == null) {
            exit(json_encode(['code' => 1, 'msg' => '没有文件上传']));
        }
        $info = $file->move(ROOT_PATH . 'public' . DS . 'uploads');
        $ext = $info->getExtension();
        if (!in_array($ext, array('jpg', 'jpeg', 'gif', 'png', 'mp4'))) {
            exit(json_encode(['code' => 1, 'msg' => '文件格式不支持']));
        }
        $img = '/uploads/' . $info->getSaveName();
        exit(json_encode(['code' => 0, 'msg' => $img]));
    }

    // 转码 // todo 此处转码删除本地和1447fe的md5路径未作删除，转码失败有肯能传至七牛时候是因为删除了本地的上传文件，数据库中的未做删除
    public function m3u8_list()
    {
        if (array_key_exists('path', request()->param())) {
            $path = trim(request()->param()['path']);
            $suffix = substr($path, strrpos($path, '.'));//截取第一个文件的后缀
            $dir = 'zone_uploads/' . date('Ymd', time()) . '/' . time();// 目录(含文件不含文件后缀)
            $qiniu_key = $dir . $suffix;
            $arr = qiniu_upload($path, false, $qiniu_key);// 传至七牛
            if ($arr) {
                $key = $arr[0]['key'];
            } else {
                exit(json_encode(['code' => 404, 'msg' => '请求失败!']));
            }
            $m3u8 = $dir;
            $res = qiniu_data_persistence($key, 'sdktest', $_SERVER['SERVER_NAME'] . '/admins.php/admins/video/notify', $m3u8, $m3u8);
            if ($res)
                exit(json_encode(['url' => 'http://video.w20.top/' . $m3u8 . '.m3u8']));
        } else {
            exit(json_encode(['error' => 404, 'msg' => '不存在path键']));
        }
    }

    // m3u8转码异步通知地址
    public function notify()
    {
        Log::write(123);
    }

    // 2分片上传(服务端默认传)
    public function CheckChumServlet()
    {
        $md5 = request()->param()['md5'];
        $object_info = request()->file('file');
        $file_name = $object_info->getInfo()['name'];
        $path = ROOT_PATH . 'public' . DS . 'zone_uploads' . DS . $md5 . '/';
        $ext = substr($file_name, strrpos($file_name, '.') + 1);

        if (in_array($ext, ['gif', 'jpg', 'jpeg', 'bmp', 'png', 'swf'])) {
//            zone_uploads();//此方法需要加入md5方法作验证，检测上传唯一性
            exit(json_encode(['error' => 412, 'msg' => '此方法不支持图片上传']));// move中检测图片，无法获取分片的图片信息，分片后的图片默认是损坏的
        }

        //测试仅支持MP4格式
        $chunk = 0;
        $chunks = 0;
        if (array_key_exists('chunk', request()->param()) && array_key_exists('chunks', request()->param())) {
            $chunk = (int)request()->param()['chunk'];
            $chunks = (int)request()->param()['chunks'];
        }

        // 保存文件的顺序很重要!
        $object = $object_info->rule('uniqid')->move($path, $chunk);
        if ($object) {
            exit(json_encode(['chunks' => $chunks, 'chunk' => $chunk]));
//            return ['chunks'=>request()->param()['chunks'],'chunk'=>request()->param()['chunk']];
        } else {
            exit(json_encode(['error' => 500]));
        }


    }

    // todo 未完善的功能：断点续传的时候合并的时候将临时md5目录和目录下的文件删掉（此处不删除仅作为测试使用）
   // 3最终合并文件
    function videoUpload()
    {
        $md5 = request()->param()['md5'];
//        $md5 = '1447fe953d79f5dd0debfb46af935f95';
        $zone_public_path = ROOT_PATH . 'public' . DS . 'zone_uploads' . DS;//分片与断点的公共路径
        $dir = $zone_public_path . $md5;
        if (is_dir($dir) && empty(scandir($dir)[2])) {//存在文件默认选取第一个，索引为2的是因为0和1是.和..
            return false;
        } else {
            $suffix = substr(scandir($dir)[2], strrpos(scandir($dir)[2], '.'));//截取第一个文件的后缀
        }

        if (is_dir($dir)) {
            //获取文件的顺序很重要!!!
            $files = [];
            $chunk_id = 0;
            $chunk_file = $zone_public_path . $md5 . DS;
            while (file_exists($chunk_file . $chunk_id . $suffix)) {
                $files[] = $chunk_file . $chunk_id . $suffix;
                $chunk_id++;
            }
            $file_name = time() . $suffix;//这里开始
            $path_file = $zone_public_path . date('Ymd') . DS . $file_name;
            //日期目录不存在则创建目录
            if (!is_dir($zone_public_path . date('Ymd'))) {
                mkdir($zone_public_path . date('Ymd'));
            }
            $count = 0;
            foreach ($files as $v) {
                $_file = file_get_contents($v);
                $_res = file_put_contents($path_file, $_file, FILE_APPEND);
                if ($_res) {
//                    unlink($v);
                } else {
                    $count++;
                }
            }

            if ($count == 0) {
                // 检查合并后的文件hash
                $_hash = hash_file('sha1', $path_file);
                //合并后的文件已存在则删除已合并文件并返回已有文件信息
                $file_info = $this->db->table('zone_uploads')->where(['sha1' => $_hash])->item();
                if (!empty($file_info)) {
                    unlink($path_file);
                    return $file_info;
                }
                //合并后的文件入库并返回
                $_data = ['name' => $file_name, 'path' => $path_file, 'sha1' => $_hash, 'guid' => '', 'md5' => request()->param()['md5']];
                $result = $this->db->table('zone_uploads')->insertGetId($_data);
                $_data['id'] = $result;
                return $_data;
            } else {
                $this->error = '合并文件失败';
                return false;
            }
        } else {
            $this->error = '分片目录不存在!';
            return false;
        }
    }

    // 1分片验证
    function checkChunk()
    {
        $md5 = request()->param()['md5'];
        $chunk = (int)(request()->param()['chunk']);
        $dir = ROOT_PATH . 'public' . DS . 'zone_uploads' . DS . $md5 . DS;
        if (is_dir($dir)) {
            $files = $this->getFileByPath($dir);
            if ($chunk <= (count($files) - 1)) {
                exit(json_encode(['ifExist' => true, 'chunk' => $chunk]));
            } else {
                exit(json_encode(['ifExist' => false, 'chunk' => $chunk]));
            }
        } else {
            exit(json_encode(['ifExist' => false, 'chunk' => $chunk]));
        }
    }

    /**
     * 获取临时分片目录下所有文件（ps：以数组格式）
     * @param $chunk_file
     * @return array|bool
     */
    function getFileByPath($chunk_file)
    {
        $chunk_id = 0;
        $files = [];

        if (is_dir($chunk_file) && empty(scandir($chunk_file)[2])) {//存在文件默认选取第一个，索引为2的是因为0和1是.和..
            return false;
        } else {
            $suffix = substr(scandir($chunk_file)[2], strrpos(scandir($chunk_file)[2], '.'));//截取第一个文件的后缀
        }

        while (file_exists($chunk_file . $chunk_id . $suffix)) {
            $files[] = $chunk_file . $chunk_id . $suffix;
            $chunk_id++;
        }
        return $files;
    }

}
