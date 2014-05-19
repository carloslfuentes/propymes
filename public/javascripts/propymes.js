$(document).ready(function(e) {
  //Uniform Aristo
  $("input, textarea, select").uniform();
  $("input:checkbox").live("click", function() {
    $.uniform.update(
      $(this).attr("checked", this.checked)
    );
  });
  
  //Close modal Press ESC
  $(document).keyup(function(e) { 
    if (e.keyCode == 27) { 
      $().closeModal();
    }
  });
  
  //Only Numbers
  $('.only_numbers').keypress(function (e){
    if( e.which!=8 && e.which!=0 && (e.which<48 || e.which>57)){
      return false;
    }
  });
});

//Calendar Date Picker
$(function($){
  $.fn.calendarDatePicker = function(options){
    
    var settings = $.extend( {
      'set_date' : undefined,
      'format' : undefined,
      'language' : undefined,
      'hideTime' : undefined
    }, options);
    
    var element = $(this).attr("id") ;
    
    var set_date = settings.set_date == undefined ? new Date() : new Date(settings.set_date);
    var format = settings.format == undefined ? '%Y-%m-%d' : settings.format;
    var language = settings.language == undefined ? 'es' : settings.language;
    var hideTime = settings.hideTime == undefined ? 'false' : settings.hideTime;
    
    var CalendarDatePicker;
    CalendarDatePicker = new dhtmlXCalendarObject([element]);
    if(hideTime == "true"){CalendarDatePicker.hideTime();}
    CalendarDatePicker.loadUserLanguage(language);
    CalendarDatePicker.setDate(set_date);
    CalendarDatePicker.setDateFormat(format);
  };
});

//Widget Modal
$(function() {
  $('.modal').click(function() {
    $().closeModal();
    var id = $(this).attr('rel') + ".widget";
    //Effect to Open
    $(id).fadeIn(400);
    $(id).fadeTo("slow",1.0);
    //Passing Params
    var id_row = $(this).attr('id_row'),
        param = $(this).attr('param');
    $(id_row).val(param);
  }); 
  
});

//Close Modal
$(function() {
  $.fn.closeModal = function(){
    $('.widget').hide();
  };
});

//KeyPad
$(function() {
  $.fn.keyPad = function(){
    var input = $(this);
    $("#keyPad a.button").click(function(){
      var num = $(this)[0].textContent.replace(/\s+/g,"");;
      $(input).val(input.val() + num);
      
    });
  };
});
