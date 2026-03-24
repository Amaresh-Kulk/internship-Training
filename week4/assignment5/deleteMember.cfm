<style>
    body {
        font-family: Arial, sans-serif;
    }

    form {
        width: 300px;
        margin: 50px auto;
        border: 1px solid #ccc;
        padding: 20px;
        border-radius: 8px;
        text-align: center;
    }

    label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
    }

    input[type="number"] {
        width: 100%;
        padding: 8px;
        margin-bottom: 15px;
        border-radius: 5px;
        border: 1px solid #aaa;
    }

    input[type="submit"] {
        padding: 8px 15px;
        border: none;
        background-color: #d9534f;
        color: white;
        border-radius: 5px;
        cursor: pointer;
    }

    input[type="submit"]:hover {
        background-color: #c9302c;
    }
    .error  {
        margin: 15px auto;
        width: 360px;
        background: #ffffff;
        color: #c62828;
        border: 1px solid #f5c6cb;
        padding: 10px 12px;
        border-radius: 6px;
        text-align: center;
        font-weight: 600;
    }
    .success{
        margin: 15px auto;
        width: 360px;
        background: #a58080;
        color: #faf6f6;
        border: 1px solid #f5c6cb;
        padding: 10px 12px;
        border-radius: 6px;
        text-align: center;
        font-weight: 600;
    }
</style>
<cfinclude template="header.cfm" >

<form action="" method="post">
    <label>ID of Member</label>
    <input type="number" name="id2" required>
    <input type="submit" value="Delete Member">
</form>

<cfif structKeyExists(form,"id2")>
    <cftry>
        <cfstoredproc procedure="proc_DeleteMembers" datasource="library" >
            <cfprocparam cfsqltype="CF_SQL_INTEGER" value="#form.id2#">
            <cfprocparam cfsqltype="CF_SQL_BIT" type="out" variable="isIdExists">
        </cfstoredproc>
        <!---
        <cfquery name="deleteMember" result="deleteResult" datasource="library">
            DELETE FROM Members
            WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.id2#">
        </cfquery>
        <cfdump var="#deleteResult#">
    --->
        <cfif isIdExists neq 1>
            <cfoutput>
                <div class="error"> ID does not exists</div>   
            </cfoutput>
        <cfelse>
            <cfoutput>
                <div class="success">Record ID: #form.id2# Deleted Successfully.</div>   
            </cfoutput>
        </cfif>
        <cfcatch>
            <div style="color:red; text-align:center;">Enter only numeric value</div>
        </cfcatch>
    </cftry>
</cfif>


<script>
    window.onload = function()   {
        let err = document.querySelector(".error");
        if(err) {
            setTimeout(() => {
                err.remove(); 
                window.location = "deleteMember.cfm";  
            }, 5000); 
        }

        let succ = document.querySelector(".success");
        if(succ)    {
            setTimeout(() =>    {
                succ.remove();
                window.location = "deleteMember.cfm";
            }, 5000);
        }
    }
</script>