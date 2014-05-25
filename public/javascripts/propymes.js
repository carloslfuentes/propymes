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
    $(id).openModal();
    //Passing Params
    var id_row = $(this).attr('id_row'),
        param = $(this).attr('param');
    $(id_row).val(param);
  }); 
  
});

//Open Modal
$(function() {
  $.fn.openModal = function(){
    $(this).fadeIn(400);
    $(this).fadeTo("slow",1.0);
  };
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

//Validate Status
$(function() {
  $.fn.validateStatus = function(){
    var date = new Date(),
        time = date.getHours() + ":" + date.getMinutes(),
        id = $(this);
    
    $.get("/home/validate_status",{}).done(function(data){
      if(data){
        $(id).openModal();
      }
    });
  };
});

//Add MultiElements
$(function(){
  $.fn.addElements = function(options){
    var id,
        text,
        element,
        prefix_name,
        prefix_id;
    
    var settings = $.extend( {
      'select' : undefined,
      'be_added_to' : undefined,
      'prefix_id' : undefined,
      'prefix_name' : undefined
    }, options);
    
    var select = settings.select == undefined ? "" : settings.select;
    var be_added_to = settings.be_added_to == undefined ? "" : settings.be_added_to;
    var prefix_id = settings.prefix_id == undefined ? "" : settings.prefix_id;
    var prefix_name = settings.prefix_name == undefined ? "" : settings.prefix_name;
    
    if(select){
      $.each(select.find("option:selected"), function(index, value){
        id = value.value;
        text = value.text;
        
        prefix_id = prefix_id+"_"+index+"_";
        prefix_name = prefix_name+"["+index+"]";
        
        select.find("option[value=" + id + "]").remove();
        
        element = "<tr><td>";
        element += "<input id='" + prefix_id + select[0].id + "' name='" + prefix_name + "[" + select[0].id + "]' value='" + id + "' type='hidden'/>";
        element += "<text_field>" + text + "</text_field>";
        element += "</td></tr>";
        
        be_added_to.append(element);
      });
    }
    
    
    $(this).closeModal();
  };
});