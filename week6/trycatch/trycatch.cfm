<!---<cftry>
    <cfset x = 10>
    <cfset y = 0>
    <cfset result = x / y>
    <cfoutput>#result#<br/></cfoutput>
<cfcatch>
    <cfoutput>Division By Zero<br/></cfoutput>
    <!---<cfrethrow>--->

</cfcatch>
</cftry>


<cfset x = 10>
<cfset y = 0>
<cfset result = x / y>
<cfoutput>#result#<br/></cfoutput>


<cftry>
    <cfset x = 10>
    <cfset y = 0>
    <cfif y eq 0>
        <cfthrow
            message="I am an Error"
            type="specialError"
            detail="This is where I put extra detail">        
    </cfif>
    <cfset result = x / y>
    <cfoutput>#result#<br/></cfoutput>
<cfcatch type="specialError">
    <cfoutput >
            #cfcatch.message# <br/>
        </cfoutput>

</cfcatch>
<cfcatch type="specialError">
    <cfoutput >
            #cfcatch.message#212 <br/>
        </cfoutput>

</cfcatch>
<cfcatch type="any">
    <cfoutput >
            any error<br/>
        </cfoutput>
</cfcatch>

<cffinally>
    Always I will run<br/>
</cffinally>
</cftry>

--->


<cftry>
    <cftry>
        <cfif 1 eq 1>
            <cfthrow type="normal" message="1 is equals to 1">
        </cfif>        
        <cfcatch type="any">
                    Inner catch: <br/>
        </cfcatch>
        <cfcatch type="normal">
            <cfoutput >
              Inner try: #cfcatch.message#<br/>              
            </cfoutput>            
        </cfcatch>

    </cftry>

    <cfif 2 eq 2>
        <cfthrow message="2 equals to 2" type="normal">       
    </cfif>
    <cfcatch type="normal">
            <cfoutput >
              Outer try: #cfcatch.message#<br/>              
            </cfoutput>
        </cfcatch>
</cftry>
