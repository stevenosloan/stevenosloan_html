//= require 'src/jquery.cycle.all'

$(document).ready( function(){
  cycleInit();
});

function cycleInit(){
  
  if( $('#work li').length > 1 ){
    
    var container = $('#work ul');
    
    container.parent().append('<div id="prev" />', '<div id="next"/>');
    
    container.cycle({
      fx: 'scrollHorz',
      sync: 'true',
      next: '#next',
      prev: '#prev',
      timeout: 0
    });
    
  }

}