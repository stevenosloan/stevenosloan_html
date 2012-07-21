//= require 'src/jquery-1.7.2.min'
//= require 'src/form'

LoadedFunctions.site = true;

$(document).ready( function(){
  
  // hide honeypot
  $('.humanOrNot').hide();
  $('input.humanOrNot').attr("value", 8);

  
  // Add function submitForm as handler
  $('#theContactForm').submit( submitForm );
  

  // When Contact is clicked - move focus to first field of form
  $('a[href="#contact"]').click( function() {
    $('#contactName').trigger('focus');
  });

});


