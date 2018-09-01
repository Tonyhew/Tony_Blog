<?php

namespace app\index\controller;
use	think\captcha\Captcha;
use think\Controller;
class User extends Controller{
	public function login() {
		if (request() -> isPost()) {
			$mail = input("post.email");
			$pass = input("post.pass");
			$verify = input("post.vercode");
			// 验证码处理类
			$captcha = new Captcha();
			if( !$captcha->check($verify)){
				return json(['status'=>-1,'msg'=>'验证码错误！']);
			}
			$res = db('user')->where(['user_mail'=>$mail,'user_pass'=>md5($pass)])->field('id,user_nickname,user_avatar,user_place')->find();
			if(isset($res['id'])) {
				session('user_id',$res['id']);
				cookie('user_nickname',$res['user_nickname']);
				cookie('user_avatar',$res['user_avatar']);
				cookie('user_place',$res['user_place']);
				return json(['status'=>0,'msg'=>'登陆成功！','action'=>'/index.php/index/index/index']);
			} else {
				return json(['status'=>-2,'msg'=>'登录失败,请重新登录！','action'=>'/index.php/index/user/login']);
			}
		} else {
			return view();
		}
	}
	
	public function register() {
		if(request() -> isPost()) {
			$mail = input("post.email");
			$nickname = input("post.username");
			$pass = input("post.pass");
			$repass = input("post.repass");
			$city = input("post.city");
			$verify = input("post.vercode");
			$captcha = new Captcha();
			if( !$captcha->check($verify)){
				return json(['status'=>-1,'msg'=>'验证码错误！']);
			}
			if($pass!=$repass) {
				return json(['status' => -2,'msg' => '两次密码不一致！']);
			}
			$data['user_mail'] = $mail;
			
			if(db('user')->where($data)->count()>0){
				return json(['status'=>-3,'msg'=>'邮箱已经存在！']);
			}
			$data['user_pass'] = md5($pass);
			$data['user_nickname'] = $nickname;
			$data['user_place'] = $city;
			$data['user_reg_time'] = time();
			$uid = db('user')->insertGetId($data);
			if($uid>0){
				session("user_id",$uid);
				cookie('user_nickname',$nickname);
				cookie('user_avatar','/public/img/avatar/default.png');
				cookie('user_place',$city);
				return json(['status'=>0,'msg'=>'注册成功！','action'=>'/index.php/index/index/index']);
			}else{
				return json(['status'=>-4,'msg'=>'注册失败！']);
			}
		} else {
			return view();
		}
	}
	
	public function logout() {
		session('user_id',null);
		cookie('user_nickname',null);
		cookie('user_avatar',null);
		cookie('user_place',null);
		$this->success('退出成功','/index.php/index/index/index');
	}
	
	
	public function setting() {
		return view();
	}
	
}










?>