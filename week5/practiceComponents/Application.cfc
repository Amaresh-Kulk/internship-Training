<cfcomponent >
    <cfset this.datasource = 'default'>
    <cffunction name="onApplicationStart" >
        <cfargument name="datasource" type="string" required="true">        
    </cffunction>
</cfcomponent>