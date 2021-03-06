package aerys.minko.scene.node.mesh.modifier
{
	import aerys.minko.scene.node.mesh.IMesh;
	import aerys.minko.type.stream.VertexStream;
	import aerys.minko.type.stream.format.VertexComponent;
	import aerys.minko.type.stream.format.VertexFormat;

	public class ColorMeshModifier extends AbstractMeshModifier
	{
		private static const RGB_FORMAT		: VertexFormat	= new VertexFormat(VertexComponent.RGB);
		private static const RGBA_FORMAT	: VertexFormat	= new VertexFormat(VertexComponent.RGBA);

		protected var _colors	: Vector.<uint>	= null;

		public function get colors () : Vector.<uint>
		{
			return _colors;
		}
		
		public function ColorMeshModifier(target 	: IMesh,
										  colors 	: Vector.<uint>,
										  withAlpha	: Boolean	= false)
		{
			_colors = colors.concat();

			super(target, getColorStream(target, withAlpha));
		}
		
		private function getColorStream(target : IMesh, withAlpha : Boolean) : VertexStream
		{
			var numVertices	: int				= target.vertexStream.length;
			var size		: int				= withAlpha ? 4 : 3;
			var colors 		: Vector.<Number> 	= new Vector.<Number>(numVertices * size, true);
			var ii			: int				= 0;

			for (var i : int = 0; i < numVertices; ++i)
			{
				var color : uint = _colors[int(i % _colors.length)];

				ii = i * size;

				colors[ii] = ((color >> 16) & 0xff) / 255.;
				colors[int(ii + 1)] = ((color >> 8) & 0xff) / 255.;
				colors[int(ii + 2)] = (color & 0xff) / 255.;
				if (withAlpha)
					colors[int(ii + 3)] = (color >>> 24) / 255.;
			}

			return new VertexStream(colors, withAlpha ? RGBA_FORMAT : RGB_FORMAT);
		}
	}
}