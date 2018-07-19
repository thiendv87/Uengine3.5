<h1>Example API Invocation Demos</h1>

<ol>


<form action=initiateProcess.jsp method=POST>
<li>Initiating Process Definition:<br>
<ul>
Enter Process Definition Name to be initiated: <input name="definitionName">
<input type=submit>
</ul>
</li>
</form>

<p>

<form action=startProcess.jsp method=POST>
<li>Starting Process Definition:<br>
<ul>
Enter InstanceId to be started: <input name="instanceId">
<input type=submit>
</ul>
</li>
</form>

<p>


<form action=initiateAndStartProcess.jsp method=POST>
<li>Initiating and Starting Process Definition:<br>
<ul>
Enter Process Definition Name to be initiated and started: <input name="definitionName">
<input type=submit>
</ul>
</li>
</form>


<p>

<form action=getProcessVariable.jsp method=POST>
<li>Getting Value of Variable:<br>
<ul>
Enter instanceId : <input name="instanceId"><br>
Enter variable name : <input name="variableName"><br>
<input type=submit>

</ul>
</li>
</form>

<p>

<form action=setProcessVariable.jsp method=POST>
<li>Setting Value to Variable:<br>
<ul>
Enter instanceId : <input name="instanceId"><br>
Enter variable name : <input name="variableName"><br>
Enter value (Just String value for this example) : <input name="value"><br>
<input type=submit>

</ul>
</li>
</form>

<p>


<p>

<form action=completeWorkitem.jsp method=POST>
<li>Completing Work item:<br>
<ul>
Enter instanceId : <input name="instanceId"><br>
Enter tracingTag : <input name="tracingTag"><br>
<input type=submit>

</ul>
</li>
</form>

<p>
