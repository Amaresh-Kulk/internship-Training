<cfset customerID = session.userID>


<!-- CUSTOMER EMAIL -->

<cfquery name="getCustomer" datasource="securitydb">
    SELECT email,name
    FROM Users
    WHERE id =
        <cfqueryparam value="#customerID#" cfsqltype="cf_sql_integer">
</cfquery>

<cfset customerEmail = getCustomer.email>
<cfset customerName = getCustomer.name>



<!-- GET ADMIN EMAILS -->

<cfquery name="getAdmins" datasource="securitydb">
    SELECT email
    FROM Users
    WHERE roleID = 1
</cfquery>

<cfset adminEmails="">
<cfloop query="getAdmins">
    <cfset adminEmails=listAppend(adminEmails,email)>
</cfloop>



<!-- CANCEL ORDER -->


<cfif structKeyExists(form,"cancelOrder")>

    <!-- Restore stock -->

    <cfquery name="orderItems" datasource="storedb">
        SELECT ProductID, Quantity
        FROM OrderItems
        WHERE orderID =
            <cfqueryparam value="#form.orderID#" cfsqltype="cf_sql_integer">
    </cfquery>

    <cfloop query="orderItems">

        <cfquery datasource="storedb">
            UPDATE Products
            SET Quantity = Quantity +
                <cfqueryparam value="#Quantity#" cfsqltype="cf_sql_integer">
            WHERE id =
                <cfqueryparam value="#ProductID#" cfsqltype="cf_sql_integer">
        </cfquery>

    </cfloop>


    <!-- Delete order items -->

    <cfquery datasource="storedb">
        DELETE FROM OrderItems
        WHERE orderID =
            <cfqueryparam value="#form.orderID#" cfsqltype="cf_sql_integer">
    </cfquery>


    <!-- Delete order -->

    <cfquery datasource="storedb">
        DELETE FROM Orders
        WHERE id =
            <cfqueryparam value="#form.orderID#" cfsqltype="cf_sql_integer">
    </cfquery>


    <cflocation url="myOrders.cfm" addtoken="false">

</cfif>


<!-- VERIFY OTP -->

<cfif structKeyExists(form,"verifyOTP")>

    <cfquery name="checkOTP" datasource="storedb">
        SELECT OTP
        FROM Orders
        WHERE id =
            <cfqueryparam value="#form.orderID#" cfsqltype="cf_sql_integer">
    </cfquery>

    <cfif checkOTP.OTP EQ trim(form.enteredOTP)>

        <cfquery datasource="storedb">
            UPDATE Orders
            SET StatusID = 4
            WHERE id =
                <cfqueryparam value="#form.orderID#" cfsqltype="cf_sql_integer">
        </cfquery>

        <cflocation url="myOrders.cfm" addtoken="false">

    <cfelse>

        <cfset errorMsg="Invalid OTP">

    </cfif>

</cfif>



<!-- SEND FEEDBACK -->

<cfif structKeyExists(form,"submitFeedback")>

    <cfmail
        to="#adminEmails#"
        from="noreply@store.com"
        subject="Customer Feedback - Order #form.orderID#"
        server="smtp.yopmail.com"
        port="25"
        type="html">

        Customer: #customerName# <br>
        Email: #customerEmail# <br>
        Order ID: #form.orderID# <br>
        Rating: #form.rating# / 5 <br><br>

        Feedback:<br>
        #form.comments#

    </cfmail>

    <cfset successMsg="Thank you for your feedback!">

</cfif>



<!-- GET ORDERS -->

<cfquery name="getOrders" datasource="storedb">
    SELECT o.*, os.orderName
    FROM Orders o
    INNER JOIN OrderStatus os
    ON os.id=o.StatusID
    WHERE o.CustomerID =
        <cfqueryparam value="#customerID#" cfsqltype="cf_sql_integer">
    ORDER BY o.OrderDate DESC
</cfquery>



<!DOCTYPE html>
<html>

<head>

    <title>My Orders</title>

    <style>

        body{
        font-family:'Segoe UI';
        background:#f4f6f9;
        margin:0;
        }

        .container{
        width:90%;
        margin:20px auto;
        }

        .order-card{
        background:white;
        padding:25px;
        border-radius:16px;
        margin-bottom:30px;
        box-shadow:0 8px 25px rgba(0,0,0,0.05);
        }

        .order-header{
        display:flex;
        justify-content:space-between;
        margin-bottom:15px;
        }

        .status-bar{
        display:flex;
        justify-content:space-between;
        margin:25px 0;
        }

        .step{
        flex:1;
        text-align:center;
        font-size:13px;
        color:#9ca3af;
        }

        .circle{
        width:28px;
        height:28px;
        border-radius:50%;
        background:#e5e7eb;
        display:inline-flex;
        align-items:center;
        justify-content:center;
        margin-bottom:5px;
        font-weight:600;
        }

        .active{
        color:#16a34a;
        font-weight:600;
        }

        .active .circle{
        background:#16a34a;
        color:white;
        }

        button{
        background:#2563eb;
        color:white;
        padding:8px 14px;
        border:none;
        border-radius:6px;
        cursor:pointer;
        }

        .cancel{
        background:#dc2626;
        }

        input,select,textarea{
        padding:8px;
        border:1px solid #ddd;
        border-radius:6px;
        }

        .items-table{
        width:100%;
        border-collapse:collapse;
        margin-top:15px;
        }

        .items-table th{
        background:#f3f4f6;
        }

        .items-table th,td{
        padding:10px;
        border-bottom:1px solid #eee;
        text-align:left;
        }

        .message{
        color:red;
        margin-bottom:10px;
        }

        .success{
        color:green;
        margin-bottom:10px;
        }

        .feedback{
        margin-top:20px;
        padding-top:15px;
        border-top:1px solid #eee;
        }

    </style>

