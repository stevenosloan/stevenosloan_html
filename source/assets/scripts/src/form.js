// Submit form with Ajax
var fillMessage       = "Please fill out all the fields",
    workingMessage    = "Your message is being sent ...",
    errorMessage      = "There was an error sending your message. Please try again or email me at stevenosloan@gmail.com",
    emailMessage      = "Please use a valid email address",
    successMessage    = "Success! Your message has been sent. I\'ll get back to you as soon as I can",
    messageContainer  = $('#contactMessages');
    
    $('#theContactForm').append('<input name="jsOrNot" value="yes" />').find('input[name="jsOrNot"]').hide();
    
function submitForm() {
  var contactForm = $(this);
  
  // validate fields
  
  if ( !$('#theContactForm #contactName').val() || !$('#theContactForm #contactEmail').val() || !$('#theContactForm #contactMessage').val() ){
  
    // No, display the fill in fields message
    // $('.contactFill').fadeIn("slow").addClass("fillText");
    messageContainer.append('<p class="error">' + fillMessage + '</p>').children('p').fadeIn("slow");
    
  } else {
  
    // Yes, submit form to PHP script
    if( messageContainer.children('p').length ){
      messageContainer.children('p').fadeOut("fast").remove();
    }
    
    messageContainer.append('<p class="working">' + workingMessage + '</p>').children('p').fadeIn("slow");
    
    $.ajax( {
      url   : contactForm.attr( 'action' ) + "?ajax=true",
      type  : contactForm.attr( 'method'),
      data  : contactForm.serialize(),
      success : submitFinished
    });
  
  }
  
  // Prevent the default form submission
  return false;
  
}

// Submit was successful
function submitFinished( response ) {
  
  response = $.trim( response );
  
  if( response == "success" ){
  
    //Form submission successful
    messageContainer
      .children('p').fadeOut("slow").end()
      .append('<p class="success">' + successMessage + '</p>').children('p.success').fadeIn("slow").delay(4000).fadeOut("slow");
    $('#contactName').val( "" );
    $('#contactEmail').val( "" );
    $('#contactMessage').val( "" );
    
    _gaq.push(['_trackPageview','/contact-form']);
  
  } else if( response == "email" ){
  
    //Email Validation Didn't Pass
    messageContainer
      .children('p').fadeOut("slow").delay(1000).remove().end()
      .append('<p class="error">' + emailMessage + '</p>').children('p').fadeIn("slow");
  
  
  } else {
  
    //Form submission failed
    messageContainer
      .children('p').fadeOut("slow").delay(1000).remove().end()
      .append('<p class="error">' + errorMessage + '</p>').children('p').fadeIn("slow");
    
  }
  
}