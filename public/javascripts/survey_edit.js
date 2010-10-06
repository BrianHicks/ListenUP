$(document).ready(function() {
  // make the questions sortable
  $("#questions").sortable({
    containment: jQuery("#questions"),
    axis: "y"
  });
  // make the order fields hidden
  jQuery(".order").parent().hide()
});
