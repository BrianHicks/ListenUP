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

var toggleVisible = function(object) {
  $(object).toggle();
}
