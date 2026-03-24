<cfcomponent>

    
    <cfset variables.dsn = "myDSN">

    
    <cffunction name="init" access="public" returntype="any" output="false">
        <cfargument name="datasource" required="true">
        <cfset variables.dsn = arguments.datasource>
        <cfreturn this>
    </cffunction>

    
    <cffunction name="logAction" access="private" returntype="void" output="true">
        <cfargument name="message" type="string" required="true">

        <cfoutput>
            Logging: #arguments.message# <br>
        </cfoutput>
    </cffunction>

</cfcomponent>
