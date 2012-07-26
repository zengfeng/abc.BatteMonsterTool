package files
{

	/**
	 * @author ZengFeng (zengfeng75[AT]163.com) 2012-7-13
	 */
	public class ExportFileMonsterProp extends ExportFile
	{
		public function ExportFileMonsterProp(src : String)
		{
			super(src);
			headLine = ["NpcId", "SkillId"];
		}
		
		override protected function generateData() : Boolean
		{
			var sourceData:Array = DataFile.monster_prop.data;
			var sourceLine:Array;
			var line:Array;
			for each(sourceLine in  sourceData)
			{
				line = [];
				line.push(sourceLine[0]);
				line.push(sourceLine[4]);
				data.push(line);
			}
			return true;
		}
	}
}
