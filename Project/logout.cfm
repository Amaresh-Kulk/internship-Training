<cfif structKeyExists(session, "isLoggedIn")>

    
    <cfset structClear(session)>

    
    <cfset sessionInvalidate()>

</cfif>

<cflocation url="login.cfm" addtoken="false">