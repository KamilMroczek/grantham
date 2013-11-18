var setup_buttons = function() {
  $('.btn-create1-next').click( function() {
    $('.create1-panel').addClass('hide');
    $('#create-project-panel-bullet1').removeClass('active');
    $('.create2-panel').removeClass('hide');
    $('#create-project-panel-bullet2').addClass('active');
  });
  
  $('.btn-create2-prev').click( function() {
    $('.create2-panel').addClass('hide');
    $('#create-project-panel-bullet2').removeClass('active');
    $('.create1-panel').removeClass('hide');
    $('#create-project-panel-bullet1').addClass('active');
  });
  
  $('.btn-create2-next').click( function() {
    $('.create2-panel').addClass('hide');
    $('#create-project-panel-bullet2').removeClass('active');
    $('.create3-panel').removeClass('hide');
    $('#create-project-panel-bullet3').addClass('active');
  });
  
  $('.btn-create3-prev').click( function() {
    $('.create3-panel').addClass('hide');
    $('#create-project-panel-bullet3').removeClass('active');
    $('.create2-panel').removeClass('hide');
    $('#create-project-panel-bullet2').addClass('active');
  });
  
  $('.btn-create3-next').click( function() {
    $("#new_project").submit();
  });
}

var setup_page = function() {
  setup_buttons();
  $("#project_skills").select2({ placeholder: "Start Typing Skills" });
}

$().ready(function() {
  setup_page();
});