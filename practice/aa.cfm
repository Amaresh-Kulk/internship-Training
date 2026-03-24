<cftry>

    <cfmail to="grofafroinneitro-5835@yopmail.com" 
    from="chaitunomula1@gmail.com" 
    subject="Welcome to Bedrock" 
    type="text"> 
    Dear hello 
    We would like to thank you for joining. 
    Best wishes 
    Chaitanya 
</cfmail> 
<cfoutput> 
    <p>Thank you  for registering. 
        We have just sent you an email.</p> 
    </cfoutput> 
    <cfcatch>
        <cfdump var=#cfcatch#/>
    </cfcatch>
</cftry>