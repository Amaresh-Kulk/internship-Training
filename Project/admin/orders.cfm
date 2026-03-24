<cfif structKeyExists(form,"updateStatus")>

    <cfquery datasource="storedb">
        UPDATE Orders
        SET StatusID =
        <cfqueryparam value="#form.newStatus#" cfsqltype="cf_sql_integer">
        WHERE id =
        <cfqueryparam value="#form.orderID#" cfsqltype="cf_sql_integer">
    </cfquery>

    <cflocation url="orders.cfm" addtoken="false">

</cfif>



<cfif structKeyExists(form,"generateOTP")>

    <cfset newOTP = randRange(100000,999999)>


    <cfquery datasource="storedb">
    UPDATE Orders
    SET OTP =
    <cfqueryparam value="#newOTP#" cfsqltype="cf_sql_varchar">
    WHERE id =
    <cfqueryparam value="#form.orderID#" cfsqltype="cf_sql_integer">
    </cfquery>


    <cfquery name="getCustomerEmail" datasource="securitydb">
        SELECT email
        FROM Users
        WHERE id =
        <cfqueryparam value="#form.customerID#" cfsqltype="cf_sql_integer">
    </cfquery>


    <cfmail
    to="#getCustomerEmail.email#"
    from="noreply@store.com"
    subject="Delivery OTP"
    server="smtp.yopmail.com"
    port="25"
    type="html">

        Your delivery OTP is: <b>#newOTP#</b><br><br>
        Please provide this OTP to confirm delivery.

    </cfmail>

    <cflocation url="orders.cfm" addtoken="false">

</cfif>




<cfparam name="form.orderID" default="">
<cfparam name="form.customerName" default="">
<cfparam name="form.statusID" default="">
<cfparam name="form.payment" default="">
<cfparam name="form.startDate" default="">
<cfparam name="form.endDate" default="">



<cfquery name="statuses" datasource="storedb">
    SELECT *
    FROM OrderStatus
</cfquery>



<cfquery name="orders" datasource="storedb">

    SELECT 
    o.*,
    os.orderName,
    u.name as customerName

    FROM Orders o

    INNER JOIN OrderStatus os 
    ON os.id = o.StatusID

    INNER JOIN SecurityDB.dbo.Users u
    ON u.id = o.CustomerID

    WHERE 1=1

    <cfif len(trim(form.orderID))>
        AND o.id =
        <cfqueryparam value="#form.orderID#" cfsqltype="cf_sql_integer">
    </cfif>

    <cfif len(trim(form.customerName))>
        AND u.name LIKE
        <cfqueryparam value="%#form.customerName#%" cfsqltype="cf_sql_varchar">
    </cfif>

    <cfif len(trim(form.statusID))>
        AND o.StatusID =
        <cfqueryparam value="#form.statusID#" cfsqltype="cf_sql_integer">
    </cfif>

    <cfif len(trim(form.payment))>
        AND o.Payment =
        <cfqueryparam value="#form.payment#" cfsqltype="cf_sql_varchar">
    </cfif>

    <cfif len(trim(form.startDate))>
        AND o.OrderDate >=
        <cfqueryparam value="#form.startDate#" cfsqltype="cf_sql_date">
    </cfif>

    <cfif len(trim(form.endDate))>
        AND o.OrderDate <=
        <cfqueryparam value="#form.endDate#" cfsqltype="cf_sql_date">
    </cfif>

    ORDER BY o.OrderDate DESC

</cfquery>



<!DOCTYPE html>
<html>

<head>

<title>Order Management</title>

<style>

    body{
    font-family:'Segoe UI';
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
    margin-bottom:25px;
    }

    .filters{
    display:flex;
    gap:12px;
    flex-wrap:wrap;
    }

    input,select{
    padding:8px;
    border:1px solid #d1d5db;
    border-radius:6px;
    }

    button{
    background:#2563eb;
    color:white;
    border:none;
    padding:8px 14px;
    border-radius:6px;
    cursor:pointer;
    }

    button:hover{
    background:#1e40af;
    }

    table{
    width:100%;
    border-collapse:collapse;
    }

    th{
    background:#f3f4f6;
    }

    th,td{
    padding:12px;
    border-bottom:1px solid #e5e7eb;
    text-align:center;
    }

    .badge{
    padding:4px 10px;
    border-radius:20px;
    color:white;
    font-size:12px;
    }

    .pending{
        background:#f59e0b;
    }
    .shipped{
        background:#2563eb;
    }
    .delivery{
        background:#6366f1;
    }
    .delivered{
        background:#16a34a;
    }

</style>

</head>


<body>

<cfinclude template="../includes/header.cfm">

<div class="container">

<h2>Order Management</h2>



<div class="card">

<table>

<tr>

<th>Order ID</th>
<th>Customer</th>
<th>Total</th>
<th>Payment</th>
<th>Status</th>
<th>Date</th>
<th>Action</th>

</tr>


<cfoutput query="orders">

<tr>

<td>#id#</td>

<td>#customerName#</td>

<td>Rs. #TotalAmount#</td>

<td>#Payment#</td>

<td>

<cfif orderName EQ "Pending">
<span class="badge pending">Pending</span>
</cfif>

<cfif orderName EQ "Shipped">
<span class="badge shipped">Shipped</span>
</cfif>

<cfif orderName EQ "Out for Delivery">
<span class="badge delivery">Out for Delivery</span>
</cfif>

<cfif orderName EQ "Delivered">
<span class="badge delivered">Delivered</span>
</cfif>

</td>

<td>#dateFormat(OrderDate,"dd mmm yyyy")#</td>


<td>


<cfif StatusID EQ 1>

<form method="post">

<input type="hidden" name="orderID" value="#id#">
<input type="hidden" name="newStatus" value="2">
<input type="hidden" name="updateStatus" value="1">

<button type="submit">
Mark Shipped
</button>

</form>

</cfif>




<cfif StatusID EQ 2>

<form method="post">

<input type="hidden" name="orderID" value="#id#">
<input type="hidden" name="newStatus" value="3">
<input type="hidden" name="updateStatus" value="1">

<button type="submit">
Out for Delivery
</button>

</form>

</cfif>




<cfif StatusID EQ 3>

<form method="post">

<input type="hidden" name="orderID" value="#id#">
<input type="hidden" name="customerID" value="#CustomerID#">
<input type="hidden" name="generateOTP" value="1">

<button type="submit">
Generate OTP
</button>

</form>

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