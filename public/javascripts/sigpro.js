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
    if( e.which!=8 && e.which!=0 && e.which!=46 && (e.which<48 || e.which>57)){
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
    var format = settings.format == undefined ? '%l, %d %F %Y [%H:%i]' : settings.format;
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
    $().overlay();
    $(this).fadeIn(400);
    $(this).fadeTo("slow",1.0);
  };
});

//Close Modal
$(function() {
  $.fn.closeModal = function(){
    $('.widget').hide();
    $().closeOverlay();
  };
});

//Create Overlay for Modal
$(function() {
  $.fn.overlay = function(){
    var overlay = document.createElement("div");
    overlay.setAttribute("id","overlay");
    overlay.setAttribute("class", "overlay");
    document.body.appendChild(overlay);
  };
});

//Close Overlay for Modal
$(function() {
  $.fn.closeOverlay = function(){
    if(document.getElementById("overlay")){
      document.body.removeChild(document.getElementById("overlay"));
    }
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
  $.fn.validateStatus = function(working_day_id){
    var date = new Date(),
        time = date.getHours() + ":" + date.getMinutes(),
        id = $(this);
    
    $.get("/home/validate_status",{working_day_id: working_day_id}).done(function(data){
      if(data["status"] == true){
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
        prefix_id,
        close_modal;
    
    var settings = $.extend( {
      'select' : undefined,
      'be_added_to' : undefined,
      'prefix_id' : undefined,
      'prefix_name' : undefined,
      'close_modal' :undefined
    }, options);
    
    var select = settings.select == undefined ? "" : settings.select;
    var be_added_to = settings.be_added_to == undefined ? "" : settings.be_added_to;
    var prefix_id = settings.prefix_id == undefined ? "" : settings.prefix_id;
    var prefix_name = settings.prefix_name == undefined ? "" : settings.prefix_name;
    var close_modal = settings.close_modal == undefined ? true : settings.close_modal;
    
    if(select){
      $.each(select.find("option:selected"), function(index, value){
        id = value.value;
        text = value.text;
        
        prefixId = prefix_id+"_"+index+"_";
        prefixName = prefix_name+"["+index+"]";
        
        select.find("option[value=" + id + "]").remove();
        
        element = "<tr><td>";
        element += "<input id='" + prefixId + select[0].id + "' name='" + prefixName + "[" + select[0].id + "]' value='" + id + "' type='hidden'/>";
        element += "<text_field>" + text + "</text_field>";
        element += "</td></tr>";
        
        be_added_to.append(element);
      });
    }
    
    //Close Modal
    if(close_modal){
      $(this).closeModal();
    }
  };
});

//Chronometer
$(function() {
  $.fn.chronometer = function(params){
    
    var settings = $.extend( {
      'hours' : undefined,
      'minutes' : undefined,
      'seconds' : undefined,
      'decimal' : undefined,
      'action' : undefined,
      'stoppage_id' : undefined,
      'working_day_id' : undefined
    }, params);
    
    hours = settings.hours == undefined ? 0 : settings.hours;
    minutes = settings.minutes == undefined ? 0 : settings.minutes;
    seconds = settings.seconds == undefined ? 0 : settings.seconds;
    decimal = settings.decimal == undefined ? 0 : settings.decimal;
    var action = settings.action == undefined ? "" : settings.action;
    var stoppage_id = settings.stoppage_id == undefined ? "" : settings.stoppage_id;
    var working_day_id = settings.working_day_id == undefined ? "" : settings.working_day_id;
    var chronometer = $(this);
    
    switch(action){
      case 'start':
        watchstopped = false;
        color = "gray";
        switch(localStorage.before_action){
          case 'boot_variable':
            reloadChronometer(hours, minutes, seconds);
            break;
          case 'standby':
            reloadChronometer(chronometer.text().split(":")[0], chronometer.text().split(":")[1], chronometer.text().split(":")[2]);
            startTimer();
            break;
          case 'stop':
            break;
          default:
            startTimer();
        }
        timerActions(action, $(this).text());
        break;
      case 'stop':
        watchstopped = true;
        localStorage.before_action = action;
        timerActions(action, $(this).text());
        break;
      case 'standby':
        watchstopped = true;
        localStorage.before_action = action;
        timerActions(action, $(this).text());
        break;
      case 'boot_variable':
        watchstopped = false;
        color = "orange";
        localStorage.before_action = action;
        startTimer();
        timerActions(action, $(this).text());
        break;
      case 'change_product':
        watchstopped = true;
        localStorage.before_action = action;
        timerActions(action, $(this).text());
        $("#change_product").openModal();
        break;
    }
    
    function reloadChronometer(hrs,mins,secs){
      hours = hrs;
      minutes = mins;
      seconds = secs;
    }
    
    function startTimer(){
      if(watchstopped == false){
        intChronometer();
      }
    }
    
    function intChronometer(){
      if(watchstopped == false) {
        decimal++;
        if(decimal > 9) {
          decimal = 0;
          seconds++;
        }
        if(seconds > 59) {
          seconds = 0;
          minutes++;
        }
        if(minutes > 59) {
          minutes = 0;
          hours++;
        }
        showChronometer();
        setTimeout(intChronometer, 100);
      }
    }
    
    function showChronometer(){
      chronometer.html(format()).attr("class", color);
    }
    
    function format(time){
      return addCero(hours) +":" + addCero(minutes) + ":" + addCero(seconds);
    }
    
    function addCero(time){
      if(time <= 9){
        return "0" + parseInt(time);
      }else{
        return time;
      }
    }
    
    function timerActions(action, timer){
      $.post("/home/timer_actions",{selectedAction:action, timer:timer, working_day_id:working_day_id, stoppage_id: stoppage_id}).done(function(data){
        if(action == "standby"){
          //Aqui se abre nueva modal y se creara un nuevo contador para el tiempo de paro  "falta hacer relacion"
          stoppage_events = $("#stoppage_events");
          stoppage_events.show();
          stoppage_events.html(data["stoppage_time"]);
        }
        $(this).reloadTimers(data);
      });
    }
  };
});

//Reload Timers
$(function() {
  $.fn.reloadTimers = function(data){
    //Boot Variable
    $("#boot_variable").html(data["boot_variable"]);
    
    //Disponible Time
    $("#disponible_time").html(data["disponible_time"]);
    
    // Effective Time
    $("#effective_time").html(data["effective_time"]);
    
    // Delayed Time
    $("#delayed_time").html(data["delayed_time"]);
  };
});

$(function() {
  $.fn.alerts = function(message){
    
  };
});