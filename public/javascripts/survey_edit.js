$(document).ready(function() {
  // make the questions sortable
  $("#questions").sortable({
    containment: jQuery("#questions"),
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
  jQuery(".order").parent().hide()
});
