<style>
.error { color:red; font-size:12px; display:block; }
.valid { border:1px solid green; }
.invalid { border:1px solid red; }
</style>

<cfoutput>

<h3>Add New Address</h3>

<div>
    <label>Address Line</label>
    <input type="text" name="AddressLine" id="addressLine">
    <small class="error" id="addressError"></small>
</div>

<div>
    <label>City</label>
    <input type="text" name="City" id="city">
    <small class="error" id="cityError"></small>
</div>

<div>
    <label>State</label>
    <input type="text" name="State" id="state">
    <small class="error" id="stateError"></small>
</div>

<div>
    <label>Postal Code</label>
    <input type="text" name="PostalCode" id="postalCode">
    <small class="error" id="postalError"></small>
</div>

<div>
    <label>Country</label>
    <input type="text" name="Country" id="country">
    <small class="error" id="countryError"></small>
</div>

<button type="submit" name="addAddress">Add Address</button>

</cfoutput>

<script>
function validateAddressForm() {

    let isValid = true;

    const address = document.getElementById("addressLine");
    const city = document.getElementById("city");
    const state = document.getElementById("state");
    const postal = document.getElementById("postalCode");
    const country = document.getElementById("country");

    function validate(input, errorId, condition, message) {
        const errorEl = document.getElementById(errorId);

        if (!condition) {
            errorEl.innerText = message;
            input.classList.add("invalid");
            input.classList.remove("valid");
            isValid = false;
        } else {
            errorEl.innerText = "";
            input.classList.remove("invalid");
            input.classList.add("valid");
        }
    }

    validate(address, "addressError",
        address.value.trim().length >= 5,
        "Minimum 5 characters");

    validate(city, "cityError",
        /^[a-zA-Z\s]+$/.test(city.value),
        "Only letters allowed");

    validate(state, "stateError",
        /^[a-zA-Z\s]+$/.test(state.value),
        "Only letters allowed");

    validate(postal, "postalError",
        /^[1-9][0-9]{5}$/.test(postal.value),
        "Invalid pincode");

    validate(country, "countryError",
        country.value.trim().length >= 3,
        "Minimum 3 characters");

    if (!isValid) {
        document.querySelector(".invalid")?.focus();
    }

    return isValid;
}
</script>