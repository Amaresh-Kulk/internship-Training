<cfset list1 = "apple,banana,apple,orange">
<!---
<cfdump var="#list1.listGetAt(2)#" >
<cfdump var="#listLen(list1, ",", "true")#" >
--->


<cfoutput >
    Using List<br/>
</cfoutput>

<cfset newList = "">

<cfloop list="#list1#" index="item">
    <cfif not listFind(newList, item)>
        <cfset newList = listAppend(newList, item)>        
    </cfif>
    
</cfloop>


<cfdump var="#newList#" >


<cfoutput >
    Using Array<br/>
</cfoutput>

<cfset arr = listToArray(list1)>

<cfset new_arr = []>

<cfloop array="#arr#" index="item">
    <cfif arrayFind(new_arr, item) eq 0>
        <cfset arrayAppend(new_arr, item)>        
    </cfif>
</cfloop>

<cfdump var="#new_arr#" >









<!---
<cfquery name="employees" datasource="dbemployees" result="resultemp">
    select * from Employees
    where employee_id = 1;
    
</cfquery>
<cfdump var="#resultemp#" >


<cfoutput query="employees">
    #employee_id#: #name#<br/>
</cfoutput>--->