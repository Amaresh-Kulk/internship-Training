<cfset news = queryNew("id, title", "integer, varchar")>
<cfset queryAddRow(news)>
<cfset querySetCell(news, "id","1")>
<cfset querySetCell(news, "title", "Trump puts tarrifs on India")>
<cfset queryAddRow(news)>
<cfset querySetCell(news, "id", "2")>
<cfset querySetCell(news, "title", "India wins bilateral series")>
<cfset writeDump(news)>


<cfquery name="sortedNews" dbtype="query">
    select id, title from news
    order by title desc
</cfquery>

<cfdump var="#sortedNews#" >



<cfset player = queryNew("id, name", "integer, varchar")>
<cfset queryAddRow(player)>
<cfset querySetCell(player, "id", "1")>
<cfset querySetCell(player, "name", "Yuvaraj")>
<cfset queryAddRow(player)>
<cfset querySetCell(player, "id", "2")>
<cfset querySetCell(player, "name", "Abhishek")>
<cfset writeDump(player)>

<cfquery name="sortedPlayer" dbtype="query">
    select Id, name from player
    order by name
</cfquery>

<cfdump var="#sortedPlayer#" >

<form action="" method="post">
    <input type="text" name="id" required>
    <input type="submit">
</form>

<!---<cfif structKeyExists(form,"name")>

<cfquery name="checkName" dbtype="query">
    select * from player
    where name = <cfqueryparam value="#form.name#" sqltype="cf_sql_varchar">
</cfquery>
--->
<cfif structKeyExists(form, "id")>
    <cftry>
        <cfquery name="checkID" dbtype="query">
            select * from player
            where id = <cfqueryparam value="#id#" sqltype="cf_sql_int">
        </cfquery>
        <cfloop query="checkID">
            <cfoutput> #id#: #name#<br/></cfoutput>
        </cfloop>
    <cfcatch>
        <cfoutput><h1>Invalid input</h1></cfoutput>
    </cfcatch>
    </cftry>
</cfif>

<form action="" method="post">
    <input type="text" name="id1">
    <input type="submit">
</form>


<cfif structKeyExists(form, "id1")>
    <cfquery name="checkTopic" dbtype="query">
        select * from news
        where id in (<cfqueryparam value="#form.id1#" sqltype="cf_sql_integer" list="true">)
    </cfquery>

    <cfloop query="checkTopic">
        <cfoutput>
            #id#: #title#            
        </cfoutput>
    </cfloop>
</cfif>

<!---<cfdbinfo type="columns" name="cols" table=""> --->

<!---<cfdbinfo type="tables" datasource="sqlserverdsn" name="tablesInfo">

<cfdump var="#tablesInfo#" >
--->
<cfdbinfo type="columns" name="cols" table="abcd" datasource="sqlserverdsn">
<cfdump var="#cols#" >  
<cfoutput query="cols">
    <br/>#cols.column_name#: #type_name#<br/>
</cfoutput>

<cfdbinfo type="Columns" name="cols2" table="CustomeR" datasource="sqlserverdsn"> <!---doesn't allow dbtype --->
<cfoutput query="cols2">
    #cols2.column_name#: cols2.type_name<br/>
</cfoutput>


<form action="" method="post">
    <input type="number" name="id">
    <input type="text" name="a_name">
    <input type="submit">
</form>
<cfif structKeyExists(form,"id") and structkeyExists(form, "a_name")>
    <cfinsert datasource="sqlserverdsn" tablename="abcd" >
</cfif>


<form action="" method="post">
    <input type="number" name="id">
    <input type="text" name="first_name">
    <input type="submit">
</form>

<cfif structKeyExists(form,"id") and structKeyExists(form, "first_name")>
    <cfupdate 
        datasource="sqlserverdsn"
        tablename="customer"
        formfields="form.id, form.first_name">
</cfif>

<h1>  Stored Procedure  </h1>
<form action="" method="post">
    <input type="number" name="id">
    <input type="submit">
</form>

<cfif structKeyExists(form, "id")>
    <cfstoredproc procedure="proc_getCustomer" datasource="sqlserverdsn" >
        <cfprocparam cfsqltype="CF_SQL_INTEGER" type="in" value="#form.id#">
        <cfprocresult name="cust" >
    </cfstoredproc>

    <cfdump var="#cust#" >
    <cfoutput query="cust">
        #id#: #first_name#</br>
    </cfoutput>
</cfif>

<form action="" method="post">
    <input type="number" name="id">
    <input type="number" name="totalPrice">
    <input type="submit">
</form>

