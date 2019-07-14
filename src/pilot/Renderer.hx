package pilot;

import haxe.DynamicAccess;

using StringTools;

class Renderer {
  
  public static inline function render(vnode:VNode) {
    return switch vnode.type {
      case VNodeElement | VNodeRecycled:
        var out = '<${vnode.name}';
        var attrs = handleAttributes(vnode.props);
        if (attrs.length > 0) {
          out += ' ' + attrs.join(' ');
        }
        if (vnode.children.length == 0) {
          return out + '/>';
        }
        out 
          + [ for (child in vnode.children) render(child) ].join('')
          + '</${vnode.name}>';
      case VNodeFragment:
        [ for (child in vnode.children) render(child) ].join('');
      case VNodeText:
        vnode.name.htmlEscape(true);
      // todo: allow for unescaped HTML.
    }
  }

  static inline function handleAttributes(props:DynamicAccess<Dynamic>) {
    var props = return [ for (k => v in props) switch v {
      case true: '${k} = "${k}"';
      case false: null;
      default: '${k} = "${Std.string(v)}"';
    } ];
    return [for(prop in props) if (prop != null) prop ];
  }

}
