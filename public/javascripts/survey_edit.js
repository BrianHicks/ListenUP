$(document).ready(function() {
  // make the questions sortable
  $("#questions").sortable({
    axis: "y", 
    update: function() { updateInfo(); }
  });
  updateInfo();
});

var updateInfo = function() {
  // update positions by iterating through position fields
  var i = 0;
  $(".position").each(function() {
    $(this).val(i);
    i++;
  });
  // make the position fields hidden
  $(".position").parent().hide();
  // make the answers hidden by default
  $(".answers").hide();
}

var toggleVisible = function(selector) {
  $(selector).toggle();
}

var remove_field = function(selector) {
  if ($(".destroy", selector).val() == 1) {
    $(selector).removeClass("delete", 500);
    //$(selector).animate({ backgroundColor: "#EEE", "color": "#000"}, 500)
    $(".destroy", selector).val("false");
    $("input, select", selector).attr("disabled", "");
  } else {
    $(selector).addClass("delete", 500);
    //$(selector).animate({ backgroundColor: "#A00", "color": "#FFF"}, 500)
    $(".destroy", selector).val("1");
    $("input, select", selector).attr("disabled", "true");
  }
}

var add_fields = function(sender, selector, html) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + selector, "g")
  html = html.replace(regexp, new_id);
  if (selector == "answers") {
    // append to the parent question's answers
    $(".answers", $(sender).parents(".question")).append(html);
  } else {
    $("#" + selector).append(html);
  }
}
