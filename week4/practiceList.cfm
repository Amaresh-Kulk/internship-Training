<cfscript>
    arr1 = [1, 2, 3];
    
</cfscript>

<cfset list1 = arrayToList(arr1, "@")>
<cfdump var="#list1#" >
<cfset arr2 = listToArray(list1)>
<cfdump var="#arr2#" >
<cfoutput >
    <cfset list1 = listAppend(list1, "3,,", ",")> <!---default is true ---> 
    <cfdump var="#list1#">  
    #listAvg(list1, "@,")#
    <cfset list1 = listChangeDelims(list1,"!", "@,")>
    <cfdump var="#list1#" >
    <cfdump var="#listCompact("!a!!b!c!!d!", "!")#" >
    #listContains("a!b!c","b", "!")#<br/>
    #listEach(list1, function (val, idx, list1){
        writeOutput("#idx#:#val#<br/>");
    }, "!")#
    <cfset list2 = "a x, b ,    c">
    <cfdump var="#list2#">
    <cfdump var ="#listItemTrim(list2, " ,")#">
    #listLen(list2, " ,", true)#<br/>
    #listInsertAt(list1, 2, 4, "!")#
    <cfset list1 = listInsertAt(list1, 2, 4, "!")>
    <cfdump var="#list1#" >
</cfoutput>
<cfloop list="#list1#" index="i" delimiters=" !">
   <cfoutput >
        #i#<br/>
    </cfoutput> 
</cfloop>