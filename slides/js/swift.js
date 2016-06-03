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
    { src: '../plugin/highlight/highlight.js', async: true, callback: function() { hljs.initHighlightingOnLoad(); } }
  ]
});
// last element of array extention
if (!Array.prototype.last){
  Array.prototype.last = function(){
    return this[this.length - 1];
  };
};
// breadcrumbs string construction
function getBreadcrumbs(slide) {
  var breadcrumbs = '';
  if(slide.parentNode.className.indexOf('stack') > -1)
    breadcrumbs = slide.parentNode.querySelector('h1').innerHTML;
  if( slide.querySelector('h1,h2,h3') != null)
    breadcrumbs =
      (breadcrumbs == '' ? '' : breadcrumbs + ' &#8594; ') +
      slide.querySelector('h1,h2,h3').innerHTML;
  if (breadcrumbs == '')
    breadcrumbs = document.title.split(' ').last();
    return breadcrumbs;
}
// if slide dont need breadcrumbs
function hideBreadcrumbsOn(slide) {
  return Reveal.isOverview() || Reveal.isFirstSlide() ||
      slide.parentNode.className.indexOf("stack") > -1 &&
      slide.parentNode.querySelector('section') == slide ||
      slide.className.indexOf("clear") > -1;
}
// change or hide breadcrumbs on slide change
Reveal.addEventListener('slidechanged', function(event) {
  var slide = event.currentSlide;
  var topBar = document.querySelector(".reveal .topbar");

  if (hideBreadcrumbsOn(slide)) {
    topBar.style.display = "none";
  } else {
    document.querySelector(".reveal .topbar .title").innerHTML = getBreadcrumbs(slide);
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
