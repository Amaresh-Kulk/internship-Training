
<cfset customerID = session.userID>



<cfquery name="getCustomer" datasource="customerdb">
    SELECT first_name,last_name
    FROM Customer
    WHERE id =
        <cfqueryparam value="#customerID#" cfsqltype="cf_sql_integer">
</cfquery>



<cfquery name="getCustomerEmail" datasource="securitydb">
    SELECT email
    FROM Users
    WHERE id =
        <cfqueryparam value="#customerID#" cfsqltype="cf_sql_integer">
</cfquery>



<cfquery name="getAdmins" datasource="securitydb">
    SELECT email
    FROM Users
    WHERE roleID = 1
</cfquery>

<cfset adminEmails = "">
<cfloop query="getAdmins">
    <cfset adminEmails = listAppend(adminEmails,email)>
</cfloop>


<cfquery name="getCart" datasource="storedb">
    SELECT id
    FROM Cart
    WHERE customerID =
        <cfqueryparam value="#customerID#" cfsqltype="cf_sql_integer">
</cfquery>

<cfif getCart.recordCount EQ 0>
    <cflocation url="dashboard.cfm" addtoken="false">
</cfif>

<cfset cartID = getCart.id>


<cfquery name="cartItems" datasource="storedb">
    SELECT ci.*,p.ProductName,p.Price
    FROM cartItems ci
    INNER JOIN Products p ON p.id = ci.ProductID
    WHERE ci.cartID =
        <cfqueryparam value="#cartID#" cfsqltype="cf_sql_integer">
</cfquery>

<cfset cartEmpty = (cartItems.recordCount EQ 0)>


<cfset grandTotal = 0>
<cfloop query="cartItems">
    <cfset grandTotal = grandTotal + (Price * Quantity)>
</cfloop>


<cfquery name="getAddresses" datasource="customerdb">
    SELECT *
    FROM Address
    WHERE customerID =
        <cfqueryparam value="#customerID#" cfsqltype="cf_sql_integer">
</cfquery>

<cfif structKeyExists(form,"addAddress")>

    <cfquery datasource="customerdb">
        INSERT INTO Address
        (customerID,AddressLine,City,State,PostalCode,Country)
        VALUES(
            <cfqueryparam value="#customerID#" cfsqltype="cf_sql_integer">,
            <cfqueryparam value="#form.AddressLine#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#form.City#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#form.State#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#form.PostalCode#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#form.Country#" cfsqltype="cf_sql_varchar">
        )
    </cfquery>

    <cflocation url="checkout.cfm" addtoken="false">
</cfif>

<cfif structKeyExists(form,"placeOrder")>

    <cfset selectedAddressID = "">

    <cfif structKeyExists(form,"addressID") AND len(form.addressID)>
        <cfset selectedAddressID = form.addressID>
    </cfif>

    <cfif NOT len(selectedAddressID)>
        <cfset errorMsg = "Please select or enter an address.">

    <cfelseif NOT structKeyExists(form,"paymentMethod")>
        <cfset errorMsg = "Please select a payment method.">

    <cfelse>

        <cftransaction>


            <cfquery name="insertOrder" datasource="storedb">
                INSERT INTO Orders
                    (CustomerID,AddressID,StatusID,Payment,OrderDate,TotalAmount,OTPVerified)
                OUTPUT INSERTED.id
                VALUES(
                    <cfqueryparam value="#customerID#" cfsqltype="cf_sql_integer">,
                    <cfqueryparam value="#selectedAddressID#" cfsqltype="cf_sql_integer">,
                    1,
                    <cfqueryparam value="#form.paymentMethod#" cfsqltype="cf_sql_varchar">,
                    GETDATE(),
                    <cfqueryparam value="#grandTotal#" cfsqltype="cf_sql_decimal">,
                    0
                )
            </cfquery>

            <cfset newOrderID = insertOrder.id>


            <cfloop query="cartItems">

            <cfquery datasource="storedb">
                INSERT INTO OrderItems
                (orderID,ProductID,Quantity,unitPrice)
                VALUES(
                    <cfqueryparam value="#newOrderID#" cfsqltype="cf_sql_integer">,
                    <cfqueryparam value="#ProductID#" cfsqltype="cf_sql_integer">,
                    <cfqueryparam value="#Quantity#" cfsqltype="cf_sql_integer">,
                    <cfqueryparam value="#Price#" cfsqltype="cf_sql_decimal">
                )
            </cfquery>


            <cfquery datasource="storedb">
                UPDATE Products
                SET Quantity = Quantity -
                <cfqueryparam value="#Quantity#" cfsqltype="cf_sql_integer">
                WHERE id =
                    <cfqueryparam value="#ProductID#" cfsqltype="cf_sql_integer">
            </cfquery>

            </cfloop>


            <cfquery datasource="storedb">
                DELETE FROM cartItems
                WHERE cartID =
                    <cfqueryparam value="#cartID#" cfsqltype="cf_sql_integer">
            </cfquery>

        </cftransaction>



        <cfmail
            to="#adminEmails#"
            from="noreply@store.com"
            subject="New Order Placed"
            server="smtp.yopmail.com"
            port="25"
            type="html">

            <h3>New Order Placed</h3>

            Customer: #getCustomer.first_name# #getCustomer.last_name# <br>
            Order ID: #newOrderID# <br>
            Total Amount: Rs. #grandTotal# <br>
            Payment Method: #form.paymentMethod# <br>

            <br>
            Products Ordered:

            <ul>

                <cfloop query="cartItems">
                    <li>#ProductName# - Qty: #Quantity#</li>
                </cfloop>

            </ul>

        </cfmail>


        <cflocation url="myOrders.cfm" addtoken="false">

    </cfif>

