<cftry>
    <cffile action="read" file="sampletext.txt" variable="var">
    <cfoutput >
            #var#<br/>
        </cfoutput>
<cfcatch >
    <cfoutput >
            file doesn't exists<br/>
        </cfoutput>
</cfcatch>
</cftry>

<cflog file="errorLog"
       type="error"
       text="Something went wrong">