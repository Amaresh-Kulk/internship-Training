<cfset userService = new userService("library")>


<form action="" method="post">
    First Name:<input type="text" name="first_name">
    Middle Name:<input type="text" name="middle_name">
    Last Name: <input type="text" name="last_name">
    <input type="submit">
</form>

<cfif structKeyExists(form, "first_name")>
    <!---<cfset userService = createObject("component", "services.userService").init("library")>--->

    
    <cfset userService.addCustomer(form.first_name, form.middle_name, form.last_name)>
    
    

    
</cfif>


<form action="" method="post">
    ID:<input type="number" name="getId">
    <input type="submit">
</form>

<cfif structKeyExists(form,"getId")>

    <cftry>
        <cfoutput query="#userService.getCustomer(form.getId)#">
            #first_name#: #middle_name# : #last_name#<br/>        
        </cfoutput>
    <cfcatch>
        <cfoutput>
            ID #form.getId# not found <br/>            
        </cfoutput>
    </cfcatch>
    </cftry>

</cfif>

<form action="" method="post">
    ID:<input type="number" name="deleteId">
    <input type="submit">
</form>

<cfif structKeyExists(form, "deleteId")>
    <cftry>
        <cfset userService.deleteCustomer(form.deleteId)>
    <cfcatch>
            <cfoutput >
                ID #form.deleteId# not found<br/>                
            </cfoutput>
    </cfcatch>        
    </cftry>
    
</cfif>