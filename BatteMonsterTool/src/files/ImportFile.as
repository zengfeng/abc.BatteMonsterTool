package files
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
	public class ImportFile
	{
		public var src:String;
		public var sComplete:MSignal = new MSignal();
		public var data:Array = [];
		function ImportFile(src:String):void
		{
			this.src = src;
		}
		
		private var fileStream:FileStream;
		private var bytes:ByteArray;
		public function read():void
		{
			if(src.indexOf(":") == -1) src = File. applicationDirectory.nativePath +"/" + src;
			var file : File = new File(src);
			if (file.exists == false)
			{
				Logger.info("//Error:导入文件不存在!" + "(" + file.url + ")");
				return;
			}
			trace("[ImportFile]" + "(" + file.url + ")");
			Logger.info("[ImportFile]" + "(" + file.url + ")");
			bytes = new ByteArray();
			fileStream = new FileStream();
			fileStream.addEventListener(ProgressEvent.PROGRESS, onProgress);
			fileStream.addEventListener(Event.COMPLETE, onComplete);
			fileStream.openAsync(file, FileMode.READ);
		}

		private function onProgress(event : ProgressEvent) : void
		{
			fileStream.readBytes(bytes, fileStream.position, fileStream.bytesAvailable);
		}
		
		private function onComplete(event : Event) : void
		{
			bytes.position = 0;
			var str:String = bytes.readUTFBytes(bytes.length);
			str = str.replace(/\"/g, "");
			var lines:Array = str.split("\r\n");
			var lineCount:int = lines.length;
			var lineStr:String;
			var line:Array;
			for(var i:int = 1; i < lineCount - 1; i++)
			{
				lineStr = lines[i];
				line = lineStr.split(";");
				data.push(line);
			}
			fileStream.close();
			sComplete.dispatch();
		}
	}
}
