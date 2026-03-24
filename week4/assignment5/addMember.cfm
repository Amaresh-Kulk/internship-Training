<style>
    body {
        font-family: Arial, sans-serif;
    }

    form {
        width: 350px;
        margin: 50px auto;
        border: 1px solid #ccc;
        padding: 20px;
        border-radius: 8px;
    }

    h1 {
        text-align: center;
    }

    .row {
        margin-bottom: 15px;
    }

    label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }

    input[type="text"] {
        width: 100%;
        padding: 8px;
        border-radius: 5px;
        border: 1px solid #aaa;
    }

    input[type="submit"] {
        width: 100%;
        padding: 10px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    input[type="submit"]:hover {
        background-color: #45a049;
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
        background: #9f7272;
        color: #efefef;
        border: 1px solid #f5c6cb;
        padding: 10px 12px;
        border-radius: 6px;
        text-align: center;
        font-weight: 600;
    }
    .required{
        color:red;
        display:inline;
    }
</style>

<cfinclude template="header.cfm" >

<form action="" method="post">
    <h1>Add a Member</h1>

    <div class="row">
        <label>First Name <div class="required">(*required)</div></label>
        <input type="text" name="first_name" required>
    </div>

    <div class="row">
        <label>Middle Name</label>
        <input type="text" name="middle_name">
    </div>

    <div class="row">
        <label>Last Name</label>
        <input type="text" name="last_name">
    </div>

    <input type="submit" value="Add Member">
</form>

<cfif structKeyExists(form,"first_name")>
    <cfset isValid = true>
    
    <cfif !reFind("^[A-Za-z]+$", trim(form.first_name))>
        <cfset isValid = false>
    </cfif>

    
    <cfif len(trim(form.middle_name))>
        <cfif !reFind("^[A-Za-z]+$", trim(form.middle_name))>
            <cfset isValid = false>
        </cfif>
    </cfif>

    
    <cfif len(trim(form.last_name))>
        <cfif !reFind("^[A-Za-z]+$", trim(form.last_name))>
            <cfset isValid = false>
        </cfif>
    </cfif>
    <cfif isValid>
        <cfset form.date_joined = now()>
        <!---<cfinsert tablename="Members" datasource="library">--->
        <cfstoredproc procedure="proc_AddMember" datasource="library" >
            <cfprocparam cfsqltype="cf_sql_varchar" value="#form.first_name#">
            <cfprocparam cfsqltype="cf_sql_varchar" value="#form.middle_name#">
            <cfprocparam cfsqltype="cf_sql_varchar" value="#form.last_name#">
            <cfprocparam cfsqltype="cf_sql_date" value="#form.date_joined#">
        </cfstoredproc>
        <cfset structClear(form)>
        <!---<cflocation url="addMember.cfm" addtoken="false"> --->
        <div class="success"> Record added Successfully.</div>  

    <cfelse>
        <cfoutput>
            <div class="error"> Give valid filed entries</div>  
             
        </cfoutput>
            
    </cfif>

    
</cfif>


<script>
    window.onload = function()   {
        let err = document.querySelector(".error");
        if(err) {
            setTimeout(() => {
                err.remove();
                window.location =
                "addMember.cfm";    
            }, 5000);
            
        }
        let succ = document.querySelector(".success");
        if(succ) {
            setTimeout(() => {
                succ.remove();
                window.location =
                "addMember.cfm";    
            }, 5000);
            
        }
        
    }
</script>