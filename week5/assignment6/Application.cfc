<cfcomponent>

    
    <cfset this.name = "EmployeeValidationApp">
    <cfset this.applicationTimeout = createTimeSpan(0, 2, 0, 0)> 
    <cfset this.sessionManagement = true>
    <cfset this.sessionTimeout = createTimeSpan(0, 0, 30, 0)> 
    <cfset this.datasource = "dbemployees">
    <cfset this.customtagpaths = [expandPath("./customtags")]>


    <cffunction name="onApplicationStart" returntype="boolean">
        
        <cflog file="app_log" 
               text="Application Started at #now()#" 
        >

        <cfreturn true>
    </cffunction>




    <cffunction name="onApplicationEnd">
        <cfargument name="applicationScope">

        <cflog file="app_log" 
               text="Application Ended at #now()#" 
        >
    </cffunction>



    <cffunction name="onSessionStart">

        <cfset session.startTime = now()>

        <cflog file="app_log" 
               text="Session Started: #session.sessionID# at #now()#" 
        >
    </cffunction>


    <cffunction name="onSessionEnd">
        <cfargument name="sessionScope">
        <cfargument name="applicationScope">

        <cflog file="app_log" 
               text="Session Ended: #sessionScope.sessionID# at #now()#" 
        >
    </cffunction>



    <cffunction name="onRequestStart" returntype="boolean">
        <cfargument name="targetPage">

        
        <cflog file="app_log"
            text="Page accessed: #targetPage# at #now()#"
        >

        <cfreturn true>
    </cffunction>


    <cffunction name="onRequest" output="true">
        <cfargument name="targetPage">
        <cfset var pageName = listLast(targetPage, "/")>
        
        <cfif pageName NEQ "login.cfm">
            <!---<cfmodule template="header.cfm">--->
            <cf_header>
        </cfif>
        
        <cfinclude template="#arguments.targetPage#">

        <cfif pageName NEQ "login.cfm">
            <cf_footer>
            <!---<cfmodule template="footer.cfm">--->
        </cfif >
                    

    </cffunction>



    


</cfcomponent>
