<form action="" method="post" class="pal-form">
    <input type="text" name="str" placeholder="Enter a string" required>
    <input type="submit" value="Palindrome">
</form>

<style>
    .pal-form {
        background: #f9f9f9;
        padding: 12px;
        border-radius: 6px;
        display: inline-block;
    }

    .pal-form input {
        padding: 6px 8px;
        margin: 4px;
        border: 1px solid #bbb;
        border-radius: 4px;
    }

    .pal-form input[type="submit"] {
        background: #4CAF50;
        color: white;
        border: none;
        cursor: pointer;
    }

    .pal-form input[type="submit"]:hover {
        background: #45a049;
    }

    .box {
        background: #f9f9f9;
        padding: 15px;
        border-radius: 6px;
        border: 1px solid #ccc;
        width: fit-content;
        margin: 20px auto;
        text-align: center;
    }
</style>


<!--- <cfset var1 = #this#>
<cfset this.var1 = "abcd">
<cfdump var="#this.var1#"> --->
<!--- <cfdump var="#form#"> --->
<cfif structKeyExists(form, "str")>

    <cfset inputString = trim(form.str)>
    <cfset str = inputString>
    <cfset rev = "">
    <cfset right = len(str)>

    
    <cfloop from="#right#" to="1" step="-1" index="i">
        <cfset rev &= mid(str, i, 1)>
    </cfloop>

    <cfset isPalindrome = true>

    <cfloop from="1" to="#len(str)#" index="i">
        <cfif mid(str, i, 1) NEQ mid(rev, i, 1)>
            <cfset isPalindrome = false>
            <cfbreak>
        </cfif>
    </cfloop>

    <cfif isNumeric(inputString)>
        <cfset session.palindrome = inputString & " is a number">
    <cfelse>
        <cfif isPalindrome>
            <cfset session.palindrome = inputString & " is a palindrome">
        <cfelse>
            <cfset session.palindrome = inputString & " is not a palindrome">
        </cfif>
    </cfif>

</cfif>

<cfif structKeyExists(session, "palindrome")>
    <cfoutput>
        <div class="box">#session.palindrome#</div>
    </cfoutput>
</cfif>
