
<style>
    .ecom-header .header {
        background:#ffffff;
        padding:14px 40px;
        display:flex;
        align-items:center;
        justify-content:space-between;

        position:fixed;
        width:95%;
        top:0;
        left:0;
        z-index:1000;

        border-bottom:1px solid #e5e7eb;
        box-shadow:0 4px 10px rgba(0,0,0,0.05);
    }

    /* LEFT SECTION */
    .header-left {
        display:flex;
        align-items:center;
        gap:15px;
    }

    .logo {
        color:#2563eb;
        font-size:20px;
        font-weight:700;
    }

    /* NAVBAR CENTER */
    .navbar {
        display:flex;
        gap:25px;
        align-items:center;
    }

    .navbar a {
        color:#374151;
        text-decoration:none;
        font-size:14px;
        font-weight:500;
        padding:6px 4px;
        transition:0.2s;
    }

    .navbar a:hover {
        color:#2563eb;
    }

    /* RIGHT SECTION */
    .header-right {
        display:flex;
        align-items:center;
        gap:15px;
    }

    /* BACK BUTTON (now subtle + clean) */
    .back-btn {
        background:#f3f4f6;
        color:#374151;
        border:none;
        padding:8px 14px;
        border-radius:8px;
        font-size:13px;
        cursor:pointer;
        transition:0.2s;
    }

    .back-btn:hover {
        background:#e5e7eb;
    }

    /* LOGOUT BUTTON (highlight action) */
    .logout-btn {
        background:#ef4444;
        color:white;
        padding:8px 14px;
        border-radius:8px;
        text-decoration:none;
        font-size:13px;
        font-weight:500;
    }

    .logout-btn:hover {
        background:#dc2626;
    }
</style>

<div class="ecom-header">
    <div class="header">

        <!-- LEFT -->
        <div class="header-left">
            <div class="logo">EcommerceOSS</div>

            
        </div>

        <!-- CENTER NAV -->
        <div class="navbar">

            <cfif structKeyExists(session,"role") AND session.role EQ "admin">
                <a href="/EcommerceOSS/admin/dashboard.cfm">Dashboard</a>
                <a href="/EcommerceOSS/admin/addAdmin.cfm">Add Admin</a>
                <a href="/EcommerceOSS/admin/orders.cfm">Orders</a>
                <a href="/EcommerceOSS/admin/categories.cfm">Categories</a>
                <a href="/EcommerceOSS/admin/products.cfm">Products</a>
                <a href="/EcommerceOSS/admin/inventoryLogs.cfm">Inventory Logs</a>
            </cfif>

            <cfif structKeyExists(session,"role") AND session.role EQ "user">
                <a href="/EcommerceOSS/customer/dashboard.cfm">Home</a>
                <a href="/EcommerceOSS/customer/myOrders.cfm">My Orders</a>
                <a href="/EcommerceOSS/customer/profile.cfm">Profile</a>
                <!---<a href="/EcommerceOSS/customer/checkout.cfm">Checkout</a>--->
            </cfif>

        </div>

        <!-- RIGHT -->
        <div class="header-right">
            <button class="back-btn" onclick="history.back()">
                 Back
            </button>

            <a href="/EcommerceOSS/logout.cfm" class="logout-btn">
                Logout
            </a>
        </div>

    </div>
</div>