<cfcomponent displayname="UserService"
             extends="BaseService">

    
    <cffunction name="logAction" access="public" returntype="void">
        <cfargument name="message" type="string" required="true">

        
        <cfset super.logAction(arguments.message)>

        
        <cfoutput>Extra User Logging<br></cfoutput>

    </cffunction>

</cfcomponent>
