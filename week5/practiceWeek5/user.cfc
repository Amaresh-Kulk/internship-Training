<cfcomponent >
    <cfset variables.count = 0>
    <cfset this.count = 0>
    <cffunction name="isGood" access="package">
            <cfoutput >
                      hello Package<br/>      
                        </cfoutput>
    </cffunction>

    <cffunction name="isBad" access="public">
            <cfoutput >
                      hello Public<br/>      
                        
            <cfset this.count = this.count + 1>
            hello #this.count#<br/>
            </cfoutput>
    </cffunction>

    <cffunction name="isAverage" access="private">
            <cfoutput >
                      hello Private<br/>      
                        </cfoutput>
    </cffunction> 

</cfcomponent>