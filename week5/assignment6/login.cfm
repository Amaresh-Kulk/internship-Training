<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
    }
    h2  {
        text-align: center;
    }
    .form-container {
        width: 400px;
        margin: 50px auto;
        padding: 20px;
        background: white;
        border-radius: 8px;
        box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
    }
    input, select {
        width: 100%;
        padding: 8px;
        margin: 8px 0;
    }
    button {
        padding: 10px;
        width: 100%;
        background-color: #007bff;
        color: white;
        border: none;
        cursor: pointer;
    }
    button:hover {
        background-color: #0056b3;
    }
    .error  {
        margin-left: 450px;
        text-align: center;
        color:red;
        padding: 20px;
        border: 1px solid red;
        border-radius: 10px;
        background: white;
        width: 300px;
    }
</style>

<div class="form-container">
    <h2>Log In</h2>

    <form method="post" action="login.cfm">
        
        
        <label>Name:</label>
        <input type="text" name="name" placeholder="Enter Full Name" required>

        
        <label>Position:</label>
        <select name="position" required>
            <option value="">-- Select Position --</option>
            <option value="Manager">Manager</option>
            <option value="Engineer">Engineer</option>
            <option value="Analyst">Analyst</option>
            <option value="Technician">Technician</option>
            <option value="HR Specialist">HR Specialist</option>
            <option value="Designer">Designer</option>
            <option value="Developer">Developer</option>
            <option value="Accountant">Accountant</option>
            <option value="Assistant">Assistant</option>
            <option value="Supervisor">Supervisor</option>
        </select>

        
        <label>Department:</label>
        <select name="department" required>
            <option value="">-- Select Department --</option>
            <option value="Sales">Sales</option>
            <option value="IT">IT</option>
            <option value="Finance">Finance</option>
            <option value="Maintenance">Maintenance</option>
            <option value="Human Resources">Human Resources</option>
            <option value="Marketing">Marketing</option>
            <option value="Administration">Administration</option>
            <option value="Production">Production</option>
        </select>

        <label>Phone Number:</label>
        <input type="text" 
            name="phone_number" 
            pattern="[6789][0-9]{9}" 
            maxlength="10"
            inputmode="numeric"
            placeholder="Enter 10 digit phone number"
        required>
        
        <button type="submit">Log In</button>

    </form>
</div>

<cfif structKeyExists(form, "name")>

    <cfset validator = createObject("component", "Employees")>
    <cfset validationResult = validator.validateEmployee(form)>

    <cfif validationResult.isValid>

        
        <cfset employeeExists = validator.checkEmployee(form)>

        <cfif employeeExists>
            
            
            <cfset session.isLoggedIn = true>
            <cfset session.userName = form.name>

            <cflocation url="home.cfm" addtoken="false">

        <cfelse>
            <cfoutput>
                <p class="error">Employee Not Found!</p>
            
            </cfoutput>
        </cfif>

    <cfelse>
        <cfoutput>
            <div class = "error">

                    #validationResult.errors#
                
            </div>
        </cfoutput>
    </cfif>

</cfif>


<script>
    window.onload = function()  {
        let err = document.querySelector(".error");
        if(err)   {
            setTimeout(() =>    {
                err.remove();
                window.location = "login.cfm";
            }, 5000);
        }
    }
</script>