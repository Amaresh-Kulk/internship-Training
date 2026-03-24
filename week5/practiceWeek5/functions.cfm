<cffunction name="isPalindrome"  returntype="boolean" output="true" access="private">
    <cfargument name="str" type="string" required="false" default="ababa">
    
    <cfset start = 1>
    <cfset end = len(str)>
    <cfloop condition="start lte end">
        <cfif str[start] neq str[end]>
            <cfoutput >
                      hello<br/>      
                        </cfoutput>
            <cfreturn false>
        </cfif>  
        <cfset start = start + 1>
        <cfset end = end - 1>
    </cfloop>
    <cfreturn true>
</cffunction>

<cfoutput >
    #isPalindrome("ababab")#<br/>
    #isPalindrome()#<br/>
    
</cfoutput>

<cfset obj = createObject("component", "anotherUser")>
<cfset obj.nowIsGood()>
<cfset obj2 = createObject("component", "user")>
<!---<cfset obj2.isGood()>--->
