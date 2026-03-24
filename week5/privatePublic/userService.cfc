<cfcomponent output="true" extends="privateUser">

    <cffunction name="sayHello" access="public" returntype="string">
        <cfoutput> #formatMessage("hello123")#<br/></cfoutput>
        <cfreturn "Hello Amaresh">
    </cffunction>

</cfcomponent>
