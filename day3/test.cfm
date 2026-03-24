<cfinclude template="../folder1/test2.cfm">

<cfset var1 = 1>
<cfparam name = "var2" default = 0 type= "numeric">
<cfset age = 20>
<cfset firstName = "Karl">
<cfset  lastName = "Johnson">
<cfset checkAddition = lastName & 1>
<cfset add = 1 && 1>
<cfscript>
    if(age > 18)    {
        writeOutput("Person is Adult");
        //<h1> Adult </h1>
    }
    else   {writeOutput("Person is Teen");}

    color = "red";

    fullName = firstName & " " & lastName

    
    
</cfscript>

<cfoutput>
    Greetings: #getGreeting("John")# </br>

   </br> Using Try: 
    </br>
    <cftry>
        #var1 / var2#
        
    <cfcatch>
    can't divide by 0</br>
    </cfcatch>
    </cftry>

    </br>
    Implementing if else statements:
    </br>
    <cfset age = 20>
    Age is #age#. </br>
    </br>The persion is 
    <cfif age gte 18>
        Adult
    <cfelseif age gte 12>
        Minor
    <cfelse>
        Todler

    </cfif>
    </br>
    </br>Implementing switch</br>
    <cfswitch expression="#color#">
        <cfcase value="red">
            color is red
        </cfcase>
        <cfcase value="blue">
            color is blue
        </cfcase>
    
    </cfswitch>
    </br>

    <h3> String concatination</h3>
    <p>Full Name is: #fullName#<p>
    <p>Addition: #checkAddition# </p>
    <p> Addition 2: #add#</p>

    <cfset age = 18>
    #IIf(age EQ 18, "Yes", "No")# 


</cfoutput>

<cfoutput>#age EQ 18#</cfoutput>
