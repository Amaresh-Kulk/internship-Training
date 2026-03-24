<cfcomponent>

    
    <cfset this.name = "Assignment7App">
    <cfset this.applicationTimeout = createTimeSpan(0,1,0,0)>
    <cfset this.sessionManagement = true>
    <cfset this.sessionTimeout = createTimeSpan(0,0,30,0)>

    
    <cffunction name="onApplicationStart" returntype="boolean">

        
        <cfset application.uploadPath = expandPath("./uploads/")>
        <cfset application.filePath   = expandPath("./files/")>
        <cfset application.logPath    = expandPath("./logs/error.log")>

        <cflog file="app_log" text="application started at #now()#">

        <cfreturn true>
    </cffunction>

    <cffunction name="onApplicationEnd" returntype="boolean">

        <cflog file="app_log" text="application ended at #now()#">

        <cfreturn true>
    </cffunction>


    
    <cffunction name="onError" returntype="void">
        <cfargument name="exception" required="true">
        <cfargument name="eventName" required="true">

        
        <cflog file="error"
                text="#now()# , #arguments.exception.message# , #arguments.exception.detail#">

        <cfmail from="app@gmail.com" subject="Error in Application" to="bahunnawanoi-1763@yopmail.com" >
            #now()# , #arguments.exception.message# , #arguments.exception.detail#
        </cfmail>
    </cffunction>

</cfcomponent>
