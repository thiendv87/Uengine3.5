var findUserCommand=function(){
        //create our own command, we dont want to use the FCKDialogCommand because it uses the default fck layout and not our own
};
findUserCommand.prototype.Execute=function(){
}
findUserCommand.GetState=function() {
        return FCK_TRISTATE_OFF; //we dont want the button to be toggled
}
findUserCommand.Execute=function() {
        //open a popup window when the button is clicked
        window.open('../../../../processmanager/finduser.jsp', 'finduser', 'width=300,height=300,scrollbars=no,scrolling=no,location=no,toolbar=no');
}
FCKCommands.RegisterCommand('Find_User', findUserCommand ); //otherwise our command will not be found
var oFind_User = new FCKToolbarButton('Find_User', 'find user');
oFind_User.IconPath = FCKConfig.PluginsPath + 'uenginecommands/image/role.gif'; //specifies the image used in the toolbar
FCKToolbarItems.RegisterItem( 'Find_User', oFind_User );
 

var calendarCommand=function(){
        //create our own command, we dont want to use the FCKDialogCommand because it uses the default fck layout and not our own
};
calendarCommand.prototype.Execute=function(){
}
calendarCommand.GetState=function() {
        return FCK_TRISTATE_OFF; //we dont want the button to be toggled
}
calendarCommand.Execute=function() {
        //open a popup window when the button is clicked
        window.open('../../../../processmanager/calendar.jsp', 'calendar', 'width=300,height=200,scrollbars=no,scrolling=no,location=no,toolbar=no');
}
FCKCommands.RegisterCommand('Calendar', calendarCommand ); //otherwise our command will not be found
var oCalendar = new FCKToolbarButton('Calendar', 'Calendar');
oCalendar.IconPath = FCKConfig.PluginsPath + 'uenginecommands/image/calendar.gif'; //specifies the image used in the toolbar
FCKToolbarItems.RegisterItem( 'Calendar', oCalendar );



var databaseRefCommand=function(){
        //create our own command, we dont want to use the FCKDialogCommand because it uses the default fck layout and not our own
};
databaseRefCommand.prototype.Execute=function(){
}
databaseRefCommand.GetState=function() {
        return FCK_TRISTATE_OFF; //we dont want the button to be toggled
}
databaseRefCommand.Execute=function() {
        //open a popup window when the button is clicked
        window.open('../../../../processmanager/databaseRef.jsp', 'Database_Ref', 'width=300,height=400,scrollbars=no,scrolling=no,location=no,toolbar=no');
}
FCKCommands.RegisterCommand('Database_Ref', databaseRefCommand ); //otherwise our command will not be found
var oDatabase_Ref = new FCKToolbarButton('Database_Ref', 'Database Ref');
oDatabase_Ref.IconPath = FCKConfig.PluginsPath + 'uenginecommands/image/databaseRef.gif'; //specifies the image used in the toolbar
FCKToolbarItems.RegisterItem( 'Database_Ref', oDatabase_Ref );


var FileUploadCommand=function(){
        //create our own command, we dont want to use the FCKDialogCommand because it uses the default fck layout and not our own
};
FileUploadCommand.prototype.Execute=function(){
}
FileUploadCommand.GetState=function() {
        return FCK_TRISTATE_OFF; //we dont want the button to be toggled
}
FileUploadCommand.Execute=function() {
        //open a popup window when the button is clicked
        window.open('../../../../processmanager/fileUpload.jsp', 'FileUpload', 'width=300,height=200,scrollbars=no,scrolling=no,location=no,toolbar=no');
}
FCKCommands.RegisterCommand('FileUpload', FileUploadCommand ); //otherwise our command will not be found
var oFileUpload = new FCKToolbarButton('FileUpload', 'FileUpload');
oFileUpload.IconPath = FCKConfig.PluginsPath + 'uenginecommands/image/fileUpload.gif'; //specifies the image used in the toolbar
FCKToolbarItems.RegisterItem( 'FileUpload', oFileUpload );

