<cfoutput>
<h2>#application.siteName#</h2>

You have visited this site #session.visits# times in this session.<br><br>
<cfscript>
    writeOutput("5 +");
</cfscript>
Current time: #TimeFormat(Now(), "hh:mm:ss tt")#
</cfoutput>
