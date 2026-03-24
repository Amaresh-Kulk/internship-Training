<form action="" method="post">
    Total Items taken by customer: <input type="number" name="totalItems"><br/>
    <input type="submit">
</form>

<cfif structKeyExists(form,"totalItems")>
    <cfquery name="fetchCustomerRecords" datasource="sqlserverdsn">
        select c.*, o.totalItems from customer c
        inner join orderTable o
        on c.id = o.customer_id
        where o.totalItems >= #form.totalItems#;         
    </cfquery>

    <cfoutput query="fetchCustomerRecords">
        #id#: #first_name#: #totalItems#<br/>        
    </cfoutput>
</cfif>