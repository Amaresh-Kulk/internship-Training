<cfquery name="updateMember" datasource="library">
    update Members
    set #url.column# = <cfqueryparam cfsqltype="cf_sql_text" value="#url.value#">
    where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.id#">
</cfquery>

<cflocation url="updateMembers.cfm" addtoken="false">