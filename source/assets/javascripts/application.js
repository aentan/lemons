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
    //
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
      $tile = $(this);
      e.preventDefault();
      pjaxLoad($tile.attr('href'));
    });
    // Back button
    $d.on('click', '.lemon-back', function(e) {
      e.preventDefault();
      pjaxLoad($(this).attr('href'));
    });
  }
  
  // About
  
  $d.on('click', '#info', function(e) {
    e.preventDefault();
    $body.toggleClass('info-active');
  });
  
});