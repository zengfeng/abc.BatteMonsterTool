package 
{
	import auxiliarys.Logger;
	import auxiliarys.MSignal;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;

	/**
	 * @author ZengFeng (zengfeng75[AT]163.com) 2012-7-12
	 */
	public class ConfigFile
	{
		private static var _instance : ConfigFile;

		/** 获取单例对像 */
		public static  function get instance() : ConfigFile
		{
			if (_instance == null)
			{
				_instance = new ConfigFile();
			}
			return _instance;
		}
		
		// ==========
		// 导入文件
		// ==========
		public static var npc : String;
		public static var monster_set : String;
		public static var monster_prop : String;
		// ==========
		// 导出文件
		// ==========
		public static var battleMonsters : String;
		public static var monster_prop_client : String;
		public static var autoExit : Boolean = false;

		function ConfigFile() : void
		{
			npc = "../out/npc.csv";
			monster_set = "../out/monster_set.csv";
			monster_prop = "../out/monster_prop.csv";

			battleMonsters = "../out/battleMonsters.csv";
			monster_prop_client = "../out/monster_prop_client.csv";
		}

		private var fileStream : FileStream;
		private var bytes : ByteArray;

		private function read() : void
		{
			var path : String = "config/configFiles.xml";
			var file : File = File. applicationDirectory;
			file = file.resolvePath(path);
			if (file.exists == false)
			{
				Logger.info("//Error:配置文件不存在!" + "(" + file.url + ")");
				return;
			}
			bytes = new ByteArray();
			fileStream = new FileStream();
			fileStream.addEventListener(Event.COMPLETE, onComplete);
			fileStream.addEventListener(ProgressEvent.PROGRESS, onProgress);
			fileStream.openAsync(file, FileMode.READ);
		}

		private function onProgress(event : ProgressEvent) : void
		{
			fileStream.readBytes(bytes, fileStream.position, fileStream.bytesAvailable);
		}

		private function onComplete(event : Event) : void
		{
			bytes.position = 0;
			var str : String = bytes.readUTFBytes(bytes.length);
			var xml : XML = new XML(str);
			var settingXML : XML = xml["setting"][0];
			autoExit = settingXML.@autoExit == "true";
			Logger.info("autoExit" + " = " + autoExit);

			var item : XML;
			var fileName : String;
			var fileSrc : String;
			var xmlList : XMLList = xml["imports"]["file"];
			for each (item in xmlList)
			{
				fileName = item.@name;
				fileSrc = item.@src;
				Logger.info("[File] "+fileName + " = " + fileSrc);
				switch(fileName)
				{
					case "npc":
						npc = fileSrc;
						break;
					case "monster_set":
						monster_set = fileSrc;
						break;
					case "monster_prop":
						monster_prop = fileSrc;
						break;
				}
			}

			xmlList = xml["exports"]["file"];
			for each (item in xmlList)
			{
				fileName = item.@name;
				fileSrc = item.@src;
				Logger.info("[File] "+fileName + " = " + fileSrc);
				switch(fileName)
				{
					case "battleMonsters":
						battleMonsters = fileSrc;
						break;
					case "monster_prop_client":
						monster_prop_client = fileSrc;
						break;
				}
			}

			sReadComplete.dispatch();
		}

		public static var sReadComplete : MSignal = new MSignal();

		public static function read() : void
		{
			instance.read();
		}
	}
}
