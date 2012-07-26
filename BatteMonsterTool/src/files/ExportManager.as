package files
{
	import auxiliarys.MSignal;
	/**
	 * @author ZengFeng (zengfeng75[AT]163.com) 2012-7-13
	 */
	public class ExportManager
	{
		private static var _instance : ExportManager;

		/** 获取单例对像 */
		public static  function get instance() : ExportManager
		{
			if (_instance == null)
			{
				_instance = new ExportManager();
			}
			return _instance;
		}

		function ExportManager() : void
		{
		}

		private var list : Vector.<ExportFile> = new Vector.<ExportFile>();
		public var sComplete : MSignal = new MSignal();

		public function append(file : ExportFile) : void
		{
			var index : int = list.indexOf(file);
			if (index == -1) list.push(file);
		}

		public function start() : void
		{
			next();
		}

		private function next() : void
		{
			if (list.length > 0)
			{
				var file : ExportFile = list.shift();
				file.sGenerateComplete.add(file.write);
				file.sWriteComplete.add(next);
				file.generate();
			}
			else
			{
				sComplete.dispatch();
			}
		}
	}
}