<cfif structKeyExists(form, "id") and structKeyExists(form, "totalPrice")>
    <cfstoredproc procedure="proc_getTotalPrice" datasource="sqlserverdsn" >
        <cfprocparam cfsqltype="CF_SQL_INTEGER" type="in" value="#form.id#">
        <cfprocparam cfsqltype="cf_sql_integer" type="in" value="#form.totalPrice#" >
        <cfprocresult name="getTotalPrice" >
    </cfstoredproc>
    <cfdump var="#getTotalPrice#" >
    <cfoutput query="getTotalPrice">
            #customer_id#: #first_name# : #totalPrice#<br/>
    </cfoutput>
</cfif>

<form action="" method="post">
    <input type="text" name="first_name">
    <input type="text" name="middle_name">
    <input type="text" name="last_name">
    <input type="submit">
</form>

<cfif structKeyExists(form,"first_name") and structKeyExists(form, "middle_name") and structKeyExists(form,"last_name")>
    <cfstoredproc procedure="proc_addCustomer" datasource="sqlServerdsn" >
        <cfprocparam type="in" value="#form.first_name#" cfsqltype="cf_sql_varchar">
        <cfprocparam type="in" value="#form.middle_name#" cfsqltype="cf_sql_varchar">
        <cfprocparam type="in" value="#form.last_name#" cfsqltype="cf_sql_varchar">
        <cfprocparam type="out" variable="newCustomerId" cfsqltype="cf_sql_integer" >
    </cfstoredproc>

    <cfoutput >
            new ID: #newCustomerId#<br/>
            #structClear(form)#
            #structDelete(form, "first_name")#
    </cfoutput>
    
</cfif>

<form action="" method="post">
    <input type="number" name="id">
    <input type="submit">
</form>

<cfif structKeyExists(form,"id")>
    <cfstoredproc procedure="proc_increment" datasource="sqlserverdsn" >
        <cfprocparam cfsqltype="CF_SQL_INTEGER" type="inout" value="#form.id#" variable="result_id">
    </cfstoredproc>
        
    <cfoutput >
        given id: #form.id#, incremented id: #result_id#<br/>
    </cfoutput>
</cfif>

<form action="" method="post">
    <input type="number" name="customer_id">
    <input type="number" name="order_id">
    <input type="submit">
</form>

<cfif structKeyExists(form, "customer_id") and structKeyExists(form,"order_id")>
    <cfstoredproc procedure="proc_display_orders_customers" datasource="sqlserverdsn" >
        <cfprocparam cfsqltype="CF_SQL_INTEGER" value="#form.customer_id#">
        <cfprocparam cfsqltype="CF_SQL_INTEGER" value="#form.order_id#">
        <cfprocresult name="customer" resultset="1">
        <cfprocresult name="order" resultset="2">
    </cfstoredproc>

    <cfoutput query="customer">
        #first_name#, #middle_name#, #last_name#<br/>        
    </cfoutput>

    <cfoutput query="order">
        #totalItems#, #totalPrice#, #purchased_date#<br/>        
    </cfoutput>
</cfif>

<cfquery datasource="sqlserverdsn">
    create or alter procedure proc_deleteRecord
        @id int
    as
    begin
        select * from customer where id = @id
        delete from Customer where id = @id
    end
</cfquery>

<form action="" method="post">
    <input type="number" name="id">
    <input type="submit">
</form>

<cfif structKeyExists(form,"id")>
    <cfstoredproc procedure="proc_deleteRecord" datasource="sqlserverdsn" >
        <cfprocparam cfsqltype="CF_SQL_INTEGER" value="#form.id#">
        <cfprocresult name="deletedRecord" resultset="1">
    </cfstoredproc>

    <cfoutput query="deletedrecord">
            #id#, #first_name#, #middle_name#, #last_name#<br/> 
    </cfoutput>
</cfif>
<cfdump var="#form#" >

<!---
<cfquery name="returnProc" datasource="sqlserverdsn">
    create or alter procedure proc_record_exists
        @id int
    as
    begin
        if exists (select 1 from customer where id = @id)
            return 1;
        else
            return 0;
    end
</cfquery>

<form action="" method="post">
    <input type="number" name="id1" placeholder="enter id">
    <input type="submit">
</form>

<cfif structKeyExists(form, "id1")>
    <cfstoredproc procedure="proc_record_exists" datasource="sqlserverdsn" result="isExists">
        <cfprocparam cfsqltype="cf_sql_integer" value="#form.id1#">
        <!---<cfprocparam cfsqltype="cf_sql_integer" type="return" variable="isExists" > --->
    </cfstoredproc>

    <cfoutput >
            <cfdump var="#isExists#"><br/>
        </cfoutput>
</cfif>

--->

<cfquery name="qname" datasource="sqlserverdsn" result="info">
    select * from customer;
</cfquery>

<cfdump var="#qname#" >
<cfdump var="#info#" >