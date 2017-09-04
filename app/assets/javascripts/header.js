$(function() {
  var _h = $('.header');
  var _b = $('body');

  $('.header_burger').on('click', function() {
    _h.toggleClass('with_nav');
    _b.toggleClass('full_screen');
  }).trigger('click1');

  $('.header_overlay, .header_menu_close').on('click', function() {
    $('.header_burger').trigger('click');
  });

  $('.header_menu_item .title a').on('click', function(e) {
    var _hmi = $(this).closest('.header_menu_item');
    if(_hmi.is('.active')) {
      _hmi.removeClass('active');
      $('.sub', _hmi).slideUp();
    } else {
      $('.header_menu_item.active .sub').slideUp();
      $('.header_menu_item.active').removeClass('active');
      _hmi.addClass('active');
      $('.sub', _hmi).slideDown();
    }
    e.preventDefault();
  });

  $('.header_menu_item.active').each(function(){
    $('.sub', this).show();
  });

  $('.phone').on('click', function(){
    _h.toggleClass('call_me');
  });

  $('.header_contact .close').on('click', function() {
    _h.removeClass('call_me');
  });

  var _window = $(window);

  _window.on('scroll', function() {
    if(_window.scrollTop() > 3) {
      if(!_h.is('.no_hide_logo')) {
        _h.addClass('hide_logo');
      }
    } else {
      _h.removeClass('hide_logo no_themes');
    }
  }).trigger('scroll');
});