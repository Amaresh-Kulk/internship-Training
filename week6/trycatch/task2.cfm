<form action="" method="post">
    First Name:<input type="text" name="first_name"><br/>
    Last Name:<input type="text" name="last_name">
    <input type="submit">
</form>


<cfif NOT structKeyExists(form, "first_name") OR trim(form.first_name) EQ "">
    <cfoutput>Please enter first name.</cfoutput>
    <cfabort>
</cfif>

<cfif NOT structKeyExists(form, "last_name") OR trim(form.last_name) EQ "">
    <cfoutput>Please enter last name.</cfoutput>
    <cfabort>
</cfif>


<cftry>

    
    <cfquery name="qUser" datasource="library">
        SELECT first_name, last_name
        FROM Members
        WHERE first_name =
        <cfqueryparam value="#form.first_name#" cfsqltype="cf_sql_varchar">
    </cfquery>

    
    <cfif qUser.recordCount EQ 0 OR qUser.last_name NEQ form.last_name>

        
        <cflog file="loginAttempts"
               type="error"
               text="Failed Login, User:#form.first_name# ">

        <cfthrow type="custom"
                 message="Invalid first name or last name.">
    </cfif>

    
    <cfoutput>Login Successful!</cfoutput>

<cfcatch type="database">

    <cflog file="loginAttempts"
           type="error"
           text="Database Error during login">

    <cfset errorMessage = "System temporarily unavailable.">

</cfcatch>

<cfcatch type="custom">
    <cfset errorMessage = cfcatch.message>
</cfcatch>

<cfcatch type="any">

    <cflog file="loginAttempts"
           type="error"
           text="Unexpected Error">

    <cfset errorMessage = "Unexpected error occurredj.">

</cfcatch>

</cftry>




<cfif structKeyExists(variables, "errorMessage")>
    <cfoutput>
        
            #errorMessage#
        
    </cfoutput>
</cfif>
