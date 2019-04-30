<?php

namespace app\index\controller;

use think\Config;
use think\Controller;
use think\Log;
use Util\data\Sysdb;
// 引入鉴权类
use Qiniu\Auth;
// 引入上传类
use Qiniu\Storage\UploadManager;
use Qiniu\Processing\PersistentFop;


class Qiniu extends Controller
{
    public function aaa()
    {
        // 需要填写你的 Access Key 和 Secret Key
        $accessKey = '5w_1SysUwnAgl_7N-P2Nvgl-3VZk72XqJtVt_bTk';
        $secretKey = '0ufeznfLYzbDQ3zOenh1rKtsHQbiO18tOtgsn1VR';
        $bucket = 'video';
        // 构建鉴权对象
        $auth = new Auth($accessKey, $secretKey);
        // 生成上传 Token
        $token = $auth->uploadToken($bucket);
        // 要上传文件的本地路径
        $filePath = ROOT_PATH . '/public/' . 'gogopher.jpg';
        // 上传到七牛后保存的文件名
        $key = 'go.jpg';
        // 初始化 UploadManager 对象并进行文件的上传。
        $uploadMgr = new UploadManager();
        // 调用 UploadManager 的 putFile 方法进行文件的上传。
        $uploadMgr->putFile($token, $key, $filePath);
    }

    public function bbb()
    {
        //对已经上传到七牛的视频发起异步转码操作
        $accessKey = '5w_1SysUwnAgl_7N-P2Nvgl-3VZk72XqJtVt_bTk';
        $secretKey = '0ufeznfLYzbDQ3zOenh1rKtsHQbiO18tOtgsn1VR';
        $bucket = 'video';
        $auth = new Auth($accessKey, $secretKey);
        //要转码的文件所在的空间和文件名。
        $key = 'videodasheng.mp4';
        //转码是使用的队列名称。 https://portal.qiniu.com/mps/pipeline
        $pipeline = 'sdktest';
        $force = false;
        //转码完成后通知到你的业务服务器。
        $notifyUrl = 'http://www.php.demo/index.php/index/qiniu/ccc';
        $config = new \Qiniu\Config();
        //$config->useHTTPS=true;
        $pfop = new PersistentFop($auth, $config);
        //存七牛的文件名
        $fileName = date('YmdHis');
        $pattern = \Qiniu\base64_urlSafeEncode($fileName . '_$(count).ts');

        //要进行转码的转码操作。 http://developer.qiniu.com/docs/v6/api/reference/fop/av/avthumb.html
        // hls转码。 https://developer.qiniu.com/dora/manual/1485/audio-and-video-slice
        $base64_url = base64_encode('video.w20.top');
        $fops = "avthumb/m3u8/domain/{$base64_url}/vb/5m/segtime/15/pattern/{$pattern}|saveas/" . \Qiniu\base64_urlSafeEncode("{$bucket}:{$fileName}.m3u8");
        list($id, $err) = $pfop->execute($bucket, $key, $fops, $pipeline, $notifyUrl, $force);
        echo "\n====> pfop avthumb result: \n";
        if ($err != null) {
            dump($err);
        } else {
            echo "PersistentFop Id: $id\n";
        }
        //查询转码的进度和状态
        list($ret, $err) = $pfop->status($id);
        echo "\n====> pfop avthumb status: \n";
        if ($err != null) {
            dump($err);
        } else {
            exit(json_encode($ret));
        }
    }

    public function ccc()
    {
        Log::write(time() . '111');
    }

    public function ddd()
    {
        $a = qiniu_data_persistence('videodasheng.mp4','sdktest','http://www.php.demo/index.php/index/qiniu/ccc','g','g',['is_more'=>true]);
        dump(json_decode($a));
    }
}