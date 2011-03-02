package aerys.minko.scene
{
	import aerys.minko.effect.Effect3DStyle;
	import aerys.minko.effect.IEffect3D;
	import aerys.minko.effect.IEffect3DStyle;
	import aerys.minko.effect.IStyled3D;
	import aerys.minko.effect.basic.BasicEffect3D;
	import aerys.minko.effect.basic.BasicStyle3D;
	import aerys.minko.ns.minko;
	import aerys.minko.query.RenderingQuery;
	import aerys.minko.scene.material.IMaterial3D;
	import aerys.minko.scene.mesh.IMesh3D;
	import aerys.minko.transform.Transform3D;
	import aerys.minko.transform.TransformManager;
	import aerys.minko.transform.TransformType;
	import aerys.minko.type.math.Matrix4x4;

	public class Model3D extends AbstractScene3D implements IScene3D, IObject3D, IStyled3D
	{
		use namespace minko;
		
		private var _emptyStyle	: IEffect3DStyle		= new Effect3DStyle();
		
		private var _mesh		: IMesh3D				= null;
		private var _material	: IMaterial3D			= null;
		private var _transform	: Transform3D			= new Transform3D();
		private var _visible	: Boolean				= true;
		private var _effects	: Vector.<IEffect3D>	= Vector.<IEffect3D>([new BasicEffect3D()]);
		private var _style		: IEffect3DStyle		= new Effect3DStyle();
		private var _toScreen	: Matrix4x4				= new Matrix4x4();
		
		public function get transform() 	: Transform3D			{ return _transform; }
		public function get mesh()			: IMesh3D				{ return _mesh; }
		public function get material()		: IMaterial3D			{ return _material; }
		public function get visible()		: Boolean				{ return _visible; }
		public function get effects()		: Vector.<IEffect3D>	{ return _effects; }
		public function get style()			: IEffect3DStyle		{ return _style; }
		
		public function set mesh(value : IMesh3D) : void
		{
			_mesh = value;
		}
		
		public function set material(value : IMaterial3D) : void
		{
			_material = value;
		}
		
		public function set visible(value : Boolean) : void
		{
			_visible = value;
		}
		
		public function Model3D(mesh 	 : IMesh3D		= null,
								material : IMaterial3D	= null)
		{
			super();
			
			_mesh = mesh;
			_material = material;
		}
		
		override protected function acceptRenderingQuery(query:RenderingQuery):void 
		{
			var transform 	: TransformManager 	= query.transform;
			
			transform.push(TransformType.WORLD);
			transform.world.multiply(_transform);
			transform.getLocalToScreen(_toScreen);
			
			_style.set(BasicStyle3D.WORLD_MATRIX, transform.world)
				  .set(BasicStyle3D.VIEW_MATRIX, transform.view)
				  .set(BasicStyle3D.PROJECTION_MATRIX, transform.projection)
				  .set(BasicStyle3D.LOCAL_TO_SCREEN_MATRIX, _toScreen);
			
			query.effects.pushEffects(_effects);
			
			var newStyle:IEffect3DStyle;
			newStyle = _style.override(query.style);
			newStyle = _emptyStyle.override(newStyle);
			query.style = newStyle;
			
			_material && query.query(_material);
			_mesh && query.query(_mesh);
			
			query.style = query.style.override().override();
			_emptyStyle.clear();
			
			query.effects.pop(_effects.length);
			
			transform.pop();
		}
	}
}