package aerys.minko.render.shader.compiler.allocator
{
	import aerys.minko.render.shader.compiler.register.RegisterLimit;
	import aerys.minko.render.shader.node.INode;

	public class VaryingAllocator extends Allocator
	{
		public function VaryingAllocator()
		{
			super(RegisterLimit.MAX_VARYING);
		}

		override public function getWriteMask(op : INode) : uint
		{
			return 0xf;
		}

		override public function allocate(op			: INode,
										  operationId	: uint = 0) : void
		{
			return super.allocate(op, 0);
		}

		override public function computeRegisterState(alignEverything : Boolean = false):void
		{
			return super.computeRegisterState(true);
		}
	}
}
