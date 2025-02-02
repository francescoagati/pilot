package todo.ui;

import pilot.Style;
import pilot.StatelessWidget;
import pilot.VNode;
import pilot.VNode.h;
import todo.data.Store;
import todo.data.VisibleTodos;

class SiteFooter extends StatelessWidget {

  @:prop var store:Store;

  override function build():VNode {
    return h('footer', {
      className: Style.create({
        color: '#777',
        padding: '10px 15px',
        height: '20px',
        'text-align': 'center',
        'border-top': '1px solid #e6e6e6',
        '&:before': {
          content: '""',
          position: 'absolute',
          right: 0,
          bottom: 0,
          left: 0,
          height: '50px',
          overflow: 'hidden',
          'box-shadow': '0 1px 1px rgba(0, 0, 0, 0.2),
                      0 8px 0 -3px #f6f6f6,
                      0 9px 1px -3px rgba(0, 0, 0, 0.2),
                      0 16px 0 -6px #f6f6f6,
                      0 17px 2px -6px rgba(0, 0, 0, 0.2)',
        }
      })
    }, [
      h('span', { 
        className: Style.create({
          float: 'left',
	        'text-align': 'left',
        })
      }, [ remaining() ]),
      h('ul', { 
        className: Style.create({
          margin: 0,
          padding: 0,
          'list-style': 'none',
          position: 'absolute',
          right: 0,
          left: 0,

          li: {
            display: 'inline',
            a: {
              color: 'inherit',
              margin: '3px',
              padding: '3px 7px',
              'text-decoration': 'none',
              border: '1px solid transparent',
              'border-radius': '3px',
              '&:hover': {
                'border-color': 'rgba(175, 47, 47, 0.1)',
              },
              '&.selected': {
                'border-color': 'rgba(175, 47, 47, 0.2)',
              }
            }
          }
        })
      }, [
        h('li', {}, [
          h('a', { 
            href: '#all',
            className: store.filter == VisibleAll ? 'filter selected' : 'filter',
            #if js
              onClick: e -> setFilter(e, VisibleAll)
            #end
          }, [ 'All' ])
        ]),
        h('li', {}, [
          h('a', { 
            href: '#pending',
            className: store.filter == VisiblePending ? 'filter selected' : 'filter',
            #if js
              onClick: e -> setFilter(e, VisiblePending)
            #end
          }, [ 'Pending' ])
        ]),
        h('li', {}, [
          h('a', { 
            href: '#pending',
            className: store.filter == VisibleCompleted ? 'filter selected' : 'filter',
            #if js
              onClick: e -> setFilter(e, VisibleCompleted)
            #end
          }, [ 'Complete' ])
        ])
      ]),
      h('button', {
        className: Style.create({
          float: 'right',
          position: 'relative',
          'line-height': '20px',
          'text-decoration': 'none',
          cursor: 'pointer',
        }),
        onClick: e -> store.clearCompleted(),
      }, [ 'Clear completed' ])
    ]);
  }

  function remaining():VNode {
    return switch store.remainingTodos {
      case 0: 'No items left';
      case 1: '1 item left';
      case remaining: '${remaining} items left';
    }
  }

  #if js

    function setFilter(e:js.html.Event, filter:VisibleTodos) {
      e.preventDefault();
      store.setFilter(filter);
    }

  #end

}
