<cfquery datasource="storedb">
    DELETE ci
    FROM cartItems ci
    LEFT JOIN Products p ON p.id = ci.ProductID
    WHERE p.id IS NULL
    OR p.isDeleted = 1
    OR p.Quantity = 0
</cfquery>

<style>
    .cart-title {
        font-size: 20px;
        margin-bottom: 15px;
        font-weight: 600;
    }
    .cart-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }
    .cart-table th {
        text-align: left;
        padding: 10px;
        border-bottom: 2px solid #eee;
        font-size: 14px;
    }
    .cart-table td {
        padding: 10px;
        border-bottom: 1px solid #eee;
        font-size: 14px;
    }
    .qty-box {
        display: flex;
        align-items: center;
        gap: 8px;
    }
    .qty-btn {
        width: 28px;
        height: 28px;
        border: none;
        background: #111827;
        color: white;
        border-radius: 5px;
        cursor: pointer;
        font-weight: bold;
    }
    .qty-btn:hover {
        background: #374151;
    }
    .checkout-btn {
        background: #2563eb;
        padding: 12px 18px;
        color: white;
        text-decoration: none;
        border-radius: 6px;
        font-weight: 600;
        display: inline-block;
    }
    .checkout-btn:hover {
        background: #1e40af;
    }
    .total-row {
        font-weight: 600;
        font-size: 15px;
    }
    .empty-cart {
        text-align: center;
        padding: 30px 10px;
        color: #666;
        font-size: 16px;
        font-weight: 500;
    }
</style>


<cfquery name="cartItems" datasource="storedb">

    SELECT 
        ci.*,
        p.ProductName,
        p.Price

    FROM cartItems ci

    INNER JOIN Products p
        ON p.id = ci.ProductID

    WHERE ci.cartID =
        <cfqueryparam value="#cartID#" cfsqltype="cf_sql_integer">

</cfquery>


<div class="cart-title">Your Cart</div>


<cfif cartItems.recordCount EQ 0>

    <div class="empty-cart">
        Your cart is currently empty.
    </div>

<cfelse>

    <table class="cart-table">

        <tr>
            <th>Product</th>
            <th style="text-align: center">Qty</th>
            <th>Price</th>
            <th>Total</th>
        </tr>

        <cfset grandTotal = 0>

        <cfoutput query="cartItems">

            <tr>

                <td>#ProductName#</td>

                <td>

                    <div class="qty-box">

                        <form method="post" action="dashboard.cfm">

                            <input type="hidden" name="redirectToCart" value="1">
                            <input type="hidden" name="productID" value="#ProductID#">
                            <input type="hidden" name="actionType" value="remove">

                            <button class="qty-btn">-</button>

                        </form>

                        <span>#Quantity#</span>

                        <form method="post" action="dashboard.cfm">

                            <input type="hidden" name="redirectToCart" value="1">
                            <input type="hidden" name="productID" value="#ProductID#">
                            <input type="hidden" name="actionType" value="add">

                            <button class="qty-btn">+</button>

                        </form>

                    </div>

                </td>

                <td>Rs. #Price#</td>

                <td>Rs. #Price * Quantity#</td>

            </tr>

            <cfset grandTotal += Price * Quantity>

        </cfoutput>


        <tr class="total-row">
            <td colspan="3" align="right">Total</td>
            <td>
                <cfoutput>Rs. #grandTotal#</cfoutput>
            </td>
        </tr>

    </table>


    <a href="checkout.cfm" class="checkout-btn">
        Proceed to Checkout
    </a>

</cfif>