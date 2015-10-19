//Search Bar Effect
document.addEventListener("touchstart", function(){}, true);

//Deliting yellos background of fields in Chrome
jQuery(document).ready(function($){
  $('.new_user input[type="email"]').attr('style', '-webkit-box-shadow: inset 0 0 0 1000px #ffffff !important');
  $('.new_user input[type="password"]').attr('style', '-webkit-box-shadow: inset 0 0 0 1000px #ffffff !important');
});

/*
  jQuery Succinct plugin. Version 1.1.0 (October 2014). Licensed under the MIT License
*/
!function(a){"use strict";a.fn.succinct=function(b){var c=a.extend({size:240,omission:"...",ignore:!0},b);return this.each(function(){var b,d,e=a(this),f=/[!-\/:-@\[-`{-~]$/,g=function(){e.each(function(){b=a(this).html(),b.length>c.size&&(d=a.trim(b).substring(0,c.size).split(" ").slice(0,-1).join(" "),c.ignore&&(d=d.replace(f,"")),a(this).html(d+c.omission))})};g()})}}(jQuery);

$(function(){
    $('.short-description').succinct({
        size: 120
    });
});
