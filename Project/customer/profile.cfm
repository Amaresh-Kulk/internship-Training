<cfquery name="getCustomer" datasource="customerDB">
    SELECT first_name,last_name,phone,profileImage
    FROM Customer
    WHERE id =
        <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_integer">
</cfquery>

<cfif structKeyExists(form,"addAddress")>

    <cfquery datasource="customerdb">
        INSERT INTO Address
        (customerID,AddressLine,City,State,PostalCode,Country)
        VALUES(
            <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_integer">,
            <cfqueryparam value="#form.AddressLine#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#form.City#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#form.State#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#form.PostalCode#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#form.Country#" cfsqltype="cf_sql_varchar">
        )
    </cfquery>

    <cflocation url="profile.cfm" addtoken="false">
</cfif>

<cfif structKeyExists(url,"deleteAddress")>

    <cfquery datasource="customerdb">
        DELETE FROM Address
        WHERE id =
        <cfqueryparam value="#url.deleteAddress#" cfsqltype="cf_sql_integer">
        AND customerID =
        <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_integer">
    </cfquery>

    <cflocation url="profile.cfm" addtoken="false">

</cfif>



<cfif structKeyExists(form,"updateAddress")>

    <cfquery datasource="customerdb">
        UPDATE Address
        SET
        AddressLine =
        <cfqueryparam value="#form.AddressLine#" cfsqltype="cf_sql_varchar">,
        City =
        <cfqueryparam value="#form.City#" cfsqltype="cf_sql_varchar">,
        State =
        <cfqueryparam value="#form.State#" cfsqltype="cf_sql_varchar">,
        PostalCode =
        <cfqueryparam value="#form.PostalCode#" cfsqltype="cf_sql_varchar">,
        Country =
        <cfqueryparam value="#form.Country#" cfsqltype="cf_sql_varchar">
        WHERE id =
        <cfqueryparam value="#url.editAddress#" cfsqltype="cf_sql_integer">
        AND customerID =
        <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_integer">
    </cfquery>

    <cflocation url="profile.cfm" addtoken="false">

</cfif>



<cfquery name="getAddresses" datasource="customerdb">
    SELECT *
    FROM Address
    WHERE customerID =
    <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_integer">
</cfquery>


<!DOCTYPE html>
<html>
<head>

    <title>Profile</title>

    <style>

        body{
        font-family:Segoe UI;
        background:#f4f6f9;
        margin:0;
        }

        .container{
        width:1000px;
        margin:70px auto;
        }

        .card{
        background:white;
        padding:30px;
        border-radius:12px;
        box-shadow:0 10px 25px rgba(0,0,0,0.08);
        margin-bottom:30px;
        }

        .profile-header{
        display:flex;
        align-items:center;
        gap:25px;
        }

        .profile-img{
        width:120px;
        height:120px;
        border-radius:50%;
        object-fit:cover;
        border:4px solid #2563eb;
        }

        h2{
        margin:0;
        }

        .grid{
        display:grid;
        grid-template-columns:1fr 1fr;
        gap:30px;
        }

        label{
        font-size:14px;
        font-weight:600;
        }

        input{
        width:100%;
        padding:10px;
        border:1px solid #ddd;
        border-radius:6px;
        margin-top:5px;
        margin-bottom:15px;
        }

        button{
        background:#2563eb;
        color:white;
        border:none;
        padding:10.5px 14px;
        border-radius:6px;
        cursor:pointer;
        font-weight:600;
        }

        button:hover{
        background:#1e40af;
        }

        .deleteBtn{
        background:#dc2626;
        }

        .deleteBtn:hover{
        background:#991b1b;
        }

        .address{
        padding:15px;
        border:1px solid #eee;
        border-radius:8px;
        margin-bottom:15px;
        background:#fafafa;
        }

        .section-title{
        font-size:18px;
        margin-bottom:15px;
        font-weight:600;
        }

        .logout{
        display:inline-block;
        margin-top:20px;
        color:#dc2626;
        text-decoration:none;
        font-weight:600;
        }

        .actions{
        margin-top:10px;
        display:flex;
        gap:10px;
        }


        .button {
            background:#c72b30;
            color:white;
            border:none;
            padding:8px 10px;
            border-radius:6px;
            cursor:pointer;
            font-weight:400;
            text-decoration: none;
            margin-top:-10px;
        }

        .button:hover {
            background-color: #741818;
        }
    </style>

</head>

