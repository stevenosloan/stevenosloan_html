<!DOCTYPE HTML>
<html>

<head>

  <meta charset="UTF-8" />
  <meta name="google-site-verification" content="7KgHTNkMMzdgvgz_Jbb_uNkC18FuunUTvC7MxXWRVRo" />
  
  <title>Steven Sloan | Designer & Developer in Atlanta</title>
  
  <link rel="stylesheet" href="css/css<?php echo '.' . filemtime('css/css.css'); ?>.css" />
  <link rel="icon" href="images/favicon<?php echo '.' . filemtime('images/favicon.png'); ?>.png" type="image/png" />
  
  <script type="text/javascript" src="scripts/modernizr-build<?php echo '.' . filemtime('scripts/modernizr-build.js'); ?>.js"></script>
  <script type="text/javascript">
    
    // be sure to add a customized modernizr build
    Modernizr.load([
      {
        // jquery & init
        load: ['http://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js' , 'scripts/init<?php echo '.' . filemtime('scripts/init.js'); ?>.js'],
        complete: function () {
          console.log('jquery & init loaded');
          jqueryInit();
        }
      },
      {
        // cycle
        load: 'scripts/jquery.cycle.all.js',
        complete: function() {
          console.log('cycle loaded');
          cycleInit();
        }
      }
    ]);
    
  </script>
  
  <script type="text/javascript">

    Modernizr.load([ ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js'
    ]);

    var _gaq = _gaq || [];
    _gaq.push(['_setAccount', 'UA-9014377-1']);
    _gaq.push(['_trackPageview']);
    _gaq.push(['_trackPageLoadTime']);
  
  </script>
  
</head>

<body>

  <article id="siteWrapper">
    
    <header id="siteHeader">
      
      <nav id="siteNav">
        
        <a id="homeLink" href="/" alt="home">Steven Sloan</a>
        <a id="workLink" href="#work" alt="work">Work</a>
        <a id="contactLink" href="#contact" alt="contact">Contact</a>
        
      </nav>
      
      <h1>I design and make things in the shop &amp; on the web.</h1>
      
    </header>
    
    <p>I’m a tinkerer at heart and love getting in the mix of it and making it work, and well. Whether it’s pushing material through the saw, pushing pixels, or pushing code updates I always seek to solve problems in the cleanest, most efficient way possible.</p>
    
    <section id="currently">
      <h1>Currently</h1>
      <p>I work as a designer &amp; developer with <a href="http://vaguelyscandinavian.com" alt="atlanta based web design and development">Vaguely Scandinavian</a></p>
      <h1>Previously</h1>
      <p>I worked as a UI and UX designer at <a href="http://digitalscientists" rel="external">Digital Scientists</a> after working as a designer &amp; developer at <a href="http://peopleofresource.com" rel="external">People of Resource</a></p>
    </section>
    
    <section id="work">
      
      <ul>
        <li class="first">
          <figure>
            <img src="images/projects/credenza-003.jpg" alt="image alt" width="768" height="506" alt="Credenza 003 - mid-century inspired modern media console" />
            <figcaption>
              <h2>Credenza 003 <em>/ mid-century modern media console</em></h2>
            </figcaption>
          </figure>
        </li>
        <li>
          <figure>
            <img src="images/projects/road_ninja-iphone-app.jpg" width="768" height="506" alt="interaction design for the iphone app road ninja" />
            <figcaption>
              <h2>Road Ninja <em>/ location &amp; deals app</em></h2>
              <p>completed at <a href="http://digitalscientists.com" rel="external">Digital Scientists</a> as lead interaction designer</p>
            </figcaption>
          </figure>
        </li>
        <li>
          <figure>
            <img src="images/projects/flickering_productions-branding-design.png" width="768" height="506" alt="branding and web design for flickering productions" />
            <figcaption>
              <h2>Flickering Productions <em>/ independent production studio</em></h2>
              <p>completed at <a href="http://vaguelyscandinavian.com" title="atlanta based branding & design agency">Vaguely Scandinavian</a> as brand &amp; web designer</p>
            </figcaption>
          </figure>
        </li>
        <li>
          <figure>
            <img src="images/projects/table_001-glueless-flatpack_furniture-design.jpg" width="768" height="506" alt="table 001 - a glueless flatpack furniture design"/>
            <figcaption>
              <h2>Table 001 <em>/ glueless flatpack furniture</em></h2>
            </figcaption>
          </figure>
        </li>
        <li>
          <figure>
            <img src="images/projects/southern_design_concern-web_design-web_development.jpg" width="768" height="506" alt="southern design concern - a southern american design collective" />
            <figcaption>
              <h2>Southern Design Concern <em>/ design collective</em></h2>
              <p>completed at <a href="http://vaguelyscandinavian.com" title="atlanta based web design & development agency">Vaguely Scandinavian</a> as lead web designer &amp; developer</p>
            </figcaption>
          </figure>
        </li>
      </ul>
      
    </section>
    
    <section id="contact">
      <h1>I'd love it if you <br/>got in touch</h1>
      
      <form id="theContactForm" action="contactForm.php" method="post">
				
				<label for="contactName">Name</label>
				<input class="text" type="text" name="contactName" id="contactName" />
				
				<label for="contactEmail">Email</label>
				<input class="text" type="email" name="contactEmail" id="contactEmail" autocomplete="off" autocapitalize="off"/>
				
				<label for="contactMessage">Message</label>
				<textarea name="contactMessage" id="contactMessage"></textarea>
				
				<label for="humanOrNot" class="humanOrNot">What is four plus four?</label>
				<input class="humanOrNot" type="text" name="humanOrNot" id="humanOrNot" placeholder="just a little math" autocomplete="off"/>
				
				<input class="submit" type="submit" id="contactSend" name="contactSend" value="Send" />
			
			</form>
			
			<div id="contactMessages">
			</div>
			
		</section>
		
		<footer id="siteFooter">
      <a href="http://twitter.com/#!/stevenosloan" rel="external">twitter</a>&nbsp;&nbsp;|&nbsp;&nbsp;
      <a href="http://www.linkedin.com/in/stevenosloan" rel="external">linkedin</a>&nbsp;&nbsp;|&nbsp;&nbsp; 
      <a href="http://southerndesignconcern.com">southern design concern</a>
      <p class="colophon">&copy;2007-<?php echo date ( "Y" ); ?> Steven Sloan.  All rights reserved.</p>
  </article>

</body>
</html>