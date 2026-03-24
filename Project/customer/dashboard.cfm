<cfset customerID = session.userID>


<cfparam name="form.searchName" default="">
<cfparam name="form.categoryID" default="">
<cfparam name="form.gender" default="">
<cfparam name="form.minPrice" default="">
<cfparam name="form.maxPrice" default="">
<cfparam name="url.openCart" default="0">



<cfquery name="getCart" datasource="storedb">
    SELECT id FROM Cart
    WHERE customerID =
    <cfqueryparam value="#customerID#" cfsqltype="cf_sql_integer">
</cfquery>



<cfif getCart.recordCount EQ 0>

    <cfquery datasource="storedb">
        INSERT INTO Cart(customerID)
        VALUES(
            <cfqueryparam value="#customerID#" cfsqltype="cf_sql_integer">
        )
    </cfquery>

    <cfquery name="getCart" datasource="storedb">
        SELECT id FROM Cart
        WHERE customerID =
        <cfqueryparam value="#customerID#" cfsqltype="cf_sql_integer">
    </cfquery>

</cfif>

<cfset cartID = getCart.id>



<cfif structKeyExists(form,"actionType")>

    <cfset productID = form.productID>

    <cfquery name="checkItem" datasource="storedb">
        SELECT *
        FROM cartItems
        WHERE cartID =
        <cfqueryparam value="#cartID#" cfsqltype="cf_sql_integer">
        AND ProductID =
        <cfqueryparam value="#productID#" cfsqltype="cf_sql_integer">
    </cfquery>

    <cfif form.actionType EQ "add">

        <cfquery name="checkStock" datasource="storedb">
            SELECT Quantity
            FROM Products
            WHERE id =
            <cfqueryparam value="#productID#" cfsqltype="cf_sql_integer">
            AND isDeleted = 0
        </cfquery>

        <cfif checkStock.recordCount EQ 0 OR checkStock.Quantity EQ 0>
            <!-- Product unavailable -->
            <cflocation url="dashboard.cfm?error=outofstock" addtoken="false">
        </cfif>

        <cfif checkItem.recordCount EQ 0>

            <cfquery datasource="storedb">
                INSERT INTO cartItems(cartID,ProductID,Quantity)
                VALUES(
                    <cfqueryparam value="#cartID#" cfsqltype="cf_sql_integer">,
                    <cfqueryparam value="#productID#" cfsqltype="cf_sql_integer">,
                    1
                )
            </cfquery>

        <cfelse>

            <cfquery datasource="storedb">
                UPDATE cartItems
                SET Quantity = Quantity + 1
                WHERE id =
                <cfqueryparam value="#checkItem.id#" cfsqltype="cf_sql_integer">
            </cfquery>

        </cfif>


    <cfelseif form.actionType EQ "remove">

        <cfif checkItem.recordCount GT 0>

            <cfif checkItem.Quantity GT 1>

                <cfquery datasource="storedb">
                    UPDATE cartItems
                    SET Quantity = Quantity - 1
                    WHERE id =
                    <cfqueryparam value="#checkItem.id#" cfsqltype="cf_sql_integer">
                </cfquery>

            <cfelse>

                <cfquery datasource="storedb">
                    DELETE FROM cartItems
                    WHERE id =
                    <cfqueryparam value="#checkItem.id#" cfsqltype="cf_sql_integer">
                </cfquery>

            </cfif>

        </cfif>

    </cfif>

    <cfif structKeyExists(form,"redirectToCart")>
        <cflocation url="dashboard.cfm?openCart=1" addtoken="false">
    <cfelse>
        <cflocation url="dashboard.cfm?openCart=0" addtoken="false">
    </cfif>

</cfif>