var AddRowCommand=function(){
        //create our own command, we dont want to use the FCKDialogCommand because it uses the default fck layout and not our own
};
AddRowCommand.prototype.Execute=function(){
}
AddRowCommand.GetState=function() {
        return FCK_TRISTATE_OFF; //we dont want the button to be toggled
}
AddRowCommand.Execute=function() {
        //open a popup window when the button is clicked
        //window.open('../../processmanager/addRow.jsp', 'AddRow', 'width=300,height=200,scrollbars=no,scrolling=no,location=no,toolbar=no');
                         		
        var html = "<input:addrow /><input type=\"button\" name=\"nameBtnAddRow\" onclick=\"addRow(this)\" value=\"Add\" style=\"width: 60px;display:none\" />"
					+ "<input type=\"button\" onclick=\"removeRow(this)\" value=\"Remove\" style=\"width: 60px;display:none\" />";
        FCK.InsertHtml(html);
     
}
FCKCommands.RegisterCommand('AddRow', AddRowCommand ); //otherwise our command will not be found
var oAddRow = new FCKToolbarButton('AddRow', 'AddRow');
oAddRow.IconPath = FCKConfig.PluginsPath + 'uenginecommands/image/addRow.gif'; //specifies the image used in the toolbar
FCKToolbarItems.RegisterItem( 'AddRow', oAddRow );



var richTextAreaCommand=function(){
        //create our own command, we dont want to use the FCKDialogCommand because it uses the default fck layout and not our own
};
richTextAreaCommand.prototype.Execute=function(){
}
richTextAreaCommand.GetState=function() {
        return FCK_TRISTATE_OFF; //we dont want the button to be toggled
}
richTextAreaCommand.Execute=function() {
        //open a popup window when the button is clicked
        window.open('../../../../processmanager/richTextArea.jsp', 'richTextArea', 'width=300,height=300,scrollbars=no,scrolling=no,location=no,toolbar=no');
}
FCKCommands.RegisterCommand('RichTextArea', richTextAreaCommand ); //otherwise our command will not be found
var oRichTextArea_User = new FCKToolbarButton('RichTextArea', 'Rich textarea');
oRichTextArea_User.IconPath = FCKConfig.PluginsPath + 'uenginecommands/image/textarea.gif'; //specifies the image used in the toolbar
FCKToolbarItems.RegisterItem( 'RichTextArea', oRichTextArea_User );



var formTemplateCommand=function(){
    //create our own command, we dont want to use the FCKDialogCommand because it uses the default fck layout and not our own
};
formTemplateCommand.prototype.Execute=function(){
}
formTemplateCommand.GetState=function() {
    return FCK_TRISTATE_OFF; //we dont want the button to be toggled
}
formTemplateCommand.Execute=function() {
    //open a popup window when the button is clicked
    window.open('../../../../processmanager/formTemplate.jsp', 'formTemplate', 'width=800,height=600,scrollbars=yes,scrolling=yes,location=no,toolbar=no,resize=yes');
}
FCKCommands.RegisterCommand('FormTemplate', formTemplateCommand ); //otherwise our command will not be found
var oFormTemplate = new FCKToolbarButton('FormTemplate', 'Form Template');
oFormTemplate.IconPath = FCKConfig.PluginsPath + 'uenginecommands/image/Docu_Lib.gif'; //specifies the image used in the toolbar
FCKToolbarItems.RegisterItem( 'FormTemplate', oFormTemplate );



var schedulerCronExpressionCommand=function(){
    //create our own command, we dont want to use the FCKDialogCommand because it uses the default fck layout and not our own
};
schedulerCronExpressionCommand.prototype.Execute=function(){
}
schedulerCronExpressionCommand.GetState=function() {
    return FCK_TRISTATE_OFF; //we dont want the button to be toggled
}
schedulerCronExpressionCommand.Execute=function() {
    //open a popup window when the button is clicked
    window.open('../../../../processmanager/schedulerCronExpression.jsp', 'calendar', 'width=300,height=200,scrollbars=no,scrolling=no,location=no,toolbar=no');
}
FCKCommands.RegisterCommand('SchedulerCronExpression', schedulerCronExpressionCommand ); //otherwise our command will not be found
var oSchedulerCronExpression = new FCKToolbarButton('SchedulerCronExpression', 'Scheduler CronExpression');
oSchedulerCronExpression.IconPath = FCKConfig.PluginsPath + 'uenginecommands/image/Scheduler.gif'; //specifies the image used in the toolbar
FCKToolbarItems.RegisterItem( 'SchedulerCronExpression', oSchedulerCronExpression );
