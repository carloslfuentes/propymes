$(document).ready(function(e) {
  //Uniform Aristo
  $("input, textarea, select").uniform();
  $("input:checkbox").live("click", function() {
    $.uniform.update(
      $(this).attr("checked", this.checked)
    );
  });
  
  //Close Widget Modal FIXME Verificar que es correcto el cierre
  $(document).keyup(function(e) { 
    if (e.keyCode == 27) { 
      $('.widget').hide();
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
    var id = $(this).attr('rel') + ".widget";
    //Effect to Open
    $(id).fadeIn(400);
    $(id).fadeTo("slow",1.0);
  }); 
});