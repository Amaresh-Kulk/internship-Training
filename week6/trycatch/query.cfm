<cfsetting showdebugoutput="true">
<cftry>
    <cfquery name="q" datasource="library">
        SELECT * FROM Members;
    </cfquery>

<cfcatch type="database">
    <cfoutput >
            #cfcatch.message#<br/>
        </cfoutput>
</cfcatch>

<cfcatch type="any">
    Some other error occurred.
</cfcatch>

</cftry>
<!---
<cfloop query="q">
    <cfquery datasource="library">
        SELECT * FROM Members;
    </cfquery>
</cfloop>--->

<cfset a = 10/1>
<cfoutput >
    #a#<br/>
</cfoutput>