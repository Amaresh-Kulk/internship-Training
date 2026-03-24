<cfcomponent displayname="UserService" output="false">
    <cfset variables.dsn = "myDSN">
    
    <cffunction name="init" access="public" returntype="any" output="false">
        <cfargument name="datasource" type="string" required="true">
        <cfset variables.dsn = arguments.datasource>

        <cfreturn this>
    </cffunction>

    <cffunction name="addCustomer" access="public" returntype="void" output="false">
        <cfargument name="first_name" type="string" required="true">        
        <cfargument name="middle_name" type="string" required="false" default="">        
        <cfargument name="last_name" type="string" required="false" default="">     
        
        <cfset var date_joined = now()>

        <cfquery name="insertCustomer" datasource="#variables.dsn#">
                    insert into Members 
                    values
                    (<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.first_name#"> 
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.middle_name#"> 
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.last_name#"> 
                    ,<cfqueryparam cfsqltype="cf_sql_date" value="#date_joined#"> );
        </cfquery>
    </cffunction>

    <cffunction name="getCustomer" access="public" returntype="query" output="false">
        <cfargument name="id" type="number" required="true">
        
        <cfquery name="getCustomerDetails" datasource="#variables.dsn#">
                select * from Members
                where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
                    
        </cfquery>

        <cfreturn getCustomerDetails>
    </cffunction>

    <cffunction name="deleteCustomer" access="public" returntype="void" output="false">
        <cfargument name="id"  type="number" required="true">

        <cfquery name="deleteCustomerByID" datasource="#variables.dsn#">
                delete from Members
                where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
        </cfquery>
    </cffunction>

    <cffunction  name="getThis" returntype="any">
        <cfreturn this>
    </cffunction>
    
</cfcomponent>