<cfquery name="getProducts" datasource="storedb">

    SELECT p.*, ISNULL(ci.Quantity,0) as cartQty
    FROM Products p
    LEFT JOIN cartItems ci 
        ON ci.ProductID = p.id
        AND ci.cartID =
        <cfqueryparam value="#cartID#" cfsqltype="cf_sql_integer">

    WHERE 1=1
    AND isDeleted = 0

    <cfif len(trim(form.searchName))>
        AND p.ProductName LIKE
        <cfqueryparam value="%#form.searchName#%" cfsqltype="cf_sql_varchar">
    </cfif>

    <cfif len(trim(form.categoryID))>
        AND p.categoryID =
        <cfqueryparam value="#form.categoryID#" cfsqltype="cf_sql_integer">
    </cfif>

    <cfif len(trim(form.gender))>
        AND p.Gender =
        <cfqueryparam value="#form.gender#" cfsqltype="cf_sql_varchar">
        <cfqueryparam value="#form.gender#" cfsqltype="cf_sql_varchar">
    </cfif>

    <cfif len(trim(form.minPrice))>
        AND p.Price >=
        <cfqueryparam value="#form.minPrice#" cfsqltype="cf_sql_decimal">
    </cfif>

    <cfif len(trim(form.maxPrice))>
        AND p.Price <=
        <cfqueryparam value="#form.maxPrice#" cfsqltype="cf_sql_decimal">
    </cfif>

</cfquery>



<cfquery name="cartCount" datasource="storedb">

    SELECT SUM(Quantity) as totalItems
    FROM cartItems
    WHERE cartID =
    <cfqueryparam value="#cartID#" cfsqltype="cf_sql_integer">

</cfquery>

<cfset totalItems = cartCount.totalItems>

<cfif NOT isNumeric(totalItems)>
    <cfset totalItems = 0>
</cfif>


<!DOCTYPE html>
<html>
<head>
    <title>Products</title>

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f4f6f9;
            margin: 0;
        }

        .container {
            width: 95%;
            margin: 70px auto;
        }

        .filters {
            background: white;
            padding: 20px;
            border-radius: 12px;
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            margin-bottom: 35px;
        }

        .filters input, .filters select {
            padding: 10px 12px;
            border-radius: 8px;
            border: 1px solid #ddd;
            min-width: 160px;
        }

        .filters input[type="submit"] {
            background: #2563eb;
            color: white;
            border: none;
            font-weight: 600;
            cursor: pointer;
        }

        .products {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(240px,1fr));
            gap: 30px;
        }

        .card {
            background: white;
            border-radius: 16px;
            padding: 18px;
            transition: 0.3s ease;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);

            transition: 0.2s ease;
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.12);
        }

        .card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 10px;
            transition: 0.3s;
        }

        .card:hover img {
            transform: scale(1.05);
        }

        .price {
            color: #1e40af;
            font-weight: bold;
            margin: 8px 0;
        }

        .qty-box {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 12px;
            margin-top: 10px;
        }

        .qty-btn {
            width: 32px;
            height: 32px;
            border-radius: 6px;
            border: none;
            background: #111827;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        .cart-floating {
            position: fixed;
            bottom: 65px;
            right: 20px;
            background: #2563eb;
            color: white;
            padding: 14px 20px;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }

        .modal {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.5);
        }

        .modal-content {
            background: white;
            width: 65%;
            margin: 5% auto;
            padding: 30px;
            border-radius: 15px;
        }
    </style>
</head>

