<html>
<head>
    <title>CFML Conditional Statements Demo</title>
</head>
<body>

<h2>1. CFIF / CFELSEIF / CFELSE</h2>
<cfset marks = 78>

<cfif marks GTE 90>
    <cfoutput>Grade: A+</cfoutput><br>
<cfelseif marks GTE 75>
    <cfoutput>Grade: A</cfoutput><br>
<cfelseif marks GTE 60>
    <cfoutput>Grade: B</cfoutput><br>
<cfelse>
    <cfoutput>Grade: C</cfoutput><br>
</cfif>

<hr>

<h2>2. CFScript IF-ELSE</h2>
<cfscript>
age = 16;

if (age >= 18) {
    writeOutput("Status: Adult<br>");
} else {
    writeOutput("Status: Minor<br>");
}
</cfscript>

<hr>

<h2>3. CFSWITCH</h2>
<cfset day = "Friday">

<cfswitch expression="#day#">
    <cfcase value="Monday">
        <cfoutput>Start of the week</cfoutput><br>
    </cfcase>
    <cfcase value="Friday">
        <cfoutput>Almost weekend!</cfoutput><br>
    </cfcase>
    <cfcase value="Saturday,Sunday">
        <cfoutput>Weekend</cfoutput><br>
    </cfcase>
    <cfdefaultcase>
        <cfoutput>Midweek</cfoutput><br>
    </cfdefaultcase>
</cfswitch>

<hr>

<h2>4. Conditional Output</h2>
<cfset score = 45>

<cfif score GTE 50>
    <cfoutput>Result: Pass</cfoutput>
<cfelse>
    <cfoutput>Result: Fail</cfoutput>
</cfif>

</body>
</html>
