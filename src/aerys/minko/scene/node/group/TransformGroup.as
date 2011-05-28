﻿package aerys.minko.scene.node.group 
{
	import aerys.minko.scene.action.IAction;
	import aerys.minko.scene.action.IActionTarget;
	import aerys.minko.scene.action.TransformAction;
	import aerys.minko.scene.node.ITransformable;
	import aerys.minko.type.math.Transform3D;
	
	/**
	 * TransformGroup apply a 3D transform to their children.
	 * 
	 * @author Jean-Marc Le Roux
	 */
	public class TransformGroup extends Group implements IActionTarget, ITransformable
	{
		private var _transform	: Transform3D		= new Transform3D();
		
		public function TransformGroup(...children) 
		{
			super(children);
			
			actions.unshift(TransformAction.transformAction);
		}
		
		/**
		 * The Transform3D object defining the transform of the object into world-space.
		 */
		public function get transform() : Transform3D
		{
			return _transform;
		}

	}

}