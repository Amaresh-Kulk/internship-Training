<cfquery name="totalUsers" datasource="EcommerceDB">
    SELECT COUNT(*) as total FROM Users WHERE roleID = 2
</cfquery>

<cfquery name="totalProducts" datasource="EcommerceDB">
    SELECT COUNT(*) as total FROM Products
</cfquery>

<cfquery name="totalOrders" datasource="EcommerceDB">
    SELECT COUNT(*) as total FROM Orders
</cfquery>

<cfquery name="totalRevenue" datasource="EcommerceDB">
    SELECT ISNULL(SUM(TotalAmount),0) as total FROM Orders WHERE StatusID = 4
</cfquery>

<!DOCTYPE html>
<html>

<head>

    <title>Admin Dashboard</title>

    <style>

        body{
        font-family:'Segoe UI', sans-serif;
        background:#f4f6f9;
        margin:0;
        }

        .container{
        width:90%;
        margin:70px auto;
        }

        .title{
        font-size:26px;
        font-weight:600;
        margin-bottom:25px;
        }

        .cards{
        display:grid;
        grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
        gap:20px;
        margin-bottom:40px;
        }

        .card{
        background:white;
        padding:25px;
        border-radius:14px;
        box-shadow:0 6px 20px rgba(0,0,0,0.06);
        transition:0.25s;
        }

        .card:hover{
        transform:translateY(-6px);
        box-shadow:0 10px 30px rgba(0,0,0,0.12);
        }

        .card-title{
        font-size:14px;
        color:#6b7280;
        margin-bottom:10px;
        }

        .card-value{
        font-size:28px;
        font-weight:700;
        color:#111827;
        }

        .actions{
        display:grid;
        grid-template-columns:repeat(auto-fit,minmax(200px,1fr));
        gap:20px;
        }

        .action-card{
        background:white;
        padding:20px;
        border-radius:12px;
        box-shadow:0 6px 18px rgba(0,0,0,0.05);
        }

        .action-card h3{
        margin:0 0 10px 0;
        font-size:18px;
        }

        .action-card a{
        display:block;
        margin-top:10px;
        padding:10px;
        background:#2563eb;
        color:white;
        text-decoration:none;
        border-radius:6px;
        text-align:center;
        font-size:14px;
        }

        .action-card a:hover{
        background:#1e40af;
        }

    </style>

</head>

<body>

    <cfinclude template="../includes/header.cfm">

    <div class="container">

        <div class="title">
            Admin Dashboard
        </div>


        <div class="cards">

            <div class="card">
                <div class="card-title">Total Customers</div>
                <div class="card-value">
                    <cfoutput>#totalUsers.total#</cfoutput>
                </div>
            </div>

            <div class="card">
                <div class="card-title">Total Products</div>
                <div class="card-value">
                    <cfoutput>#totalProducts.total#</cfoutput>
                </div>
            </div>

            <div class="card">
                <div class="card-title">Total Orders</div>
                <div class="card-value">
                    <cfoutput>#totalOrders.total#</cfoutput>
                </div>
            </div>

            <div class="card">
                <div class="card-title">Total Revenue</div>
                <div class="card-value">
                    Rs. <cfoutput>#totalRevenue.total#</cfoutput>
                </div>
            </div>

        </div>



        <div class="actions">

            <div class="action-card">
                <h3>Product Management</h3>
                Manage all products in your store.
                <a href="products.cfm">Manage Products</a>
            </div>

            <div class="action-card">
                <h3>Category Management</h3>
                Add or update product categories.
                <a href="categories.cfm">Manage Categories</a>
            </div>

            <div class="action-card">
                <h3>Orders</h3>
                View and manage customer orders.
                <a href="orders.cfm">View Orders</a>
            </div>

            <div class="action-card">
                <h3>Inventory Logs</h3>
                Track product updates and admin actions.
                <a href="inventoryLogs.cfm">View Logs</a>
            </div>

        </div>

    </div>

    <cfinclude template="../includes/footer.cfm">

</body>

<script>
    document.querySelector(".back-btn").style.display = "none";
</script>
</html>