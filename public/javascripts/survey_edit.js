$(document).ready(function() {
  // make the questions sortable
  $("#questions").sortable({
    axis: "y",
    update: function() {
      // update orders by iterating through order fields
      var i = 0;
      $(".order").each(function() {
        $(this).val(i);
        i++;
      });
    }
  });
  // make the order fields hidden
  $(".order").parent().hide();
  // make the answers hidden by default
  $(".answers").hide();
});

var toggleVisible = function(selector) {
  $(selector).toggle();
}

var remove_field = function(selector) {
  if ($(".destroy", selector).val() == 1) {
    $(selector).animate({ backgroundColor: "#EEE", "color": "#000"}, 500)
    $(".destroy", selector).val("false");
  } else {
    $(selector).animate({ backgroundColor: "#A00", "color": "#FFF"}, 500)
    $(".destroy", selector).val("1");
  }
}
