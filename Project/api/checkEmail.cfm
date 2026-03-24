<cfcontent type="application/json">

<cfif structKeyExists(url,"email")>

    <cfquery name="checkEmail" datasource="securitydb">
        SELECT id FROM Users
        WHERE email =
        <cfqueryparam value="#url.email#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <cfif checkEmail.recordCount GT 0>
        <cfoutput>{"exists": true}</cfoutput>
    <cfelse>
        <cfoutput>{"exists": false}</cfoutput>
    </cfif>

</cfif>