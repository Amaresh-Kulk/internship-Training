<cfquery name="logs" datasource="storedb">

    SELECT 
    l.*,
    u.name,
    p.ProductName

    FROM InventoryLogs l

    LEFT JOIN SecurityDB.dbo.Users u
    ON u.id = l.adminID

    LEFT JOIN Products p
    ON p.id = l.productID

    ORDER BY actionTime DESC

</cfquery>


<!DOCTYPE html>
<html>

<head>

    <title>Inventory Logs</title>

    <style>

        body{
        font-family:'Segoe UI',sans-serif;
        background:#eef2f7;
        margin:0;
        }

        .container{
        width:92%;
        margin:70px auto;
        }

        .card{
        background:white;
        padding:25px;
        border-radius:12px;
        box-shadow:0 5px 18px rgba(0,0,0,0.08);
        }

        table{
        width:100%;
        border-collapse:collapse;
        }

        th{
        background:#f3f4f6;
        font-weight:600;
        }

        th,td{
        padding:12px;
        border-bottom:1px solid #e5e7eb;
        text-align:center;
        font-size:14px;
        }

        .badge{
        padding:4px 10px;
        border-radius:20px;
        font-size:12px;
        font-weight:600;
        color:white;
        }

        .add{background:#16a34a;}
        .update{background:#2563eb;}
        .delete{background:#dc2626;}

        .time{
        color:#6b7280;
        font-size:13px;
        }

    </style>

</head>


<body>

    <cfinclude template="../includes/header.cfm">

    <div class="container">

        <h2>Inventory Logs</h2>

        <div class="card">

            <table>

                <tr>
                    <th>Product</th>
                    <th>Admin</th>
                    <th>Action</th>
                    <th>Description</th>
                    <th>Date</th>
                    <th>Time</th>
                </tr>

                <cfoutput query="logs">

                    <tr>

                        <td>#ProductName#</td>

                        <td>#name#</td>

                        <td>

                            <cfif actionType EQ "ADD">
                                <span class="badge add">ADD</span>
                            </cfif>

                            <cfif actionType EQ "UPDATE">
                                <span class="badge update">UPDATE</span>
                            </cfif>

                            <cfif actionType EQ "DELETE">
                                <span class="badge delete">DELETE</span>
                            </cfif>

                        </td>

                        <td>#description#</td>

                        <td>
                            <cfif isDate(actionTime)>
                                #dateFormat(actionTime,"dd mmm yyyy")#
                            <cfelse>
                                -
                            </cfif>
                        </td>

                        <td class="time">
                            <cfif isDate(actionTime)>
                                #timeFormat(actionTime,"hh:mm tt")#
                            <cfelse>
                                -
                            </cfif>
                        </td>

                    </tr>

                </cfoutput>

            </table>

        </div>

    </div>

    <cfinclude template="../includes/footer.cfm">

</body>
</html>