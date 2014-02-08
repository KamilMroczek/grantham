var setup_page = function() {
  // setup_buttons();
  // $("#project_skills").select2({ placeholder: "Start Typing Skills" });
  $("#new_project_submit").click(function() {
    $("#new_project").submit();
  })
}

$().ready(function() {
  setup_page();
});