<body>

    <cfinclude template="../includes/header.cfm">

    <div class="container">
        <div class="card">

            <div class="profile-header">
                <img class="profile-img"
                src="/EcommerceOSS/uploads/profileImages/<cfoutput>#getCustomer.profileImage#</cfoutput>">
                <div>

                    <h2>
                        <cfoutput>
                            #getCustomer.first_name# #getCustomer.last_name#
                        </cfoutput>
                    </h2>


                    <p style="color:#666;">
                        Phone:
                        <cfoutput>#getCustomer.phone#</cfoutput>
                    </p>

                    <p style="color:#666;">
                        Customer Account
                    </p>

                </div>

            </div>

        </div>


    <div class="card">

        <div class="section-title">Personal Details</div>

        <cfif structKeyExists(form,"updatePhone")>

            <cfquery datasource="customerdb">
                UPDATE Customer
                SET phone =
                    <cfqueryparam value="#form.phone#" cfsqltype="cf_sql_varchar">
                WHERE id =
                    <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_integer">
            </cfquery>

            <cflocation url="profile.cfm" addtoken="false">

        </cfif>

        <form method="post" onsubmit="return validatePhoneForm()">

            <label>Phone Number</label>

            <input type="text"
            id="phone"
            name="phone"
            value="<cfoutput>#getCustomer.phone#</cfoutput>"
            pattern="[6789][0-9]{9}"
            maxlength="10"
            inputmode="numeric">

            <small id="phoneError" class="error" style="display:block"></small>
            <button name="updatePhone">
                Update Phone
            </button>

        </form>

    </div>
    <div class="card">
        <cftry>                
            <div class="section-title">Profile Image</div>
                <cfif structKeyExists(form,"uploadImage")>
                    <cffile
                        action="upload"
                        filefield="profilePic"
                        destination="#expandPath('/EcommerceOSS/uploads/profileImages/')#"
                        nameconflict="makeunique"
                        accept="image/jpeg,image/png,image/gif">

                    <cfif NOT listFindNoCase("jpg,jpeg,png,gif", cffile.serverFileExt)>
                        <cfset fileDelete(cffile.serverDirectory & "/" & cffile.serverFile)>
                    <cfelse>
                        <cfquery datasource="customerdb">
                            UPDATE Customer
                            SET profileImage =
                            <cfqueryparam value="#cffile.serverFile#" cfsqltype="cf_sql_varchar">
                            WHERE id =
                            <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_integer">
                        </cfquery>

                        <cflocation url="profile.cfm" addtoken="false">

                    </cfif>

                </cfif>

            <form method="post" enctype="multipart/form-data">

                <input type="file" id="profilePic" name="profilePic" accept="image/*" required>
                <small id="imgError" style="color:red;"></small>

                <button name="uploadImage">
                    Upload Image
                </button>

            </form>
        <cfcatch >
            <div style="color:red;margin-bottom:10px;">
                <cfoutput>#cfcatch.message#</cfoutput>
            </div>
            <form method="post" enctype="multipart/form-data">

                <input type="file" id="profilePic" name="profilePic" accept="image/*" required>
                <small id="imgError" style="color:red;"></small>

                <button name="uploadImage">
                    Upload Image
                </button>

            </form>
        </cfcatch>
        </cftry>
    </div>

    <div class="card">

        <div class="section-title">Shipping Addresses</div>

        <cfoutput query="getAddresses">

            <div class="address">

                #AddressLine# <br>
                #City#, #State# <br>
                #PostalCode# <br>
                #Country#

                <div class="actions">

                    <a href="profile.cfm?editAddress=#id#">
                        <button type="button">Edit</button>
                    </a>

                    <a href="profile.cfm?deleteAddress=#id#"
                        onclick="return confirm('Delete this address?')">
                        <button type="button" class="deleteBtn">Delete</button>
                    </a>

                </div>

            </div>

        </cfoutput>




        <cfif structKeyExists(url,"editAddress")>

            <cfquery name="editAddress" datasource="customerdb">
                SELECT *
                FROM Address
                WHERE id =
                    <cfqueryparam value="#url.editAddress#" cfsqltype="cf_sql_integer">
                AND customerID =
                    <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_integer">
            </cfquery>

            <h3>Edit Address</h3>

            <cfoutput query="editAddress">

                <form method="post" class="grid"  onsubmit="return validateEditForm()">
                    <div>
                        <label>AddressLine</label>
                        <input type="text" id="editAddressLine" name="AddressLine" value="#AddressLine#">
                        <small id="editAddressError" class="error"></small>
                    </div>
                    <div>

                    </div>
                    <div>
                        <label>City</label>
                        <input type="text" id="editCity" name="City" value="#City#">
                        <small id="editCityError" class="error"></small>
                    </div>
                    <div>
                        <label>State</label>
                        <input type="text" id="editState" name="State" value="#State#">
                        <small id="editStateError" class="error"></small>
                    </div>
                    <div>
                        <label>Postal Code</label>
                        <input type="text" id="editPostal" name="PostalCode" value="#PostalCode#">
                        <small id="editPostalError" class="error"></small>
                    </div>

                    <div>
                        <label>Country</label>
                        <input type="text" id="editCountry" name="Country" value="#Country#">
                        <small id="editCountryError" class="error"></small>

                    </div>

                    <div style="display:flex; justify-content: space-between" >
                        <div style="align-self:end; display:inline-block">
                            <button name="updateAddress">Update Address</button>
                        </div>

                        <div style="align-self:center; display:inline-block">
                            <a href="profile.cfm" class="button">Cancel Address</a>
                        </div>

                    </div>

                </form>
            </cfoutput>

        </cfif>

        <form method="post" onsubmit="return validateAddressForm()">
            <cfinclude template="address.cfm">
        </form>


        </div>

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

        document.addEventListener("DOMContentLoaded", function () {

            const phone = document.getElementById("phone");
            const phoneError = document.getElementById("phoneError");

            if (phone) {

                phone.addEventListener("input", function () {

                    const value = phone.value;

                    if (!/^[6-9][0-9]{0,9}$/.test(value)) {
                        phoneError.innerText = "Must start with 6-9 and be numeric";
                        phone.classList.add("invalid");
                    } else if (value.length !== 10) {
                        phoneError.innerText = "Phone must be 10 digits";
                        phone.classList.add("invalid");
                    } else {
                        phoneError.innerText = "";
                        phone.classList.remove("invalid");
                        phone.classList.add("valid");
                    }

                });

            }

        });

        document.addEventListener("DOMContentLoaded", function () {

            function validate(input, errorEl, condition, message) {
                if (!condition) {
                    errorEl.innerText = message;
                    input.classList.add("invalid");
                    input.classList.remove("valid");
                } else {
                    errorEl.innerText = "";
                    input.classList.remove("invalid");
                    input.classList.add("valid");
                }
            }

            const address = document.getElementById("editAddressLine");
            const city = document.getElementById("editCity");
            const state = document.getElementById("editState");
            const postal = document.getElementById("editPostal");
            const country = document.getElementById("editCountry");

            if (address) {

                address.addEventListener("input", () => {
                    validate(address, editAddressError,
                        address.value.trim().length >= 5,
                        "Address too short");
                });

                city.addEventListener("input", () => {
                    validate(city, editCityError,
                        /^[a-zA-Z\s]+$/.test(city.value),
                        "Only letters allowed");
                });

                state.addEventListener("input", () => {
                    validate(state, editStateError,
                        /^[a-zA-Z\s]+$/.test(state.value),
                        "Only letters allowed");
                });

                postal.addEventListener("input", () => {
                    validate(postal, editPostalError,
                        /^[1-9][0-9]{5}$/.test(postal.value),
                        "Invalid pincode");
                });

                country.addEventListener("input", () => {
                    validate(country, editCountryError,
                        country.value.trim().length >= 3,
                        "Country too short");
                });

            }

        });

        function validatePhoneForm() {

            const phone = document.getElementById("phone");
            const error = document.getElementById("phoneError");

            if (!/^[6-9][0-9]{9}$/.test(phone.value)) {
                error.innerText = "Enter valid 10-digit phone number";
                phone.classList.add("invalid");
                phone.focus();
                return false;
            }

            error.innerText = "";
            phone.classList.remove("invalid");
            phone.classList.add("valid");

            return true;
        }
        
        function validateEditForm() {

            let isValid = true;

            function check(id, errorId, condition, msg) {
                const input = document.getElementById(id);
                const error = document.getElementById(errorId);

                if (!condition) {
                    error.innerText = msg;
                    input.classList.add("invalid");
                    isValid = false;
                } else {
                    error.innerText = "";
                    input.classList.remove("invalid");
                }
            }

            check("editAddressLine","editAddressError",
                document.getElementById("editAddressLine").value.trim().length >= 5,
                "Minimum 5 characters");

            check("editCity","editCityError",
                /^[a-zA-Z\s]+$/.test(document.getElementById("editCity").value),
                "Only letters");

            check("editState","editStateError",
                /^[a-zA-Z\s]+$/.test(document.getElementById("editState").value),
                "Only letters");

            check("editPostal","editPostalError",
                /^[1-9][0-9]{5}$/.test(document.getElementById("editPostal").value),
                "Invalid pincode");

            check("editCountry","editCountryError",
                document.getElementById("editCountry").value.trim().length >= 3,
                "Too short");

            if (!isValid) {
                document.querySelector(".invalid")?.focus();
            }

            return isValid;
        }

        document.addEventListener("DOMContentLoaded", function () {

            const fileInput = document.getElementById("profilePic");
            const errorEl = document.getElementById("imgError");

            fileInput.addEventListener("change", function () {

                const file = this.files[0];

                if (!file) return;

                const allowedTypes = ["image/jpeg", "image/png", "image/gif"];

                if (!allowedTypes.includes(file.type)) {

                    errorEl.innerText = "Only JPG, PNG, GIF images are allowed\n";
                    fileInput.value = ""; // clear file
                    return;

                }

                errorEl.innerText = ""; // valid

            });

        });

    </script>
</body>
</html>

