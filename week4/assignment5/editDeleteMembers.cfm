<cfif structKeyExists(form, "deleteId")>
    <cfquery datasource="library">
        DELETE FROM Members
        WHERE id = <cfqueryparam value="#form.deleteId#" cfsqltype="cf_sql_integer">
    </cfquery>
</cfif>

<cfif structKeyExists(form, "updateId")>
    <cfset isValid = true>
    <cfif structKeyExists(form, "first_name")>
        <cfif not (reFind("^[A-Za-z]+$",form.first_name))>
            <cfset isValid = false>
        </cfif>
    </cfif>

    <cfif structKeyExists(form, "middle_name")>
        <cfif not (reFind("^[A-Za-z]*$",form.middle_name) or(form.middle_name == ""))>
            <cfset isValid = false>
        </cfif>
    </cfif>

    <cfif structKeyExists(form, "last_name")>
        <cfif not (reFind("^[A-Za-z]+$",form.last_name) or (form.last_name == ""))>
            <cfset isValid = false>
        </cfif>
    </cfif>

    <cfif not isValid>
        <script>
            alert("Please enter only letters in name fields!");
        </script>
    </cfif>

    <cfquery datasource="library">
        UPDATE Members
        SET
            first_name = <cfqueryparam value="#form.first_name#" cfsqltype="cf_sql_varchar">,
            middle_name = <cfqueryparam value="#form.middle_name#" cfsqltype="cf_sql_varchar">,
            last_name = <cfqueryparam value="#form.last_name#" cfsqltype="cf_sql_varchar">
        WHERE id = <cfqueryparam value="#form.updateId#" cfsqltype="cf_sql_integer">
    </cfquery>
</cfif>


<cfset editId = "">
<cfif structKeyExists(url, "editId")>
    <cfset editId = url.editId>
</cfif>


<cfquery name="showMembers" datasource="library">
    SELECT * FROM Members ORDER BY date_joined;
</cfquery>

<html>
<head>
    <style>
        body { 
            font-family: Arial,sans-serif;
        }
        table {
            border-collapse: collapse;
            width: 80%;
            margin: 40px auto;
        }
        th, td {
            border: 1px solid #aaa;
            padding: 8px;
            text-align: center;
        }
        th { 
            background-color: #f2f2f2;
        }
        input[type=text] {
             width: 90%; 
        }
        .btn { 
            padding: 4px 8px;
            cursor: pointer;
        }
        form    {
            display:inline;
        }
    </style>
</head>

<body>
<cfinclude template="header.cfm">

<table>
    <tr>
        <th>SI</th>
        <th>First Name</th>
        <th>Middle Name</th>
        <th>Last Name</th>
        <th>Date Joined</th>
        <th>Actions</th>
    </tr>
<cfset count = 1>
<cfoutput query="showMembers">
    <cfif editId EQ id>
        
        <form method="post" action="editDeleteMembers.cfm">
        <tr>
            <td>#count#</td>
            <cfset count = count + 1>
            <td><input type="text" name="first_name" value="#first_name#"></td>
            <td><input type="text" name="middle_name" value="#middle_name#"></td>
            <td><input type="text" name="last_name" value="#last_name#"></td>
            <td>#dateFormat(date_joined, "dd-mmm-yyyy")#</td>
            <td>
                <input type="hidden" name="updateId" value="#id#">
                <input type="submit" value="Save" class="btn">
                <a href="editDeleteMembers.cfm">Cancel</a>
            </td>
        </tr>
        </form>
    <cfelse>
        
        <tr>
            <td>#count#</td>
            <cfset count = count + 1>
            <td>#first_name#</td>
            <td>#iif(!len(trim(middle_name)), "'---'", "middle_name")#</td>
            <td>#iif(!len(trim(last_name)), "'---'", "last_name")#</td>
            <td>#dateFormat(date_joined, "dd-mmm-yyyy")#</td>
            <td>
                
                <form method="get" action="editDeleteMembers.cfm" >
                    <input type="hidden" name="editId" value="#id#">
                    <input type="submit" value="Edit" class="btn">
                </form>

                
                <form method="post" action="editDeleteMembers.cfm" >
                    <input type="hidden" name="deleteId" value="#id#">
                    <input type="submit" value="Delete" class="btn"
                           onclick="surecheck()">
                </form>
            </td>
        </tr>
    </cfif>
</cfoutput>

</table>
</body>
</html>



<script>
    function surecheck()    {
        return confirm('Are you sure?');
    }
</script>