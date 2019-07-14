package pilot;

#if js
  using pilot.Differ;
#end

@:autoBuild(pilot.macro.WidgetBuilder.build({ stateful: true }))
class StatefulWidget implements Widget {

   function build():VNode {
    return null;
  }

  #if js
    
    var _pilot_vnode:VNode;

     inline public function render():VNode {
      _pilot_vnode = build();
      _pilot_vnode.hooks.attach = attached;
      _pilot_vnode.hooks.detach = _pilot_detached;
      return _pilot_vnode;
    }

     public inline function patch() {
      if (_pilot_vnode == null) return;
      if (_pilot_vnode.node == null) return;
      _pilot_vnode.node.patch(render());
    }

     final inline function _pilot_detached() {
      _pilot_vnode = null;
      detached();
    } 

    public inline function attached(vnode:VNode) {
      // noop
    }

    public inline function detached() {
      // noop
    }

  #else

    public inline function render():VNode {
      return build();
    }

    public inline function patch() {
      // noop for now?
    }

  #end

}
