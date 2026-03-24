<style>

    .footer-container{
    /* position: absolute; */
    }

    .footer-bottom{
    position: fixed;
    bottom: 0;
    text-align:center;
    border-top:1px solid #e5e7eb;
    font-size:13px;
    color:#6b7280;

    background:#ffffff;
    color:#6b7280;
    padding:10px 20px 15px;
    margin-top:10px;

    width: 100%;

    }

    /* Back Button */

    /* .back-btn{
    position:fixed;
    bottom:20px;
    right:20px;
    background:#2563eb;
    color:white;
    border:none;
    padding:10px 16px;
    border-radius:8px;
    font-size:14px;
    cursor:pointer;
    box-shadow:0 4px 12px rgba(0,0,0,0.15);
    width: 70px;
    }

    .back-btn:hover{
    background:#1e40af;
    } */

</style>

<!---
<div class="footer-container">
--->
    <div class="footer-bottom">
        <cfoutput>#year(now())#</cfoutput> EcommerceOSS. All rights reserved.
    </div>

  <!---  <button class="back-btn" onclick="history.back()">
        Back
    </button>

</div>--->