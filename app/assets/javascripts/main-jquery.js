document.addEventListener("touchstart", function(){}, true);

$(function() {
  return $('#products').imagesLoaded(function() {
    return $('#products').masonry({
      itemSelector: '.box-product',
      isFitWidth: true
    });
  });
});