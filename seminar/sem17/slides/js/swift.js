if (!Array.prototype.first){
  Array.prototype.first = function(){
    return this[0];
  };
};
if (!Array.prototype.last){
  Array.prototype.last = function(){
    return this[this.length - 1];
  };
};

Reveal.initialize({
  // More info https://github.com/hakimel/reveal.js#configuration
  history: true,
  slideNumber: 'c/t',
  transition: 'slide',
  // More info https://github.com/hakimel/reveal.js#dependencies
  dependencies: [
    { src: '../plugin/markdown/marked.js' },
    { src: '../plugin/markdown/markdown.js' },
    { src: '../plugin/notes/notes.js', async: true },
    { src: '../plugin/chart/reveal-chart.js' },
    { src: '../plugin/chart/chart.min.js', callback: function() {
        RevealChart();
      }
    },
    { src: '../plugin/highlight/highlight.pack.js', async: true, callback: function() {
      hljs.configure({ tabReplace: '    ', languages: ['swift', 'objectivec']});
        // pre code
        [].forEach.call(document.querySelectorAll('pre code'), function($code) {
            // Trim leading white spaces
            if( ! $code.hasAttribute( 'data-notrim' ) ) {
              var lines = $code.textContent.split('\n');
              // remove empty lines
              if (lines.first().length == 0)
                lines.splice(0, 1);
              if (lines.last().length == 0)
                lines.splice(lines.length-1, 1);
              // reident based on the first line
              var identation = /^\s+/.exec(lines.first());
              if (!!identation) {
                lines = lines.map(function(line) {
                  return line.replace(identation.first(), '');
                });
                $code.textContent = lines.join('\n').trim();
              }
            }

            // Now escape html unless prevented by author
            if( ! $code.hasAttribute( 'data-noescape' )) {
              $code.innerHTML = $code.innerHTML.replace(/</g,"&lt;").replace(/>/g,"&gt;");
            }

            // re-highlight when focus is lost (for edited code)
            $code.addEventListener( 'focusout', function( event ) {
              hljs.highlightBlock( event.currentTarget );
            }, false );
          });

          window.addEventListener('load', function() {
            [].forEach.call(document.querySelectorAll('pre code'), function($code) {
              hljs.highlightBlock($code);
              // Add header with language name and source file name
              if( ! $code.hasAttribute( 'data-noheader' )) {
                var $source = document.createElement('p');
                var $langNames = {'swift':'Swift', 'objectivec':'Objective-C'}
                for ($langClass in $langNames) {
                  if ( $code.className.indexOf($langClass) > -1) {
                    $source.className = $langClass;
                    $source.innerHTML = $langNames[$langClass];
                  }
                }
                if( $code.hasAttribute( 'src' ) ) {
                  var $fileName=$code.getAttribute( 'src' );
                  if( $fileName.indexOf('/') >-1 ){
                    var $filePath = $fileName.split('/');
                    $source.innerHTML = $filePath[0]+ ' - ' + $filePath[1];
                  } else
                    $source.innerHTML = $source.innerHTML + ' - ' + $fileName;
                }
                if ( !!$source.innerHTML)
                  $code.parentNode.insertBefore($source, $code);
              }
            });
          });
          //hljs.initHighlightingOnLoad();
      }
    }
  ],
  chart: {
      defaults: {
          global: {
            title: { fontSize: 20,  fontStyle: "italic", fontColor: "#ccc", position: "bottom"},
            legend: {
                labels: { fontSize: 20, fontStyle: "italic", fontColor: "#ccc" },
            },
          },
            scale: {
                scaleLabel: { fontColor: "#ccc" },
                gridLines: { color: "#666", zeroLineColor: "#ccc" },
                ticks: { fontColor: "#ccc" },
            }
        },
        line: { borderColor: [ "#FF8D3C" , "#E43944" , "#CA5CA9", "#13DAEC", "#41B645" ], "borderDash": [ [5,10], [0,0] ]},
        bar: { backgroundColor: [ "#FF8D3C" , "#E43944" , "#CA5CA9", "#13DAEC", "#41B645" ] },
        horizontalBar: { backgroundColor: [ "#FF8D3C" , "#E43944" , "#CA5CA9", "#13DAEC", "#41B645" ]},
        pie: { backgroundColor: [ [ "#FF8D3C" , "#E43944" , "#CA5CA9", "#13DAEC", "#41B645" ] ]},
        radar: { borderColor: [ "#FF8D3C" , "#E43944" , "#CA5CA9", "#13DAEC", "#41B645" ]},
    },
});
// breadcrumbs string construction
function getBreadcrumbsFor(slide) {
  var breadcrumbs = '';
  if(slide.parentNode.className.indexOf('stack') > -1)
    breadcrumbs = slide.parentNode.querySelector('h1').innerHTML;
  if( slide.querySelector('h1,h2,h3') != null)
    breadcrumbs =
      (breadcrumbs == '' ? '' : breadcrumbs + ' &#8594; ') +
      slide.querySelector('h1,h2,h3').innerHTML;
  if (breadcrumbs == '')
    breadcrumbs = document.title.split(' ', 2).last();
    return breadcrumbs;
}
// if slide dont need breadcrumbs
function hideBreadcrumbsOn(slide) {
  return Reveal.isOverview() || Reveal.isFirstSlide() ||
      // hide breadcrumbs on first slide of stack
      slide.parentNode.className.indexOf("stack") > -1 &&
      slide.parentNode.querySelector('section') == slide ||
      // hide breadcrumbs on clear style slides
      slide.className.indexOf("gluten-free") > -1;
}
// change or hide breadcrumbs on slide change
Reveal.addEventListener('slidechanged', function(event) {
  var slide = event.currentSlide;
  var topBar = document.querySelector(".reveal .topbar");
  /*var $fragment = slide.querySelector('.fragment');
  if($fragment && $fragment.first.className.indexOf('visible') == -1)
  {
    $fragment.first.className +='visible current-fragment';
  }*/
  if (hideBreadcrumbsOn(slide)) {
    topBar.style.display = "none";
  } else {
    document.querySelector(".reveal .topbar .breadcrumbs").innerHTML = getBreadcrumbsFor(slide);
    topBar.style.display = 'block';
  }
  // move slide number to breadcrumbs
  var slideNumber = document.querySelector('.slide-number');
  topBar.appendChild(slideNumber);
});
// hide breadcrumbs in overview
Reveal.addEventListener( 'overviewshown', function( event ) {
  document.querySelector(".reveal .topbar").style.display= 'none';
});
Reveal.addEventListener( 'overviewhidden', function( event ) {
  if (!hideBreadcrumbsOn(Reveal.getCurrentSlide()))
    document.querySelector(".reveal .topbar").style.display = 'block';
});
/*Reveal.addEventListener( 'fragmentshown', function( event ) {
    // event.fragment = the fragment DOM element
} );
Reveal.addEventListener( 'fragmentshown', function( event ) {
    // event.fragment = the fragment DOM element
} );*/
window.addEventListener('load', function() {
  // PDF-print support
  if (window.location.search.match( /print-pdf/gi ))
    window.print();
});
