<cfset user = createObject("component", "UserService")>

<cfoutput>#user.sayHello()#<br/></cfoutput>
<cfoutput>#user.logAction("hello")#<br/></cfoutput>
<!---<cfoutput>#user.format("hello")#<br/></cfoutput>
--->
<cfset user2 = createObject("component", "privateUser")>
<cfoutput>#user2.logAction("sample message")#</cfoutput>
<!---<cfoutput>#user2.formatMessage("sample message")#</cfoutput>
--->