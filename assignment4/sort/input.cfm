<form action="" method="post" class="sort-form">
    <label>Enter values (comma separated):</label><br>
    <input type="text" name="nums" placeholder="6,5,2,9,7" required>
    <br><br>
    <input type="submit" value="Submit">
</form>

<style>
    .sort-form {
        background: #f9f9f9;
        padding: 12px;
        border-radius: 6px;
        display: inline-block;
    }

    .sort-form input {
        padding: 6px;
        margin-top: 6px;
        border: 1px solid #bbb;
        border-radius: 4px;
    }

    .sort-form input[type="submit"] {
        background: #4CAF50;
        color: white;
        border: none;
        cursor: pointer;
    }

    .sort-form input[type="submit"]:hover {
        background: #45a049;
    }

    .box {
        margin: 20px auto;
        padding: 15px;
        border: 1px solid #ccc;
        border-radius: 6px;
        width: fit-content;
        text-align: center;
        background: #f9f9f9;
    }

    h3 {
        margin-bottom: 5px;
    }
</style>

<cfif structKeyExists(form, "nums")>

    <cfset input = replace(trim(form.nums), " ", "", "all")>
    <cfset arr = listToArray(input, ",", true)>
    <cfset n = arrayLen(arr)>
    <cfset resultHTML = "">

    <cfloop from="1" to="#n#" index="i">
        <cfif isNumeric(arr[i])>
            <cfset resultHTML &= arr[i] & " -> Number<br>">
        <cfelse>
            <cfset resultHTML &= arr[i] & " -> Character<br>">
        </cfif>
    </cfloop>

    <cfset resultHTML &= "<br><strong>Sorted Result</strong><br>">

    <cfloop from="1" to="#n-1#" index="i">
        <cfloop from="1" to="#n-i#" index="j">
            <cfif asc(arr[j]) GT asc(arr[j+1])>
                <cfset temp = arr[j]>
                <cfset arr[j] = arr[j+1]>
                <cfset arr[j+1] = temp>
            </cfif>
        </cfloop>
    </cfloop>

    <cfloop from="1" to="#arrayLen(arr)#" index="i">
        <cfset resultHTML &= arr[i] & " ">
    </cfloop>

    <cfset session.sort = resultHTML>

</cfif>

<cfif structKeyExists(session, "sort")>
    <cfoutput>
        <div class="box">#session.sort#</div>
    </cfoutput>
</cfif>
