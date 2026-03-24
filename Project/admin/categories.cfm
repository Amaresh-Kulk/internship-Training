

<cfif structKeyExists(form,"action") AND form.action EQ "add">

    <cfquery datasource="storedb">

        INSERT INTO categories(categoryName)

        VALUES(
        <cfqueryparam value="#form.categoryName#" cfsqltype="cf_sql_varchar">
        )

    </cfquery>

    <cflocation url="categories.cfm" addtoken="false">

</cfif>




<cfif structKeyExists(form,"action") AND form.action EQ "update">

    <cfquery datasource="storedb">

        UPDATE categories

        SET categoryName =
        <cfqueryparam value="#form.categoryName#" cfsqltype="cf_sql_varchar">

        WHERE id =
        <cfqueryparam value="#form.categoryID#" cfsqltype="cf_sql_integer">

    </cfquery>

    <cflocation url="categories.cfm" addtoken="false">

</cfif>




<cfif structKeyExists(url,"deleteID")>

    <cfquery datasource="storedb">

        DELETE FROM categories

        WHERE id =
        <cfqueryparam value="#url.deleteID#" cfsqltype="cf_sql_integer">

    </cfquery>

    <cflocation url="categories.cfm" addtoken="false">

</cfif>




<cfquery name="getCategories" datasource="storedb">
    SELECT * FROM categories ORDER BY id DESC
</cfquery>



<!DOCTYPE html>
<html>

<head>

<title>Category Management</title>

<style>

    body{
    font-family:'Segoe UI',sans-serif;
    background:#f1f5f9;
    margin:0;
    }

    .container{
    width:92%;
    margin:70px auto;
    }

    .header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:25px;
    }

    .header h2{
    margin:0;
    font-size:26px;
    font-weight:600;
    color:#111827;
    }

    /* Buttons */

    button{
    background:#2563eb;
    color:white;
    border:none;
    padding:10px 18px;
    border-radius:8px;
    cursor:pointer;
    font-weight:600;
    font-size:14px;
    }

    button:hover{
    background:#1e40af;
    }

    .deleteBtn{
    background:#dc2626;
    padding:7px 12px;
    border-radius:6px;
    text-decoration:none;
    color:white;
    font-size:13px;
    }

    .deleteBtn:hover{
    background:#991b1b;
    }

    /* Cards */

    .card{
    background:white;
    padding:25px;
    border-radius:14px;
    box-shadow:0 10px 25px rgba(0,0,0,0.05);
    margin-bottom:30px;
    }

    /* Form */

    input{
    width:100%;
    padding:10px;
    border:1px solid #d1d5db;
    border-radius:8px;
    font-size:14px;
    }

    input:focus{
    outline:none;
    border-color:#2563eb;
    box-shadow:0 0 0 2px rgba(37,99,235,0.15);
    }

    /* Table */

    table{
    width:100%;
    border-collapse:collapse;
    font-size:14px;
    }

    th{
    background:#f3f4f6;
    font-weight:600;
    }

    th,td{
    padding:12px;
    border-bottom:1px solid #e5e7eb;
    text-align:center;
    }

    tr:hover{
    background:#f9fafb;
    }

    .actions{
    display:flex;
    gap:10px;
    justify-content:center;
    }

    .updateBtn{
    background:#16a34a;
    padding:7px 14px;
    }

    .updateBtn:hover{
    background:#166534;
    }

</style>

</head>


<body>

    <cfinclude template="../includes/header.cfm">

    <div class="container">


        <div class="header">

            <h2>Category Management</h2>

            <cfif structKeyExists(url,"add")>
                <a href="categories.cfm">
                    <button type="button">Cancel Category</button>
                </a>
            <cfelse>
                    <a href="categories.cfm?add=1">
                        <button type="button">Add Category</button>
                    </a>
            </cfif>

        </div>




        <cfif structKeyExists(url,"add")>

            <div class="card">

                <h3>Add New Category</h3>

                <form method="post">

                    <input type="hidden" name="action" value="add">

                    <input type="text" name="categoryName" placeholder="Category Name" required>

                    <br><br>

                    <button type="submit">
                        Add Category
                    </button>

                </form>

            </div>

        </cfif>




        <cfif NOT structKeyExists(url,"add")>

            <div class="card">

            <table>

                <tr>

                    <th>Category ID</th>
                    <th>Category Name</th>
                    <th>Actions</th>

                </tr>


                <cfoutput query="getCategories">

                    <form method="post">

                        <tr>

                            <td>#id#</td>

                            <td>
                                <input type="text" name="categoryName" value="#categoryName#" required>
                            </td>

                            <td>

                            <div class="actions">

                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="categoryID" value="#id#">

                                <button class="updateBtn" type="submit">
                                    Update
                                </button>

                                <a class="deleteBtn"
                                href="categories.cfm?deleteID=#id#"
                                onclick="return confirm('Delete this category?')">

                                    Delete

                                </a>

                            </div>

                            </td>

                        </tr>

                    </form>

                </cfoutput>

            </table>

            </div>

        </cfif>

    </div>

    <cfinclude template="../includes/footer.cfm">

</body>

</html>