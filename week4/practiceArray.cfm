<cfset arr1 = [1, 2, 3, 4]>
<cfset arr2 = arrayNew(1)>
<cfoutput >
    #arrayAppend(arr2, 2)#
    #arrayAppend(arr2, 1)#
    #arrayAppend(arr2, 5)#
    #arrayAppend(arr2, 2)#
    #arrayAppend(arr2, 4.3)#
    #arrayAvg(arr2)#
    <cfdump var="#arr2#">
    #arraySort(arr2, "numeric","asc")#
    <cfloop array="#arr2#" index="i">
        #i#<br/>        
    </cfloop>
    <!---#arrayGetMetadata(arr2)#--->   
    #arrayInsertAt(arr2, 1, 99)#
    <cfdump var="#arr2#">

</cfoutput>


<cfset MyArray = arrayNew(1)> 
 <!--- Resize that array to the number of records in the query. ---> 
 <cfset temp = arrayResize(MyArray, 8)> 
  <cfdump var="#MyArray#" />  
<cfset list2 = arrayToList(arr2, " ")>
<cfdump var="#list2#" >

<cfset arr2D = arrayNew(2)>

<cfset arr1 = [1, 2, 3, 4]>
<cfset arr2 = [5, 6, 7, 8]>
<cfset arrayAppend(arr2D, arr1)>
<cfset arrayAppend(arr2D, arr2)>
<cfdump var="#arr2D#" >

<cfset i = 1>
<cfloop condition="i lte arrayLen(arr2D)">
    <cfset j = 1>
    <cfloop condition="j lte arrayLen(arr2D[i])">
        <cfoutput >
            #arr2D[i][j]#           
        </cfoutput>       
        <cfset j = j + 1>
    </cfloop>
    <cfset i = i + 1>
    <br/>
</cfloop>