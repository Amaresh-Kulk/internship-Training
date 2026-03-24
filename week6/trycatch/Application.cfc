<cfcomponent >
    <cfset this.debugMode = true>
    <cffunction name="onMissingTemplate" >
        <cfargument name="targetpage">
            <cfoutput >
                       #targetpage# is not found<br/>     
            </cfoutput>
        </cffunction>
    <!---
    <cffunction name="onError" >
        <cfoutput>This is the last error</cfoutput>   
        <cfmail from="abcd@gmail.com" subject="Sample error 1" to="grofafroinneitro-5835@yopmail.com" >
                    Divided by zero
                </cfmail>   
    </cffunction>--->
</cfcomponent>