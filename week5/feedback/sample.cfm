<!---<cffunction name="returnValue" returntype="numeric">
    <cfoutput >
            hello<br/>
        </cfoutput>
    <cfreturn 1>
</cffunction>

<cffunction name="noReturnValue" returntype="numeric">
    <cfoutput >
            hello2<br/>
        </cfoutput>
    
</cffunction>


<cfdump var="#returnValue()#">
<cfdump var="#noReturnValue()#">



<cfquery name="members" result="re_mem" datasource="library">
    select * from Members;
</cfquery>

<cfoutput query="members">
    #first_name# : #last_name#<br/>
</cfoutput>

<cfdump var="#re_mem#" >

<cfoutput >
    Record Count: #re_mem.recordcount#<br/>
</cfoutput>


<cfset local.name = "jj">
<cfdump var="#local#" >
<cffunction name="checkLocal" >
    <cfargument name="lo" type="struct">
    <cfset var name1 = "ko">
    <cfdump var="#local#" >
    <cfset local.name = "Sugama">
    <cfset lo.name = "Sugama">
    <cfdump var="#local.name#" >
</cffunction>

<cfset checkLocal(local)>

<cfoutput >
    #local.name#<br/>
</cfoutput>

--->

<cfinvoke method="jj" component="Test">