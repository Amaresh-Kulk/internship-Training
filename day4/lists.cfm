<cfset sample_list= "red,black,blue">

<cfoutput>
length:#listLen(sample_list)# </br>
<cfscript>
sample_list = #listAppend(sample_list, "purple")#
sample_list = #listPrepend(sample_list, "green")#
sample_list= #listInsertAt(sample_list, "2", "grey")#
arr = ListToArray(sample_list)


</cfscript>
looping through list:
<cfloop list="#sample_list#" index="i">
    </br>#i#
</cfloop>

</br>
#listContains(sample_list, "green1")#
#listContainsNoCase(sample_list, "Green")#

</br>

<cfloop from="1" to= "#arrayLen(arr)#" index="i">
    </br>#arr[i]#
</cfloop>
</br>

<cfset list2= ArrayToList(sample_list)>

looping through list2:
<cfloop list="#list2#" index="i">
    </br>#i#
</cfloop>
</cfoutput>