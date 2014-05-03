//Calendar
function calendar(options){
  
  //options
  var settings = $.extend( {
    'first_hour' : undefined,
    'event_duration' : undefined,
    'message' : undefined
  }, options);
  
  var first_hour = settings.first_hour == undefined ? 7 : settings.first_hour;
  var event_duration = settings.event_duration == undefined ? '' : settings.event_duration;
  var message = settings.message == undefined ? '' : settings.message;
  
  //Config
  scheduler.config.preserve_scroll = true;
  scheduler.config.cascade_event_display = true;
  scheduler.config.icons_select=[];
  scheduler.config.icons_edit=[];
  scheduler.config.start_on_monday = true;
  scheduler.xy.menu_width=0;
  scheduler.config.multi_day = false;
  scheduler.config.drag_resize = true;
  scheduler.config.drag_move = true;
  scheduler.config.dblclick_create = true;
  scheduler.config.edit_on_create = false;
  scheduler.config.details_on_dblclick=false;
  scheduler.config.details_on_create = false;
  scheduler.config.drag_create = false;
  scheduler.config.first_hour = first_hour;
  scheduler.config.last_hour = 25;
  scheduler.config.hour_size_px = 88;
  scheduler.config.event_duration = event_duration; 
  scheduler.config.auto_end_date = true;
  scheduler.config.separate_short_events = true;
  scheduler.config.step = 1;
  scheduler.config.time_step = event_duration + 1;
  
  //Message to Create Cite
  scheduler.templates.event_text=function(start,end,event){
   return message;
  };
  
  scheduler.init('scheduler_here',new Date(),"week");
  //Load Cites
  //scheduler.load("#{events_path(:xml,@internal_scopes)}");
  scheduler.load("");
  
  //New Event
  scheduler.attachEvent("onEventAdded", function(event_cite){
    //Start Date
    var convertStrDate = scheduler.date.date_to_str('%Y-%m-%d %H:%i');
    var cite = scheduler.getEvent(event_cite);
    var start_cite = convertStrDate( cite.start_date );
    
    document.getElementById('selected_date').value = start_cite;
    document.getElementById('event_duration').value = event_duration;
    document.getElementById('process_cite_new').submit();
  });
}