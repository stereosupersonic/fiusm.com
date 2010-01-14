(function($) {
$.fn.canvasDesigner = function(options) {
  
  // default options
  if (options) $.extend({
    // empty for now
  }, options)
  
  this.each(function() { // main
    
    // var columnController = new Ext.ColumnController({
    //   
    // })

    Designer = {
      
      // this.columns = new Array;
      
      addColumn : function() {
        
      }
      
    }

    var toolbar = new Ext.Toolbar({
      items: [
        {
          'handler': Designer.addColumn,
          'text': 'Add Column'
        }
      ]
    })

    
    var window = new Ext.Window({
      title  : 'Canvas Designer',
      width  : 600,
      height : 400,
      items  : [toolbar]
    });
    
    window.show();
    
    
    
    // $(this).html('Test');
    
    
  });

  return this; // continue chaining

};  
})(jQuery);

$(document).ready(function() {
  $("#canvas_designer").canvasDesigner();
})