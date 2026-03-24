<cfif NOT structKeyExists(session, "init")>
    <cfset session.init = true>
</cfif>

<cfset structDelete(session, "prime", false)>
<cfset structDelete(session, "reverse", false)>
<cfset structDelete(session, "palindrome", false)>
<cfset structDelete(session, "calculator", false)>
<cfset structDelete(session, "sort", false)>




<!DOCTYPE html>
<html>
<head>
    <title>CFML Assignment 4</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 20px;
        }

        h1 {
            text-align: center;
        }

        .container {
            max-width: 1000px;
            margin: auto;
        }

        .row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }

        .card {
            background: white;
            padding: 15px;
            border-radius: 6px;
            box-shadow: 0 0 5px rgba(0,0,0,0.1);
        }

        .card h2 {
            margin-top: 0;
            color: #333;
            border-bottom: 1px solid #ddd;
            padding-bottom: 5px;
        }

        .calci {
            margin: auto;
            width: 250px;
        }

    </style>
</head>

<body>
    <h1>CFML Assignment 4</h1>

    <div class="container">

        <!-- Row 1 -->
        <div class="row">
            <div class="card">
                <h2>Prime Number</h2>
                <cfinclude template="prime/input.cfm">
            </div>

            <div class="card">
                <h2>Reverse String</h2>
                <cfinclude template="reverseString/input.cfm">
            </div>
        </div>

        <!-- Row 2 -->
        <div class="row">
            <div class="card">
                <h2>Palindrome Check</h2>
                <cfinclude template="palindrome/input.cfm">
            </div>

            <div class="card">
                <h2>Sort Numbers</h2>
                <cfinclude template="sort/input.cfm">
            </div>
            
        </div>

        <!-- Row 3 -->
        <div class="card calci">
            <h2>Calculator</h2>
            <cfinclude template="calculator/input.cfm">
        </div>

    </div>
</body>
</html>

<!---<cfdump var="#session#"> --->