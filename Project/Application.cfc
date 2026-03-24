<cfcomponent output="false">

    
    <cfset this.name = "EcommerceOSS">
    <cfset this.sessionManagement = true>
    <cfset this.sessionTimeout = createTimeSpan(0,0,30,0)>
    <cfset this.loginStorage = "session">

    
    <cffunction name="onApplicationStart" returnType="boolean" output="false">

        <cfset application.appName = "Ecommerce Online Shopping System">

        
        <cfset application.securityDB = "securitydb">
        <cfset application.customerDB = "customerdb">
        <cfset application.storeDB = "storedb">

        <cfreturn true>

    </cffunction>


    
    <cffunction name="onSessionStart" returnType="void" output="false">

        <cfset session.isLoggedIn = false>
        <cfset session.userID = "">
        <cfset session.userName = "">
        <cfset session.role = "">

    </cffunction>

    <!-- Authorization for every request -->

    <cffunction name="onRequestStart" returntype="boolean">

        <cfargument name="targetPage" required="true">


        <!-- Allow login page and public pages -->

        <cfif findNoCase("login.cfm", arguments.targetPage) OR
              findNoCase("404.cfm", arguments.targetPage) OR
              findNoCase("Register.cfm", arguments.targetPage) OR
              findNoCase("forgotPassword.cfm", arguments.targetPage)>
            <cfreturn true>
        </cfif>


        <!-- Check if session exists -->

        <cfif NOT structKeyExists(session,"userID")>

            <cfoutput>
                <div style="
                font-family:Segoe UI;
                padding:50px;
                text-align:center;
                ">

                    <h2 style="color:red;">Access Restricted</h2>

                    <p style="margin:15px 0;color:grey;">
                        You are not authorized to access this page.
                        Please login first.
                    </p>

                    <a href="/EcommerceOSS/login.cfm?redirect=#urlEncodedFormat(arguments.targetPage)#">
                        <button style="
                            background:blue;
                            color:white;
                            border:none;
                            padding:12px 20px;
                            border-radius:8px;
                            font-size:14px;
                            cursor:pointer;
                        ">
                            Login
                        </button>
                    </a>

                </div>
            </cfoutput>

            <cfabort>

        </cfif>


        <!-- Admin pages protection -->

        <cfif findNoCase("/admin/", arguments.targetPage) AND session.role NEQ "admin">

            <cfoutput>
                <div style="text-align:center;padding:50px;">

                    <h2 style="color:red;">Admin Access Required</h2>

                    <p>You don't have permission to access this page.</p>

                    <a href="/EcommerceOSS/login.cfm">
                        <button style="
                            background:blue;
                            color:white;
                            padding:10px 18px;
                            border:none;
                            border-radius:6px;
                        ">
                            Login as Admin
                        </button>
                    </a>

                </div>
            </cfoutput>

            <cfabort>

        </cfif>


        <!-- Customer pages protection -->

        <cfif findNoCase("/customer/", arguments.targetPage) AND session.role NEQ "user">

            <cfoutput>
                <div style="text-align:center;padding:50px;">

                    <h2 style="color:red;">Customer Access Only</h2>

                    <p>This page is only available for customers.</p>

                    <a href="/EcommerceOSS/login.cfm">
                        <button style="
                            background:blue;
                            color:white;
                            padding:10px 18px;
                            border:none;
                            border-radius:6px;
                        ">
                            Login
                        </button>
                    </a>

                </div>
            </cfoutput>

            <cfabort>

        </cfif>


        <cfreturn true>

    </cffunction>


   
    <cffunction name="onError" returntype="void" output="false">

        <cfargument name="exception" required="true">
        <cfargument name="eventName" required="true">

        
        <cflog
            file="errorLog"
            type="error"
            text="Exception in #arguments.eventName# :
            Message: #arguments.exception.message#
            Detail: #arguments.exception.detail#
            StackTrace: #arguments.exception.stackTrace#">

    </cffunction>

    <cffunction name="onMissingTemplate" returntype="boolean">

        <cfargument name="targetPage" type="string" required="true">

        <cflocation url="/EcommerceOSS/404.cfm" addtoken="false">


    </cffunction>

</cfcomponent>