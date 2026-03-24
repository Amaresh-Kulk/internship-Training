<cfcomponent output="false">

    <cffunction name="sendMail" access="public" returntype="struct" output="false">
        
        
        <cfargument name="senderName"  type="string" required="true">
        <cfargument name="senderEmail" type="string" required="true">
        <cfargument name="subject"     type="string" required="false" default="">
        <cfargument name="message"     type="string" required="false" default="">
        <cfargument name="fileField"   type="string" required="false" default="">

        <cfset var result = structNew()>
        <cfset var uploadPath = expandPath("./tempAttachments")>
        <cfset var uploadedFilePath = "">

        
        <cfif NOT len(trim(arguments.senderName)) 
            OR NOT reFind("^[A-Za-z ]+$", arguments.senderName)>

            <cfset result.status = "error">
            <cfset result.message = "Invalid Name. Only letters allowed.">
            <cfreturn result>
        </cfif>

        
        <cfif NOT isValid("email", arguments.senderEmail)>
            <cfset result.status = "error">
            <cfset result.message = "Invalid Email Address.">
            <cfreturn result>
        </cfif>

        
        <cfif NOT directoryExists(uploadPath)>
            <cfdirectory action="create" directory="#uploadPath#">
        </cfif>

        <cftry>

            
            <cfif len(arguments.fileField) 
                AND structKeyExists(form, arguments.fileField) 
                AND len(form[arguments.fileField])>

                <cffile 
                    action="upload"
                    filefield="#arguments.fileField#"
                    destination="#uploadPath#"
                    nameconflict="makeunique">

                <cfset uploadedFilePath = cffile.serverDirectory & "/" & cffile.serverFile>
            </cfif>

            
            <cfmail 
                to="solauquammukeu-4918@yopmail.com"
                from="#arguments.senderEmail#"
                subject="#arguments.subject#"
                type="html">

                <h3>New Message</h3>

                <p><strong>Name:</strong> #arguments.senderName#</p>
                <p><strong>Email:</strong> #arguments.senderEmail#</p>
                <p><strong>Message:</strong></p>
                <p>#arguments.message#</p>

                
                <cfif len(uploadedFilePath)>
                    <cfmailparam file="#uploadedFilePath#">
                </cfif>

            </cfmail>

            
            <cfif len(uploadedFilePath)>
                <cffile action="delete" file="#uploadedFilePath#">
            </cfif>

            <cfset result.status = "success">
            <cfset result.message = "Email sent successfully with attachment (if provided).">

        <cfcatch>

            <cflog file="error"
                   text="#now()# | Mail Error | #cfcatch.message#">

            <cfset result.status = "error">
            <cfset result.message = "Error sending email: " & cfcatch.message>

        </cfcatch>
        </cftry>

        <cfreturn result>

    </cffunction>

</cfcomponent>