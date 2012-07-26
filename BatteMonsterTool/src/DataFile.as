package 
{
	import files.ExportFileBattleMonsters;
	import files.ExportFileMonsterProp;
	import files.ImportFile;
	/**
	 * @author ZengFeng (zengfeng75[AT]163.com) 2012-7-12
	 */
	public class DataFile
	{
		public static var npc:ImportFile;
		public static var monster_set:ImportFile;
		public static var monster_prop:ImportFile;
		
		public static var battleMonsters:ExportFileBattleMonsters;
		public static var monster_prop_client:ExportFileMonsterProp;
	}
}
