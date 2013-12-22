package ky.enumerate
{
	public class MobileCommandMode
	{
		/**
		 * 获取播放列表
		 */
		public static const GET_PLAY_LIST:String = "0001";
		/**
		 * 改变播放模块(发送附带值：模块编码coding)
		 */
		public static const CHANGE_MODULE:String = "0002";
		/**
		 * 控制是否自动播放(发送附带值：0关闭，1开启)
		 */
		public static const CONTROL_LOOP:String = "0003";
		/**
		 * 发送文本信息（附带值：信息文本）
		 */
		public static const TEXT_MESSAGE:String = "0004";
		/**
		 * 关机
		 */
		public static const SHUTDOWN:String = "0005";
		public function MobileCommandMode()
		{
		}
	}
}