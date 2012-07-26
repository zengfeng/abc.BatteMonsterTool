package 
{
	import auxiliarys.DelayCall;
	import auxiliarys.Logger;
	import files.ExportFileBattleMonsters;
	import files.ExportFileMonsterProp;
	import files.ExportManager;
	import files.ImportFile;
	import files.ImportManger;
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.utils.setTimeout;


	public class BatteMonsterTool extends Sprite
	{
		public function BatteMonsterTool()
		{
			Logger.info("//初始化...");
			addChild(Logger.instance);
			setTimeout(readConfigFile, 500);
		}

		private function readConfigFile() : void
		{
			Logger.info("//读取配置...");
			ConfigFile.sReadComplete.add(new DelayCall(importFiles, 100).call);
			ConfigFile.read();
		}

		private function importFiles() : void
		{
			Logger.info("//导入文件...");
			var manager : ImportManger = ImportManger.instance;
			DataFile.npc = new ImportFile(ConfigFile.npc);
			DataFile.monster_set = new ImportFile(ConfigFile.monster_set);
			DataFile.monster_prop = new ImportFile(ConfigFile.monster_prop);
			manager.append(DataFile.npc);
			manager.append(DataFile.monster_set);
			manager.append(DataFile.monster_prop);
			manager.sComplete.add(new DelayCall(exportFiles, 100).call);
			manager.start();
		}

		private function exportFiles() : void
		{
			Logger.info("//生成导出文件...");
			var manager : ExportManager = ExportManager.instance;
			DataFile.battleMonsters = new ExportFileBattleMonsters(ConfigFile.battleMonsters);
			DataFile.monster_prop_client = new ExportFileMonsterProp(ConfigFile.monster_prop_client);
			manager.append(DataFile.battleMonsters);
			manager.append(DataFile.monster_prop_client);
			manager.sComplete.add(new DelayCall(complete, 100).call);
			manager.start();
		}

		private function complete() : void
		{
			Logger.info("//完成!!!!!!!!!!.");
			if (ConfigFile.autoExit)
			{
				new DelayCall(exit, 500).call();
			}
		}

		public function exit() : void
		{
			Logger.info("//退出!!!!!!!!!!.");
			NativeApplication.nativeApplication.exit();
		}
	}
}
