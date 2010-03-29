PageStatusBehavior = Behavior.create({
  initialize: function(options){
    this.update();
  },
  
  update: function() {
    if(this.element.value >= 90) { 
      $('published_at').show();
    } else { 
      $('published_at').hide();
    }
  }
});