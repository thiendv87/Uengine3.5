	var calendarInputId = null;
	var calendarReturnType = null;
	
	function showFullcalendar(returnType, inputFieldId)
	{
		var divCalendarArea = document.getElementById("divCalendarArea");
		calendarInputId = inputFieldId;
		calendarReturnType = returnType;
		
		if (!divCalendarArea)
		{
			var divCalendarArea = document.createElement("div");
			divCalendarArea.id = "divCalendarArea";
			divCalendarArea.title = "Choose a date";
			divCalendarArea.style.width = "500px";
			
			document.body.appendChild(divCalendarArea);
			createFullcalendar(
				divCalendarArea,
				{
//					height: 500,
					dayClick: function(date, allDay, jsEvent, view)
					{
						switch (calendarInputId)
						{
						case null:
							break;
						default:
							var resultDate = null;
							
							switch (calendarReturnType)
							{
							case "calendar" :
								resultDate = $.fullCalendar.formatDate( date, "yyyy-MM-dd HH:mm" );
								break;
							default :
								resultDate = $.fullCalendar.formatDate( date, "yyyy-MM-dd" );
								break;
							}
							
							if (isIE)
							{
								var inputs = document.getElementsByName(calendarInputId);
								for (var i = 0, il = inputs.length; i < il; i++)
								{
									inputs[i].value = resultDate;
								}
							}
							else
							{
								document.getElementById(calendarInputId).value = resultDate;
							}
							
							$(divCalendarArea).dialog('close');
							break;
						}
					}
				}
			);
			
			$(divCalendarArea).dialog({
					autoOpen: false,
					bgiframe: true,
					width: 540,
					modal: true,
					resizable: false
			});
		}
		
		var tempDate = null;
		var currentValue = document.getElementById(calendarInputId).value;
		
		if (currentValue.isTrue())
		{
			tempDate = $.fullCalendar.parseDate( currentValue );
		}
		else
		{
			tempDate = new Date();
		}
		
		$(divCalendarArea).dialog('open');
		$(divCalendarArea).fullCalendar('gotoDate', tempDate.getFullYear(), tempDate.getMonth(), tempDate.getDate());
		$(divCalendarArea).fullCalendar('refetchEvents');
	}

	function getEventDatas(start, end, callback)
	{
		$.ajax({
            url: WEB_CONTEXT_ROOT + "/processparticipant/json/calendarEventsJson.jsp",
            data: {
                dtStart: $.fullCalendar.formatDate( start, "yyyy-MM-dd HH:mm:ss" ),
                dtEnd: $.fullCalendar.formatDate( end, "yyyy-MM-dd HH:mm:ss" )
            },
            success: function(resultString) {
                var events = new Array();
                var resultSet = eval(resultString);

                for (var i=0, il=resultSet.length; i < il; i++)
                {
	                var result = resultSet[i];
	                var tempTitle = result.title.decodeURI().replaceAll("\\+", " ");
	                var tempEnd = result.end;
	                var event = null;
	                var today = new Date();

	                switch (tempEnd)
	                {
	                case (null):
	                case ("null"):
	                case (""):
	                	tempTitle = tempTitle + " (Unfinished)";
	                	tempEnd = today;
		                break;
	                default:
		                break;
	                }

                	event = {
                        title: tempTitle,
                        start: result.start,
                        end: tempEnd,
                        className: "status_" + result.status,
                        allday: false
               		}
                	
                	events.push(event);
                }
                
                callback(events);
            }
        });
    }

	function createFullcalendar(divObject, objOptions)
	{
		var options = {
			header: {
					left: 'month,agendaWeek,agendaDay',
					center: 'title',
					right: 'prevYear,prev today next,nextYear'
			}
			,buttonIcons : {
				prev: 'circle-arrow-w',
				next: 'circle-arrow-e',
				prevYear: 'circle-triangle-w',
				nextYear: 'circle-triangle-e'
			}
			,editable: false
			,theme: true
			,allDaySlot: true
			,slotMinutes: 30
			,allDayDefault: false
//			,events: getEventDatas
		};
		
		if (objOptions)
		{
			if (objOptions.height) { options.height = objOptions.height; }
			if (objOptions.width) { options.width = objOptions.width; }
			if (objOptions.dayClick) { options.dayClick = objOptions.dayClick; }
		}
		
		$(divObject).fullCalendar(options);
	}