package files
{
	import flash.utils.Dictionary;


	/**
	 * @author ZengFeng (zengfeng75[AT]163.com) 2012-7-13
	 */
	public class ExportFileBattleMonsters extends ExportFile
	{
		public function ExportFileBattleMonsters(src : String)
		{
			super(src);
			headLine = ["Npc", "Monsters"];
		}

		override protected function generateData() : Boolean
		{
			generateNpcData();
			generateMonsterData();
			for each (var npcId:int in npcList)
			{
				var monsters : Array = monsterDic[npcId];
				if (monsters && monsters.length > 0)
				{
					var line:Array = [npcId, monsters.join(",")];
					data.push(line);
				}
			}
			return true;
		}

		private var monsterDic : Dictionary;

		private function generateMonsterData() : void
		{
			monsterDic = new Dictionary();
			var monsterData : Array = DataFile.monster_set.data;
			var line : Array;
			for each (line in monsterData)
			{
				var npcId : int = parseInt(line[0]);
				var monsters : Array = [];
				monsterDic[npcId] = monsters;
				var strA : String = line[1];
				var arrA : Array = strA.split("|");
				for each (var strB:String in  arrA)
				{
					var arrB : Array = strB.split(":");
					var monsterId : int = parseInt(arrB[0]);
					monsters.push(monsterId);
				}
			}
		}

		private var npcList : Array;

		private function generateNpcData() : void
		{
			npcList = [];
			var npcData : Array = DataFile.npc.data;
			var line : Array;
			for each (line in npcData)
			{
				var mapId : int = parseInt(line[4]);
				if (mapId >= 100)
				{
					var npcId : int = parseInt(line[0]);
					if (npcId > 0)
					{
						npcList.push(npcId);
					}
				}
			}
		}
	}
}
