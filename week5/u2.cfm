<cfset obj = createObject("component", "user2")>
<cfset obj.nowIsGood()>

<cfset obj2 = createObject("component", "practiceWeek5.user")>
<!---<cfset obj2.isGood()>--->

<!---<cfset obj2.isBad()>--->
<!---<cfset obj2.isAverage()>--->

<cfinvoke  method="isBad" component="practiceWeek5/user.cfc">
<cfinvoke  method="isBad" component="practiceWeek5/user.cfc">
<cfinvoke  method="isBad" component="practiceWeek5/user.cfc">
<!---<cfinvoke  method="isGood" component="practiceWeek5/user.cfc">--->
<!---<cfinvoke method="isAverage" component="practiceWeek5/user.cfc" >--->
