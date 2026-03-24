<cfset name = "amaresh">
<cfparam name="name" default="Sachin">

<cfoutput>#name#
</cfoutput>

<!--- <cfset arr= newArray()> --->

<cfset list1 = "1 2,3">

<cfoutput >
    #listLen(list1, " ,")#<br/>
</cfoutput>
<cfloop list="#list1#" index="i"  delimiters=" ,">
    <cfoutput>#i# <br/>
    </cfoutput>
</cfloop>

<cfquery name="name" datasource="practice1_1">
    select id, name from abcd
</cfquery>

<cfloop query="name">
    <cfoutput>#id# #name#</br> </cfoutput>
</cfloop>

<!---<cfswitch expression="">
    <cfcase value="">
        
    </cfcase>
    <cfcase value="">
    </cfcase>
    <cfcase value="">
    </cfcase>
    <cfdefault>
    </cfdefault>
</cfswitch>
--->
<cfset str="   I am Amaresh Kulkarni">

<cfoutput>
    lenght:#len(str)#<br/>
    find: #find("Amaresh", str)#<br/>
    findNocase: #findNoCase("AMARESH", str)#<br/>
    trim: <cfset str = trim(str)><br/>
    Replace: #replace(str, " ", "*", "all")# <br/>
    
</cfoutput>

<cfset person = {
    name = "Amaresh",
    age = 21
}>

<cfif isdefined("person.age")>
    <cfoutput> Age is present<br/>
    </cfoutput>
<cfelse>
    <cfoutput> Age is not present<br/>
    </cfoutput>
</cfif>

<cfif structKeyExists(person, "age")>
    <cfoutput> Age is present<br/>
    </cfoutput>
<cfelse>
    <cfoutput> Age is not present<br/>
    </cfoutput>
</cfif>


<cfif structKeyExists(person, "age") >
    <cfoutput> 
        <cfset local.thing = "eleven">
        
    </cfoutput>
<cfelse>
    <cfoutput> #local.thing#<br/>
    </cfoutput>

</cfif>
<cfoutput >
    #local.thing#
</cfoutput>
<cfdump var="#local#" >