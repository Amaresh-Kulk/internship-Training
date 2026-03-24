<cfdbinfo name="databaseInfo" type="DBNames" datasource="library">
<cfdump var="#databaseInfo#" >
<!---
<cfdbinfo type="Procedures" datasource="library" name="proceInfo" >
<cfdump var="#proceInfo#" >

<cfdbinfo type="Tables" datasource="library" name="tablesInfo">
<cfdump var="#tablesInfo#" >
<!---<cfoutput query="#tablesInfo#">
--->
</cfoutput> --->
<!---<cfset form.first_name = 'Radha'>
<cfset form.last_name= 'Pande'>
<cfset form.date_joined = '2025-11-11'>
<form action="" method="post">
    <input type="text" name="first_name">
    <input type="submit">
</form>

<cfset form.first_name = 'Kamal'>
<cfset form.last_name = 'Pande'>
<cfif structKeyExists(form, "first_name")>
    <cfset form.date_joined = now()>
    <cfinsert tablename="Members" datasource="library" formfields="first_name, date_joined">
    
</cfif>
--->
<cfset list1="222!203!202">
<cfquery name="n123" datasource="library" result="abcd">
    select * from Members
    where id in (<cfqueryparam cfsqltype="cf_sql_int" value="#list1#" list="true" separator="!">);
</cfquery>
<cfdump var="#abcd#" >

<cfloop query="#n123#">
    <cfoutput >
            #first_name#<br/>
        </cfoutput>
</cfloop>

<cfset form.id = 222>
<cfset form.last_name = 'Pande'>
<cfupdate tablename="Members" datasource="library" 
        formfields="id,last_name">

<cfstoredproc procedure="p_select" datasource="library" >
    <cfprocparam cfsqltype="cf_sql_int" value="201" type="in">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="first_name" type="out">
    <cfprocresult name="result1" resultset="1">
</cfstoredproc>

<cfdump var="#first_name#" >
<cfdump var="#result1#" >