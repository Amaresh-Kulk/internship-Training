
<cfif NOT structKeyExists(session, "isLoggedIn") OR NOT session.isLoggedIn>
    <cflocation url="login.cfm" addtoken="false">
</cfif>

<cfset emp = createObject("component", "Employees")>
<cfset employeeList = emp.getAllEmployees()>

<style>
    .page-title {
        text-align: center;
        margin-top: 20px;
        font-family: Arial, sans-serif;
    }

    .employee-table {
        width: 80%;
        margin: 30px auto;
        border-collapse: collapse;
        font-family: Arial, sans-serif;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    .employee-table th {
        background-color: #333;
        color: white;
        padding: 10px;
        text-align: left;
    }

    .employee-table td {
        padding: 8px;
        border: 1px solid #ddd;
    }
    .employee-table tr:hover {
        background-color: #e6e6e6;
    }
</style>

<cfoutput>
    <h2 class="page-title">All Employees</h2>

    <table class="employee-table">
        <tr>
            <th>No.</th>
            <th>Name</th>
            <th>Position</th>
            <th>Department</th>
            <th>Phone</th>
        </tr>
        <cfset count = 1>
        <cfloop query="employeeList">
            <tr>
                <td>#count#</td>
                <cfset count = count + 1>
                <td>#name#</td>
                <td>#position#</td>
                <td>#department#</td>
                <td>#phone_number#</td>
            </tr>
        </cfloop>

    </table>
</cfoutput>
