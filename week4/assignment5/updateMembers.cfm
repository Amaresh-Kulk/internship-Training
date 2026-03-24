<cfquery name="showMembers" datasource="library">
    SELECT * FROM Members ORDER BY date_joined;
</cfquery>

<html>
<head>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #fafafa;
        }

        h1 {
            text-align: center;
        }

        table {
            border-collapse: collapse;
            width: 75%;
            margin: 20px auto;
            background: white;
        }

        th, td {
            /* border: 1px solid #ccc; */
            border-radius: 20px;
            padding: 8px 12px;
            text-align: center;

        }

        th {
            background-color: #eee;
        }

        /* Clickable columns */
        td.first_name,
        td.middle_name,
        td.last_name {
            cursor: pointer;
            color: blue;
        }

        td.first_name:hover,
        td.middle_name:hover,
        td.last_name:hover {
            background-color: #f0f8ff;
        }
    </style>
</head>

<body>
    <cfinclude template="header.cfm" >
    <h1>Update Entry (Click on a name)</h1>

    <table>
        <tr>
            <th>ID</th>
            <th>First Name</th>
            <th>Middle Name</th>
            <th>Last Name</th>
            <th>Date Joined</th>
        </tr>

        <cfoutput query="showMembers">
            <tr>
                <td class="id">#id#</td>
                <td class="first_name" onclick="editColumn(this)">#first_name#</td>
                <td class="middle_name" onclick="editColumn(this)">
                    <cfif len(trim(middle_name))>#middle_name#<cfelse>---</cfif>
                </td>
                <td class="last_name" onclick="editColumn(this)">
                    <cfif len(trim(last_name))>#last_name#<cfelse>---</cfif>
                </td>
                <td>#dateFormat(date_joined, "dd-mmm-yyyy")#</td>
            </tr>
        </cfoutput>
    </table>
</body>

<script>
function editColumn(cell) {
    let value = cell.innerText;
    let column = cell.className;
    let id = cell.closest("tr").querySelector(".id").innerText;
    let regex = /^[A-Za-z]+$/;
    let new_value = prompt("Enter new " + column + ": ");
    if (new_value != null && regex.test(new_value)) {
        cell.innerText = new_value;
        window.location =
            "updateQuery.cfm?id=" + encodeURIComponent(id) +
            "&column=" + encodeURIComponent(column) +
            "&value=" + encodeURIComponent(new_value);
    }   else    {
        alert("Only letters are allowed and can't enter empty string!");
    }
}
</script>
</html>
