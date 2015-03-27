(function(win, doc, $) {
  var kbns;
  kbns = win.kbns || {};
  return $.extend({

    /*
    * wait
     */
    wait: function(duration) {
      var dfd;
      dfd = new $.Deferred();
      setTimeout(dfd.resolve, duration);
      return dfd;
    }
  });
})(window, window.document, jQuery);
