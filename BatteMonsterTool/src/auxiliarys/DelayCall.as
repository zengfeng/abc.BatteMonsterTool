package auxiliarys
{
	import flash.utils.setTimeout;

	/**
	 * @author ZengFeng (zengfeng75[AT]163.com) 2012-7-13
	 */
	public class DelayCall
	{
		private var time : Number = 20;
		private var fun : Function;
		private var args : Array;

		function DelayCall(fun : Function, time : Number = 20, args : Array = null) : void
		{
			this.time = time;
			this.fun = fun;
			this.args = args;
		}

		public function call() : void
		{
			setTimeout(run, time);
		}

		private function run() : void
		{
			if (fun != null) fun.apply(null, args);
		}
	}
}
