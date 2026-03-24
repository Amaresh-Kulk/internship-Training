<cfset user = createObject("component", "UserService").init("library")>
<cfdump var="#user#" >
<cfoutput> #user.logAction("Amaresh123")# </cfoutput>