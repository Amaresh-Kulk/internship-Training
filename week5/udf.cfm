<cfscript>
    session.func1 = 2;
    function func1(a, b)    {
        writeOutput(1 & "<br/>");
        //return 1;
    }
    function func2(a = 3)   {
        writeOutput(a & "2<br/>");
        //return "str";
    }

    func1(1,2);
    func2();

</cfscript>

<cffunction name="addItem" returntype="void">
    <cfargument name="arr" type="array">

    <cfset ArrayAppend(arr, "CFML")>
</cffunction>

<cfset myArray = ["Java", "SQL"]>
<cfset addItem(myArray)>
<cfdump var="#myArray#">




<cffunction name="sort">
    <cfargument name="arr" type="array" required="true">
    <cfargument name="left" type="numeric" required="true">
    <cfargument name="mid" type="numeric" required="true">
    <cfargument name="right" type="numeric" required="true">
    
    <cfset leftLen = mid - left + 1>
    <cfset rightLen = right - mid>
    <cfset leftArray = arrayNew(1)>
    <cfset rightArray = arrayNew(1)>

    <cfloop from="1" to="#leftLen#" index="i">
        <cfset arrayAppend(leftArray, arr[left + i - 1])>
    </cfloop>

    <cfloop from="1" to="#rightLen#" index="i">
        <cfset arrayAppend(rightArray, arr[mid + i ])>
    </cfloop>

    <cfset i = 1>
    <cfset j = 1>
    <cfset k = left>
    <!--- <cfdump var="#leftArray#" >
    <cfdump var="#rightArray#" >--->
    <cfloop condition="i lte leftLen and j lte rightLen">
        <cfif (leftArray[i] lte rightArray[j])>
            <cfset arr[k] = leftArray[i]>
            <cfset k = k + 1>
            <cfset i = i + 1>
        <cfelse>
            <cfset arr[k] = rightArray[j]>
            <cfset k = k + 1>
            <cfset j = j + 1>
        </cfif>
    </cfloop>
    <cfloop condition="i lte leftLen">
        <cfset arr[k] = leftArray[i]>
        <cfset k = k + 1>
        <cfset i = i + 1>      
    </cfloop>

    <cfloop condition="j lte rightLen">
        <cfset arr[k] = rightArray[j]>
        <cfset k = k + 1>
        <cfset j = j + 1>      
    </cfloop>
</cffunction>

<cffunction name="mergesort" >
    <cfargument name="arr" type="array" required="true">
    <cfargument name="left" type="number" required="true">
    <cfargument name="right" type="number" required="true">

    <cfif left lt right>
        <cfset mid = int((right + left) / 2)>
        <cfset mergesort(arr, left, mid)>
        <cfset mergesort(arr, mid + 1, right)>
        <cfset sort(arr, left, mid, right)>
    </cfif>
</cffunction>

<cfset arr = arrayNew(1)>
<cfscript>
    arrayAppend(arr, 1);
    arrayAppend(arr, 5);
    arrayAppend(arr, 2);
    arrayAppend(arr, 7);
    arrayAppend(arr, 10);
    arrayAppend(arr, 6);
    arrayAppend(arr, 11);
    mergesort(arr, 1, arrayLen(arr));
    mergesort(arr, 1, arrayLen(arr));
    writeDump(arr);
</cfscript>

<cffunction name="addAandB">
    <cfargument name="a" type="number" required="true">
    <cfargument name="b" type="number" required="true">

    <cfreturn a + b>

</cffunction>

<cfoutput >
    #addAandB(1, 3)#
    <cfset app = new Application()>
    #app.square(3)#
</cfoutput>

<cffunction name="giveDiscount" >
    <cfargument name="price" type="number" required="true">
    <cfset var discount = 0.10>

    <cfset var discountedPrice = price - discount * price>

    <cfreturn discountedPrice>

</cffunction>

<form action="" method="post">
    <input type="number" name="price" required>
    <input type="submit">
</form>

<cfoutput >
    <cfif structKeyExists(form,"price")>
        #giveDiscount(form.price)#
    </cfif>
    
</cfoutput>

