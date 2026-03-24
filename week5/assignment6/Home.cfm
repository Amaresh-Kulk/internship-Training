<cfif NOT structKeyExists(session, "isLoggedIn") OR NOT session.isLoggedIn>
    <cflocation url="login.cfm" addtoken="false">

</cfif>

<style>
    #home   {
        text-align: center;
        
    }
</style>

<cfoutput>
    <div id="home">
        <h2>Welcome #session.userName#!</h2>
        <p>You are successfully logged in.</p>
    </div>
</cfoutput>