</head>



<body>

    <cfinclude template="../includes/header.cfm">

    <div class="container">

        <h2>My Orders</h2>


        <cfif structKeyExists(variables,"errorMsg")>
            <div class="message"><cfoutput>#errorMsg#</cfoutput></div>
        </cfif>

        <cfif structKeyExists(variables,"successMsg")>
            <div class="success"><cfoutput>#successMsg#</cfoutput></div>
        </cfif>



        <cfset count = 1>

        <cfoutput query="getOrders">

            <div class="order-card">

                <div class="order-header">

                    <div>
                        <strong>Order #count#</strong><br>
                        <cfset count = count + 1>
                        Date: #dateFormat(OrderDate,"dd mmm yyyy")#
                    </div>

                    <div>
                        Total: Rs. #TotalAmount#<br>
                        Status: #orderName#
                    </div>

                </div>



                <!-- STATUS PROGRESS -->

                <div class="status-bar">

                    <div class="step <cfif StatusID GTE 1>active</cfif>">
                        <div class="circle">1</div>
                        Pending
                    </div>

                    <div class="step <cfif StatusID GTE 2>active</cfif>">
                        <div class="circle">2</div>
                        Shipped
                    </div>

                    <div class="step <cfif StatusID GTE 3>active</cfif>">
                        <div class="circle">3</div>
                        Out for Delivery
                    </div>

                    <div class="step <cfif StatusID EQ 4>active</cfif>">
                        <div class="circle">4</div>
                        Delivered
                    </div>

                </div>



                <!-- ORDER ITEMS -->

                <cfquery name="orderItems" datasource="storedb">
                    SELECT oi.*,p.ProductName
                    FROM OrderItems oi
                    INNER JOIN Products p
                    ON p.id = oi.ProductID
                    WHERE oi.orderID =
                        <cfqueryparam value="#id#" cfsqltype="cf_sql_integer">
                </cfquery>

                <table class="items-table">
                    <tr>
                        <th>Product</th>
                        <th>Quantity</th>
                        <th>Unit Price</th>
                        <th>Total</th>
                    </tr>

                    <cfloop query="orderItems">

                        <tr>
                            <td>#ProductName#</td>
                            <td>#Quantity#</td>
                            <td>Rs. #unitPrice#</td>
                            <td>Rs. #Quantity * unitPrice#</td>
                        </tr>

                    </cfloop>

                </table>



                <!-- CANCEL ORDER -->

                <cfif StatusID EQ 1>

                    <form method="post" style="margin-top:15px;">
                        <input type="hidden" name="orderID" value="#id#">
                        <input type="hidden" name="cancelOrder" value="1">

                        <button class="cancel">
                            Cancel Order
                        </button>

                    </form>

                </cfif>



                <!-- OTP VERIFICATION -->

                <cfif StatusID EQ 3>

                    <h4>Enter Delivery OTP</h4>

                    <form method="post">

                        <input type="hidden" name="orderID" value="#id#">

                        <input type="text"
                        name="enteredOTP"
                        placeholder="Enter OTP"
                        required>

                        <input type="hidden"
                        name="verifyOTP"
                        value="1">

                        <button type="submit">
                            Verify OTP
                        </button>

                    </form>

                </cfif>



                <!-- FEEDBACK -->

                <cfif StatusID EQ 4>

                    <div class="feedback">

                        <h4>Send Feedback</h4>

                        <form method="post">

                            <input type="hidden" name="orderID" value="#id#">

                            <label>Rating</label><br>

                            <select name="rating" required>

                                <option value="">Select</option>
                                <option value="5"> Excellent</option>
                                <option value="4"> Good</option>
                                <option value="3"> Average</option>
                                <option value="2"> Poor</option>
                                <option value="1">Bad</option>

                            </select>

                            <br><br>

                            <textarea name="comments"
                            placeholder="Write your feedback"
                            style="width:100%;height:70px;"></textarea>

                            <br><br>

                            <button name="submitFeedback">
                                Send Feedback
                            </button>

                        </form>

                    </div>

                </cfif>


            </div>

        </cfoutput>

    </div>

    <cfinclude template="../includes/footer.cfm">

</body>
</html>