</cfif>

<cfif structKeyExists(form,"cancelCheckout")>

    <cfquery datasource="storedb">
        DELETE FROM cartItems
        WHERE cartID =
            <cfqueryparam value="#cartID#" cfsqltype="cf_sql_integer">
    </cfquery>

    <cflocation url="dashboard.cfm" addtoken="false">

</cfif>


<!DOCTYPE html>
<html>
<head>
    <title>Checkout</title>

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f4f6f9;
            margin: 0;
        }

        .container {
            width: 85%;
            margin: 70px auto;
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 40px;
        }

        .section {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
        }

        .address-box {
            padding: 12px;
            border: 1px solid #eee;
            border-radius: 8px;
            margin-bottom: 10px;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 8px;
            border: 1px solid #ddd;
        }

        .payment-option {
            margin-bottom: 8px;
        }

        button {
            background: #2563eb;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            margin-top: 15px;
        }
    </style>
</head>

<body>
    <cfinclude template="../includes/header.cfm">

    <div class="container">

        <cfif cartEmpty>

            <div style="
            align-items: center;
            background:white;
            padding:60px;
            border-radius:15px;
            box-shadow:0 10px 25px rgba(0,0,0,0.05);
            text-align:center;
            width:60%;
            margin:auto;
            margin-left: 270px;
            ">

                <h2>Your Cart is Empty</h2>

                <p style="color:#6b7280;margin-top:10px;">
                    Looks like you haven't added any products yet.
                </p>

                <a href="dashboard.cfm">
                    <button style="width:auto;margin-top:20px;">
                        Continue Shopping
                    </button>
                </a>

            </div>

        <cfelse>
            <!-- LEFT COLUMN -->
            <div>

                <!-- Greeting -->
                <div style="margin-bottom:20px;">
                    <cfoutput query="getCustomer">
                        <h3>Hello #first_name# #last_name#,</h3>
                    </cfoutput>

                    
                </div>
                <form method="post" onsubmit="return validateAddressForm()">
                    <cfinclude template="address.cfm">
                </form>

                <!-- FORM -->
                <form method="post" onsubmit="return validateOrderForm()">

                    <cfif structKeyExists(variables,"errorMsg")>
                        <div style="color:red; margin-bottom:15px;">
                            <cfoutput>#errorMsg#</cfoutput>
                        </div>
                    </cfif>
                    
                    <h3 style="margin-top:10px;">Select Delivery Address</h3>
                    <div id="orderError" style="color:red; margin-bottom:10px;"></div>
                    <cfoutput query="getAddresses">
                        <div class="address-box">
                            <input type="radio" name="addressID" value="#id#">
                            #AddressLine#, #City#, #State#, #PostalCode#, #Country#
                        </div>
                    </cfoutput>

                    <h3>Select Payment Method</h3>

                    <div class="payment-option">
                        <input type="radio" name="paymentMethod" value="Cash on Delivery"> Cash on Delivery
                    </div>

                    <div class="payment-option">
                        <input type="radio" name="paymentMethod" value="Bank Transfer"> Bank Transfer
                    </div>

                    

                    <button type="submit" name="placeOrder">Place Order</button>
                    <button type="submit" name="cancelCheckout" style="background:#dc2626;margin-top:10px;">
                        Cancel Order
                    </button>

                </form>

            </div>

            <!-- RIGHT COLUMN -->
            <div class="section">
                <h3>Order Summary</h3>

                <cfoutput query="cartItems">
                    <div>
                        #ProductName# (x#Quantity#) - Rs. #Price * Quantity#
                    </div>
                </cfoutput>

                <hr>

                <h3>Total:
                    <cfoutput>Rs. #grandTotal#</cfoutput>
                </h3>
            </div>

        </cfif>
    </div>
    <cfinclude template="../includes/footer.cfm">

    <script>
        document.addEventListener("DOMContentLoaded", function () {

            const pincodeInput = document.getElementById("postalCode");

            if (!pincodeInput) return;

            let timer;

            pincodeInput.addEventListener("input", function () {

                const pincode = this.value;

                // clear previous timer
                clearTimeout(timer);

                // only run if 6 digits
                if (pincode.length === 6) {

                    timer = setTimeout(() => {

                        fetch("https://api.postalpincode.in/pincode/" + pincode)
                            .then(res => res.json())
                            .then(data => {

                                if (data[0].Status === "Success" && data[0].PostOffice) {

                                    const postOffice = data[0].PostOffice[0];

                                    document.getElementById("city").value = postOffice.District;
                                    document.getElementById("state").value = postOffice.State;
                                    document.getElementById("country").value = "India";

                                } else {
                                    console.log("Invalid Pincode");
                                }

                            })
                            .catch(() => {
                                console.log("Error fetching pincode data");
                            });

                    }, 500); // wait 500ms after typing stops

                }

            });

        });

        function validateOrderForm() {

            let isValid = true;

            const address = document.querySelector("input[name='addressID']:checked");
            const payment = document.querySelector("input[name='paymentMethod']:checked");

            const errorDiv = document.getElementById("orderError");

            if (!address) {
                errorDiv.innerText = "Please select a delivery address";
                isValid = false;
            } else if (!payment) {
                errorDiv.innerText = "Please select payment method";
                isValid = false;
            } else {
                errorDiv.innerText = "";
            }

            return isValid;
        }
    </script>

</body>
</html>