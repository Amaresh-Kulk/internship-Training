<form method="post" action="" class="calc-form">
    <input type="text" name="expr" id="expr" placeholder="0" readonly>

    <div class="keys">
        <button type="button" onclick="add('7')">7</button>
        <button type="button" onclick="add('8')">8</button>
        <button type="button" onclick="add('9')">9</button>
        <button type="button" onclick="add('/')">/</button>

        <button type="button" onclick="add('4')">4</button>
        <button type="button" onclick="add('5')">5</button>
        <button type="button" onclick="add('6')">6</button>
        <button type="button" onclick="add('*')">*</button>

        <button type="button" onclick="add('1')">1</button>
        <button type="button" onclick="add('2')">2</button>
        <button type="button" onclick="add('3')">3</button>
        <button type="button" onclick="add('-')">-</button>

        <button type="button" onclick="add('0')">0</button>
        <button type="button" onclick="add('.')">.</button>
        <button type="button" onclick="clearBox()">C</button>
        <button type="submit">=</button>
        <button type="button" onclick="add('+')">+</button>
    </div>
</form>

<style>
.calc-form {
    width: 220px;
    background: #f9f9f9;
    padding: 15px;
    border-radius: 8px;
    border: 1px solid #ccc;
}

.calc-form input {
    width: 90%;
    padding: 8px;
    margin-bottom: 10px;
    text-align: right;
    font-size: 16px;
}

.keys {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 6px;
}

.keys button {
    padding: 8px;
    font-size: 14px;
    border-radius: 4px;
    border: 1px solid #bbb;
    background: white;
    cursor: pointer;
}

.keys button:hover {
    background: #eee;
}

.box {
    margin-top: 15px;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 6px;
    background: #f9f9f9;
    text-align: center;
}

.error {
    color: red;
}
</style>

<script>
function add(val) {
    document.getElementById("expr").value += val;
}
function clearBox() {
    document.getElementById("expr").value = "";
}
</script>

<cfif structKeyExists(form, "expr")>

    <cfset expr = replace(form.expr, " ", "", "all")>
    <cfset tokens = []>
    <cfset num = "">

    
    <cfloop from="1" to="#len(expr)#" index="i">
        <cfset ch = mid(expr, i, 1)>
        <cfif isNumeric(ch) OR ch EQ ".">
            <cfset num &= ch>
        <cfelse>
            <cfset arrayAppend(tokens, num)>
            <cfset arrayAppend(tokens, ch)>
            <cfset num = "">
        </cfif>
    </cfloop>
    <cfset arrayAppend(tokens, num)>

    
    <cfset i = 1>
    <cfloop condition="i LTE arrayLen(tokens)">
        <cfif tokens[i] EQ "*" OR tokens[i] EQ "/" OR tokens[i] EQ "%">
            <cfset a = val(tokens[i-1])>
            <cfset b = val(tokens[i+1])>

            <cfif (tokens[i] EQ "/" OR tokens[i] EQ "%") AND b EQ 0>
                <cfset session.calculator = "Error: Can't divide by zero">
                <cfbreak>
            </cfif>

            <cfif tokens[i] EQ "*"><cfset r = a * b></cfif>
            <cfif tokens[i] EQ "/"><cfset r = a / b></cfif>
            <cfif tokens[i] EQ "%"><cfset r = a MOD b></cfif>

            <cfset tokens[i-1] = r>
            <cfset arrayDeleteAt(tokens, i)>
            <cfset arrayDeleteAt(tokens, i)>
            <cfset i = i - 1>
        <cfelse>
            <cfset i = i + 1>
        </cfif>
    </cfloop>

    
    <cfif NOT structKeyExists(session, "calculator")>
        <cfset result = val(tokens[1])>
        <cfloop from="2" to="#arrayLen(tokens)#" step="2" index="i">
            <cfif tokens[i] EQ "+">
                <cfset result += val(tokens[i+1])>
            <cfelse>
                <cfset result -= val(tokens[i+1])>
            </cfif>
        </cfloop>

        <cfset session.calculator = expr & " = " & result>
    </cfif>

</cfif>

<cfif structKeyExists(session, "calculator")>
    <cfoutput>
        <div class="box">#session.calculator#</div>
    </cfoutput>
</cfif>


