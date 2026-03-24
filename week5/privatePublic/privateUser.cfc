<cfcomponent>

    <cffunction name="formatMessage" access="private" returntype="string">
        <cfargument name="msg" required="true">
        <cfreturn "Formatted: " & arguments.msg>
    </cffunction>

    <cffunction name="logAction" access="public" returntype="string">
        <cfargument name="msg" required="true">

        <cfreturn formatMessage(arguments.msg)>
    </cffunction>

</cfcomponent>