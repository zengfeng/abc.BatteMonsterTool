package files
{
	import auxiliarys.MSignal;

	/**
	 * @author ZengFeng (zengfeng75[AT]163.com) 2012-7-12
	 */
	public class ImportManger
	{
		private static var _instance : ImportManger;

		/** 获取单例对像 */
		public static  function get instance() : ImportManger
		{
			if (_instance == null)
			{
				_instance = new ImportManger();
			}
			return _instance;
		}

		function ImportManger() : void
		{
		}

		private var list : Vector.<ImportFile> = new Vector.<ImportFile>();
		public var sComplete : MSignal = new MSignal();

		public function append(file : ImportFile) : void
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
				var file : ImportFile = list.shift();
				file.sComplete.add(next);
				file.read();
			}
			else
			{
				sComplete.dispatch();
			}
		}
	}
}
