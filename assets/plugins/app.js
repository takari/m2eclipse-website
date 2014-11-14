var App = function () {
  return {
    init: function () {
      jQuery('.carousel').carousel({
        interval: 10000,
        pause: 'hover'
      });
    }
  };
}();