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
        window.open('/html/uengine-web/processmanager/finduser.jsp', 'finduser', 'width=300,height=200,scrollbars=no,scrolling=no,location=no,toolbar=no');
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
        window.open('/html/uengine-web/processmanager/calendar.jsp', 'calendar', 'width=300,height=200,scrollbars=no,scrolling=no,location=no,toolbar=no');
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
        window.open('/html/uengine-web/processmanager/databaseRef.jsp', 'Database_Ref', 'width=300,height=400,scrollbars=no,scrolling=no,location=no,toolbar=no');
}
FCKCommands.RegisterCommand('Database_Ref', databaseRefCommand ); //otherwise our command will not be found
var oDatabase_Ref = new FCKToolbarButton('Database_Ref', 'Database Ref');
oDatabase_Ref.IconPath = FCKConfig.PluginsPath + 'uenginecommands/image/databaseRef.gif'; //specifies the image used in the toolbar
FCKToolbarItems.RegisterItem( 'Database_Ref', oDatabase_Ref );




var docu_libCommand=function(){
        //create our own command, we dont want to use the FCKDialogCommand because it uses the default fck layout and not our own
};
docu_libCommand.prototype.Execute=function(){
}
docu_libCommand.GetState=function() {
        return FCK_TRISTATE_OFF; //we dont want the button to be toggled
}
docu_libCommand.Execute=function() {
        //open a popup window when the button is clicked
        window.open('/html/uengine-web/processmanager/docu_lib.jsp', 'Docu_Lib', 'width=300,height=200,scrollbars=no,scrolling=no,location=no,toolbar=no');
}
FCKCommands.RegisterCommand('Docu_Lib', docu_libCommand ); //otherwise our command will not be found
var oDocu_Lib = new FCKToolbarButton('Docu_Lib', 'Docuement Lib');
oDocu_Lib.IconPath = FCKConfig.PluginsPath + 'uenginecommands/image/Docu_Lib.gif'; //specifies the image used in the toolbar
FCKToolbarItems.RegisterItem( 'Docu_Lib', oDocu_Lib );



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
        window.open('/uengine-web/processmanager/fileUpload.jsp', 'FileUpload', 'width=300,height=200,scrollbars=no,scrolling=no,location=no,toolbar=no');
}
FCKCommands.RegisterCommand('FileUpload', FileUploadCommand ); //otherwise our command will not be found
var oFileUpload = new FCKToolbarButton('FileUpload', 'FileUpload');
oFileUpload.IconPath = FCKConfig.PluginsPath + 'uenginecommands/image/fileUpload.gif'; //specifies the image used in the toolbar
FCKToolbarItems.RegisterItem( 'FileUpload', oFileUpload );

