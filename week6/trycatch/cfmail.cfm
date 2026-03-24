<!---<cfset myQuery = queryNew("recipient, firstname, lastname")>
<cfset queryAddRow(myQuery, {recipient: "grofafroinneitro-5835@yopmail.com", 
                firstname: "John", lastname: "Due"})>

<cfmail from="amaresh@hotmail.com" subject="Sample email" to="#recipient#" 
    query="myQuery">
    
    Dear #firstname# #lastname#,
    Please read below documents carefully
</cfmail>

<cfmail from="amaresh@hotmail1.com" subject="sending file" to="zevuttasoma-8894@yopmail.com" >
    <cfmailparam file="sampletext.txt" type="text/plain">
    Please read the document.
</cfmail>

<cfmail from="abc@mail.com" subject="Example mail" to="zevuttasoma-8894@yopmail.com" >
    <cfmailparam value="sampletext" name="sampletext">
    hello!!
</cfmail>

<cfmail from="amaresh@hotmail1.com" subject="sending file" to="zevuttasoma-8894@yopmail.com" >
    <cfmailparam file="sampletext.txt" type="text/plain">
    Please read the document.
    
</cfmail>


<cfmail from="amaresh@hotmail1.com" subject="sending file" to="zevuttasoma-8894@yopmail.com" type="HTML">
    <cfmailparam file="image.jpg" type="image" contentid="img">
    Please read the document.<br/>
    <img src="cid:img">
</cfmail>
--->


<h3>cfmailpart Example</h3> 
<cfmail from = "peter@domain.com" To = "zevuttasoma-8894@yopmail.com" 
Subject = "Which version do you see?"> 
<cfmailpart type="text" wraptext="74"> 
You are reading this message as plain text, because your mail reader does not handle 
HTML text. 
</cfmailpart> 
<cfmailpart type="html"> 
<h3>HTML Mail Message</h3> 
<p>You are reading this message as <strong>HTML</strong>.</p> 
<p>Your mail reader handles HTML text.</p> 
</cfmailpart> 
</cfmail>