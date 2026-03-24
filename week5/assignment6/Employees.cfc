<cfcomponent>
    <cfset this.datasource = "dbemployees">
    
    <cffunction name="validateEmployee" access="public" returntype="struct">
        <cfargument name="formData" type="struct" required="true">

        <cfset var result = {}>
        <cfset result.isValid = true>
        <cfset result.errors = "">

        
        <cfif NOT (len(trim(arguments.formData.name)) and 
        reFind("^[A-Za-z ]+$",arguments.formData.name))>
            <cfset result.errors =  "Name is incorrect.">
        </cfif>

        
        <cfif len(result.errors) GT 0>
            <cfset result.isValid = false>
        </cfif>

        <cfreturn result>
    </cffunction>

    <cffunction name="checkEmployee" access="public" returntype="boolean">
        <cfargument name="formData" type="struct" required="true">

        <cfquery name="qEmployee">
            SELECT employee_id
            FROM Employees
            WHERE name = <cfqueryparam value="#formData.name#" cfsqltype="cf_sql_varchar">
            AND position = <cfqueryparam value="#formData.position#" cfsqltype="cf_sql_varchar">
            AND department = <cfqueryparam value="#formData.department#" cfsqltype="cf_sql_varchar">
            AND phone_number = <cfqueryparam value="#formData.phone_number#" cfsqltype="cf_sql_varchar">
        </cfquery>

        <cfreturn qEmployee.recordCount GT 0>
    </cffunction>

    <cffunction name="getAllEmployees" access="public" returntype="query">

        <cfquery name="qEmployees">
            SELECT employee_id,
                name,
                position,
                department,
                phone_number
            FROM Employees
            ORDER BY department
        </cfquery>

        <cfreturn qEmployees>

    </cffunction>

</cfcomponent>
