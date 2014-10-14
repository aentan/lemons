//= require_tree .

$(function() {

  $d = $(document);
  $w = $(window);
  
  var $main = $('#main');
  var $body = $('body');

  function pjaxLoad(url) {
    $.pjax({
      url: url,
      container: '#main',
      fragment: '#main'
    });
  }

  // Fadeout
  $d.on('pjax:start', function(e) {
    $main.after($main.clone().attr('id', 'clone'));
    $('#clone').css('z-index', 1090);
    $body.css('overflow', 'hidden');
  });

  $d.on('pjax:end', function(e) {
    picturefill();
    TweenLite.to($('#clone'), 0.8, {
      opacity: 0,
      onComplete: function() {
        $('#clone').remove();
        $body.css('overflow', 'auto');
        picturefill();
      }
    });
  });

  if ($.support.pjax) {
    // Load
    $d.on('click', '.tile', function(e) {
      e.preventDefault();
      pjaxLoad($(this).attr('href'));
    });
    // Back button
    $d.on('click', '.lemon-back', function(e) {
      e.preventDefault();
      pjaxLoad($(this).attr('href'));
    });
  }
  
});