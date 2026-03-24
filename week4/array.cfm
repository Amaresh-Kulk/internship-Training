<cfscript>
    arr = ArrayNew(1)   
</cfscript>


<cfset arr[1] = "Apple">
<cfset arr[2] = "Banana">
<cfset arr[10] = "Mango">
<!--- <cfscript>
    
    function iterate(arr)  { 
        var i = 1;
        for(i in arr) {
            writeOutput(i & " <br/>");
        }  
    }
</cfscript>

--->

<cffunction name="iterate" returntype="void">
    <cfargument name="arr" type="array" required = "true">
    <cfloop collection="#arr#" index="i">
            <cfoutput >
                       #arr[i]# <br/>     
                        </cfoutput>
    </cfloop>
</cffunction>
     




<!---
<cfset i = 1>
<cfloop condition="i lte 10">
    <cfoutput >
            #arr[i]# <br/>
        </cfoutput>
    <cfset i = i + 1>
</cfloop>
--->

<cfscript>
    iterate(arr);
    arrayAppend(arr,"Pineapple");
    writeOutput("<br/>");
    iterate(arr);
    arr2 = [1, 2, 3, 4];
    writeOutput(arrayAvg(arr2) & "<br/>");

    temp = arr;
    arrayclear(arr);
    writeOutput(arrayLen(temp) & "<br/>");
    writeOutput("Length of arr:" & arrayLen(arr) & "<br/>");
    arrayPrepend(arr,"Guava");
    iterate(arr);
    arrayInsertAt(arr,2,"Pomegranade");
    iterate(arr);
    writeOutput(arrayContains(arr, "Apple") & "<br/>");
    writeOutput(arrayContains(arr, "Guava") & "<br/>");
    writeOutput(arrayContains(arr, "Pomegranade") & "<br/>"); //arrayContainisNoCase
    arrayDelete(arr, "Guava"); //arrayDeleteNoCase
    iterate(arr);
    iterate(temp);

    arrayAppend(arr,"Pineapple");
    arrayAppend(arr,"Apple");
    arrayAppend(arr,"Mango");

    arrayDeleteAt(arr, 3);
    iterate(arr);

    // arrayEach(arr)

    writeOutput(isArray(arr, 1) & "<br/>");
    writeOutput(isArray(arr, 2) & "<br/>");

    arrayEach(arr, function(item){
        writeOutput(item & "<br/>");
    });

    arrayEach(arr, function(value, index){
        writeOutput(index & ": " & value & "<br/>");
    });

    result = arrayEvery(arr, function(v){ //value, index
        return !isNumeric(arr);
    });
    writeOutput(result & "<br/>");


    nums = [1, 2, 3, 4, 5, 6];
    evens = arrayFilter(nums, function(v){ //value, index
        return v % 2 == 0;
    });

    writeDump(evens);

    arrayAppend(arr, "mango");
    writeOutput(arrayFind(arr, "Mango") & "<br/>");//arrayFindNoCase

    // res = arrayFindAll(arr, function(v){
    //   return v  == 'ManGo';   
    // });

    res = arrayFindAll(arr, "mango"); //arrayFindAllNoCase
    for(a in res)   {
        writeOutput(arr[a] & "<br/>");    
    }

    writeOutput(arrayFirst(arr) & "<br/>");
    writeOutput(arrayLast(arr) & "<br/>");
    res = arrayMid(arr, 2, 3);
    writeOutput(iterate(res) & "<br/>");

    // meta = arrayGetMetadata(arr) doesn't work
    // writeDump(meta);
    
    FirstArray = [1,2,3];
    secondArray = [11,12,13];
    combineArray = arrayNew(2);//2d array
    arrayAppend(combineArray, firstArray);
    arrayAppend(combineArray, secondArray);
    iterate(combineArray[2])
    writeOutput(arrayIsDefined(combineArray[2], 2) & "<br/>");//checks index is present or not
    arr3 = [1, 8, 3, 4];
    arraySort(arr3,"numeric");
    iterate(arr3);
    arraySort(arr,"text", "desc");
    iterate(arr);
</cfscript>