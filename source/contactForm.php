<?php

$toName   = 'Steven Sloan';
$toEmail  =   'stevenosloan@gmail.com';
$toSubject  =   'Inquiry from Contact Form - Steven Sloan';

// Check & Sanitize Fields
$success    =   false;
$contactName  =   isset( $_POST['contactName'] ) ? preg_replace( "/[^\.\-\' a-zA-Z0-9]/", "", $_POST['contactName'] ) : "";
$contactEmail =   isset( $_POST['contactEmail'] ) ? preg_replace( "/[^\.\-\_\@a-zA-Z0-9]/", "", $_POST['contactEmail'] ) : "";
$contactMessage =   isset( $_POST['contactMessage'] ) ? preg_replace( "/(From:|To:|BCC:|CC:|Subject:|Content-Type:)/", "", $_POST['contactMessage'] ) : "";
$jsOrNot = $_POST['jsOrNot'];
$botPrevention = $_POST['humanOrNot'];


if( isset( $jsOrNot ) ){
  $contactMessage = $contactMessage . "
  
  //// js was on";
  }

// If all clear, send message
if ( $contactName && $contactEmail && $contactMessage && $humanOrNot == "8"){
  if ( check_email_address($contactEmail) ){
    $recipient  = $toName . " <" . $toEmail . ">";
    $headers  = "From: " . $contactName . " <" . $contactEmail . ">";
    $success  = mail( $recipient, $toSubject, $contactMessage, $headers );
  } else {
    $success  = "email";
  }
}

// Return success for ajax calls
if ( isset($_GET["ajax"]) ){
  if( $success === "email" ){
    echo "email";
  } elseif( $success ){
    echo "success";
  } else {
    echo "error";
  }
  //echo $success ? "success" : "error";
} else {
  ?>
    <html><head><title><?php if( $sucess){ echo "Success!"; } else { echo "Failure..."; } ?></title></head><body>
    <?php 
      if ( $success ) echo "<h1>Success!</h1><p>I'll get in touch with you as soon as I can.<br /><br />Also, sorry you had to see this, it looks like you have javascript turned off.</p>";
      if ( !$success ) echo "<h1>Failure!</h1><p>Doh, either I messed up or the information you gave us is invalid. Try again or just email me directly at stevenosloan@gmail.com</p>";
    ?>
    </body></html>
  <?php   
}




function check_email_address($email) {
  // First, we check that there's one @ symbol, 
  // and that the lengths are right.
  if (!ereg("^[^@]{1,64}@[^@]{1,255}$", $email)) {
    // Email invalid because wrong number of characters 
    // in one section or wrong number of @ symbols.
    return false;
  }
  // Split it into sections to make life easier
  $email_array = explode("@", $email);
  $local_array = explode(".", $email_array[0]);
  for ($i = 0; $i < sizeof($local_array); $i++) {
    if
(!ereg("^(([A-Za-z0-9!#$%&'*+/=?^_`{|}~-][A-Za-z0-9!#$%&
↪'*+/=?^_`{|}~\.-]{0,63})|(\"[^(\\|\")]{0,62}\"))$",
$local_array[$i])) {
      return false;
    }
  }
  // Check if domain is IP. If not, 
  // it should be valid domain name
  if (!ereg("^\[?[0-9\.]+\]?$", $email_array[1])) {
    $domain_array = explode(".", $email_array[1]);
    if (sizeof($domain_array) < 2) {
        return false; // Not enough parts to domain
    }
    for ($i = 0; $i < sizeof($domain_array); $i++) {
      if
(!ereg("^(([A-Za-z0-9][A-Za-z0-9-]{0,61}[A-Za-z0-9])|
↪([A-Za-z0-9]+))$",
$domain_array[$i])) {
        return false;
      }
    }
  }
  return true;
}



?>