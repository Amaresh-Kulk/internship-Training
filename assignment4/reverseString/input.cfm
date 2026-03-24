<form action="" method="post" class="rev-form">
    <input type="text" name="rev_str" placeholder="Enter a string" required>
    <input type="submit" value="Reverse">
</form>
<!--- <cfset var1 = this>
<cfdump var="#var1#" label="Scope: This"> --->

<style>
    .rev-form {
        background: #f9f9f9;
        padding: 12px;
        border-radius: 6px;
        display: inline-block;
    }

    .rev-form input {
        padding: 6px 8px;
        margin: 4px;
        border: 1px solid #bbb;
        border-radius: 4px;
    }

    .rev-form input[type="submit"] {
        background: #4CAF50;
        color: white;
        border: none;
        cursor: pointer;
    }

    .rev-form input[type="submit"]:hover {
        background: #45a049;
    }

    .box {
        background: #f9f9f9;
        padding: 12px;
        border-radius: 6px;
        border: 1px solid #ccc;
        width: fit-content;
        margin: 20px auto;
        text-align: center;
    }
</style>

<cfif structKeyExists(form, "rev_str")>

    <cfset inputString = trim(form.rev_str)>

    <cfif isNumeric(inputString)>
        <cfset session.reverse = inputString & " is a number">
    <cfelse>
        <cfset rev = "">
        <cfset right = len(inputString)>

        <cfloop from="#right#" to="1" step="-1" index="i">
            <cfset rev &= mid(inputString, i, 1)>
        </cfloop>

        <cfset session.reverse = "After Reverse: " & rev>
    </cfif>

</cfif>

<cfif structKeyExists(session, "reverse")>
    <cfoutput>
        <div class="box">#session.reverse#</div>
    </cfoutput>
</cfif>
