<cfset lists1 = "ama1, ama2, ama13, ama4">

<cfloop list= "#lists1#" index="i">
    <cfoutput>#i#</br> </cfoutput>
</cfloop>
</br>
<cfscript>
listLen(lists1)



lists1 = listAppend(lists1, "ama5");

lists1 = listPrepend(lists1, "ama0");

lists1 = listInsertAt(lists1, "3", "amaHello");
</cfscript>
<cfoutput>#listContains(lists1, "ama4")#</cfoutput>

<cfoutput>#listContainsNoCase(lists1, "amA4")#</cfoutput>

<cfset arr = listToArray(lists1)>
<cfscript>
for(i = 1;i <= arrayLen(arr);i++) {
    writeOutput("#arr[i]# </br>")
}



</cfscript>

<cfloop array="#arr#" index="i">
    <cfoutput >
            array #i#<br/>
        </cfoutput>
</cfloop>

<cfset lists2 = "2$3$5$$$3">

<cfoutput>#listAvg(lists2, "$")#</cfoutput>

<cfoutput>#listChangeDelims(lists2, ",", "$")#</cfoutput>

<cfoutput>#lists2#</cfoutput>

<cfset lists2 = listCompact(lists2, "$")>
<cfoutput>#lists2#</cfoutput>

<cfoutput>#listDeleteAt(lists2, 2, "$")# </cfoutput>

<cfoutput></br>#lists2#</cfoutput>

<cfscript>
    function display(name)    {
        writeOutput("</br>" & name & " </br>");
    }
    //runs function for every item
    listEach(lists1, display)
    

    function isEven(num)    {
        return num % 2 == 0;
    }
    num = "1,2,3,4,5"
    //Returns true if all items satisfy condition.
    writeOutput(listEvery(num, isEven))

    writeOutput(" " & listSome(num, isEven))

    writeOutput(" " & listFind(lists1, "ama0")) //FindNoCase listFirstAt

    writeOutput(" " & listGetAt(num, 3));

    writeOutput(" " & listIndexExists(num, 7));

    writeOutput(" " & listLast(num));

    writeOutput(" " & listSetAt(num, 1, 8));

    writeOutput(" " & listFirst(num));

    writeOutput(" " & listRest(num));

    writeOutput(" " & listRemoveDuplicates(num));

    writeOutput(" " & listFilter(num, isEven));

    function increaseBy10(ele, ele2)  {
        return ele + ele2;
    }

    writeOutput(" " & listMap(num, increaseBy10));

    writeOutput("</br>" & listReduce(num, increaseBy10, 0));

    function concat(acc, x) {
        return acc & x;
    }
    // below isn't working
    // writeOutput("</br>" & listReduceRight(lists1, concat, ""));

    list3 = "               w        ,,             t           ,  a            ";

    writeOutput("</br>" & list3)
    writeOutput("</br>" & listItemTrim(list3));
    //below doesn't work    
    list3 = listTrim(list3)
    writeOutput("</br>" & listSort(num, "numeric", "desc"));

    writeOutput("</br>" & listSort(lists1, "text", "desc"));
    
    writeOutput("</br>" & listValueCount(lists1, "ama10"));

    writeOutput("</br>" & listValueCountNoCase(lists1, "AMA0"));

    writeOutput("</br>" & listQualify(lists1, "'", ","));


</cfscript>

<cfquery name="q" datasource="sqlserverDSN">
    SELECT 'A' AS col UNION SELECT 'B' UNION SELECT 'C'
</cfquery>

<cfoutput></br>#quotedValueList(q.col)#</cfoutput>

<cfoutput></br>#valueList(q.col)#</cfoutput>

<cfset colors = "red,green,blue">
<cfoutput></br>#replaceList(colors, "red,blue", "pink,cyan")#</cfoutput>

<cfset colors = "Red,Green,Blue">
<cfoutput></br>#replaceListNoCase(colors, "red,blue", "pink,cyan")#</cfoutput>

<cfset s = {name="Amaresh", age=30, city="Pune"}>
<cfoutput></br>#structKeyList(s)#</cfoutput>

<cfscript>
    arr = listToArray(colors);
</cfscript>
