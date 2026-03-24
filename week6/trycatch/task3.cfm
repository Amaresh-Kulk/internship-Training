<style>
body    {
    align-items: center;
}
    .container  {
        display:flex;
        flex-direction: column;
        padding 20px;
        border: 1px solid grey;
        justify-content: center;
        max-width: 320px;
        max-height: 600px;
        margin: 30px auto;
        border-radius: 20px;
    }
    .box    {
        padding: 10px;
        
    }
    label   {
        
        display: block;
    }
    input   {
        padding:5px;
        padding-right: 20px;
    }
    input[name:"subject"]   {
        padding:25px;
    }
    input[type="address"]   {
        padding: 20px;
    }
    input[type="submit"]    {
        cursor: pointer;
        border: none;
        border-radius: 20px;
        background: blue;
        padding: 10px;
        width: 320px;
        text-align:center;
        margin: 1px auto 0px auto;
        color: white;
    }
</style>

<form action="" method="post">
    <div class="container">
        <div class="box">
            <label>Name:</label> 
            <input type="text" name="name"><br/>
        </div>
        <div class="box">
            <label>Email:</label>
            <input type="email" name="email"><br/>
        </div>
        <div class="box">
            <label>Subject:</label>
            <input type="text" name="subject"><br/>
        </div>
        <div class="box">
            <label>Message: </label>
            <input type="address" name="message"><br/>
        </div>

        <input type="submit">
    </div>
</form>


<cfif structKeyExists(form,"name")>
    <cfmail from="#form.email#" subject="#form.subject#" to="amareshkulkarni2@gmail.com" >
    #form.message#        
    </cfmail>
    <cfdump var="#form#" >
</cfif>

<cfquery name="h" datasource="ecommercedb">
    select * from Customer;
</cfquery>

<cfoutput query="h">
    #first_name#<br/>
</cfoutput>