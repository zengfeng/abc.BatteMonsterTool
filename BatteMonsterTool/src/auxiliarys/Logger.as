package auxiliarys
{
	import flash.text.TextFormat;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.display.Sprite;

	/**
	 * @author ZengFeng (zengfeng75[AT]163.com) 2012-7-12
	 */
	public class Logger extends Sprite
	{
		/** 单例对像 */
		private static var _instance : Logger;

		/** 获取单例对像 */
		public static  function get instance() : Logger
		{
			if (_instance == null)
			{
				_instance = new Logger();
			}
			return _instance;
		}

		private var tf : TextField;
		private var _width : int = 0;
		private var _height : int = 0;

		function Logger(width : int = 0, height : int = 0) : void
		{
			_width = width;
			_height = height;
			var textFormat : TextFormat = new TextFormat();
			textFormat.size = 14;
			tf = new TextField();
			tf.defaultTextFormat = textFormat;
			addChild(tf);
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}

		private function onAddToStage(event : Event) : void
		{
			if (_width == 0 && _height == 0)
			{
				tf.width = stage.stageWidth;
				tf.height = stage.stageHeight;
			}
			else
			{
				tf.width = _width;
				tf.height = _height;
			}
		}

		public function info(str : String) : void
		{
			tf.appendText(str);
			tf.scrollV = tf.maxScrollV;
		}

		public static function info(str : String) : void
		{
			instance.info(str + "\n");
		}
	}
}