<body>
    <cfinclude template="../includes/header.cfm">

    <div class="container">

        <form method="post" class="filters">
            <input type="text" id="searchInput" name="searchName" placeholder="Search"
                value="<cfoutput>#form.searchName#</cfoutput>">

            <select name="categoryID">
                <option value="">All Categories</option>
                <option value="1">Men</option>
                <option value="2">Women</option>
                <option value="3">Electronics</option>
                <option value="4">Footwear</option>
                <option value="5">Accessories</option>
            </select>

            <select name="gender">
                <option value="">All Gender</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Unisex">Unisex</option>
            </select>

            <input type="number" name="minPrice" min="0" placeholder="Min Price">
            <input type="number" name="maxPrice" min="1" placeholder="Max Price">

            <input type="submit" value="Apply">
        </form>

        <div class="products">
            <cfif getProducts.recordCount EQ 0>

                <div style="
                    grid-column:1/-1;
                    background:white;
                    padding:40px;
                    text-align:center;
                    border-radius:12px;
                    box-shadow:0 5px 20px rgba(0,0,0,0.05);
                    color:grey;
                    font-size:16px;
                    font-weight:500;
                ">
                    No products found.
                </div>

            <cfelse>

                <cfoutput query="getProducts">

            <div class="card" data-name="#lcase(ProductName)#">

                <img src="/EcommerceOSS/#image_path#">

                <h4>#ProductName#</h4>

                <div class="price">
                    Rs. #Price#
                </div>


                <!-- Stock Status -->

                <cfif Quantity GT 0>

                    <div style="font-size:13px;color:blue;margin-bottom:6px;">
                        Available: #Quantity# left
                    </div>


                    <!-- Quantity Controls -->

                    <div class="qty-box">

                        <!-- Remove Button -->

                        <form method="post" action="dashboard.cfm?openCart=0">

                            <input type="hidden" name="productID" value="#id#">
                            <input type="hidden" name="actionType" value="remove">

                            <button class="qty-btn"
                                <cfif cartQty EQ 0>disabled</cfif>>
                                -
                            </button>

                        </form>


                        <!-- Current Quantity -->

                        <strong style="min-width:20px;text-align:center;">
                            #cartQty#
                        </strong>


                        <!-- Add Button -->

                        <form method="post" action="dashboard.cfm?openCart=0">

                            <input type="hidden" name="productID" value="#id#">
                            <input type="hidden" name="actionType" value="add">

                            <button class="qty-btn"
                                <cfif cartQty GTE Quantity>disabled</cfif>>
                                +
                            </button>

                        </form>

                    </div>


                <cfelse>

                    <!-- Out Of Stock -->

                    <div style="font-size:13px;color:red;font-weight:600;margin-top:6px;">
                        Out of Stock
                    </div>

                </cfif>

            </div>
            <div id="noResults" style="
                display:none;
                grid-column:1/-1;
                background:white;
                padding:40px;
                text-align:center;
                border-radius:12px;
                box-shadow:0 5px 20px rgba(0,0,0,0.05);
                color:grey;
                font-size:16px;
                font-weight:500;
            ">
                Product unavailable
            </div>

            </cfoutput>
            </cfif>
        </div>

    </div>

    <cfif totalItems GT 0>
        <div class="cart-floating" onclick="openCart()">
            View Cart (<cfoutput >
                    #totalItems#
                </cfoutput> )
        </div>
    </cfif>

    <div class="modal" id="cartModal">
        <div class="modal-content">
            <span onclick="closeCart()" style="float:right;cursor:pointer;">X</span>
            <cfinclude template="cart.cfm">
        </div>
    </div>

    <cfinclude template="../includes/footer.cfm">
</body>

    <script>
        function openCart() {
            document.getElementById('cartModal').style.display='block';
        }
        function closeCart() {
            document.getElementById('cartModal').style.display='none';
        }

        window.onload = function() {
            <cfif url.openCart EQ 1>
                openCart();
            </cfif>
        }
        
        document.querySelector(".back-btn").style.display = "none";
        


        const searchInput = document.getElementById("searchInput");
        const cards = document.querySelectorAll(".card");
        const noResults = document.getElementById("noResults");

        searchInput.addEventListener("input", function () {

            const searchValue = this.value.toLowerCase();
            let visibleCount = 0;

            cards.forEach(card => {

                const productName = card.getAttribute("data-name");

                if (productName.includes(searchValue)) {
                    card.style.display = "block";
                    visibleCount++;
                } else {
                    card.style.display = "none";
                }

            });

            if (visibleCount === 0 && searchValue.trim() !== "") {
                noResults.style.display = "block";
            } else {
                noResults.style.display = "none";
            }

        });
    </script>
</html>