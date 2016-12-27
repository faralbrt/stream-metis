$(document).ready(function() {
  var green = $("td[style='background-color: green']").parent().detach();
  var red = $("td[style='background-color: red']").parent().detach();
  $("tbody").prepend(green);
  $("tbody").prepend(red);  
});
