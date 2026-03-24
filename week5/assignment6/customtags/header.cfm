
<style>
    .header {
        background: #333;
        padding: 10px;
        text-align: center;
        margin-top: -8px;
        /* width: 500px; */
        display: flex;
        justify-content:space-around;
    }

    .header a {
        color: white;
        text-decoration: none;
        margin: 0 10px;
        padding: 6px 12px;
        border-radius: 4px;
    }

    .header a:hover {
        background: #555;
    }

    button  {
        background: #04AA6D;
        border:none;
        border-radius: 10px;
        padding:5px;
        cursor:pointer;
    }
</style>

<div class="header">

    <!---<a href="index.cfm">Log-In</a>
    --->
    <cfif structKeyExists(session, "isLoggedIn") AND session.isLoggedIn>
        <div>
            <a href="home.cfm">Home</a>

        </div>

        <div>
            <a href="employees.cfm">Employees</a>
            
        </div>
        <div>
            <a href="logout.cfm">Log-Out</a>
            <!---<button onclick="signOff()">
                Log-Out
            </button>--->
        </div>
        
        
    </cfif>

</div>
<!---<cfdump var="#session#" >
<script>
    function signOff() {
        window.location = "login.cfm"
    }
</script>--->