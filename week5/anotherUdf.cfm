<!---<cfinclude template="udf.cfm" >
<cfoutput >
    #addAandB(3, 5)#
</cfoutput>
--->

<!---

<cffunction name="giveDiscount" returntype="void">
    <cfargument name="price" type="array" required="true">

    <cfset discount = 0.10>

    <cfset price[1] =  price[1] - price[1] * discount >
    <cfset price[2] = "pqrs">
</cffunction>

<form action="" method="post">
    <input type="number" name="price">
    <input type="submit">
</form>

<cfif structKeyExists(form,"price")>
    <cfset arr = arrayNew(1)>
    <cfset arrayAppend(arr, form.price)>
    <cfset arrayAppend(arr, "abcd")>
    <cfset giveDiscount(arr)>
    <cfoutput>#arr[1]#<br/></cfoutput>
    <cfoutput>#arr[2]#<br/></cfoutput>
</cfif>

<cftry>
<cffunction name="getCustomerRecord"  returntype="void">
    <cfargument name="form" type="struct">
    
        <cfquery name="getCustomer" datasource="practice1_0">
            select * from Customer where id = #form.id#;
        </cfquery>
        
    
    <cfoutput query="getCustomer">
        <cfset form.first_name = first_name>        
        <cfset form.middle_name = middle_name>        
        <cfset form.last_name = last_name>        
    </cfoutput>

    
</cffunction>

<form action="" method="post">
    <input type="number" name="id">
    <input type="submit">
</form>

<cfif structKeyExists(form, "id")>
    <cfoutput >
            #getCustomerRecord(form)#
            #form.id#: #form.first_name# : #form.middle_name# : #form.last_name#<br/>
        </cfoutput>
</cfif>

<cfcatch>
    <cfoutput >
        Record for #form.id# doesn't exists<br/>                
    </cfoutput>
        
</cfcatch>
</cftry>

<cffunction name="voidCall" returntype="number">
    <cfset num = 10>
    <cfreturn num>
</cffunction>

<cfoutput >
    #voidCall()#<br/>
</cfoutput>
--->
<cfset variables.num = 20>

<cfset session.num = 60>
<cfset this.num = 70>
<cfdump var="#num#" >
<cffunction name="scopes" >
    <cfargument name="num" type="number" required="true">
    <cfset var num = 10>
    <cfset arguments.num = 50>
    <cfset variables.num = 40>
    <cfoutput >
            #num#<br/>
            #local.num#<br/>
            #variables.num#<br/>
            #arguments.num#<br/>
    </cfoutput>

</cffunction>

<cfset num = 30>
<cfdump var="#num#" >
<cfset scopes(num)>

<cfoutput >
    #variables.num# <br/>
    #num# <br/>
</cfoutput>

<cffunction name="printFullName">
    <cfargument name="first_name" type="string" required="true">
    <cfargument name="middle" type="string" required="false" default="---">
    <cfargument name="last" type="string" required="false" default="---">

    <cfoutput >
            The full name is: #first_name# #middle#
                     #last#<br/>
        </cfoutput>
</cffunction>


<cfset first_name = 'Amaresh'>
<cfset printFullName(first_name = "Trisha", last = "Patil", middle_name="Rahul")>

<cfdump var="#form#">
<!---<cfdump var="#last_name#">
<cfdump var="#isDefined("last_name")#" >
--->
<form action="" method="post">
    <input type="text" name="name">
    <input type="submit">
</form>

<cffunction name="reverseString" >
    <cfargument name="arr" type="array">
    <cfset j = len(arr[1])>
    <cfset i = 1>
    <cfset s = arr[1]>
    <cfset chars = listToArray(s, "")>
    <cfloop condition="i lte j">
        <cfset temp = chars[j]>
        <cfset chars[j] = chars[i]>
        <cfset chars[i] = temp>
        
        <cfset i = i + 1>
        <cfset j = j - 1>
    </cfloop>
    <cfset arr[1] = arrayToList(chars, "")>

</cffunction>

<cfif structKeyExists(form, "name")>
    <cfset arr = arrayNew(1)>
    <cfset arrayAppend(arr, form.name)>
    <cfset reverseString(arr)>
    <cfset form.name = arr[1]>
    <cfoutput>
            #form.name#<br/>
    </cfoutput>
</cfif>

<cffunction name="validateUser">
    <cfargument name="email" type="string" required="true">
    <cfargument name="num" type="number" required="true">
    <cfargument name="name" type="string" required="true">

    <cfif not reFind("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$", email)>
        <cfreturn false>
    </cfif>

    <cfif num lte 0 or num gt 100>
        <cfreturn false>
    </cfif>

    <cfif not reFind("^[A-Za-z ]+$",name)>
        <cfreturn false>
    </cfif>
    <cfreturn true>
</cffunction>

<form action="" method="post">
    <input type="email" name="email" required>
    <input type="number" name="num" required>
    <input type="text" name="name" required>
    <input type="submit">
</form>

<cfif structKeyExists(form,"email") and structKeyExists(form,"num") and structKeyExists(form, "name")>
    <cfset isCorrect = validateUser(form.email,form.num,form.name)>

    <cfif isCorrect>
        <cfoutput >
            You entered correct information<br/>            
        </cfoutput>
    <cfelse>
        <cfoutput >
            You entered wrong information<br/>            
        </cfoutput>
    </cfif>
</cfif>