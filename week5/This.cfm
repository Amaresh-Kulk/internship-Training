<cfset this.age = 25>
<cfset this.name = "Amaresh">
this:<cfdump var="#this#">

<cfset variables.age = 20>
<cfset variables.date = "2022-11-11">
variables:<cfdump var="#variables#" >

<cfset obj = new userService("library")>
<cfoutput >
    object:<cfdump var ="#obj.getThis()#">
</cfoutput>

<cfset obj2 = new userService("practiceDB1_0")>
<cfoutput >
    object:<cfdump var ="#obj2.getThis()#">
</cfoutput>