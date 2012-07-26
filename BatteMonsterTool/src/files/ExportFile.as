package files
{
	import auxiliarys.Logger;
	import auxiliarys.MSignal;
	import flash.events.OutputProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;


	/**
	 * @author ZengFeng (zengfeng75[AT]163.com) 2012-7-12
	 */
	public class ExportFile
	{
		public var data : Array = [];
		public var headLine:Array = [];
		public var src : String;
		public var sGenerateComplete : MSignal = new MSignal();
		public var sWriteComplete : MSignal = new MSignal();
		protected var file : File;
		protected var fileStream : FileStream;
		protected var bytes : ByteArray = new ByteArray();

		function ExportFile(src : String) : void
		{
			this.src = src;
		}

		public function generate() : ExportFile
		{
			Logger.info("[GenerateData]" + "(" + src + ")");
			if (generateData())
			{
				sGenerateComplete.dispatch();
			}
			return this;
		}

		protected function generateData() : Boolean
		{
			return true;
		}

		public function write() : void
		{
			Logger.info("[WriteData]" + "(" + src + ")");
			trace("[WriteData]" + "(" + src + ")");

			if(src.indexOf(":") == -1) src = File. applicationDirectory.nativePath +"/" + src;
			file = new File(src);
			fileStream = new FileStream();
			fileStream.addEventListener(OutputProgressEvent.OUTPUT_PROGRESS, onOutputProgress);
			fileStream.openAsync(file, FileMode.WRITE);
			try
			{
				writeData();
			}
			catch(error : Error)
			{
				trace(error);
				Logger.info("//Error: 导出文件出错 (" + src + ")" + error);
			}
			finally
			{
				fileStream.close();
			}
		}

		protected function writeData() : void
		{
			var str : String = "文件为空";
			var line : Array;
			if (data.length > 0)
			{
				line = data[0];
				var aStr : String = "A";
				var a : Number = aStr.charCodeAt(0);
				for (var i : int = headLine.length; i < line.length; i++)
				{
					headLine.push(String.fromCharCode(a + i));
				}
				str = headLine.join(";") + "\r\n";
			}
			var strArr : Array = [];
			for each (line in  data)
			{
				strArr.push(line.join(";"));
			}
			str += strArr.join("\r\n");
			str += "\r\n";
			bytes.clear();
			bytes.position = 0;
			bytes.writeUTFBytes(str);

			fileStream.writeBytes(bytes, 0, bytes.length);
		}

		protected function onOutputProgress(event : OutputProgressEvent) : void
		{
			trace("write onOutputProgress " + event.bytesPending + " " + src);
			if (event.bytesPending == 0)
			{
				sWriteComplete.dispatch();
			}
		}
	}
}
