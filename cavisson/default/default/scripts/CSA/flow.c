/*-----------------------------------------------------------------------------
    Name: flow
    Recorded By: cavisson
    Date of recording: 04/14/2023 11:15:56
    Flow details:
    Build details: 4.6.1 (build# 93)
    Modification History:
-----------------------------------------------------------------------------*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ns_string.h"

/*----------------------------------------------------------------------------
human_steps:1. **Open URL:** Navigate to `https://www.flipkart.com/`.
2. **Fill Search Box:** Enter `mobile` into the search field.
3. **Click Search Button:** Click the button labeled **"Search for Products, Brands and More"**.
4. **Click Search Button:** Click the button labeled **"Search"** on the results page.
steps:{"pages":[{"asserts":[],"title_re":null,"pagedump_url":null,"thinkTime":-1,"name":"Others","title":"Online Shopping Site for Mobiles, Electronics, Furniture, Grocery, Lifestyle, Books & More. Best Offers!","navigationType":0,"actions":[{"xpath":"html\/body\/div[1]\/div\/div[1]\/div\/div\/div\/div\/div\/div\/div\/div\/div\/div[1]\/div\/div\/header\/div[1]\/div[2]\/form\/div\/div\/input","idType":"selector","thinkTime":10,"width":"0","id":"html > body > div:nth-of-type(1) > div > div:nth-of-type(1) > div > div > div > div > div > div > div > div > div > div:nth-of-type(1) > div > div > header > div:nth-of-type(1) > div:nth-of-type(2) > form > div > div > input.Pke_EE[type=\"text\"][title=\"Search for Products, Brands and More\"][name=\"q\"][autocomplete=\"off\"][placeholder=\"Search for Products, Brands and More\"]","type":"change","elementType":"INPUT","value":"mobile","height":"0"}],"url":"https:\/\/www.flipkart.com\/"},{"asserts":[],"title_re":null,"pagedump_url":null,"thinkTime":-1,"name":"Others","title":"Online Shopping Site for Mobiles, Electronics, Furniture, Grocery, Lifestyle, Books & More. Best Offers!","navigationType":-1,"actions":[{"xpath":"html\/body\/div[1]\/div\/div[1]\/div\/div\/div\/div\/div\/div\/div\/div\/div\/div[1]\/div\/div\/header\/div[1]\/div[2]\/form\/div\/button","idType":"selector","thinkTime":14,"width":"0","id":"html > body > div:nth-of-type(1) > div > div:nth-of-type(1) > div > div > div > div > div > div > div > div > div > div:nth-of-type(1) > div > div > header > div:nth-of-type(1) > div:nth-of-type(2) > form > div > button._2iLD__[type=\"submit\"][aria-label=\"Search for Products, Brands and More\"][title=\"Search for Products, Brands and More\"]","type":"click","elementType":"BUTTON","value":"","height":"0"}],"url":"https:\/\/www.flipkart.com\/"},{"asserts":[],"title_re":null,"pagedump_url":null,"thinkTime":-1,"name":"Others","title":"Mobile- Buy Products Online at Best Price in India - All Categories | Flipkart.com","navigationType":-1,"actions":[{"xpath":"html\/body\/div[1]\/div\/div[1]\/div[1]\/div[2]\/div[2]\/form\/div\/button","idType":"selector","thinkTime":9,"width":"0","id":"html > body > div:nth-of-type(1) > div > div:nth-of-type(1) > div:nth-of-type(1) > div:nth-of-type(2) > div:nth-of-type(2) > form > div > button.MJG8Up[type=\"submit\"]","type":"click","elementType":"BUTTON","value":"","height":"0"}],"url":"https:\/\/www.flipkart.com\/search?q=mobile&otracker=search&otracker1=search&marketplace=FLIPKART&as-show=on&as=off"}],"OS":{"name":"WINDOWS","version":"11"},"userAgent":"WINDOWS\/11; x86; ; Google Chrome\/134; 134.0.6998.165","uuid":"0806d19c-743d-4f04-ad92-a2f6c5a0c134","device":"PC","resolution":"1536x864","Browser":{"name":"Chrome","version":"134"},"Location":{"country":"Others"},"tags":[]}
-----------------------------------------------------------------------------*/

void flow()
{
    ns_start_transaction("index");
    ns_web_url ("index",
        "URL=https://www.cavisson.com/aaa-app/",
        "HEADER=Upgrade-Insecure-Requests:1",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        INLINE_URLS,
            "URL=https://www.cavisson.com/aaa-app/rfRes/datatable.ecss.xhtml?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/rfRes/datascroller.ecss.xhtml?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/rfRes/popupPanel.ecss.xhtml?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/rfRes/calendar.ecss.xhtml?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/style.scss?crc=35028a4325f902599b9d233517d61cecf68921c4:blue", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/css-plain/index-default.css?crc=8df6e3073927a0f7952b145dff384c5816546cb8", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/css-plain/index-custom.css?crc=f50929fa5198a781ee02f403103d4d2fde2107db", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/theme.scss?ln=scss/theme/blue&crc=4d8a2dbea4209567e9a72fd08f56ffee7da8b381:blue", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/jsf.js?ln=javax.faces&crc=cf18b5c6bee824112dc894dd35debcb5c46528d7", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/jquery/jquery.js?ln=primefaces&crc=abfa24db127591cd2defbf6fd6b8e097da7f6af6", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/richfaces.js?crc=c0e3450c92a522ed0569ebcadc3c1c3e79e19b92", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/richfaces-base-component.js?crc=16b7e47381dcb31e65522feae29565e05ebf694a", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/datatable.js?ln=org.richfaces&crc=4766f61371b64ae249b7f03a5b8ca332a746016b", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/richfaces-queue.js?crc=b950ade239cb2d05fea1f27b7b1c6708175eed45", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/richfaces-event.js?crc=e51f0836164018bcd91651a6c4a5b3d1679e5439", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/datascroller.js?ln=org.richfaces&crc=e3ed7fa32cdddd082269e6f0bd5aba5f1f297da3", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/popupPanel.js?ln=org.richfaces&crc=75e71ab80660a389e1c2f56bd1e4d8eb0f1d0f88", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/popupPanelBorders.js?ln=org.richfaces&crc=2c5a827616173baa4a426065b1426e5079fb3255", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/popupPanelSizer.js?ln=org.richfaces&crc=cd63dd984684fc4f39f327078449f267862fc2ff", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/jquery.position.js?crc=0c6d2d0c395a50e53f9d3eaf590514fe2a2529f1", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/json-dom.js?ln=org.richfaces&crc=ecbe16df0e1113de146a2827ed47e124181066d5", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/jquery/jquery-plugins.js?ln=primefaces&crc=d5625b9b0f27fdd73b0ada8363fa1f38a7738dae", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/JQuerySpinBtn.js?ln=org.richfaces&crc=87b46721fda2a0cd09ebc102bebd26a2f7a23133", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/calendar-utils.js?ln=org.richfaces&crc=77a3151e5b605a5d047bd0c5fed5a6898848a9de", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/calendar.js?ln=org.richfaces&crc=bfff6614e0b90d2acdb09a97e0d1b583ab37dce3", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/togglePanel.js?ln=org.richfaces&crc=7f14f3eb908079d77528a87698e7fd96ad4e9eb1", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/togglePanelItem.js?ln=org.richfaces&crc=64c0fdeea19be7d5e1feaab8cd9caa2f2709e8c0", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/collapsiblePanel.js?ln=org.richfaces&crc=78078f4da3df99435bb181f4b394cc570031a160", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/collapsiblePanelItem.js?ln=org.richfaces&crc=6b3a767aed1669fd539deace4acdbb3c2ad31d44", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/eis-scripts.min.js?crc=daf35335db98010e185d255e1553b4bd826e2b94", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/font/fontello.woff?31336992", "HEADER=Origin:https://www.cavisson.com", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE,
            "URL=https://www.cavisson.com/aaa-app/javax.faces.resource/font/fontello.woff?31336992", "HEADER=Origin:https://www.cavisson.com", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE", END_INLINE
    );

    ns_end_transaction("index", NS_AUTO_STATUS);
    ns_page_think_time(0.04);

    ns_start_transaction("flow");
    ns_web_url ("flow",
        "URL=https://www.cavisson.com/aaa-app/flow?_flowId=ipb-entry-flow",
        "HEADER=Upgrade-Insecure-Requests:1",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=oam.Flash.RENDERMAP.TOKEN;JSESSIONID;PASROUTE"
    );

    ns_end_transaction("flow", NS_AUTO_STATUS);
    ns_page_think_time(0.007);

    ns_start_transaction("SAML");
    ns_web_url ("SAML",
        "URL=https://www.con.com/aaa-external-stub-services-app/authentification/SAML",
        "METHOD=POST",
        "HEADER=Upgrade-Insecure-Requests:1",
        "HEADER=Origin:https://www.cavisson.com",
        "HEADER=Content-Type:application/x-www-form-urlencoded",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:navigate",
        "HEADER=Sec-Fetch-Dest:document",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=PASROUTE",
        BODY_BEGIN,
            "SAMLRequest=sampleReq",
        BODY_END
    );

    ns_end_transaction("SAML", NS_AUTO_STATUS);
    ns_page_think_time(42.063);


    // signin
    // 
    // ========================


    // login
    // 
    // ==============

    //Page Auto split for Button 'Login' Clicked by User
    ns_start_transaction("SAML_2");
    ns_web_url ("SAML_2",
        "URL=https://www.con.com/aaa-external-stub-services-app/authentification/SAML?",
        "METHOD=POST",
        "HEADER=Upgrade-Insecure-Requests:1",
        "HEADER=Origin:https://www.con.com",
        "HEADER=Content-Type:application/x-www-form-urlencoded",
        "HEADER=Sec-Fetch-Site:same-origin",
        "HEADER=Sec-Fetch-Mode:navigate",
        "HEADER=Sec-Fetch-User:?1",
        "HEADER=Sec-Fetch-Dest:document",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=PAS_SRV_JSESSIONID;PASROUTE",
        BODY_BEGIN,
            "username=Anjali&groups=T49&groups=U50&states=AZ&uw_level=04&billing_level=05&password=Anjali&submit=Login",
        BODY_END,
        );
         ns_end_transaction("SAML_2", NS_AUTO_STATUS);



         ns_start_transaction("SSO");
    		ns_web_url ("SSO",
    		  "URL=https://e3.pncie.com/aaa-app/saml/SSO",
            "METHOD=POST",
            "HEADER=Upgrade-Insecure-Requests:1",
            "HEADER=Origin:https://www.con.com",
            "HEADER=Content-Type:application/x-www-form-urlencoded",
            "HEADER=Sec-Fetch-Site:cross-site",
            "HEADER=Sec-Fetch-Mode:navigate",
            "HEADER=Sec-Fetch-Dest:document",
            "HEADER=Accept-Language:en-US,en;q=0.9",
            "REDIRECT=YES",
            "LOCATION=/aaa-app/flow?_flowId=ipb-entry-flow",
            ITEMDATA,
                "Name=SAMLResponse", "Value=SampleResp",
                "Name=submit", "Value=Login",
            ITEMDATA_END,
            INLINE_URLS,
            "URL=https://e3.pncie.com/aaa-app/flow?_flowId=ipb-entry-flow", "HEADER=Upgrade-Insecure-Requests:1", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Mode:navigate", "HEADER=Sec-Fetch-Dest:document", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;PASROUTE;GTQFSDHU", "REDIRECT=YES", "LOCATION=/aaa-app/faces/work/work-list.xhtml?_windowId=W1681537368383", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/faces/work/work-list.xhtml?_windowId=W1681537368383", "HEADER=Upgrade-Insecure-Requests:1", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Mode:navigate", "HEADER=Sec-Fetch-Dest:document", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/jquery/jquery.js?ln=primefaces&crc=abfa24db127591cd2defbf6fd6b8e097da7f6af6", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/faces/rfRes/datatable.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/faces/rfRes/datascroller.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/faces/rfRes/popupPanel.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/faces/rfRes/calendar.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/style.scss?crc=35028a4325f902599b9d233517d61cecf68921c4:blue", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/faces/rfRes/tooltip.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/eis-styles.min.css?crc=dca6f74eb38f9386801f1c90f6dc967118f2a968", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/primefaces.css?ln=primefaces&crc=55381084881a9a68f2cc1fa3769572784d05c328", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/watermark/watermark.css?ln=primefaces&crc=186d952b276bfce31ef2dd7d61e9fa2e906ca01e", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/schedule/schedule.css?ln=primefaces&crc=49a5910e945e178d2f926d9b41f9138a16429b1b", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/editor/editor.css?ln=primefaces&crc=11de34d08ce50f7d7f5fc583eeef5fc131fcf190", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/theme.scss?ln=scss/theme/blue&crc=4d8a2dbea4209567e9a72fd08f56ffee7da8b381:blue", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/primefaces.js?ln=primefaces&crc=3ef9e0d8279d09220d21c2545370fdf09d163d79", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/jsf.js?ln=javax.faces&crc=cf18b5c6bee824112dc894dd35debcb5c46528d7", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/richfaces.js?crc=c0e3450c92a522ed0569ebcadc3c1c3e79e19b92", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/richfaces-base-component.js?crc=16b7e47381dcb31e65522feae29565e05ebf694a", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/datatable.js?ln=org.richfaces&crc=4766f61371b64ae249b7f03a5b8ca332a746016b", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/richfaces-queue.js?crc=b950ade239cb2d05fea1f27b7b1c6708175eed45", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/richfaces-event.js?crc=e51f0836164018bcd91651a6c4a5b3d1679e5439", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/datascroller.js?ln=org.richfaces&crc=e3ed7fa32cdddd082269e6f0bd5aba5f1f297da3", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/popupPanel.js?ln=org.richfaces&crc=75e71ab80660a389e1c2f56bd1e4d8eb0f1d0f88", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/popupPanelBorders.js?ln=org.richfaces&crc=2c5a827616173baa4a426065b1426e5079fb3255", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/popupPanelSizer.js?ln=org.richfaces&crc=cd63dd984684fc4f39f327078449f267862fc2ff", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/jquery.position.js?crc=0c6d2d0c395a50e53f9d3eaf590514fe2a2529f1", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/json-dom.js?ln=org.richfaces&crc=ecbe16df0e1113de146a2827ed47e124181066d5", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/jquery/jquery-plugins.js?ln=primefaces&crc=d5625b9b0f27fdd73b0ada8363fa1f38a7738dae", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/JQuerySpinBtn.js?ln=org.richfaces&crc=87b46721fda2a0cd09ebc102bebd26a2f7a23133", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/calendar-utils.js?ln=org.richfaces&crc=77a3151e5b605a5d047bd0c5fed5a6898848a9de", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/calendar.js?ln=org.richfaces&crc=bfff6614e0b90d2acdb09a97e0d1b583ab37dce3", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/togglePanel.js?ln=org.richfaces&crc=7f14f3eb908079d77528a87698e7fd96ad4e9eb1", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/togglePanelItem.js?ln=org.richfaces&crc=64c0fdeea19be7d5e1feaab8cd9caa2f2709e8c0", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/collapsiblePanel.js?ln=org.richfaces&crc=78078f4da3df99435bb181f4b394cc570031a160", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/collapsiblePanelItem.js?ln=org.richfaces&crc=6b3a767aed1669fd539deace4acdbb3c2ad31d44", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/popup.js?ln=org.richfaces&crc=1dd8641fa0f53f5658d4376062cd13e8770a5cab", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/tooltip.js?ln=org.richfaces&crc=617c17b0c6a9326e701fde8306a46f5a9b979c4c", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/status.js?ln=org.richfaces&crc=5d0389f0633361f98a8ec33999933f3a8df93a71", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/js-plain/atmosphere.min.js?crc=b5b04dc461a090c1609e476f547ab4f4872d0bee", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/eis-scripts.min.js?crc=daf35335db98010e185d255e1553b4bd826e2b94", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/watermark/watermark.js?ln=primefaces&crc=2f7b4dc3c7e446a4763c88e1f04399b7644c6f7e", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/schedule/schedule.js?ln=primefaces&crc=fe4f8d437d115b17a68c2fffae69687dfe5601e8", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/editor/editor.js?ln=js-plain&crc=408955bcc63c4f9bf7037897e18a9c672fdaeebf", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/menuitem.js?ln=org.richfaces&crc=4e3df2c2184e4fbf2bcb4937f5ff776b920adc19", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/js-plain/bulk-actions-validator.min.js?crc=cbc7f203a32bcd16960f11c100665e8bcf456fcd", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/js-plain/primefaces-tooltip-extension.min.js?crc=10ed532ee0963edd10482e5eb218e2e399913155", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/js-plain/primefaces-schedule-extension.min.js?crc=cc31349ba91062facc032e293769c3efd5dfafbc", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/js/AAA_UI_Functions_3.0.js", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/js/AAA_UI_ValidationUtils_4.0.js", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/resources/css/aaaStyles.css", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/resources/css/mprogress.min.css", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/js/mprogress.min.js", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/js-plain/work-task-filter-controller.min.js?crc=3362c63934293d3ba58748492ded856a3b36645f", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/js-plain/aaa-work-task-filter-controller.js?crc=aa1cd18a8f4d1fcfd54c3173eb56b6cd65ee5b89", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/js-plain/predefined-filter.min.js?crc=b0baec1a66c415a71a22c5af6f640ae3b44d6386", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/js-plain/primefaces-selectoneradio-extension.min.js?crc=7a6ae8751b3fe2f5641d67f2a9fd2d201903529d", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/resources/css/images/1x1.gif", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:image", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/faces/rfRes/calendarIcon.png?v=4.3.0.Final-e2&db=eAH7f-X88f!PZzEAAB5uBeo_&ln=org.richfaces.images", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:image", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/css/images/close.png", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:image", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/font/fontello.woff?31336992", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=Origin:https://e3.pncie.com", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:cors", "HEADER=Sec-Fetch-Dest:font", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/css/images/AAA_Logo.png", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:image", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/faces/work/work-list.xhtml?_windowId=W1681537368383#noback", END_INLINE
    );
	ns_end_transaction("SSO", NS_AUTO_STATUS);
    ns_page_think_time(50.232);

     ns_start_transaction("flow_01");
    ns_web_url ("flow_01",
        "URL=https://e3.pncie.com/aaa-app/flow?_flowId=ipb-entry-flow", 
        "HEADER=Upgrade-Insecure-Requests:1",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:navigate", "HEADER=Sec-Fetch-Dest:document", 
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID;PASROUTE;GTQFSDHU",
        "REDIRECT=YES",
        "LOCATION=/aaa-app/faces/work/work-list.xhtml?_windowId=W1681537368383", 
    );

    ns_end_transaction("flow_01", NS_AUTO_STATUS);
	ns_page_think_time(55.741);

    ns_start_transaction("work_list_xhtml");
    ns_web_url ("work_list_xhtml",
        "URL=https://e3.pncie.com/aaa-app/faces/work/work-list.xhtml?_windowId=W1681537368383#noback2"
    );

    ns_end_transaction("work_list_xhtml", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("work_list_xhtml_2");
    ns_web_url ("work_list_xhtml_2",
        "URL=https://e3.pncie.com/aaa-app/faces/work/work-list.xhtml?_windowId=W1681537368383",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=X-Requested-With:XMLHttpRequest",
        "HEADER=Faces-Request:partial/ajax",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=Content-Type:application/x-www-form-urlencoded; charset=UTF-8",
        "HEADER=Origin:https://e3.pncie.com",
        "HEADER=Sec-Fetch-Site:same-origin",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU",
        ITEMDATA,
            "Name=javax.faces.partial.ajax", "Value=true",
            "Name=javax.faces.source", "Value=taskListForm:j_id_2b_3u_8p",
            "Name=javax.faces.partial.execute", "Value=@all",
            "Name=javax.faces.partial.render", "Value=taskViewContainerForm:taskViewTabs",
            "Name=taskListForm:j_id_2b_3u_8p", "Value=taskListForm:j_id_2b_3u_8p",
            "Name=taskListForm_SUBMIT", "Value=1",
            "Name=javax.faces.ViewState", "Value=tf0Mgc9O/DxZAdi+JMVi8+/09v+DMEGnX82Sdwq4cDlayLGk",
        ITEMDATA_END,
        INLINE_URLS,
            "URL=https://e3.pncie.com/aaa-app/faces/work/work-list.xhtml?_windowId=W1681537368383#noback", END_INLINE
    );

    ns_end_transaction("work_list_xhtml_2", NS_AUTO_STATUS);

   


    // click on search
    // 
    // ==========

    //Page Auto split for Link 'A' Clicked by User
    ns_start_transaction("flow_8");
    ns_web_url ("flow_8",
        "URL=https://e3.pncie.com/aaa-app/flow?_flowId=search-main-flow&_parentWindowId=W1681537368383",
        "HEADER=Upgrade-Insecure-Requests:1",
        "HEADER=Sec-Fetch-Site:same-origin",
        "HEADER=Sec-Fetch-Mode:navigate",
        "HEADER=Sec-Fetch-User:?1",
        "HEADER=Sec-Fetch-Dest:document",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU",
        INLINE_URLS,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/datatable.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/datascroller.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/popupPanel.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/calendar.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/style.scss?crc=35028a4325f902599b9d233517d61cecf68921c4:blue", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/tooltip.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/eis-styles.min.css?crc=dca6f74eb38f9386801f1c90f6dc967118f2a968", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/primefaces.css?ln=primefaces&crc=55381084881a9a68f2cc1fa3769572784d05c328", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/watermark/watermark.css?ln=primefaces&crc=186d952b276bfce31ef2dd7d61e9fa2e906ca01e", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/theme.scss?ln=scss/theme/blue&crc=4d8a2dbea4209567e9a72fd08f56ffee7da8b381:blue", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/js/search/aaaSearchValidation.js?crc=93fcf74d3844933b47d354f1e2536731f8027306", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/resources/css/aaaStyles.css", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/resources/css/mprogress.min.css", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/calendarIcon.png?v=4.3.0.Final-e2&db=eAH7f-X88f!PZzEAAB5uBeo_&ln=org.richfaces.images", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:image", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow?_flowId=search-main-flow&_parentWindowId=W1681537368383#noback", END_INLINE
    );

    ns_end_transaction("flow_8", NS_AUTO_STATUS);
    ns_page_think_time(68.196);

    ns_start_transaction("flow_2");
    ns_web_url ("flow_2",
        "URL=https://e3.pncie.com/aaa-app/flow?_flowId=search-main-flow&_parentWindowId=W1681537368383#noback2",
        INLINE_URLS,
            "URL=https://e3.pncie.com/aaa-app/flow?_flowId=search-main-flow&_parentWindowId=W1681537368383#noback", END_INLINE
    );

    ns_end_transaction("flow_2", NS_AUTO_STATUS);
    ns_page_think_time(91.823);


    // customer radio button
    // 
    // ============================

    //Page Auto split for 
    ns_start_transaction("flow_9");
    ns_web_url ("flow_9",
        "URL=https://e3.pncie.com/aaa-app/flow?_flowId=search-main-flow&_flowExecutionKey=e1s1&_windowId=W1681537368383",
        "METHOD=POST",
        "HEADER=Upgrade-Insecure-Requests:1",
        "HEADER=Origin:https://e3.pncie.com",
        "HEADER=Content-Type:application/x-www-form-urlencoded",
        "HEADER=Sec-Fetch-Site:same-origin",
        "HEADER=Sec-Fetch-Mode:navigate",
        "HEADER=Sec-Fetch-User:?1",
        "HEADER=Sec-Fetch-Dest:document",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU",
        BODY_BEGIN,
            "searchForm%3AentityTypeSelect=customer&searchForm%3AcoveragesPremiumsTable%3A0%3ApolicyNumber=&searchForm%3AcoveragesPremiumsTable%3A0%3AfirstName=&searchForm%3AcoveragesPremiumsTable%3A0%3AcustomerNumber=&searchForm%3AcoveragesPremiumsTable%3A0%3AproductCode=&searchForm%3AcoveragesPremiumsTable%3A0%3AlastName=&searchForm%3AcoveragesPremiumsTable%3A0%3AbrokerName=&searchForm%3AcoveragesPremiumsTable%3A0%3AagentOfRecord=&searchForm%3AcoveragesPremiumsTable%3A0%3Acity=&searchForm%3AcoveragesPremiumsTable%3A0%3AbrokerNumber=&searchForm%3AcoveragesPremiumsTable%3A0%3AagentNo=&searchForm%3AcoveragesPremiumsTable%3A0%3Astate=&searchForm%3AcoveragesPremiumsTable%3A0%3AunderwritingCompanyNumber=&searchForm%3AcoveragesPremiumsTable%3A0%3AaccountNumber=&searchForm%3AcoveragesPremiumsTable%3A0%3ApostCode=&searchForm%3AcoveragesPremiumsTable%3A0%3AdobInputDate=&searchForm%3AcoveragesPremiumsTable%3A0%3AdobInputCurrentDate=04%2F2023&searchForm%3AcoveragesPremiumsTable%3A0%3AbillingAccountNumber=&searchForm%3AcoveragesPremiumsTable%3A0%3Aphone=&searchForm_SUBMIT=1&javax.faces.ViewState=48a905d2-5092-4315-bfa8-ea3c098b2213&searchForm%3A_idcl=searchForm%3AclearListBtn",
        BODY_END,
        INLINE_URLS,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/datatable.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/datascroller.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/popupPanel.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/calendar.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/style.scss?crc=35028a4325f902599b9d233517d61cecf68921c4:blue", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/tooltip.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/primefaces.css?ln=primefaces&crc=55381084881a9a68f2cc1fa3769572784d05c328", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/watermark/watermark.css?ln=primefaces&crc=186d952b276bfce31ef2dd7d61e9fa2e906ca01e", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/eis-styles.min.css?crc=dca6f74eb38f9386801f1c90f6dc967118f2a968", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/theme.scss?ln=scss/theme/blue&crc=4d8a2dbea4209567e9a72fd08f56ffee7da8b381:blue", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/resources/css/aaaStyles.css", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/resources/css/mprogress.min.css", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow?_flowId=search-main-flow&_flowExecutionKey=e1s1&_windowId=W1681537368383#noback", END_INLINE
    );

    ns_end_transaction("flow_9", NS_AUTO_STATUS);
    ns_page_think_time(92.098);

    ns_start_transaction("flow_3");
    ns_web_url ("flow_3",
        "URL=https://e3.pncie.com/aaa-app/flow?_flowId=search-main-flow&_flowExecutionKey=e1s1&_windowId=W1681537368383#noback2",
        INLINE_URLS,
            "URL=https://e3.pncie.com/aaa-app/flow?_flowId=search-main-flow&_flowExecutionKey=e1s1&_windowId=W1681537368383#noback", END_INLINE
    );

    ns_end_transaction("flow_3", NS_AUTO_STATUS);
    ns_page_think_time(159.198);


    // firstname


    // last name


    // create account


    // click on ok 
    // =============

    //Page Auto split for Button 'OK' Clicked by User
    ns_start_transaction("flow_10");
    ns_web_url ("flow_10",
        "URL=https://e3.pncie.com/aaa-app/flow?_flowId=search-main-flow&_flowExecutionKey=e1s1&_windowId=W1681537368383",
        "METHOD=POST",
        "HEADER=Upgrade-Insecure-Requests:1",
        "HEADER=Origin:https://e3.pncie.com",
        "HEADER=Content-Type:application/x-www-form-urlencoded",
        "HEADER=Sec-Fetch-Site:same-origin",
        "HEADER=Sec-Fetch-Mode:navigate",
        "HEADER=Sec-Fetch-User:?1",
        "HEADER=Sec-Fetch-Dest:document",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU",
        "REDIRECT=YES",
        "LOCATION=/aaa-app/flow?_flowId=new-account-flow&customerLName=Test&customerLegalName=&customerFName=Perf&customerType=INDV&_windowId=W1681537368383",
        BODY_BEGIN,
            "searchForm%3AentityTypeSelect=customer&searchForm%3AcoveragesPremiumsTable%3A0%3ApolicyNumber=&searchForm%3AcoveragesPremiumsTable%3A0%3AfirstName=Perf&searchForm%3AcoveragesPremiumsTable%3A0%3AcustomerNumber=&searchForm%3AcoveragesPremiumsTable%3A0%3AproductCode=&searchForm%3AcoveragesPremiumsTable%3A0%3AlastName=Test&searchForm%3AcoveragesPremiumsTable%3A0%3AbrokerName=&searchForm%3AcoveragesPremiumsTable%3A0%3AagentOfRecord=&searchForm%3AcoveragesPremiumsTable%3A0%3Acity=&searchForm%3AcoveragesPremiumsTable%3A0%3AbrokerNumber=&searchForm%3AcoveragesPremiumsTable%3A0%3AagentNo=&searchForm%3AcoveragesPremiumsTable%3A0%3Astate=&searchForm%3AcoveragesPremiumsTable%3A0%3AunderwritingCompanyNumber=&searchForm%3AcoveragesPremiumsTable%3A0%3AaccountNumber=&searchForm%3AcoveragesPremiumsTable%3A0%3ApostCode=&searchForm%3AcoveragesPremiumsTable%3A0%3AdobInputDate=&searchForm%3AcoveragesPremiumsTable%3A0%3AdobInputCurrentDate=04%2F2023&searchForm%3AcoveragesPremiumsTable%3A0%3AbillingAccountNumber=&searchForm%3AcoveragesPremiumsTable%3A0%3Aphone=&searchForm%3AcustomerType=INDV&searchForm%3Ayes=OK&searchForm_SUBMIT=1&javax.faces.ViewState=48a905d2-5092-4315-bfa8-ea3c098b2213",
        BODY_END,
        INLINE_URLS,
            "URL=https://e3.pncie.com/aaa-app/flow?_flowId=new-account-flow&customerLName=Test&customerLegalName=&customerFName=Perf&customerType=INDV&_windowId=W1681537368383", "HEADER=Upgrade-Insecure-Requests:1", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:navigate", "HEADER=Sec-Fetch-User:?1", "HEADER=Sec-Fetch-Dest:document", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/datatable.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/datascroller.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/popupPanel.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/calendar.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/style.scss?crc=35028a4325f902599b9d233517d61cecf68921c4:blue", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/tooltip.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/msg.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/eis-styles.min.css?crc=dca6f74eb38f9386801f1c90f6dc967118f2a968", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/primefaces.css?ln=primefaces&crc=55381084881a9a68f2cc1fa3769572784d05c328", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/watermark/watermark.css?ln=primefaces&crc=186d952b276bfce31ef2dd7d61e9fa2e906ca01e", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/theme.scss?ln=scss/theme/blue&crc=4d8a2dbea4209567e9a72fd08f56ffee7da8b381:blue", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/message.js?ln=org.richfaces&crc=e0cf9586220046b27453a7816a642642c1259419", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/component-control.js?ln=org.richfaces&crc=2c5931e9a33751c98f9dbd3d64bd4cf111ae9994", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/js-plain/hide-spooler-on-validation-requests.min.js?crc=37395c011b233a3f35f561a93e9f6c7004e03286", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/js-plain/jquery.mask.min.js?crc=f430c4ec982fe0fb6ba38284c2e5d7018125f1a6", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/js-plain/customer-temporary-contacts-switch.min.js?crc=1d9eea7d67b16dd4b870daa7ddae52950256417b", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/resources/css/aaaStyles.css", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/resources/css/mprogress.min.css", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/richfaces-csv.js?ln=org.richfaces&crc=db6bfffa0b39de616ad8295e3099f3040c622e28", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/js-plain/customer-address.min.js?crc=051f837d5295b31965fc1ed2db96acc33af5806e", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/spacer.gif?crc=ea7df583983133b62712b5e73bffbcd45cc53736", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:image", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow?_flowId=new-account-flow&customerLName=Test&customerLegalName=&customerFName=Perf&customerType=INDV&_windowId=W1681537368383#noback", END_INLINE
    );

    ns_end_transaction("flow_10", NS_AUTO_STATUS);
    ns_page_think_time(160.319);

    ns_start_transaction("flow_4");
    ns_web_url ("flow_4",
        "URL=https://e3.pncie.com/aaa-app/flow?_flowId=new-account-flow&customerLName=Test&customerLegalName=&customerFName=Perf&customerType=INDV&_windowId=W1681537368383#noback2",
        INLINE_URLS,
            "URL=https://e3.pncie.com/aaa-app/flow?_flowId=new-account-flow&customerLName=Test&customerLegalName=&customerFName=Perf&customerType=INDV&_windowId=W1681537368383#noback", END_INLINE
    );

    ns_end_transaction("flow_4", NS_AUTO_STATUS);

    // zipcode


    //Page Auto split for Method = POST
    ns_start_transaction("flow_11");
    ns_web_url ("flow_11",
        "URL=https://e3.pncie.com/aaa-app/flow?_flowId=new-account-flow&_flowExecutionKey=e2s1&_windowId=W1681537368383",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Faces-Request:partial/ajax",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=Content-Type:application/x-www-form-urlencoded; charset=UTF-8",
        "HEADER=Origin:https://e3.pncie.com",
        "HEADER=Sec-Fetch-Site:same-origin",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU",
        ITEMDATA,
            "Name=crmForm:customerGeneralTogglePanel-value", "Value=true",
            "Name=crmForm:generalInfo_salutation", "Value=",
            "Name=crmForm:generalInfo_firstName", "Value=Perf",
            "Name=crmForm:generalInfo_middleName", "Value=",
            "Name=crmForm:generalInfo_lastName", "Value=Test",
            "Name=crmForm:generalInfo_suffix", "Value=",
            "Name=crmForm:generalInfo_birthDateInputDate", "Value=",
            "Name=crmForm:generalInfo_birthDateInputCurrentDate", "Value=04/2023",
            "Name=crmForm:generalInfo_genderCd", "Value=",
            "Name=crmForm:generalInfo_maritalStatusCd", "Value=",
            "Name=crmForm:generalInfo_taxId", "Value=",
            "Name=crmForm:contactMethod:contactMethodSelect", "Value=PHONE",
            "Name=crmForm:customerContactInfoTogglePanel-value", "Value=true",
            "Name=crmForm:addressTypeInfo_0_addressTypeCd", "Value=mailing",
            "Name=crmForm:addressInfo_0_countryCd", "Value=US",
            "Name=crmForm:addressInfo_0_postalCode", "Value=85053",
            "Name=crmForm:addressInfo_0_city", "Value=",
            "Name=crmForm:addressInfo_0_stateProvCd", "Value=",
            "Name=crmForm:addressInfo_0_addressLine1", "Value=",
            "Name=crmForm:addressInfo_0_addressLine2", "Value=",
            "Name=crmForm:addressInfo_0_doNotSolicitInd", "Value=false",
            "Name=crmForm:addressInfoComment_0_comment", "Value=",
            "Name=crmForm:contactSchedulingInfo_address__0_effectiveFromInputDate", "Value=",
            "Name=crmForm:contactSchedulingInfo_address__0_effectiveFromInputCurrentDate", "Value=04/2023",
            "Name=crmForm:contactSchedulingInfo_address__0_effectiveToInputDate", "Value=",
            "Name=crmForm:contactSchedulingInfo_address__0_effectiveToInputCurrentDate", "Value=04/2023",
            "Name=crmForm:contactSchedulingInfo_address__0_duration", "Value=",
            "Name=crmForm:addressContactMethod_0", "Value=ADDRESS",
            "Name=contactType", "Value=",
            "Name=crmForm:agencyAssignmentTogglePanel-value", "Value=true",
            "Name=selAgencyIndex", "Value=-1",
            "Name=removeAssignmentIndex", "Value=-1",
            "Name=crmForm:currentElementFocus", "Value=",
            "Name=crmForm_SUBMIT", "Value=1",
            "Name=javax.faces.ViewState", "Value=53c86b8f-9827-4de8-95a5-daf23b8c42b0",
            "Name=excludeFromBreadcrumb", "Value=excludeFromBreadcrumb",
            "Name=skipBeanValidation", "Value=true",
            "Name=org.richfaces.ajax.component", "Value=crmForm:onAddressChange_0",
            "Name=crmForm:onAddressChange_0", "Value=crmForm:onAddressChange_0",
            "Name=AJAX:EVENTS_COUNT", "Value=1",
            "Name=javax.faces.partial.event", "Value=undefined",
            "Name=javax.faces.source", "Value=crmForm:onAddressChange_0",
            "Name=javax.faces.partial.ajax", "Value=true",
            "Name=javax.faces.partial.execute", "Value=@component crmForm:onAddressChange_0",
            "Name=javax.faces.partial.render", "Value=@component",
            "Name=crmForm", "Value=crmForm",
        ITEMDATA_END
    );

    ns_end_transaction("flow_11", NS_AUTO_STATUS);

    // address line 1
    // 
    // 
    // =======================


    //Page Auto split for Method = POST
    ns_start_transaction("flow_12");
    ns_web_url ("flow_12",
        "URL=https://e3.pncie.com/aaa-app/flow?_flowId=new-account-flow&_flowExecutionKey=e2s1&_windowId=W1681537368383",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Faces-Request:partial/ajax",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=Content-Type:application/x-www-form-urlencoded; charset=UTF-8",
        "HEADER=Origin:https://e3.pncie.com",
        "HEADER=Sec-Fetch-Site:same-origin",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU",
        BODY_BEGIN,
            "crmForm%3AcustomerGeneralTogglePanel-value=true&crmForm%3AgeneralInfo_salutation=&crmForm%3AgeneralInfo_firstName=Perf&crmForm%3AgeneralInfo_middleName=&crmForm%3AgeneralInfo_lastName=Test&crmForm%3AgeneralInfo_suffix=&crmForm%3AgeneralInfo_birthDateInputDate=&crmForm%3AgeneralInfo_birthDateInputCurrentDate=04%2F2023&crmForm%3AgeneralInfo_genderCd=&crmForm%3AgeneralInfo_maritalStatusCd=&crmForm%3AgeneralInfo_taxId=&crmForm%3AcontactMethod%3AcontactMethodSelect=PHONE&crmForm%3AcustomerContactInfoTogglePanel-value=true&crmForm%3AaddressTypeInfo_0_addressTypeCd=mailing&crmForm%3AaddressInfo_0_countryCd=US&crmForm%3AaddressInfo_0_postalCode=85053&crmForm%3AaddressInfo_0_city=PHOENIX&crmForm%3AaddressInfo_0_stateProvCd=AZ&crmForm%3AaddressInfo_0_addressLine1=3127%20W%20Greenway%20Rd&crmForm%3AaddressInfo_0_addressLine2=&crmForm%3AaddressInfo_0_doNotSolicitInd=false&crmForm%3AaddressInfoComment_0_comment=&crmForm%3AcontactSchedulingInfo_address__0_effectiveFromInputDate=&crmForm%3AcontactSchedulingInfo_address__0_effectiveFromInputCurrentDate=04%2F2023&crmForm%3AcontactSchedulingInfo_address__0_effectiveToInputDate=&crmForm%3AcontactSchedulingInfo_address__0_effectiveToInputCurrentDate=04%2F2023&crmForm%3AcontactSchedulingInfo_address__0_duration=&crmForm%3AaddressContactMethod_0=ADDRESS&contactType=&crmForm%3AagencyAssignmentTogglePanel-value=true&selAgencyIndex=-1&removeAssignmentIndex=-1&crmForm%3AcurrentElementFocus=&crmForm_SUBMIT=1&javax.faces.ViewState=53c86b8f-9827-4de8-95a5-daf23b8c42b0&excludeFromBreadcrumb=excludeFromBreadcrumb&excludeFromBreadcrumb=excludeFromBreadcrumb&javax.faces.behavior.event=valueChange&org.richfaces.ajax.component=crmForm%3AaddressInfo_0_addressLine1&AJAX%3AEVENTS_COUNT=1&javax.faces.partial.event=change&javax.faces.source=crmForm%3AaddressInfo_0_addressLine1&javax.faces.partial.ajax=true&javax.faces.partial.execute=%40component%20crmForm%3AaddressInfo_0_addressLine1&javax.faces.partial.render=%40component&crmForm=crmForm",
        BODY_END
    );

    ns_end_transaction("flow_12", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("flow_13");
    ns_web_url ("flow_13",
        "URL=https://e3.pncie.com/aaa-app/flow?_flowId=new-account-flow&_flowExecutionKey=e2s1&_windowId=W1681537368383",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Faces-Request:partial/ajax",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=Content-Type:application/x-www-form-urlencoded; charset=UTF-8",
        "HEADER=Origin:https://e3.pncie.com",
        "HEADER=Sec-Fetch-Site:same-origin",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU",
        BODY_BEGIN,
            "crmForm%3AcustomerGeneralTogglePanel-value=true&crmForm%3AgeneralInfo_salutation=&crmForm%3AgeneralInfo_firstName=Perf&crmForm%3AgeneralInfo_middleName=&crmForm%3AgeneralInfo_lastName=Test&crmForm%3AgeneralInfo_suffix=&crmForm%3AgeneralInfo_birthDateInputDate=&crmForm%3AgeneralInfo_birthDateInputCurrentDate=04%2F2023&crmForm%3AgeneralInfo_genderCd=&crmForm%3AgeneralInfo_maritalStatusCd=&crmForm%3AgeneralInfo_taxId=&crmForm%3AcontactMethod%3AcontactMethodSelect=PHONE&crmForm%3AcustomerContactInfoTogglePanel-value=true&crmForm%3AaddressTypeInfo_0_addressTypeCd=mailing&crmForm%3AaddressInfo_0_countryCd=US&crmForm%3AaddressInfo_0_postalCode=85053&crmForm%3AaddressInfo_0_city=PHOENIX&crmForm%3AaddressInfo_0_stateProvCd=AZ&crmForm%3AaddressInfo_0_addressLine1=3127%20W%20Greenway%20Rd&crmForm%3AaddressInfo_0_addressLine2=&crmForm%3AaddressInfo_0_doNotSolicitInd=false&crmForm%3AaddressInfoComment_0_comment=&crmForm%3AcontactSchedulingInfo_address__0_effectiveFromInputDate=&crmForm%3AcontactSchedulingInfo_address__0_effectiveFromInputCurrentDate=04%2F2023&crmForm%3AcontactSchedulingInfo_address__0_effectiveToInputDate=&crmForm%3AcontactSchedulingInfo_address__0_effectiveToInputCurrentDate=04%2F2023&crmForm%3AcontactSchedulingInfo_address__0_duration=&crmForm%3AaddressContactMethod_0=ADDRESS&contactType=&crmForm%3AagencyAssignmentTogglePanel-value=true&selAgencyIndex=-1&removeAssignmentIndex=-1&crmForm%3AcurrentElementFocus=&crmForm_SUBMIT=1&javax.faces.ViewState=53c86b8f-9827-4de8-95a5-daf23b8c42b0&excludeFromBreadcrumb=excludeFromBreadcrumb&excludeFromBreadcrumb=excludeFromBreadcrumb&excludeFromBreadcrumb=excludeFromBreadcrumb&org.richfaces.ajax.component=crmForm%3Aj_id_2i_4v_5s_1_1_3_6&crmForm%3Aj_id_2i_4v_5s_1_1_3_6=crmForm%3Aj_id_2i_4v_5s_1_1_3_6&AJAX%3AEVENTS_COUNT=1&javax.faces.partial.event=undefined&javax.faces.source=crmForm%3Aj_id_2i_4v_5s_1_1_3_6&javax.faces.partial.ajax=true&javax.faces.partial.execute=%40component%20crmForm%3Aj_id_2i_4v_5s_1_1_3_6&javax.faces.partial.render=%40component&crmForm=crmForm",
        BODY_END
    );

    ns_end_transaction("flow_13", NS_AUTO_STATUS);

    // click on next
    // 
    // 
    // ======================


    //Page Auto split for Method = POST
    ns_start_transaction("flow_14");
    ns_web_url ("flow_14",
        "URL=https://e3.pncie.com/aaa-app/flow?_flowId=new-account-flow&_flowExecutionKey=e2s1&_windowId=W1681537368383",
        "METHOD=POST",
        "HEADER=Upgrade-Insecure-Requests:1",
        "HEADER=Origin:https://e3.pncie.com",
        "HEADER=Content-Type:application/x-www-form-urlencoded",
        "HEADER=Sec-Fetch-Site:same-origin",
        "HEADER=Sec-Fetch-Mode:navigate",
        "HEADER=Sec-Fetch-User:?1",
        "HEADER=Sec-Fetch-Dest:document",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU",
        BODY_BEGIN,
            "crmForm%3AcustomerGeneralTogglePanel-value=true&crmForm%3AgeneralInfo_salutation=&crmForm%3AgeneralInfo_firstName=Perf&crmForm%3AgeneralInfo_middleName=&crmForm%3AgeneralInfo_lastName=Test&crmForm%3AgeneralInfo_suffix=&crmForm%3AgeneralInfo_birthDateInputDate=&crmForm%3AgeneralInfo_birthDateInputCurrentDate=04%2F2023&crmForm%3AgeneralInfo_genderCd=&crmForm%3AgeneralInfo_maritalStatusCd=&crmForm%3AgeneralInfo_taxId=&crmForm%3AcontactMethod%3AcontactMethodSelect=PHONE&crmForm%3AcustomerContactInfoTogglePanel-value=true&crmForm%3AaddressTypeInfo_0_addressTypeCd=mailing&crmForm%3AaddressInfo_0_countryCd=US&crmForm%3AaddressInfo_0_postalCode=85053&crmForm%3AaddressInfo_0_city=PHOENIX&crmForm%3AaddressInfo_0_stateProvCd=AZ&crmForm%3AaddressInfo_0_addressLine1=3127+W+Greenway+Rd&crmForm%3AaddressInfo_0_addressLine2=&crmForm%3AaddressInfo_0_doNotSolicitInd=false&crmForm%3AaddressInfoComment_0_comment=&crmForm%3AcontactSchedulingInfo_address__0_effectiveFromInputDate=&crmForm%3AcontactSchedulingInfo_address__0_effectiveFromInputCurrentDate=04%2F2023&crmForm%3AcontactSchedulingInfo_address__0_effectiveToInputDate=&crmForm%3AcontactSchedulingInfo_address__0_effectiveToInputCurrentDate=04%2F2023&crmForm%3AcontactSchedulingInfo_address__0_duration=&crmForm%3AaddressContactMethod_0=ADDRESS&contactType=&crmForm%3AagencyAssignmentTogglePanel-value=true&selAgencyIndex=-1&removeAssignmentIndex=-1&crmForm%3AcurrentElementFocus=&crmForm_SUBMIT=1&javax.faces.ViewState=53c86b8f-9827-4de8-95a5-daf23b8c42b0&excludeFromBreadcrumb=excludeFromBreadcrumb&excludeFromBreadcrumb=excludeFromBreadcrumb&excludeFromBreadcrumb=excludeFromBreadcrumb&excludeFromBreadcrumb=excludeFromBreadcrumb&skipBeanValidation=true&crmForm%3A_idcl=crmForm%3AnextBtn",
        BODY_END
    );

    ns_end_transaction("flow_14", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("flow_15");
    ns_web_url ("flow_15",
        "URL=https://e3.pncie.com/aaa-app/flow?_flowId=new-account-flow&_flowExecutionKey=e2s1&_windowId=W1681537368383",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Faces-Request:partial/ajax",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=Content-Type:application/x-www-form-urlencoded; charset=UTF-8",
        "HEADER=Origin:https://e3.pncie.com",
        "HEADER=Sec-Fetch-Site:same-origin",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU",
        BODY_BEGIN,
            "crmForm%3AcustomerGeneralTogglePanel-value=true&crmForm%3AgeneralInfo_salutation=&crmForm%3AgeneralInfo_firstName=Perf&crmForm%3AgeneralInfo_middleName=&crmForm%3AgeneralInfo_lastName=Test&crmForm%3AgeneralInfo_suffix=&crmForm%3AgeneralInfo_birthDateInputDate=&crmForm%3AgeneralInfo_birthDateInputCurrentDate=04%2F2023&crmForm%3AgeneralInfo_genderCd=&crmForm%3AgeneralInfo_maritalStatusCd=&crmForm%3AgeneralInfo_taxId=&crmForm%3AcontactMethod%3AcontactMethodSelect=PHONE&crmForm%3AcustomerContactInfoTogglePanel-value=true&crmForm%3AaddressTypeInfo_0_addressTypeCd=mailing&crmForm%3AaddressInfo_0_countryCd=US&crmForm%3AaddressInfo_0_postalCode=85053&crmForm%3AaddressInfo_0_city=PHOENIX&crmForm%3AaddressInfo_0_stateProvCd=AZ&crmForm%3AaddressInfo_0_addressLine1=3127%20W%20Greenway%20Rd&crmForm%3AaddressInfo_0_addressLine2=&crmForm%3AaddressInfo_0_doNotSolicitInd=false&crmForm%3AaddressInfoComment_0_comment=&crmForm%3AcontactSchedulingInfo_address__0_effectiveFromInputDate=&crmForm%3AcontactSchedulingInfo_address__0_effectiveFromInputCurrentDate=04%2F2023&crmForm%3AcontactSchedulingInfo_address__0_effectiveToInputDate=&crmForm%3AcontactSchedulingInfo_address__0_effectiveToInputCurrentDate=04%2F2023&crmForm%3AcontactSchedulingInfo_address__0_duration=&crmForm%3AaddressContactMethod_0=ADDRESS&contactType=&crmForm%3AagencyAssignmentTogglePanel-value=true&selAgencyIndex=-1&removeAssignmentIndex=-1&crmForm%3AcurrentElementFocus=&crmForm_SUBMIT=1&javax.faces.ViewState=53c86b8f-9827-4de8-95a5-daf23b8c42b0&excludeFromBreadcrumb=excludeFromBreadcrumb&excludeFromBreadcrumb=excludeFromBreadcrumb&excludeFromBreadcrumb=excludeFromBreadcrumb&excludeFromBreadcrumb=excludeFromBreadcrumb&org.richfaces.ajax.component=crmForm%3Aj_id_2i_4o_7&crmForm%3Aj_id_2i_4o_7=crmForm%3Aj_id_2i_4o_7&AJAX%3AEVENTS_COUNT=1&javax.faces.partial.event=undefined&javax.faces.source=crmForm%3Aj_id_2i_4o_7&javax.faces.partial.ajax=true&javax.faces.partial.execute=%40component%20crmForm%3Aj_id_2i_4o_7&javax.faces.partial.render=%40component&crmForm=crmForm",
        BODY_END
    );

    ns_end_transaction("flow_15", NS_AUTO_STATUS);
    ns_page_think_time(0.109);

    //Page Auto split for Button 'Next' Clicked by User
    ns_start_transaction("datatable_ecss");
    ns_web_url ("datatable_ecss",
        "URL=https://e3.pncie.com/aaa-app/flow/rfRes/datatable.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=Sec-Fetch-Site:same-origin",
        "HEADER=Sec-Fetch-Mode:no-cors",
        "HEADER=Sec-Fetch-Dest:style",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU",
        INLINE_URLS,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/datascroller.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/popupPanel.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/calendar.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/style.scss?crc=35028a4325f902599b9d233517d61cecf68921c4:blue", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/tooltip.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/msg.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/eis-styles.min.css?crc=dca6f74eb38f9386801f1c90f6dc967118f2a968", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/primefaces.css?ln=primefaces&crc=55381084881a9a68f2cc1fa3769572784d05c328", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/watermark/watermark.css?ln=primefaces&crc=186d952b276bfce31ef2dd7d61e9fa2e906ca01e", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/theme.scss?ln=scss/theme/blue&crc=4d8a2dbea4209567e9a72fd08f56ffee7da8b381:blue", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/resources/css/aaaStyles.css", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/resources/css/mprogress.min.css", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/spacer.gif?crc=ea7df583983133b62712b5e73bffbcd45cc53736", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:image", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow?_flowId=new-account-flow&_flowExecutionKey=e2s1&_windowId=W1681537368383#noback", END_INLINE
    );

    ns_end_transaction("datatable_ecss", NS_AUTO_STATUS);
    ns_page_think_time(217.218);

    ns_start_transaction("flow_5");
    ns_web_url ("flow_5",
        "URL=https://e3.pncie.com/aaa-app/flow?_flowId=new-account-flow&_flowExecutionKey=e2s1&_windowId=W1681537368383#noback2",
        INLINE_URLS,
            "URL=https://e3.pncie.com/aaa-app/flow?_flowId=new-account-flow&_flowExecutionKey=e2s1&_windowId=W1681537368383#noback", END_INLINE
    );

    ns_end_transaction("flow_5", NS_AUTO_STATUS);
    ns_page_think_time(234.163);


    // click on done
    // 
    // ==============================

    //Page Auto split for Button 'Done' Clicked by User
    ns_start_transaction("flow_16");
    ns_web_url ("flow_16",
        "URL=https://e3.pncie.com/aaa-app/flow?_flowId=new-account-flow&_flowExecutionKey=e2s1&_windowId=W1681537368383",
        "METHOD=POST",
        "HEADER=Upgrade-Insecure-Requests:1",
        "HEADER=Origin:https://e3.pncie.com",
        "HEADER=Content-Type:application/x-www-form-urlencoded",
        "HEADER=Sec-Fetch-Site:same-origin",
        "HEADER=Sec-Fetch-Mode:navigate",
        "HEADER=Sec-Fetch-User:?1",
        "HEADER=Sec-Fetch-Dest:document",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU",
        "REDIRECT=YES",
        "LOCATION=/aaa-app/flow?_flowId=crm-customer-detail-flow&customerId=995896125417&_windowId=W1681537368383",
        BODY_BEGIN,
            "crmForm%3AcustomerRelationshipsTogglePanel-value=false&contactType=&crmForm%3AdoneBtn=Done&crmForm%3AcurrentElementFocus=&crmForm_SUBMIT=1&javax.faces.ViewState=b430e43e-2b20-4ca3-a613-a6dda330447c&excludeFromBreadcrumb=excludeFromBreadcrumb",
        BODY_END,
        INLINE_URLS,
            "URL=https://e3.pncie.com/aaa-app/flow?_flowId=crm-customer-detail-flow&customerId=995896125417&_windowId=W1681537368383", "HEADER=Upgrade-Insecure-Requests:1", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:navigate", "HEADER=Sec-Fetch-User:?1", "HEADER=Sec-Fetch-Dest:document", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/datatable.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/datascroller.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/popupPanel.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/calendar.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/style.scss?crc=35028a4325f902599b9d233517d61cecf68921c4:blue", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/tooltip.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/tree.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/msg.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/collapsible-subtable.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/eis-styles.min.css?crc=dca6f74eb38f9386801f1c90f6dc967118f2a968", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/primefaces.css?ln=primefaces&crc=55381084881a9a68f2cc1fa3769572784d05c328", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/watermark/watermark.css?ln=primefaces&crc=186d952b276bfce31ef2dd7d61e9fa2e906ca01e", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/fileupload/fileupload.css?ln=primefaces&crc=355fd685ed74f238afab76ffa3ea5a8c7613790c", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/editor/editor.css?ln=primefaces&crc=11de34d08ce50f7d7f5fc583eeef5fc131fcf190", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/theme.scss?ln=scss/theme/blue&crc=4d8a2dbea4209567e9a72fd08f56ffee7da8b381:blue", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/tree.js?ln=org.richfaces&crc=057377880feaf865236f5e04593b38c8bed7c777", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/fileupload/fileupload.js?ln=primefaces&crc=46796ddea0be1d587ddf3d8b0565259c429dcfae", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/editor/editor.js?ln=js-plain&crc=408955bcc63c4f9bf7037897e18a9c672fdaeebf", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/collapsible-subtable-toggler.js?ln=org.richfaces&crc=368e4691f29801c1928de5351052913f133a9292", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/collapsible-subtable.js?ln=org.richfaces&crc=7012f6d1a761fbfcae826d967bfb9b1318a94f51", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/js-plain/efolder-msie-specific.min.js?crc=c68e7159a35ba3e46e9215cf5e28292a40b30cdf", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/js-plain/filtered-table-enter-handler.min.js?crc=3870b1166c9022a686ce6db01e53d5a9785da4d9", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/resources/css/aaaStyles.css", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/resources/css/mprogress.min.css", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/js-plain/primefaces-tooltip-extension.min.js?crc=10ed532ee0963edd10482e5eb218e2e399913155", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/calendarIcon.png?v=4.3.0.Final-e2&db=eAH7f-X88f!PZzEAAB5uBeo_&ln=org.richfaces.images", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:image", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow?_flowId=crm-customer-detail-flow&customerId=995896125417&_windowId=W1681537368383#noback", END_INLINE
    );

    ns_end_transaction("flow_16", NS_AUTO_STATUS);
    ns_page_think_time(236.061);

    ns_start_transaction("flow_6");
    ns_web_url ("flow_6",
        "URL=https://e3.pncie.com/aaa-app/flow?_flowId=crm-customer-detail-flow&customerId=995896125417&_windowId=W1681537368383#noback2",
        INLINE_URLS,
            "URL=https://e3.pncie.com/aaa-app/flow?_flowId=crm-customer-detail-flow&customerId=995896125417&_windowId=W1681537368383#noback", END_INLINE
    );

    ns_end_transaction("flow_6", NS_AUTO_STATUS);
    ns_page_think_time(246.676);


    // add quote

    //Page Auto split for Link 'A' Clicked by User
    ns_start_transaction("flow_17");
    ns_web_url ("flow_17",
        "URL=https://e3.pncie.com/aaa-app/flow?_flowId=crm-customer-detail-flow&_flowExecutionKey=e3s1&_windowId=W1681537368383",
        "METHOD=POST",
        "HEADER=Upgrade-Insecure-Requests:1",
        "HEADER=Origin:https://e3.pncie.com",
        "HEADER=Content-Type:application/x-www-form-urlencoded",
        "HEADER=Sec-Fetch-Site:same-origin",
        "HEADER=Sec-Fetch-Mode:navigate",
        "HEADER=Sec-Fetch-User:?1",
        "HEADER=Sec-Fetch-Dest:document",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU",
        "REDIRECT=YES",
        "LOCATION=/aaa-app/flow?_flowId=quote-main-flow&customerNumber=715597413&_windowId=W1681537368383",
        BODY_BEGIN,
            "quotes%3AquotesTogglePanel-value=true&quotes_SUBMIT=1&javax.faces.ViewState=7731480c-6138-4237-a9a1-b1bd37fb5b75&quotes%3A_idcl=quotes%3AaddPolicyBtn",
        BODY_END,
        INLINE_URLS,
            "URL=https://e3.pncie.com/aaa-app/flow?_flowId=quote-main-flow&customerNumber=715597413&_windowId=W1681537368383", "HEADER=Upgrade-Insecure-Requests:1", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:navigate", "HEADER=Sec-Fetch-User:?1", "HEADER=Sec-Fetch-Dest:document", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/datatable.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/datascroller.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/popupPanel.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/calendar.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/style.scss?crc=35028a4325f902599b9d233517d61cecf68921c4:blue", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow/rfRes/tooltip.ecss?db=eAG7e5rtPQAG1AKe&ln=org.richfaces", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/eis-styles.min.css?crc=dca6f74eb38f9386801f1c90f6dc967118f2a968", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/primefaces.css?ln=primefaces&crc=55381084881a9a68f2cc1fa3769572784d05c328", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/watermark/watermark.css?ln=primefaces&crc=186d952b276bfce31ef2dd7d61e9fa2e906ca01e", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/javax.faces.resource/theme.scss?ln=scss/theme/blue&crc=4d8a2dbea4209567e9a72fd08f56ffee7da8b381:blue", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/resources/css/aaaStyles.css", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/resources/css/mprogress.min.css", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;window.name;loaded_W1681537368383;_WEBFLOW_LAST_EXECUTOR_NAME;oam.Flash.RENDERMAP.TOKEN;PASROUTE;GTQFSDHU", END_INLINE,
            "URL=https://e3.pncie.com/aaa-app/flow?_flowId=quote-main-flow&customerNumber=715597413&_windowId=W1681537368383#noback", END_INLINE
    );

    ns_end_transaction("flow_17", NS_AUTO_STATUS);
    ns_page_think_time(247.194);

    ns_start_transaction("flow_7");
    ns_web_url ("flow_7",
        "URL=https://e3.pncie.com/aaa-app/flow?_flowId=quote-main-flow&customerNumber=715597413&_windowId=W1681537368383#noback2",
        INLINE_URLS,
            "URL=https://e3.pncie.com/aaa-app/flow?_flowId=quote-main-flow&customerNumber=715597413&_windowId=W1681537368383#noback", END_INLINE
    );

    ns_end_transaction("flow_7", NS_AUTO_STATUS);
    ns_page_think_time(264.115);


    // launch dash
    // 
    // =========================

    //Page Auto split for Button 'Launch Dash' Clicked by User
    ns_start_transaction("quote_2");
    ns_web_url ("quote_2",
        "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/property/quote?prefill_customer=715597413",
        "HEADER=Upgrade-Insecure-Requests:1",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:navigate",
        "HEADER=Sec-Fetch-User:?1",
        "HEADER=Sec-Fetch-Dest:document",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        INLINE_URLS,
            "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/nr/nr_test.js", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/static/css/2.22ce742d.chunk.css", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/static/css/main.5dff0763.chunk.css", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/static/js/2.691367db.chunk.js", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/static/js/main.8b8adb67.chunk.js", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://s.go-mpulse.net/boomerang/8GSRP-JVCR4-6J3AN-EWLKW-WZ2FU", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE
    );

    ns_end_transaction("quote_2", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("config_json");
    ns_web_url ("config_json",
        "URL=https://c.go-mpulse.net/api/config.json?key=8GSRP-JVCR4-6J3AN-EWLKW-WZ2FU&d=dash-perf.pas.n01.csaa-insurance.aaa.com&t=5605125&v=1.720.0&if=&sl=0&si=b898286a-1df1-47d6-b771-5de504437345-rt56pc&plugins=AK,ConfigOverride,Continuity,PageParams,IFrameDelay,AutoXHR,SPA,History,Angular,Backbone,Ember,RT,CrossDomain,BW,PaintTiming,NavigationTiming,ResourceTiming,Memory,CACHE_RELOAD,Errors,TPAnalytics,UserTiming,Akamai,Early,EventTiming,LOGN&acao=&ak.ai=780488",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("config_json", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("index_3");
    ns_web_url ("index_3",
        "URL=https://17de4c1e.akstat.io/",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=Content-Type:application/x-www-form-urlencoded",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:no-cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        INLINE_URLS,
            "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/static/media/fontawesome-webfont.20fd1704.woff2", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:cors", "HEADER=Sec-Fetch-Dest:font", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE
    );

    ns_end_transaction("index_3", NS_AUTO_STATUS);
    ns_page_think_time(0.108);

    ns_start_transaction("okta_scope_openid_20policyex");
    ns_web_url ("okta_scope_openid_20policyex",
        "URL=https://csaa.oktapreview.com/oauth2/ausonkbfb50QxAYGV0h7/v1/authorize?client_id=0oau787gpcxcre98g0h7&redirect_uri=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/okta&scope=openid%20policyexpress%20offline_access&response_type=code&state=test",
        "HEADER=Upgrade-Insecure-Requests:1",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:navigate",
        "HEADER=Sec-Fetch-Dest:document",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("okta_scope_openid_20policyex", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("manifest_json");
    ns_web_url ("manifest_json",
        "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/manifest.json",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=Sec-Fetch-Site:same-origin",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        INLINE_URLS,
            "URL=https://op1static.oktacdn.com/assets/css/saasure.cd78cfa15834b4971c5123bc886ab7e0.css", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://op1static.oktacdn.com/assets/courage/css/courage.7d434dcb032cd8a46b404c6f04be338a.css", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://op1static.oktacdn.com/assets/css/admin-overrides.a8f85aef7e3cc7fbc4377c7f6de96dfe.css", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://op1static.oktacdn.com/assets/js/saasure.jqueryui.min.7db5506b9a133ee45f2a3400db0e51f2.js", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=Origin:https://csaa.oktapreview.com", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Mode:cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://op1static.oktacdn.com/assets/js/sections/user/routing.77e1bbe6e9f5f13ec333a5b6f091135e.js", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=Origin:https://csaa.oktapreview.com", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Mode:cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://op1static.oktacdn.com/assets/js/properties/saasure-js-bundle.9152f75626124d6cd8102eb7541c6ec7.js", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=Origin:https://csaa.oktapreview.com", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Mode:cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://op1static.oktacdn.com/assets/img/ui/indicators/okta-spinner.631e53afc4149c55253645fb7d1177ac.gif", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:image", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://op1static.oktacdn.com/assets/courage/font/assets/proximanova-light-webfont.aba797dabec6686294a9.woff2", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=Origin:https://csaa.oktapreview.com", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Mode:cors", "HEADER=Sec-Fetch-Dest:font", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://op1static.oktacdn.com/assets/courage/font/assets/proximanova-reg-webfont.353416ed0ff540352235.woff2", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=Origin:https://csaa.oktapreview.com", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Mode:cors", "HEADER=Sec-Fetch-Dest:font", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://op1static.oktacdn.com/assets/courage/font/assets/proximanova-light-webfont.aba797dabec6686294a9.woff2", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=Origin:https://csaa.oktapreview.com", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Mode:cors", "HEADER=Sec-Fetch-Dest:font", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://op1static.oktacdn.com/assets/courage/font/assets/proximanova-reg-webfont.353416ed0ff540352235.woff2", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=Origin:https://csaa.oktapreview.com", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Mode:cors", "HEADER=Sec-Fetch-Dest:font", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE
    );

    ns_end_transaction("manifest_json", NS_AUTO_STATUS);
    ns_page_think_time(0.011);

    // Following URL has HTTP authentication (NTLM/Kerberos/Basic/Digest) enabled.
    // Username & password was prompted during recording.
    ns_start_transaction("index_2");
    ns_web_url ("index_2",
        "URL=https://iwa.tent.trt.csaa.pri/IWA/",
        "HTTPAuthUserName=<username>",
        "HTTPAuthPassword=<password>",
        "METHOD=POST",
        "HEADER=Upgrade-Insecure-Requests:1",
        "HEADER=Origin:null",
        "HEADER=Content-Type:application/x-www-form-urlencoded",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:navigate",
        "HEADER=Sec-Fetch-Dest:document",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "fromURI=%2Foauth2%2Fv1%2Fauthorize%2Fredirect%3Fokta_key%3DbFt7i1ljnzNIyTDzcK7i_fRjOFbYH7neE_N7ZEJuhbU&serviceToken=eyJ6aXAiOiJERUYiLCJhbGlhcyI6ImVuY3J5cHRpb25rZXkiLCJ2ZXIiOiIxIiwib2lkIjoiMDBvb2I2MG9sZHZOWGxPeW0waDciLCJlbmMiOiJBMjU2R0NNIiwiYWxnIjoiZGlyIn0..r7KX17EUtPfIcaOi.-dU_KMpRlGzW3BVKjS1n.3Ck-HuDU2CEugeDVV0RyEw",
        BODY_END,
        INLINE_URLS,
            "URL=http://www.gstatic.com/generate_204", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE
    );

    ns_end_transaction("index_2", NS_AUTO_STATUS);
    // Following URL has HTTP authentication (NTLM/Kerberos/Basic/Digest) enabled.
    // Username & password was prompted during recording.

    //Page Auto split for Method = POST
    ns_start_transaction("index_4");
    ns_web_url ("index_4",
        "URL=https://iwa.tent.trt.csaa.pri/IWA/",
        "HTTPAuthUserName=<username>",
        "HTTPAuthPassword=<password>",
        "METHOD=POST",
        "HEADER=Upgrade-Insecure-Requests:1",
        "HEADER=Origin:null",
        "HEADER=Content-Type:application/x-www-form-urlencoded",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:navigate",
        "HEADER=Sec-Fetch-Dest:document",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        INLINE_URLS,
            "URL=https://iwa.tent.trt.csaa.pri/IWA/css/iwa-light.css", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=ASP.NET_SessionId", END_INLINE,
            "URL=https://iwa.tent.trt.csaa.pri/IWA/js/iwa-light.js", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=ASP.NET_SessionId", END_INLINE,
            "URL=https://iwa.tent.trt.csaa.pri/IWA/css/iwa-light.css", END_INLINE,
            "URL=https://auth.e1.pncie.com/.well-known/logo", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:image", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://iwa.tent.trt.csaa.pri/IWA/js/iwa-light.js", END_INLINE,
            "URL=https://iwa.tent.trt.csaa.pri/IWA/js/testWorker.js", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:same-origin", "HEADER=Sec-Fetch-Dest:worker", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=ASP.NET_SessionId", END_INLINE,
            "URL=https://iwa.tent.trt.csaa.pri/IWA/js/testWorker.js", END_INLINE,
            "URL=https://iwa.tent.trt.csaa.pri/IWA/iwa_test.aspx", "HEADER=accept:text/plain", "HEADER=content-type:text/plain", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:cors", "HEADER=Sec-Fetch-Dest:empty", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=ASP.NET_SessionId", END_INLINE,
            "URL=https://iwa.tent.trt.csaa.pri/IWA/iwa_test.aspx", END_INLINE
    );

    ns_end_transaction("index_4", NS_AUTO_STATUS);
    ns_page_think_time(0.009);

    // Following URL has HTTP authentication (NTLM/Kerberos/Basic/Digest) enabled.
    // Username & password was prompted during recording.
    ns_start_transaction("auth_aspx");
    ns_web_url ("auth_aspx",
        "URL=https://iwa.tent.trt.csaa.pri/IWA/auth.aspx",
        "HTTPAuthUserName=<username>",
        "HTTPAuthPassword=<password>",
        "METHOD=POST",
        "HEADER=Upgrade-Insecure-Requests:1",
        "HEADER=Origin:https://iwa.tent.trt.csaa.pri",
        "HEADER=Content-Type:application/x-www-form-urlencoded",
        "HEADER=Sec-Fetch-Site:same-origin",
        "HEADER=Sec-Fetch-Mode:navigate",
        "HEADER=Sec-Fetch-Dest:document",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=ASP.NET_SessionId",
        BODY_BEGIN,
            "fromURI=%2Foauth2%2Fv1%2Fauthorize%2Fredirect%3Fokta_key%3DbFt7i1ljnzNIyTDzcK7i_fRjOFbYH7neE_N7ZEJuhbU&serviceToken=eyJ6aXAiOiJERUYiLCJhbGlhcyI6ImVuY3J5cHRpb25rZXkiLCJ2ZXIiOiIxIiwib2lkIjoiMDBvb2I2MG9sZHZOWGxPeW0waDciLCJlbmMiOiJBMjU2R0NNIiwiYWxnIjoiZGlyIn0..r7KX17EUtPfIcaOi.-dU_KMpRlGzW3BVKjS1n.3Ck-HuDU2CEugeDVV0RyEw",
        BODY_END,
        INLINE_URLS,
            "URL=https://op1static.oktacdn.com/fs/bco/1/fs0wrp6yl5wIWuj7q0h7", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:image", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE
    );

    ns_end_transaction("auth_aspx", NS_AUTO_STATUS);
    // Following URL has HTTP authentication (NTLM/Kerberos/Basic/Digest) enabled.
    // Username & password was prompted during recording.

    //Page Auto split for Method = POST
    ns_start_transaction("auth_aspx_2");
    ns_web_url ("auth_aspx_2",
        "URL=https://iwa.tent.trt.csaa.pri/IWA/auth.aspx",
        "HTTPAuthUserName=<username>",
        "HTTPAuthPassword=<password>",
        "METHOD=POST",
        "HEADER=Upgrade-Insecure-Requests:1",
        "HEADER=Origin:https://iwa.tent.trt.csaa.pri",
        "HEADER=Content-Type:application/x-www-form-urlencoded",
        "HEADER=Sec-Fetch-Site:same-origin",
        "HEADER=Sec-Fetch-Mode:navigate",
        "HEADER=Sec-Fetch-Dest:document",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=ASP.NET_SessionId",
        INLINE_URLS,
            "URL=https://js-agent.newrelic.com/nr-1216.min.js", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://auth.e1.pncie.com/login/sso_iwa_auth", "METHOD=POST", "HEADER=Upgrade-Insecure-Requests:1", "HEADER=Origin:https://iwa.tent.trt.csaa.pri", "HEADER=Content-Type:application/x-www-form-urlencoded", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Mode:navigate", "HEADER=Sec-Fetch-Dest:document", "HEADER=Accept-Language:en-US,en;q=0.9",
            BODY_BEGIN,
            "__VIEWSTATE=%2FwEPDwUKMTQ3MTQ4NTY0Mg9kFgICAQ8WAh4GYWN0aW9uBSxodHRwczovL2F1dGguZTEucG5jaWUuY29tL2xvZ2luL3Nzb19pd2FfYXV0aGRkWO7NPKJwzpPeMIG%2FSXlMUp0%2BX5NuyFFgg5RbsGOQyw0%3D&__VIEWSTATEGENERATOR=766B8F0C&__EVENTVALIDATION=%2FwEdAAbPsJduDUvsCHI5CWomJL%2BwwosTMGIIbiP8e%2FuENlg9ohXaa1O5JOnLjfUrDqnh5Zhg0ZCp6CPBMtATJWOhvoylEzByJaK4lpyQ4GMdAjAgqvujHH%2FsRFakW8L1z4%2FFwUAKnAty7HkY8L3Y3lu3AWPwQmC62ioa5j4rdZspSkbBfQ%3D%3D&B64EncodedSignature=ltA2YxcFhtog%2BJwI2lAC%2FFbEASthY5EpSCrnNN34YXnmLMmZGwtW2uOI0VU7SQqIRfVvTNjETAYLGaEaMKsOrqjoXpjYwNlEtOni%2BGTwngGZd2xtNXgDgxWZuKJ8IXtE5ingBMB0zbT23aW6hVFYNP0nZzBjsYumvVHnCv6413k2CWz5W5L%2B1PIgknc4NNI6IoUsiMIjgV4NDnqWjQjBIOykIs0UxVqKYvmLrmKkFQjJK1vud0n7AA1AAsLPKPzprRO%2B4b%2FltVeMj2v8PBFE3427Dk7hcmINcnru1NZAHz5uRuPH4Bb23EuKg0P%2FYAj4c%2F1zNRLtPwh2Q7MYiu73lA%3D%3D&B64EncodedSerializedXML=PHVzZXIgeG1sbnM6eHNkPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6eHNpPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYS1pbnN0YW5jZSI%2BDQogIDxva3RhV2luZG93c1VzZXJHcm91cHMgLz4NCiAgPHY%2BMS4xNS4wLjA8L3Y%2BDQogIDxuPlRFTlRcY2FzZXB0MDAwNzwvbj4NCiAgPHNpZD5TLTEtNS0yMS0xOTY0MjQ3Mjk1LTM4NzY2MDg2NzYtMTEzODY0MDUtNTQ4MzE5PC9zaWQ%2BDQogIDx1cG4%2BQmFyYWN1ZGE3LlRob3JuN0Bjc2FhLWlnLmNvbTwvdXBuPg0KICA8ZG4gLz4NCiAgPHNvdD5leUo2YVhBaU9pSkVSVVlpTENKaGJHbGhjeUk2SW1WdVkzSjVjSFJwYjI1clpYa2lMQ0oyWlhJaU9pSXhJaXdpYjJsa0lqb2lNREJ2YjJJMk1HOXNaSFpPV0d4UGVXMHdhRGNpTENKbGJtTWlPaUpCTWpVMlIwTk5JaXdpWVd4bklqb2laR2x5SW4wLi5yN0tYMTdFVXRQZkljYU9pLi1kVV9LTXBSbEd6VzNCVktqUzFuLjNDay1IdURVMkNFdWdlRFZWMFJ5RXc8L3NvdD4NCjwvdXNlcj4%3D&redirectToLoginDefault=&fromURI=%2Foauth2%2Fv1%2Fauthorize%2Fredirect%3Fokta_key%3DbFt7i1ljnzNIyTDzcK7i_fRjOFbYH7neE_N7ZEJuhbU&iwaServerHostName=N01IAW3018",
        BODY_END,
             END_INLINE,
            "URL=https://auth.e1.pncie.com/oauth2/v1/authorize/redirect?okta_key=bFt7i1ljnzNIyTDzcK7i_fRjOFbYH7neE_N7ZEJuhbU&fromLogin=true", "HEADER=Upgrade-Insecure-Requests:1", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Mode:navigate", "HEADER=Sec-Fetch-Dest:document", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID;t;DT;sid", END_INLINE
    );

    ns_end_transaction("auth_aspx_2", NS_AUTO_STATUS);
    ns_page_think_time(0.004);

    ns_start_transaction("okta");
    ns_web_url ("okta",
        "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/okta?code=XNTs9oS8O_KX5fr2CdRTX50Ahzg1MZqlPv7B3wdIk-I&state=test",
        "HEADER=Upgrade-Insecure-Requests:1",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:navigate",
        "HEADER=Sec-Fetch-Dest:document",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        INLINE_URLS,
            "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/nr/nr_test.js", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/static/css/2.22ce742d.chunk.css", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/static/css/main.5dff0763.chunk.css", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/static/js/2.691367db.chunk.js", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/static/js/main.8b8adb67.chunk.js", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://s.go-mpulse.net/boomerang/8GSRP-JVCR4-6J3AN-EWLKW-WZ2FU", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE
    );

    ns_end_transaction("okta", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("config_json_2");
    ns_web_url ("config_json_2",
        "URL=https://c.go-mpulse.net/api/config.json?key=8GSRP-JVCR4-6J3AN-EWLKW-WZ2FU&d=dash-perf.pas.n01.csaa-insurance.aaa.com&t=5605125&v=1.720.0&if=&sl=0&si=c8a686a5-355d-434f-9068-a93e77d69206-rt56qh&plugins=AK,ConfigOverride,Continuity,PageParams,IFrameDelay,AutoXHR,SPA,History,Angular,Backbone,Ember,RT,CrossDomain,BW,PaintTiming,NavigationTiming,ResourceTiming,Memory,CACHE_RELOAD,Errors,TPAnalytics,UserTiming,Akamai,Early,EventTiming,LOGN&acao=&ak.ai=780488",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("config_json_2", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("session");
    ns_web_url ("session",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session",
        "METHOD=OPTIONS",
        "HEADER=Access-Control-Request-Method:POST",
        "HEADER=Access-Control-Request-Headers:content-type,x-api-key",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        INLINE_URLS,
            "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/static/media/fontawesome-webfont.20fd1704.woff2", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:cors", "HEADER=Sec-Fetch-Dest:font", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://js-agent.newrelic.com/nr-spa-1212.min.js", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE
    );

    ns_end_transaction("session", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("manifest_json_2");
    ns_web_url ("manifest_json_2",
        "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/manifest.json",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=Sec-Fetch-Site:same-origin",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        INLINE_URLS,
            "URL=https://bam-cell.nr-data.net/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=2769&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/okta&be=1263&fe=2699&dc=2681&af=err,xhr,stn,ins,spa&perf=%7B%22timing%22:%7B%22of%22:1681537624935,%22n%22:0,%22f%22:986,%22dn%22:986,%22dne%22:986,%22c%22:986,%22ce%22:986,%22rq%22:988,%22rp%22:1074,%22rpe%22:1076,%22dl%22:1168,%22di%22:2681,%22ds%22:2681,%22de%22:2682,%22dc%22:2699,%22l%22:2699,%22le%22:2701%7D,%22navigation%22:%7B%7D%7D&fp=2668&fcp=2668&jsonp=NREUM.setToken", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID", END_INLINE
    );

    ns_end_transaction("manifest_json_2", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("index_5");
    ns_web_url ("index_5",
        "URL=https://17de4c0e.akstat.io/",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=Content-Type:application/x-www-form-urlencoded",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:no-cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        INLINE_URLS,
            "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/csaa-logo.png", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:image", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE
    );

    ns_end_transaction("index_5", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("okta_st_1681537624935");
    ns_web_url ("okta_st_1681537624935",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=2947&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/okta&st=1681537624935",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"res":[{"n":"navigationStart","s":0,"e":0,"o":"document","t":"timing"},{"n":"fetchStart","s":986,"e":986,"o":"document","t":"timing"},{"n":"domainLookupStart","s":986,"e":986,"o":"document","t":"timing"},{"n":"domainLookupEnd","s":986,"e":986,"o":"document","t":"timing"},{"n":"connectStart","s":986,"e":986,"o":"document","t":"timing"},{"n":"connectEnd","s":986,"e":986,"o":"document","t":"timing"},{"n":"requestStart","s":988,"e":988,"o":"document","t":"timing"},{"n":"responseStart","s":1074,"e":1074,"o":"document","t":"timing"},{"n":"responseEnd","s":1076,"e":1076,"o":"document","t":"timing"},{"n":"domLoading","s":1168,"e":1168,"o":"document","t":"timing"},{"n":"domInteractive","s":2681,"e":2681,"o":"document","t":"timing"},{"n":"domContentLoadedEventStart","s":2681,"e":2681,"o":"document","t":"timing"},{"n":"domContentLoadedEventEnd","s":2682,"e":2682,"o":"document","t":"timing"},{"n":"domComplete","s":2699,"e":2699,"o":"document","t":"timing"},{"n":"loadEventStart","s":2699,"e":2699,"o":"document","t":"timing"},{"n":"loadEventEnd","s":2701,"e":2701,"o":"document","t":"timing"}]}",
        BODY_END
    );

    ns_end_transaction("okta_st_1681537624935", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("session_2");
    ns_web_url ("session_2",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"accessCode":"XNTs9oS8O_KX5fr2CdRTX50Ahzg1MZqlPv7B3wdIk-I","callbackURL":"https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/okta"}",
        BODY_END
    );

    ns_end_transaction("session_2", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("session_3");
    ns_web_url ("session_3",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("session_3", NS_AUTO_STATUS);
    ns_page_think_time(0.022);

    ns_start_transaction("quote");
    ns_web_url ("quote",
        "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/property/quote?prefill_customer=715597413",
        "HEADER=Upgrade-Insecure-Requests:1",
        "HEADER=Sec-Fetch-Site:same-origin",
        "HEADER=Sec-Fetch-Mode:navigate",
        "HEADER=Sec-Fetch-Dest:document",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("quote", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("okta_2");
    ns_web_url ("okta_2",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=4496&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/okta",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.7;1,1,,3gq,230,5,'initialPageLoad,'https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/okta,1,1,,,!!!!'7cfa8c5d-78fe-42ce-89fa-bcd10a900019,'1,224,224;2,1,22f,wt,4,6,'POST,5k,'api-perf.n01.csaa-insurance.aaa.com:443,'/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session,3v,ul,,'4,!!!;2,,2zb,h6,9,a,'GET,5k,5,6,,6f,,'5,!!!;b,!!!!re,,,,!,2,2e,2,2k,161,,1,h,,2",
        BODY_END
    );

    ns_end_transaction("okta_2", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("index_6");
    ns_web_url ("index_6",
        "URL=https://17de4c0e.akstat.io/",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=Content-Type:application/x-www-form-urlencoded",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:no-cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("index_6", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("okta_3");
    ns_web_url ("okta_3",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=4623&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/okta",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=Content-Type:text/plain;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:no-cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.6;e,'load,22z,1;6,'cls,0.;e,'fp,224,1;6,1,0.;e,'fcp,224,1;6,1,0.;e,'lcp,224,3;6,'size,2849.;5,'eid;6,1,0.;e,'pageHide,3ke,1;6,1,0.00028748095970728386;e,'unload,3ke,1;6,1,0.00028748095970728386",
        BODY_END
    );

    ns_end_transaction("okta_3", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("okta_4");
    ns_web_url ("okta_4",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=4625&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/okta",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=Content-Type:text/plain;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:no-cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":1}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/resources/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":1097},"rxSize":{"t":36},"duration":{"t":143},"cbTime":{"t":0},"time":{"t":2949}}},{"params":{"method":"POST","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session","status":200},"metrics":{"count":2,"txSize":{"t":139},"rxSize":{"t":1332,"min":231,"max":1101,"sos":1265562,"c":2},"duration":{"t":1812,"min":627,"max":1185,"sos":1797354,"c":2},"cbTime":{"t":0,"min":0,"max":0,"sos":0,"c":2},"time":{"t":6542,"min":2679,"max":3863,"sos":22099810,"c":2}}}]}",
        BODY_END
    );

    ns_end_transaction("okta_4", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("okta_st_1681537624935_ptid_b");
    ns_web_url ("okta_st_1681537624935_ptid_b",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=4626&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/okta&st=1681537624935&ptid=ba7be0fd-0001-b381-c9c9-01878373f7cc",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=Content-Type:text/plain;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:no-cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"res":[{"n":"script","s":1208,"e":1243,"o":"https://dash-perf.pas.n01.csaa-insurance.aaa.com:443/pasperf4/nr/nr_test.js","t":"resource"},{"n":"script","s":1210,"e":1337,"o":"https://dash-perf.pas.n01.csaa-insurance.aaa.com:443/pasperf4/static/js/main.8b8adb67.chunk.js","t":"resource"},{"n":"script","s":2699,"e":2706,"o":"https://js-agent.newrelic.com:443/nr-spa-1212.min.js","t":"resource"},{"n":"link","s":1209,"e":1256,"o":"https://dash-perf.pas.n01.csaa-insurance.aaa.com:443/pasperf4/static/css/2.22ce742d.chunk.css","t":"resource"},{"n":"link","s":1209,"e":1257,"o":"https://dash-perf.pas.n01.csaa-insurance.aaa.com:443/pasperf4/static/css/main.5dff0763.chunk.css","t":"resource"},{"n":"readystatechange","s":2677,"e":2677,"t":"event","o":"undefined POST: api-perf.n01.csaa-insurance.aaa.com:443/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session"},{"n":"readystatechange","s":2949,"e":2949,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":3090,"e":3090,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":3090,"e":3090,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":3091,"e":3091,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":3858,"e":3858,"t":"event","o":"undefined POST: api-perf.n01.csaa-insurance.aaa.com:443/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session"},{"n":"readystatechange","s":3858,"e":3859,"t":"event","o":"undefined POST: api-perf.n01.csaa-insurance.aaa.com:443/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session"},{"n":"readystatechange","s":3859,"e":3859,"t":"event","o":"undefined POST: api-perf.n01.csaa-insurance.aaa.com:443/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session"},{"n":"readystatechange","s":3859,"e":3859,"t":"event","o":"undefined POST: api-perf.n01.csaa-insurance.aaa.com:443/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session"},{"n":"readystatechange","s":3859,"e":3860,"t":"event","o":"undefined POST: api-perf.n01.csaa-insurance.aaa.com:443/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session"},{"n":"readystatechange","s":3860,"e":3861,"t":"event","o":"undefined POST: api-perf.n01.csaa-insurance.aaa.com:443/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session"},{"n":"readystatechange","s":3863,"e":3863,"t":"event","o":"undefined GET: api-perf.n01.csaa-insurance.aaa.com:443/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session"},{"n":"readystatechange","s":4480,"e":4480,"t":"event","o":"undefined GET: api-perf.n01.csaa-insurance.aaa.com:443/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session"},{"n":"readystatechange","s":4481,"e":4481,"t":"event","o":"undefined GET: api-perf.n01.csaa-insurance.aaa.com:443/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session"},{"n":"readystatechange","s":4481,"e":4481,"t":"event","o":"undefined GET: api-perf.n01.csaa-insurance.aaa.com:443/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session"},{"n":"readystatechange","s":4481,"e":4481,"t":"event","o":"undefined GET: api-perf.n01.csaa-insurance.aaa.com:443/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session"},{"n":"readystatechange","s":4481,"e":4482,"t":"event","o":"undefined GET: api-perf.n01.csaa-insurance.aaa.com:443/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session"},{"n":"readystatechange","s":4482,"e":4482,"t":"event","o":"undefined GET: api-perf.n01.csaa-insurance.aaa.com:443/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session"},{"n":"readystatechange","s":4496,"e":4496,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/events/1/NRJS-caa2993fd9f89f03d7d"},{"n":"DOMContentLoaded","s":2681,"e":2681,"t":"event","o":"document"},{"n":"DOMContentLoaded","s":2681,"e":2681,"t":"event","o":"document"},{"n":"load","s":2700,"e":2700,"t":"event","o":"window"},{"n":"load","s":2700,"e":2700,"t":"event","o":"window"},{"n":"load","s":3091,"e":3091,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":3092,"e":3092,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":3092,"e":3093,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":3864,"e":3864,"t":"event","o":"200 POST: api-perf.n01.csaa-insurance.aaa.com:443/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session"},{"n":"load","s":3864,"e":3864,"t":"event","o":"200 POST: api-perf.n01.csaa-insurance.aaa.com:443/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session"},{"n":"load","s":4490,"e":4490,"t":"event","o":"200 GET: api-perf.n01.csaa-insurance.aaa.com:443/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session"},{"n":"load","s":4490,"e":4490,"t":"event","o":"200 GET: api-perf.n01.csaa-insurance.aaa.com:443/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session"},{"n":"css","s":2682,"e":2688,"o":"https://dash-perf.pas.n01.csaa-insurance.aaa.com:443/pasperf4/static/media/fontawesome-webfont.20fd1704.woff2","t":"resource"},{"n":"animationstart","s":2773,"e":2775,"t":"event","o":"i.fa.fa-spinner.fa-spin.fa-1x.fa-fw"},{"n":"animationstart","s":2776,"e":2776,"t":"event","o":"i.fa.fa-spinner.fa-spin.fa-1x.fa-fw"},{"n":"other","s":2738,"e":2863,"o":"https://dash-perf.pas.n01.csaa-insurance.aaa.com:443/pasperf4/manifest.json","t":"resource"},{"n":"other","s":2866,"e":2923,"o":"https://dash-perf.pas.n01.csaa-insurance.aaa.com:443/pasperf4/csaa-logo.png","t":"resource"},{"n":"setTimeout","s":2956,"e":2956,"o":"window","t":"timer"},{"n":"setTimeout","s":4494,"e":4497,"o":"window","t":"timer"},{"n":"progress","s":3090,"e":3090,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"progress","s":3859,"e":3859,"t":"event","o":"undefined POST: api-perf.n01.csaa-insurance.aaa.com:443/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session"},{"n":"progress","s":4481,"e":4481,"t":"event","o":"undefined GET: api-perf.n01.csaa-insurance.aaa.com:443/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session"},{"n":"Ajax","s":2949,"e":3092,"o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"ajax"},{"n":"Ajax","s":2679,"e":3864,"o":"200 POST: api-perf.n01.csaa-insurance.aaa.com:443/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session","t":"ajax"},{"n":"Ajax","s":3863,"e":4490,"o":"200 GET: api-perf.n01.csaa-insurance.aaa.com:443/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session","t":"ajax"},{"n":"xmlhttprequest","s":2949,"e":3089,"o":"https://bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"resource"},{"n":"xmlhttprequest","s":3863,"e":4479,"o":"https://api-perf.n01.csaa-insurance.aaa.com:443/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session","t":"resource"},{"n":"beacon","s":4487,"e":4575,"o":"https://17de4c0e.akstat.io:443/","t":"resource"},{"n":"pagehide","s":4622,"e":4624,"t":"event","o":"window"}]}",
        BODY_END,
        INLINE_URLS,
            "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/nr/nr_test.js", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/static/css/2.22ce742d.chunk.css", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/static/css/main.5dff0763.chunk.css", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:style", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://s.go-mpulse.net/boomerang/8GSRP-JVCR4-6J3AN-EWLKW-WZ2FU", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://js-agent.newrelic.com/nr-spa-1212.min.js", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/property/quote", END_INLINE
    );

    ns_end_transaction("okta_st_1681537624935_ptid_b", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("X15597413");
    ns_web_url ("X15597413",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/express/v1/customers/715597413",
        "METHOD=OPTIONS",
        "HEADER=Access-Control-Request-Method:GET",
        "HEADER=Access-Control-Request-Headers:authorization,x-api-key",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("X15597413", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("manifest_json_3");
    ns_web_url ("manifest_json_3",
        "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/manifest.json",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=Sec-Fetch-Site:same-origin",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        INLINE_URLS,
            "URL=https://bam-cell.nr-data.net/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=645&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/property/quote&be=213&fe=576&dc=562&af=err,xhr,stn,ins,spa&perf=%7B%22timing%22:%7B%22of%22:1681537629423,%22n%22:0,%22u%22:140,%22ue%22:141,%22f%22:9,%22dn%22:9,%22dne%22:9,%22c%22:9,%22ce%22:9,%22rq%22:39,%22rp%22:127,%22rpe%22:129,%22dl%22:143,%22di%22:562,%22ds%22:562,%22de%22:563,%22dc%22:576,%22l%22:576,%22le%22:577%7D,%22navigation%22:%7B%7D%7D&fp=567&fcp=567&jsonp=NREUM.setToken", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:script", "HEADER=Accept-Language:en-US,en;q=0.9", "COOKIE=JSESSIONID", END_INLINE
    );

    ns_end_transaction("manifest_json_3", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("config_json_3");
    ns_web_url ("config_json_3",
        "URL=https://c.go-mpulse.net/api/config.json?key=8GSRP-JVCR4-6J3AN-EWLKW-WZ2FU&d=dash-perf.pas.n01.csaa-insurance.aaa.com&t=5605125&v=1.720.0&if=&sl=0&si=1c3bead7-a1a6-495d-8185-aac53e54561f-rt56ql&plugins=AK,ConfigOverride,Continuity,PageParams,IFrameDelay,AutoXHR,SPA,History,Angular,Backbone,Ember,RT,CrossDomain,BW,PaintTiming,NavigationTiming,ResourceTiming,Memory,CACHE_RELOAD,Errors,TPAnalytics,UserTiming,Akamai,Early,EventTiming,LOGN&acao=&ak.ai=780488",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("config_json_3", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("X15597413_2");
    ns_web_url ("X15597413_2",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/express/v1/customers/715597413",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("X15597413_2", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423");
    ns_web_url ("quote_st_1681537629423",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=777&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/property/quote&st=1681537629423",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"res":[{"n":"navigationStart","s":0,"e":0,"o":"document","t":"timing"},{"n":"unloadEventStart","s":140,"e":140,"o":"document","t":"timing"},{"n":"unloadEventEnd","s":141,"e":141,"o":"document","t":"timing"},{"n":"fetchStart","s":9,"e":9,"o":"document","t":"timing"},{"n":"domainLookupStart","s":9,"e":9,"o":"document","t":"timing"},{"n":"domainLookupEnd","s":9,"e":9,"o":"document","t":"timing"},{"n":"connectStart","s":9,"e":9,"o":"document","t":"timing"},{"n":"connectEnd","s":9,"e":9,"o":"document","t":"timing"},{"n":"requestStart","s":39,"e":39,"o":"document","t":"timing"},{"n":"responseStart","s":127,"e":127,"o":"document","t":"timing"},{"n":"responseEnd","s":129,"e":129,"o":"document","t":"timing"},{"n":"domLoading","s":143,"e":143,"o":"document","t":"timing"},{"n":"domInteractive","s":562,"e":562,"o":"document","t":"timing"},{"n":"domContentLoadedEventStart","s":562,"e":562,"o":"document","t":"timing"},{"n":"domContentLoadedEventEnd","s":563,"e":563,"o":"document","t":"timing"},{"n":"domComplete","s":576,"e":576,"o":"document","t":"timing"},{"n":"loadEventStart","s":576,"e":576,"o":"document","t":"timing"},{"n":"loadEventEnd","s":577,"e":577,"o":"document","t":"timing"}]}",
        BODY_END,
        INLINE_URLS,
            "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/csaa-logo.png", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:no-cors", "HEADER=Sec-Fetch-Dest:image", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE
    );

    ns_end_transaction("quote_st_1681537629423", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_3");
    ns_web_url ("quote_3",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=786&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/property/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.7;1,,,g1,g1,,'initialPageLoad,'https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/property/quote,1,1,,,!!!!'946190c5-f53c-4e20-9d60-eff99810c0bc,'1,fr,fr;b,3w,!1,!-3o,,,,!,u,2g,2,e,bn,,1,d,,1",
        BODY_END
    );

    ns_end_transaction("quote_3", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("index_7");
    ns_web_url ("index_7",
        "URL=https://17de4c0e.akstat.io/",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=Content-Type:application/x-www-form-urlencoded",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:no-cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        INLINE_URLS,
            "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/static/media/cabin-latin-400-normal.7de32b3c.woff2", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:cors", "HEADER=Sec-Fetch-Dest:font", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/static/media/rtraleway-bold-webfont.5902f975.woff2", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:cors", "HEADER=Sec-Fetch-Dest:font", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE,
            "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/static/media/rtraleway-regular-webfont.a56c12cf.woff2", "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"", "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com", "HEADER=sec-ch-ua-mobile:?0", "HEADER=Sec-Fetch-Site:same-origin", "HEADER=Sec-Fetch-Mode:cors", "HEADER=Sec-Fetch-Dest:font", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE
    );

    ns_end_transaction("index_7", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("metadata");
    ns_web_url ("metadata",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/home/v1/metadata",
        "METHOD=OPTIONS",
        "HEADER=Access-Control-Request-Method:POST",
        "HEADER=Access-Control-Request-Headers:authorization,content-type,x-api-key",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("metadata", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_2");
    ns_web_url ("metadata_2",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/home/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"AZ","typeOfPolicy":"Home","effectiveDate":"2023-04-15","productBundle":"Heritage"},"filters":{"properties":["detachedStructures","dwellingUsage","exteriorWallFinish","foundationType","garageType","hailResistanceRating","leadLiability","newLoan","numberFireplaces","numberStories","oilFuelCoverageNeeded","oilFuelTankAge","poolType","propertySlope","qualityGrade","siteAccess","spaType","squareFootage","tLockShingles","trampolineType","undergroundStorage","yearBuilt","constructionType","percentLowestLevelFinished","roofRenovation","noFamilyUnits","maritalStatus","relationship","occupation","elc","thirdPartyDesignee","typeOfPolicy","additionalInsured","additionalInterest","certificateHolder","mortgageeDetails","inspectionType","productBundle","replacementAmount","covALimit","covBLimitPercent","covCLimit","covCLimitPercent","covCAddLimit","covCAddLimitPercent","covDLimitPercent","covELimit","covELimitPercent","covFLimit","deductible","extendedReplaceCost","buildingCodeUpgrade","renovationType","interestType","policyType","limit","salesChannelType","officeType","county","retirementCommunity","numberFamilyUnits","numberOccupants","localFireAlarm","fullResidentialSprinklers","localTheftAlarm","gatedCommunity","basicWDD","advancedWDD","windstorm","chamberCommerce","ceaDiscount","priorPolicyRemarks","cancellationRemarks","foreClosureRemarks","isWaterHeaterHeight","numberOfEmployees","numberOfEmployeesRemarks","isDayCare","hasDayCareLicense","isFarmingRanching","isFarmingRanchingForProfit","isIncidentalBusinessOccupancy","isOtherBusinessOnPremise","petsInjuryRemarks","animalBreed"],"models":["HOPropertyDetails","HOInsuredDetails","HOQuoteInfo","HOCoverages","HORoofRenovation","HOHeatingOrCoolingRenovation","HOElectricalRenovation","HOPlumbingRenovation","HOAdditionalInsured","HOPriorInsurance","Bicycles","Camera","Coins","FineArts","Firearms","Furs","GolfEquipment","Jewelry","MedicalDevices","MusicalInstruments","PostageStamps","Silverware","TradingCardComics","Boat","ProducerInfo","HOAddress","HODetachedStructures","HODiscounts","HOOtherDiscounts","HOUnderwritingQuestionaire","HOAnimals"],"rootModels":["HOAppliedForms"]}}",
        BODY_END
    );

    ns_end_transaction("metadata_2", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("autocomplete");
    ns_web_url ("autocomplete",
        "URL=https://api-qa.n01.csaa-insurance.aaa.com/address-v1/validate/autocomplete?ff=3127+W+Greenway+Rd%2C+PHOENIX%2C+AZ+85053&maxrecords=10&country=US",
        "METHOD=OPTIONS",
        "HEADER=Access-Control-Request-Method:GET",
        "HEADER=Access-Control-Request-Headers:authorization,x-api-key",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("autocomplete", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("autocomplete_2");
    ns_web_url ("autocomplete_2",
        "URL=https://api-qa.n01.csaa-insurance.aaa.com/address-v1/validate/autocomplete?ff=3127+W+Greenway+Rd%2C+PHOENIX%2C+AZ+85053&maxrecords=10&country=US",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("autocomplete_2", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_4");
    ns_web_url ("quote_4",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=10658&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/property/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.6;e,'load,g0,1;6,'cls,0.;e,'fp,fr,1;6,1,0.;e,'fcp,fr,1;6,1,0.",
        BODY_END
    );

    ns_end_transaction("quote_4", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid_");
    ns_web_url ("quote_st_1681537629423_ptid_",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=10865&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/property/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__url_0_1_1681539358084.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid_", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__2");
    ns_web_url ("quote_st_1681537629423_ptid__2",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=30891&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/property/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"res":[{"n":"readystatechange","s":10869,"e":10869,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":10953,"e":10953,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":10953,"e":10953,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":10953,"e":10954,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"setTimeout","s":10864,"e":10870,"o":"window","t":"timer"},{"n":"setTimeout","s":20884,"e":20884,"o":"window","t":"timer"},{"n":"setTimeout","s":30581,"e":30582,"o":"window","t":"timer"},{"n":"setTimeout","s":30782,"e":30784,"o":"window","t":"timer"},{"n":"progress","s":10953,"e":10953,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":10954,"e":10954,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":10954,"e":10954,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":10954,"e":10954,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"Ajax","s":10869,"e":10954,"o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"ajax"},{"n":"xmlhttprequest","s":10869,"e":10951,"o":"https://bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"resource"},{"n":"setInterval","s":11597,"e":11597,"o":"window","t":"timer"},{"n":"setInterval","s":12593,"e":12593,"o":"window","t":"timer"},{"n":"setInterval","s":13595,"e":13595,"o":"window","t":"timer"},{"n":"setInterval","s":14594,"e":14594,"o":"window","t":"timer"},{"n":"setInterval","s":15587,"e":15587,"o":"window","t":"timer"},{"n":"setInterval","s":16592,"e":16592,"o":"window","t":"timer"},{"n":"setInterval","s":17593,"e":17593,"o":"window","t":"timer"},{"n":"setInterval","s":18585,"e":18585,"o":"window","t":"timer"},{"n":"setInterval","s":19586,"e":19586,"o":"window","t":"timer"},{"n":"setInterval","s":20592,"e":20592,"o":"window","t":"timer"},{"n":"setInterval","s":21596,"e":21596,"o":"window","t":"timer"},{"n":"setInterval","s":22598,"e":22598,"o":"window","t":"timer"},{"n":"setInterval","s":23585,"e":23586,"o":"window","t":"timer"},{"n":"setInterval","s":24590,"e":24590,"o":"window","t":"timer"},{"n":"setInterval","s":25585,"e":25585,"o":"window","t":"timer"},{"n":"setInterval","s":26589,"e":26589,"o":"window","t":"timer"},{"n":"setInterval","s":27595,"e":27595,"o":"window","t":"timer"},{"n":"setInterval","s":28584,"e":28584,"o":"window","t":"timer"},{"n":"setInterval","s":29590,"e":29590,"o":"window","t":"timer"},{"n":"setInterval","s":30596,"e":30596,"o":"window","t":"timer"}]}",
        BODY_END,
        INLINE_URLS,
            "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote", END_INLINE
    );

    ns_end_transaction("quote_st_1681537629423_ptid__2", NS_AUTO_STATUS);
    ns_page_think_time(347.065);


    // General info page 
    // 
    // 
    // 
    // 
    // 
    // 
    // 
    // 
    // 
    // 
    // 
    // select policy type
    // ========================

    //Page Auto split for 
    ns_start_transaction("metadata_3");
    ns_web_url ("metadata_3",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=OPTIONS",
        "HEADER=Access-Control-Request-Method:POST",
        "HEADER=Access-Control-Request-Headers:authorization,content-type,x-api-key",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("metadata_3", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_4");
    ns_web_url ("metadata_4",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"AZ","typeOfPolicy":"Auto","effectiveDate":"2023-04-15"},"filters":{"properties":["typeOfPolicy","elc","thirdPartyDesignee","residenceType","policyType","policyTerm","salesChannelType","officeType","agencyCd","agencyLocation","agentCd","birthDate","firstName","lastName","maritalStatus","relationship","gender","rideShareIndicator","military","aarpNumber","driverAssignment","defensiveDriverRefresher","nationalOrigin","driverType","reasonExcluded","reasonNAFR","driverRelToApplicantCd","antiTheft","antiLockBrakes","airBags","ownershipTypeCd","vehicleUsageCd","vehIdentificationNo","year","make","model","series","residentialAddressInd","odometerReading","registeredOwner","vehicleClassification","bodyType","type","priorBiLimit","insuredSince","licenseNumber","stateLicensed","licenseStatus","county"],"models":["AutoQuoteInfo","ProducerInfo","AutoDriver","AutoDriverType","AutoVehicle","AutoCarrierInfo","AutoDrivingLicense","AutoContactInfoAddress"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_4", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("autocomplete_3");
    ns_web_url ("autocomplete_3",
        "URL=https://api-qa.n01.csaa-insurance.aaa.com/address-v1/validate/autocomplete?ff=3127+W+Greenway+Rd%2C+PHOENIX%2C+AZ+85053&maxrecords=10&country=US",
        "METHOD=OPTIONS",
        "HEADER=Access-Control-Request-Method:GET",
        "HEADER=Access-Control-Request-Headers:authorization,x-api-key",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("autocomplete_3", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("autocomplete_4");
    ns_web_url ("autocomplete_4",
        "URL=https://api-qa.n01.csaa-insurance.aaa.com/address-v1/validate/autocomplete?ff=3127+W+Greenway+Rd%2C+PHOENIX%2C+AZ+85053&maxrecords=10&country=US",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("autocomplete_4", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_5");
    ns_web_url ("quote_5",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=38171&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.7;1,2,se7,120,t8,9g,'click,'https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/property/quote,1,'https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote,,1,!!!!'6325b7c8-a6fe-4e3d-a326-b151aaf45af5,'4,!!;2,,9a,ld,6a,6b,'POST,5k,'api-perf.n01.csaa-insurance.aaa.com:443,'/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata,rq,ag3,,'5,!!!;2,,ji,ic,6,6,'GET,5k,'api-qa.n01.csaa-insurance.aaa.com:443,'/address-v1/validate/autocomplete,,128,,'6,!!!;",
        BODY_END
    );

    ns_end_transaction("quote_5", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_6");
    ns_web_url ("quote_6",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=40671&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.6;e,'fi,pym,3;5,'type,'pointerdown;6,'fid,28.;6,'cls,0.4923938463878722;e,'lcp,3z6,3;6,'size,16926.;5,'eid;6,4,0.49237243556023147",
        BODY_END
    );

    ns_end_transaction("quote_6", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__3");
    ns_web_url ("quote_st_1681537629423_ptid__3",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=40905&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__3_url_0_1_1681539358130.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__3", NS_AUTO_STATUS);

    // effective date


    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__4");
    ns_web_url ("quote_st_1681537629423_ptid__4",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=50917&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"res":[{"n":"readystatechange","s":40914,"e":40914,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":41007,"e":41007,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":41007,"e":41007,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":41007,"e":41007,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"setTimeout","s":40904,"e":40916,"o":"window","t":"timer"},{"n":"progress","s":41007,"e":41007,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":41007,"e":41008,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":41008,"e":41008,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":41008,"e":41008,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"Ajax","s":40914,"e":41008,"o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"ajax"},{"n":"xmlhttprequest","s":40915,"e":41005,"o":"https://bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"resource"},{"n":"setInterval","s":41584,"e":41584,"o":"window","t":"timer"},{"n":"setInterval","s":42593,"e":42593,"o":"window","t":"timer"},{"n":"setInterval","s":43595,"e":43595,"o":"window","t":"timer"},{"n":"setInterval","s":44589,"e":44589,"o":"window","t":"timer"},{"n":"setInterval","s":45597,"e":45597,"o":"window","t":"timer"},{"n":"setInterval","s":46585,"e":46585,"o":"window","t":"timer"},{"n":"setInterval","s":47593,"e":47593,"o":"window","t":"timer"},{"n":"setInterval","s":48595,"e":48595,"o":"window","t":"timer"},{"n":"setInterval","s":49583,"e":49583,"o":"window","t":"timer"},{"n":"setInterval","s":50584,"e":50585,"o":"window","t":"timer"},{"n":"pointerover","s":48628,"e":48628,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"},{"n":"pointerover","s":48629,"e":48629,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"},{"n":"pointerover","s":48629,"e":48629,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"},{"n":"pointerover","s":48629,"e":48629,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"},{"n":"pointerover","s":50423,"e":50423,"t":"event","o":"input#mui-23.MuiInputBase-input.MuiFilledInput-input.css-94ukvg"},{"n":"pointerover","s":50423,"e":50423,"t":"event","o":"input#mui-23.MuiInputBase-input.MuiFilledInput-input.css-94ukvg"},{"n":"pointerover","s":50423,"e":50423,"t":"event","o":"input#mui-23.MuiInputBase-input.MuiFilledInput-input.css-94ukvg"},{"n":"pointerover","s":50423,"e":50423,"t":"event","o":"input#mui-23.MuiInputBase-input.MuiFilledInput-input.css-94ukvg"},{"n":"mousing","s":48629,"e":48630,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"},{"n":"mousing","s":50400,"e":50424,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"},{"n":"mousing","s":50424,"e":50913,"t":"event","o":"input#mui-23.MuiInputBase-input.MuiFilledInput-input.css-94ukvg"},{"n":"pointermove","s":48630,"e":48630,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"},{"n":"pointermove","s":48630,"e":48630,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"},{"n":"pointermove","s":48630,"e":48630,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"},{"n":"pointermove","s":48630,"e":48630,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"},{"n":"pointermove","s":50399,"e":50399,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"},{"n":"pointermove","s":50399,"e":50399,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"},{"n":"pointermove","s":50399,"e":50400,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"},{"n":"pointermove","s":50400,"e":50400,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"},{"n":"pointermove","s":50424,"e":50424,"t":"event","o":"input#mui-23.MuiInputBase-input.MuiFilledInput-input.css-94ukvg"},{"n":"pointermove","s":50425,"e":50425,"t":"event","o":"input#mui-23.MuiInputBase-input.MuiFilledInput-input.css-94ukvg"},{"n":"pointermove","s":50425,"e":50425,"t":"event","o":"input#mui-23.MuiInputBase-input.MuiFilledInput-input.css-94ukvg"},{"n":"pointermove","s":50425,"e":50425,"t":"event","o":"input#mui-23.MuiInputBase-input.MuiFilledInput-input.css-94ukvg"},{"n":"pointermove","s":50452,"e":50452,"t":"event","o":"input#mui-23.MuiInputBase-input.MuiFilledInput-input.css-94ukvg"},{"n":"pointermove","s":50452,"e":50452,"t":"event","o":"input#mui-23.MuiInputBase-input.MuiFilledInput-input.css-94ukvg"},{"n":"pointermove","s":50452,"e":50452,"t":"event","o":"input#mui-23.MuiInputBase-input.MuiFilledInput-input.css-94ukvg"},{"n":"pointermove","s":50453,"e":50453,"t":"event","o":"input#mui-23.MuiInputBase-input.MuiFilledInput-input.css-94ukvg"},{"n":"pointermove","s":50571,"e":50571,"t":"event","o":"input#mui-23.MuiInputBase-input.MuiFilledInput-input.css-94ukvg"},{"n":"pointermove","s":50571,"e":50571,"t":"event","o":"input#mui-23.MuiInputBase-input.MuiFilledInput-input.css-94ukvg"},{"n":"pointermove","s":50572,"e":50572,"t":"event","o":"input#mui-23.MuiInputBase-input.MuiFilledInput-input.css-94ukvg"},{"n":"pointermove","s":50572,"e":50572,"t":"event","o":"input#mui-23.MuiInputBase-input.MuiFilledInput-input.css-94ukvg"},{"n":"pointermove","s":50758,"e":50758,"t":"event","o":"input#mui-23.MuiInputBase-input.MuiFilledInput-input.css-94ukvg"},{"n":"pointermove","s":50758,"e":50758,"t":"event","o":"input#mui-23.MuiInputBase-input.MuiFilledInput-input.css-94ukvg"},{"n":"pointermove","s":50758,"e":50758,"t":"event","o":"input#mui-23.MuiInputBase-input.MuiFilledInput-input.css-94ukvg"},{"n":"pointermove","s":50758,"e":50758,"t":"event","o":"input#mui-23.MuiInputBase-input.MuiFilledInput-input.css-94ukvg"},{"n":"pointermove","s":50912,"e":50913,"t":"event","o":"input#mui-23.MuiInputBase-input.MuiFilledInput-input.css-94ukvg"},{"n":"pointermove","s":50913,"e":50913,"t":"event","o":"input#mui-23.MuiInputBase-input.MuiFilledInput-input.css-94ukvg"},{"n":"pointermove","s":50913,"e":50913,"t":"event","o":"input#mui-23.MuiInputBase-input.MuiFilledInput-input.css-94ukvg"},{"n":"pointermove","s":50913,"e":50913,"t":"event","o":"input#mui-23.MuiInputBase-input.MuiFilledInput-input.css-94ukvg"},{"n":"pointerout","s":50422,"e":50422,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"},{"n":"pointerout","s":50422,"e":50422,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"},{"n":"pointerout","s":50422,"e":50423,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"},{"n":"pointerout","s":50423,"e":50423,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"}]}",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__4", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_5");
    ns_web_url ("metadata_5",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"AZ","typeOfPolicy":"Auto","effectiveDate":"2023-04-16"},"filters":{"properties":["typeOfPolicy","elc","thirdPartyDesignee","residenceType","policyType","policyTerm","salesChannelType","officeType","agencyCd","agencyLocation","agentCd","birthDate","firstName","lastName","maritalStatus","relationship","gender","rideShareIndicator","military","aarpNumber","driverAssignment","defensiveDriverRefresher","nationalOrigin","driverType","reasonExcluded","reasonNAFR","driverRelToApplicantCd","antiTheft","antiLockBrakes","airBags","ownershipTypeCd","vehicleUsageCd","vehIdentificationNo","year","make","model","series","residentialAddressInd","odometerReading","registeredOwner","vehicleClassification","bodyType","type","priorBiLimit","insuredSince","licenseNumber","stateLicensed","licenseStatus","county"],"models":["AutoQuoteInfo","ProducerInfo","AutoDriver","AutoDriverType","AutoVehicle","AutoCarrierInfo","AutoDrivingLicense","AutoContactInfoAddress"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_5", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_7");
    ns_web_url ("quote_7",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=60781&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":9}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/resources/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":5,"txSize":{"t":128008,"min":1193,"max":75534,"sos":7422872640,"c":5},"rxSize":{"t":180,"min":36,"max":36,"sos":6480,"c":5},"duration":{"t":399,"min":73,"max":94,"sos":32195,"c":5},"cbTime":{"t":0,"min":0,"max":0,"sos":0,"c":5},"time":{"t":134373,"min":777,"max":50921,"sos":5339958191,"c":5}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/events/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":4,"txSize":{"t":880,"min":65,"max":479,"sos":292426,"c":4},"rxSize":{"t":96,"min":24,"max":24,"sos":2304,"c":4},"duration":{"t":296,"min":69,"max":79,"sos":21972,"c":4},"cbTime":{"t":3,"min":0,"max":1,"sos":3,"c":4},"time":{"t":90289,"min":786,"max":40672,"sos":3225545245,"c":4}}},{"params":{"method":"GET","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/express/v1/customers/715597413","status":201},"metrics":{"count":1,"rxSize":{"t":214},"duration":{"t":4465},"cbTime":{"t":0},"time":{"t":606}}},{"params":{"method":"POST","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csaa/home/v1/metadata","status":200},"metrics":{"count":1,"txSize":{"t":2176},"rxSize":{"t":114973},"duration":{"t":2359},"cbTime":{"t":0},"time":{"t":5070}}},{"params":{"method":"GET","hostname":"api-qa.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-qa.n01.csaa-insurance.aaa.com:443","pathname":"/address-v1/validate/autocomplete","status":200},"metrics":{"count":2,"rxSize":{"t":2752,"min":1376,"max":1376,"sos":3786752,"c":2},"duration":{"t":2841,"min":666,"max":2175,"sos":5174181,"c":2},"cbTime":{"t":0,"min":0,"max":0,"sos":0,"c":2},"time":{"t":42791,"min":5290,"max":37501,"sos":1434309101,"c":2}}},{"params":{"method":"POST","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata","status":200},"metrics":{"count":2,"txSize":{"t":1996,"min":998,"max":998,"sos":1992008,"c":2},"rxSize":{"t":27078,"min":13539,"max":13539,"sos":366609042,"c":2},"duration":{"t":1799,"min":804,"max":995,"sos":1636441,"c":2},"cbTime":{"t":0,"min":0,"max":0,"sos":0,"c":2},"time":{"t":96512,"min":37133,"max":59379,"sos":4904725330,"c":2}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_7", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_8");
    ns_web_url ("quote_8",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=60783&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.7;2,,gu,2xy,,,'GET,5l,'api-perf.n01.csaa-insurance.aaa.com:443,'/polexp-property/ent/pasgw/pasperf4/api/express/v1/customers/715597413,,5y,,'0,!!!;2,,3wu,1ia,,,'POST,5k,1,'/polexp-property/ent/pasgw/pasperf4/api/csaa/home/v1/metadata,1og,2gpp,,3,!!!;2,,42y,1o4,,,0,5k,'api-qa.n01.csaa-insurance.aaa.com:443,'/address-v1/validate/autocomplete,,128,,3,!!!;2,,19tf,gr,,,4,5k,1,'/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata,rq,ag3,,3,!!!",
        BODY_END
    );

    ns_end_transaction("quote_8", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__5");
    ns_web_url ("quote_st_1681537629423_ptid__5",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=60926&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__5_url_0_1_1681539358177.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__5", NS_AUTO_STATUS);

    // DOB
    // 
    // ==================


    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__6");
    ns_web_url ("quote_st_1681537629423_ptid__6",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=70937&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"res":[{"n":"readystatechange","s":60929,"e":60929,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":61081,"e":61081,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":61081,"e":61081,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":61082,"e":61082,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"setTimeout","s":60925,"e":60931,"o":"window","t":"timer"},{"n":"setTimeout","s":70675,"e":70676,"o":"window","t":"timer"},{"n":"progress","s":61081,"e":61081,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":61082,"e":61082,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":61082,"e":61082,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":61082,"e":61082,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"Ajax","s":60929,"e":61082,"o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"ajax"},{"n":"xmlhttprequest","s":60929,"e":61079,"o":"https://bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"resource"},{"n":"setInterval","s":61593,"e":61593,"o":"window","t":"timer"},{"n":"setInterval","s":62583,"e":62583,"o":"window","t":"timer"},{"n":"setInterval","s":63588,"e":63588,"o":"window","t":"timer"},{"n":"setInterval","s":64592,"e":64592,"o":"window","t":"timer"},{"n":"setInterval","s":65594,"e":65594,"o":"window","t":"timer"},{"n":"setInterval","s":66584,"e":66584,"o":"window","t":"timer"},{"n":"setInterval","s":67594,"e":67594,"o":"window","t":"timer"},{"n":"setInterval","s":68593,"e":68593,"o":"window","t":"timer"},{"n":"setInterval","s":69591,"e":69591,"o":"window","t":"timer"},{"n":"setInterval","s":70584,"e":70585,"o":"window","t":"timer"},{"n":"pointerover","s":70210,"e":70210,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"},{"n":"pointerover","s":70210,"e":70210,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"},{"n":"pointerover","s":70211,"e":70211,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"},{"n":"pointerover","s":70211,"e":70211,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"},{"n":"mousing","s":70211,"e":70213,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"},{"n":"pointermove","s":70212,"e":70212,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"},{"n":"pointermove","s":70212,"e":70212,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"},{"n":"pointermove","s":70212,"e":70212,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"},{"n":"pointermove","s":70212,"e":70212,"t":"event","o":"input#mui-27.MuiInputBase-input.MuiFilledInput-input.MuiInputBase-inputAdornedEnd.css-1a8q6ac"}]}",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__6", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__7");
    ns_web_url ("quote_st_1681537629423_ptid__7",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=80953&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__7_url_0_1_1681539358212.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__7", NS_AUTO_STATUS);

    // location


    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__8");
    ns_web_url ("quote_st_1681537629423_ptid__8",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=90969&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__8_url_0_1_1681539358239.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__8", NS_AUTO_STATUS);
    ns_page_think_time(0.331);

    //Page Auto split for 
    ns_start_transaction("autocomplete_5");
    ns_web_url ("autocomplete_5",
        "URL=https://api-qa.n01.csaa-insurance.aaa.com/address-v1/validate/autocomplete?ff=381&maxrecords=10&country=US",
        "METHOD=OPTIONS",
        "HEADER=Access-Control-Request-Method:GET",
        "HEADER=Access-Control-Request-Headers:authorization,x-api-key",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("autocomplete_5", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("autocomplete_6");
    ns_web_url ("autocomplete_6",
        "URL=https://api-qa.n01.csaa-insurance.aaa.com/address-v1/validate/autocomplete?ff=381&maxrecords=10&country=US",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("autocomplete_6", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("autocomplete_7");
    ns_web_url ("autocomplete_7",
        "URL=https://api-qa.n01.csaa-insurance.aaa.com/address-v1/validate/autocomplete?ff=381+&maxrecords=10&country=US",
        "METHOD=OPTIONS",
        "HEADER=Access-Control-Request-Method:GET",
        "HEADER=Access-Control-Request-Headers:authorization,x-api-key",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("autocomplete_7", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("autocomplete_8");
    ns_web_url ("autocomplete_8",
        "URL=https://api-qa.n01.csaa-insurance.aaa.com/address-v1/validate/autocomplete?ff=381+&maxrecords=10&country=US",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("autocomplete_8", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("autocomplete_9");
    ns_web_url ("autocomplete_9",
        "URL=https://api-qa.n01.csaa-insurance.aaa.com/address-v1/validate/autocomplete?ff=381+B&maxrecords=10&country=US",
        "METHOD=OPTIONS",
        "HEADER=Access-Control-Request-Method:GET",
        "HEADER=Access-Control-Request-Headers:authorization,x-api-key",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("autocomplete_9", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("autocomplete_10");
    ns_web_url ("autocomplete_10",
        "URL=https://api-qa.n01.csaa-insurance.aaa.com/address-v1/validate/autocomplete?ff=381+B&maxrecords=10&country=US",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("autocomplete_10", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("autocomplete_11");
    ns_web_url ("autocomplete_11",
        "URL=https://api-qa.n01.csaa-insurance.aaa.com/address-v1/validate/autocomplete?ff=381+Bent&maxrecords=10&country=US",
        "METHOD=OPTIONS",
        "HEADER=Access-Control-Request-Method:GET",
        "HEADER=Access-Control-Request-Headers:authorization,x-api-key",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("autocomplete_11", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("autocomplete_12");
    ns_web_url ("autocomplete_12",
        "URL=https://api-qa.n01.csaa-insurance.aaa.com/address-v1/validate/autocomplete?ff=381+Bent&maxrecords=10&country=US",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("autocomplete_12", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("autocomplete_13");
    ns_web_url ("autocomplete_13",
        "URL=https://api-qa.n01.csaa-insurance.aaa.com/address-v1/validate/autocomplete?ff=381+Bent+&maxrecords=10&country=US",
        "METHOD=OPTIONS",
        "HEADER=Access-Control-Request-Method:GET",
        "HEADER=Access-Control-Request-Headers:authorization,x-api-key",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("autocomplete_13", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("autocomplete_14");
    ns_web_url ("autocomplete_14",
        "URL=https://api-qa.n01.csaa-insurance.aaa.com/address-v1/validate/autocomplete?ff=381+Bent+&maxrecords=10&country=US",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("autocomplete_14", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__9");
    ns_web_url ("quote_st_1681537629423_ptid__9",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=100981&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__9_url_0_1_1681539358271.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__9", NS_AUTO_STATUS);
    ns_page_think_time(0.007);

    //Page Auto split for 
    ns_start_transaction("autocomplete_15");
    ns_web_url ("autocomplete_15",
        "URL=https://api-qa.n01.csaa-insurance.aaa.com/address-v1/validate/autocomplete?ff=381+Bent+Ave%2C+Akron%2C+CO+80720-1433&maxrecords=10&country=US",
        "METHOD=OPTIONS",
        "HEADER=Access-Control-Request-Method:GET",
        "HEADER=Access-Control-Request-Headers:authorization,x-api-key",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("autocomplete_15", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("autocomplete_16");
    ns_web_url ("autocomplete_16",
        "URL=https://api-qa.n01.csaa-insurance.aaa.com/address-v1/validate/autocomplete?ff=381+Bent+Ave%2C+Akron%2C+CO+80720-1433&maxrecords=10&country=US",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("autocomplete_16", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_6");
    ns_web_url ("metadata_6",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16"},"filters":{"properties":["typeOfPolicy","elc","thirdPartyDesignee","residenceType","policyType","policyTerm","salesChannelType","officeType","agencyCd","agencyLocation","agentCd","birthDate","firstName","lastName","maritalStatus","relationship","gender","rideShareIndicator","military","aarpNumber","driverAssignment","defensiveDriverRefresher","nationalOrigin","driverType","reasonExcluded","reasonNAFR","driverRelToApplicantCd","antiTheft","antiLockBrakes","airBags","ownershipTypeCd","vehicleUsageCd","vehIdentificationNo","year","make","model","series","residentialAddressInd","odometerReading","registeredOwner","vehicleClassification","bodyType","type","priorBiLimit","insuredSince","licenseNumber","stateLicensed","licenseStatus","county"],"models":["AutoQuoteInfo","ProducerInfo","AutoDriver","AutoDriverType","AutoVehicle","AutoCarrierInfo","AutoDrivingLicense","AutoContactInfoAddress"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_6", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__10");
    ns_web_url ("quote_st_1681537629423_ptid__10",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=110991&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__10_url_0_1_1681539358302.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__10", NS_AUTO_STATUS);

    // save and cont
    // 
    // 
    // 
    // ========================


    //Page Auto split for Method = POST
    ns_start_transaction("quote_9");
    ns_web_url ("quote_9",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=120793&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":8}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/events/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":454},"rxSize":{"t":24},"duration":{"t":139},"cbTime":{"t":0},"time":{"t":60783}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":2841},"rxSize":{"t":24},"duration":{"t":144},"cbTime":{"t":1},"time":{"t":60781}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/resources/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":6,"txSize":{"t":311568,"min":3473,"max":74354,"sos":20057849160,"c":6},"rxSize":{"t":216,"min":36,"max":36,"sos":7776,"c":6},"duration":{"t":603,"min":71,"max":153,"sos":66243,"c":6},"cbTime":{"t":1,"min":0,"max":1,"sos":1,"c":6},"time":{"t":515772,"min":60929,"max":110994,"sos":46091535910,"c":6}}},{"params":{"method":"GET","hostname":"api-qa.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-qa.n01.csaa-insurance.aaa.com:443","pathname":"/address-v1/validate/autocomplete","status":200},"metrics":{"count":6,"rxSize":{"t":66270,"min":1342,"max":13123,"sos":845027586,"c":6},"duration":{"t":8407,"min":458,"max":2337,"sos":15474915,"c":6},"cbTime":{"t":0,"min":0,"max":0,"sos":0,"c":6},"time":{"t":567492,"min":91431,"max":101060,"sos":53748774600,"c":6}}},{"params":{"method":"POST","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata","status":200},"metrics":{"count":1,"txSize":{"t":998},"rxSize":{"t":13723},"duration":{"t":808},"cbTime":{"t":0},"time":{"t":105704}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_9", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_10");
    ns_web_url ("quote_10",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=120796&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.7;2,,1yjr,1so,,,'GET,5k,'api-qa.n01.csaa-insurance.aaa.com:443,'/address-v1/validate/autocomplete,,a0a,,'0,!!!;2,,1yw9,1lq,,,0,5k,1,2,,a0a,,3,!!!;2,,1zzt,j0,,,0,5k,1,2,,a4j,,3,!!!;2,,1z8x,1mf,,,0,5k,1,2,,9ty,,3,!!!;2,,237q,js,,,0,5k,1,2,,a4j,,3,!!!;2,,25z8,cj,,,0,5k,1,2,,11a,,3,!!!;2,,29k8,h5,,,'POST,5k,'api-perf.n01.csaa-insurance.aaa.com:443,'/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata,rq,al7,,3,!!!",
        BODY_END
    );

    ns_end_transaction("quote_10", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__11");
    ns_web_url ("quote_st_1681537629423_ptid__11",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=121008&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__11_url_0_1_1681539358333.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__11", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__12");
    ns_web_url ("quote_st_1681537629423_ptid__12",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=131026&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__12_url_0_1_1681539358365.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__12", NS_AUTO_STATUS);
    ns_page_think_time(4.735);


    // yes the c accepts
    // 
    // ======================

    //Page Auto split for Button '' Clicked by User
    ns_start_transaction("quotes_express");
    ns_web_url ("quotes_express",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express",
        "METHOD=OPTIONS",
        "HEADER=Access-Control-Request-Method:POST",
        "HEADER=Access-Control-Request-Headers:authorization,content-type,x-api-key",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("quotes_express", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quotes_express_2");
    ns_web_url ("quotes_express_2",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"requestHeader":{"partnerId":"PE2","quoteType":"Quick","customerNumber":"715597413"},"quote":{"effectiveDate":"2023-04-16","typeOfPolicy":"Auto","contactInfo":{"address":{"addressValidated":true,"mailingAddressIndicator":false,"priorAddressIndicator":false,"addressLine1":"381 Bent Ave","city":"Akron","stateProvCd":"CO","postalCode":"80720-1433"},"email":null},"drivers":[{"driverOID":"++72bbe56a-2422-4fd1-9773-4601d10642dd","firstName":"Perf","lastName":"Test","birthDate":"2000-01-01","maritalStatus":null}],"consents":[{"consentType":"NCF","consentGranted":true,"ipAddress":"Dash","consentGrantedBy":"Processed by Agent","consentTimeStamp":"2023-04-14T22:47:09-07:00"}],"policyType":"SignatureSeries","residenceType":"OWNHOME","elc":"None","riskState":"CO"}}",
        BODY_END
    );

    ns_end_transaction("quotes_express_2", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__13");
    ns_web_url ("quote_st_1681537629423_ptid__13",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=141044&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__13_url_0_1_1681539358396.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__13", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_7");
    ns_web_url ("metadata_7",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16","subTypeOfPolicy":"AC"},"filters":{"properties":["typeOfPolicy","elc","thirdPartyDesignee","residenceType","policyType","policyTerm","salesChannelType","officeType","agencyCd","agencyLocation","agentCd","birthDate","firstName","lastName","maritalStatus","relationship","gender","rideShareIndicator","military","aarpNumber","driverAssignment","defensiveDriverRefresher","nationalOrigin","driverType","reasonExcluded","reasonNAFR","driverRelToApplicantCd","antiTheft","antiLockBrakes","airBags","ownershipTypeCd","vehicleUsageCd","vehIdentificationNo","year","make","model","series","residentialAddressInd","odometerReading","registeredOwner","vehicleClassification","bodyType","type","priorBiLimit","insuredSince","licenseNumber","stateLicensed","licenseStatus","county"],"models":["AutoQuoteInfo","ProducerInfo","AutoDriver","AutoDriverType","AutoVehicle","AutoCarrierInfo","AutoDrivingLicense","AutoContactInfoAddress"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_7", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__14");
    ns_web_url ("quote_st_1681537629423_ptid__14",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=151052&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__14_url_0_1_1681539358429.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__14", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__15");
    ns_web_url ("quote_st_1681537629423_ptid__15",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=161063&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__15_url_0_1_1681539358458.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__15", NS_AUTO_STATUS);

    // Add vehicles 1
    // 
    // ======================


    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__16");
    ns_web_url ("quote_st_1681537629423_ptid__16",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=171068&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"res":[{"n":"readystatechange","s":161065,"e":161065,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":161141,"e":161141,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":161141,"e":161141,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":161142,"e":161142,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"setTimeout","s":161062,"e":161066,"o":"window","t":"timer"},{"n":"progress","s":161141,"e":161141,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":161142,"e":161142,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":161142,"e":161142,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":161142,"e":161142,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"Ajax","s":161065,"e":161142,"o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"ajax"},{"n":"xmlhttprequest","s":161065,"e":161140,"o":"https://bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"resource"},{"n":"setInterval","s":161587,"e":161587,"o":"window","t":"timer"},{"n":"setInterval","s":162597,"e":162597,"o":"window","t":"timer"},{"n":"setInterval","s":163589,"e":163589,"o":"window","t":"timer"},{"n":"setInterval","s":164593,"e":164593,"o":"window","t":"timer"},{"n":"setInterval","s":165584,"e":165584,"o":"window","t":"timer"},{"n":"setInterval","s":166590,"e":166590,"o":"window","t":"timer"},{"n":"setInterval","s":167593,"e":167593,"o":"window","t":"timer"},{"n":"setInterval","s":168584,"e":168584,"o":"window","t":"timer"},{"n":"setInterval","s":169596,"e":169596,"o":"window","t":"timer"},{"n":"setInterval","s":170582,"e":170582,"o":"window","t":"timer"},{"n":"pointerover","s":170140,"e":170140,"t":"event","o":"div.MuiBox-root.css-0"},{"n":"pointerover","s":170141,"e":170141,"t":"event","o":"div.MuiBox-root.css-0"},{"n":"pointerover","s":170141,"e":170141,"t":"event","o":"div.MuiBox-root.css-0"},{"n":"pointerover","s":170141,"e":170141,"t":"event","o":"div.MuiBox-root.css-0"},{"n":"pointerover","s":171021,"e":171021,"t":"event","o":"div.collapse-header.collapse-header-expandable.MuiBox-root.css-1c6p7qf"},{"n":"pointerover","s":171021,"e":171021,"t":"event","o":"div.collapse-header.collapse-header-expandable.MuiBox-root.css-1c6p7qf"},{"n":"pointerover","s":171021,"e":171021,"t":"event","o":"div.collapse-header.collapse-header-expandable.MuiBox-root.css-1c6p7qf"},{"n":"pointerover","s":171021,"e":171021,"t":"event","o":"div.collapse-header.collapse-header-expandable.MuiBox-root.css-1c6p7qf"},{"n":"pointerover","s":171047,"e":171047,"t":"event","o":"div.MuiGrid-root.MuiGrid-container.css-7lg6x3"},{"n":"pointerover","s":171047,"e":171047,"t":"event","o":"div.MuiGrid-root.MuiGrid-container.css-7lg6x3"},{"n":"pointerover","s":171047,"e":171047,"t":"event","o":"div.MuiGrid-root.MuiGrid-container.css-7lg6x3"},{"n":"pointerover","s":171047,"e":171047,"t":"event","o":"div.MuiGrid-root.MuiGrid-container.css-7lg6x3"},{"n":"mousing","s":170142,"e":171022,"t":"event","o":"div.MuiBox-root.css-0"},{"n":"mousing","s":171022,"e":171048,"t":"event","o":"div.collapse-header.collapse-header-expandable.MuiBox-root.css-1c6p7qf"},{"n":"mousing","s":171048,"e":171048,"t":"event","o":"div.MuiGrid-root.MuiGrid-container.css-7lg6x3"},{"n":"pointermove","s":170142,"e":170142,"t":"event","o":"div.MuiBox-root.css-0"},{"n":"pointermove","s":170142,"e":170142,"t":"event","o":"div.MuiBox-root.css-0"},{"n":"pointermove","s":170142,"e":170142,"t":"event","o":"div.MuiBox-root.css-0"},{"n":"pointermove","s":170142,"e":170142,"t":"event","o":"div.MuiBox-root.css-0"},{"n":"pointermove","s":170990,"e":170990,"t":"event","o":"div.MuiBox-root.css-0"},{"n":"pointermove","s":170990,"e":170990,"t":"event","o":"div.MuiBox-root.css-0"},{"n":"pointermove","s":170990,"e":170990,"t":"event","o":"div.MuiBox-root.css-0"},{"n":"pointermove","s":170991,"e":170991,"t":"event","o":"div.MuiBox-root.css-0"},{"n":"pointermove","s":171022,"e":171022,"t":"event","o":"div.collapse-header.collapse-header-expandable.MuiBox-root.css-1c6p7qf"},{"n":"pointermove","s":171022,"e":171022,"t":"event","o":"div.collapse-header.collapse-header-expandable.MuiBox-root.css-1c6p7qf"},{"n":"pointermove","s":171022,"e":171022,"t":"event","o":"div.collapse-header.collapse-header-expandable.MuiBox-root.css-1c6p7qf"},{"n":"pointermove","s":171022,"e":171022,"t":"event","o":"div.collapse-header.collapse-header-expandable.MuiBox-root.css-1c6p7qf"},{"n":"pointermove","s":171048,"e":171048,"t":"event","o":"div.MuiGrid-root.MuiGrid-container.css-7lg6x3"},{"n":"pointermove","s":171048,"e":171048,"t":"event","o":"div.MuiGrid-root.MuiGrid-container.css-7lg6x3"},{"n":"pointermove","s":171048,"e":171048,"t":"event","o":"div.MuiGrid-root.MuiGrid-container.css-7lg6x3"},{"n":"pointermove","s":171048,"e":171048,"t":"event","o":"div.MuiGrid-root.MuiGrid-container.css-7lg6x3"},{"n":"pointerout","s":171021,"e":171021,"t":"event","o":"div.MuiBox-root.css-0"},{"n":"pointerout","s":171021,"e":171021,"t":"event","o":"div.MuiBox-root.css-0"},{"n":"pointerout","s":171021,"e":171021,"t":"event","o":"div.MuiBox-root.css-0"},{"n":"pointerout","s":171021,"e":171021,"t":"event","o":"div.MuiBox-root.css-0"},{"n":"pointerout","s":171047,"e":171047,"t":"event","o":"div.collapse-header.collapse-header-expandable.MuiBox-root.css-1c6p7qf"},{"n":"pointerout","s":171047,"e":171047,"t":"event","o":"div.collapse-header.collapse-header-expandable.MuiBox-root.css-1c6p7qf"},{"n":"pointerout","s":171047,"e":171047,"t":"event","o":"div.collapse-header.collapse-header-expandable.MuiBox-root.css-1c6p7qf"},{"n":"pointerout","s":171047,"e":171047,"t":"event","o":"div.collapse-header.collapse-header-expandable.MuiBox-root.css-1c6p7qf"}]}",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__16", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_11");
    ns_web_url ("quote_11",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=180797&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":8}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":2057},"rxSize":{"t":24},"duration":{"t":69},"cbTime":{"t":0},"time":{"t":120794}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/events/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":426},"rxSize":{"t":24},"duration":{"t":73},"cbTime":{"t":0},"time":{"t":120796}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/resources/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":6,"txSize":{"t":240665,"min":6118,"max":70268,"sos":12540722681,"c":6},"rxSize":{"t":216,"min":36,"max":36,"sos":7776,"c":6},"duration":{"t":587,"min":73,"max":153,"sos":62197,"c":6},"cbTime":{"t":0,"min":0,"max":0,"sos":0,"c":6},"time":{"t":876278,"min":121011,"max":171069,"sos":129731191324,"c":6}}},{"params":{"method":"POST","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express","status":206},"metrics":{"count":1,"txSize":{"t":764},"rxSize":{"t":8298},"duration":{"t":14024},"cbTime":{"t":0},"time":{"t":135848}}},{"params":{"method":"POST","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata","status":200},"metrics":{"count":1,"txSize":{"t":1021},"rxSize":{"t":13710},"duration":{"t":1169},"cbTime":{"t":0},"time":{"t":149601}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_11", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_12");
    ns_web_url ("quote_12",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=180799&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.7;2,,2wtk,ae2,,,'POST,5q,'api-perf.n01.csaa-insurance.aaa.com:443,'/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express,l8,6ei,,'0,!!!;2,,37fl,ny,,,0,5k,1,'/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata,sd,aku,,3,!!!",
        BODY_END
    );

    ns_end_transaction("quote_12", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__17");
    ns_web_url ("quote_st_1681537629423_ptid__17",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=181078&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__17_url_0_1_1681539358491.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__17", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__18");
    ns_web_url ("quote_st_1681537629423_ptid__18",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=191082&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__18_url_0_1_1681539358520.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__18", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__19");
    ns_web_url ("quote_st_1681537629423_ptid__19",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=211106&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"res":[{"n":"readystatechange","s":191083,"e":191083,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":191161,"e":191161,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":191161,"e":191161,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":191162,"e":191162,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"setTimeout","s":191082,"e":191085,"o":"window","t":"timer"},{"n":"setTimeout","s":201093,"e":201093,"o":"window","t":"timer"},{"n":"setTimeout","s":210811,"e":210811,"o":"window","t":"timer"},{"n":"progress","s":191161,"e":191161,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":191162,"e":191162,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":191162,"e":191162,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":191162,"e":191162,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"Ajax","s":191083,"e":191162,"o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"ajax"},{"n":"xmlhttprequest","s":191083,"e":191160,"o":"https://bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"resource"},{"n":"setInterval","s":191593,"e":191593,"o":"window","t":"timer"},{"n":"setInterval","s":192586,"e":192586,"o":"window","t":"timer"},{"n":"setInterval","s":193590,"e":193590,"o":"window","t":"timer"},{"n":"setInterval","s":194594,"e":194594,"o":"window","t":"timer"},{"n":"setInterval","s":195593,"e":195593,"o":"window","t":"timer"},{"n":"setInterval","s":196584,"e":196584,"o":"window","t":"timer"},{"n":"setInterval","s":197592,"e":197592,"o":"window","t":"timer"},{"n":"setInterval","s":198594,"e":198594,"o":"window","t":"timer"},{"n":"setInterval","s":199597,"e":199597,"o":"window","t":"timer"},{"n":"setInterval","s":200585,"e":200585,"o":"window","t":"timer"},{"n":"setInterval","s":201587,"e":201587,"o":"window","t":"timer"},{"n":"setInterval","s":202588,"e":202588,"o":"window","t":"timer"},{"n":"setInterval","s":203583,"e":203583,"o":"window","t":"timer"},{"n":"setInterval","s":204587,"e":204587,"o":"window","t":"timer"},{"n":"setInterval","s":205588,"e":205588,"o":"window","t":"timer"},{"n":"setInterval","s":206585,"e":206585,"o":"window","t":"timer"},{"n":"setInterval","s":207592,"e":207592,"o":"window","t":"timer"},{"n":"setInterval","s":208594,"e":208594,"o":"window","t":"timer"},{"n":"setInterval","s":209589,"e":209589,"o":"window","t":"timer"},{"n":"setInterval","s":210593,"e":210593,"o":"window","t":"timer"}]}",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__19", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__20");
    ns_web_url ("quote_st_1681537629423_ptid__20",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=231117&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"res":[{"n":"readystatechange","s":211106,"e":211107,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":211178,"e":211178,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":211178,"e":211178,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":211179,"e":211179,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"setTimeout","s":211106,"e":211108,"o":"window","t":"timer"},{"n":"setTimeout","s":220701,"e":220702,"o":"window","t":"timer"},{"n":"setTimeout","s":221116,"e":221116,"o":"window","t":"timer"},{"n":"progress","s":211178,"e":211178,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":211179,"e":211179,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":211179,"e":211179,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":211179,"e":211179,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"Ajax","s":211107,"e":211179,"o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"ajax"},{"n":"xmlhttprequest","s":211107,"e":211177,"o":"https://bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"resource"},{"n":"setInterval","s":211585,"e":211585,"o":"window","t":"timer"},{"n":"setInterval","s":212594,"e":212594,"o":"window","t":"timer"},{"n":"setInterval","s":213587,"e":213587,"o":"window","t":"timer"},{"n":"setInterval","s":214587,"e":214587,"o":"window","t":"timer"},{"n":"setInterval","s":215592,"e":215592,"o":"window","t":"timer"},{"n":"setInterval","s":216594,"e":216594,"o":"window","t":"timer"},{"n":"setInterval","s":217595,"e":217595,"o":"window","t":"timer"},{"n":"setInterval","s":218588,"e":218588,"o":"window","t":"timer"},{"n":"setInterval","s":219591,"e":219591,"o":"window","t":"timer"},{"n":"setInterval","s":220593,"e":220593,"o":"window","t":"timer"},{"n":"setInterval","s":221594,"e":221594,"o":"window","t":"timer"},{"n":"setInterval","s":222586,"e":222587,"o":"window","t":"timer"},{"n":"setInterval","s":223593,"e":223593,"o":"window","t":"timer"},{"n":"setInterval","s":224597,"e":224597,"o":"window","t":"timer"},{"n":"setInterval","s":225596,"e":225596,"o":"window","t":"timer"},{"n":"setInterval","s":226587,"e":226587,"o":"window","t":"timer"},{"n":"setInterval","s":227594,"e":227594,"o":"window","t":"timer"},{"n":"setInterval","s":228591,"e":228591,"o":"window","t":"timer"},{"n":"setInterval","s":229596,"e":229596,"o":"window","t":"timer"},{"n":"setInterval","s":230591,"e":230591,"o":"window","t":"timer"}]}",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__20", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_13");
    ns_web_url ("quote_13",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=240811&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":6}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/events/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":250},"rxSize":{"t":24},"duration":{"t":73},"cbTime":{"t":1},"time":{"t":180799}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":1953},"rxSize":{"t":24},"duration":{"t":83},"cbTime":{"t":0},"time":{"t":180797}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/resources/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":4,"txSize":{"t":64635,"min":2889,"max":32948,"sos":1773539627,"c":4},"rxSize":{"t":144,"min":36,"max":36,"sos":5184,"c":4},"duration":{"t":370,"min":72,"max":146,"sos":38070,"c":4},"cbTime":{"t":0,"min":0,"max":0,"sos":0,"c":4},"time":{"t":814387,"min":181079,"max":231118,"sos":167284012503,"c":4}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_13", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__21");
    ns_web_url ("quote_st_1681537629423_ptid__21",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=241122&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"res":[{"n":"readystatechange","s":231118,"e":231118,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":231190,"e":231190,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":231190,"e":231190,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":231191,"e":231191,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":240811,"e":240811,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/jserrors/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":240945,"e":240945,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/jserrors/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":240945,"e":240945,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/jserrors/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":240946,"e":240946,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/jserrors/1/NRJS-caa2993fd9f89f03d7d"},{"n":"setTimeout","s":231117,"e":231119,"o":"window","t":"timer"},{"n":"setTimeout","s":240810,"e":240813,"o":"window","t":"timer"},{"n":"setTimeout","s":240813,"e":240813,"o":"window","t":"timer"},{"n":"setTimeout","s":240813,"e":240813,"o":"window","t":"timer"},{"n":"progress","s":231191,"e":231191,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"progress","s":240945,"e":240945,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/jserrors/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":231191,"e":231191,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":231191,"e":231191,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":231191,"e":231191,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":240946,"e":240946,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/jserrors/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":240946,"e":240946,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/jserrors/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":240946,"e":240946,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/jserrors/1/NRJS-caa2993fd9f89f03d7d"},{"n":"Ajax","s":231118,"e":231191,"o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"ajax"},{"n":"Ajax","s":240811,"e":240946,"o":"200 POST: bam-cell.nr-data.net:443/jserrors/1/NRJS-caa2993fd9f89f03d7d","t":"ajax"},{"n":"xmlhttprequest","s":231118,"e":231189,"o":"https://bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"resource"},{"n":"xmlhttprequest","s":240811,"e":240944,"o":"https://bam-cell.nr-data.net:443/jserrors/1/NRJS-caa2993fd9f89f03d7d","t":"resource"},{"n":"setInterval","s":231583,"e":231583,"o":"window","t":"timer"},{"n":"setInterval","s":232587,"e":232588,"o":"window","t":"timer"},{"n":"setInterval","s":233595,"e":233595,"o":"window","t":"timer"},{"n":"setInterval","s":234583,"e":234583,"o":"window","t":"timer"},{"n":"setInterval","s":235590,"e":235590,"o":"window","t":"timer"},{"n":"setInterval","s":236583,"e":236583,"o":"window","t":"timer"},{"n":"setInterval","s":237597,"e":237597,"o":"window","t":"timer"},{"n":"setInterval","s":238590,"e":238590,"o":"window","t":"timer"},{"n":"setInterval","s":239584,"e":239584,"o":"window","t":"timer"},{"n":"setInterval","s":240593,"e":240593,"o":"window","t":"timer"}]}",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__21", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__22");
    ns_web_url ("quote_st_1681537629423_ptid__22",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=251126&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__22_url_0_1_1681539358572.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__22", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_8");
    ns_web_url ("metadata_8",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16"},"filters":{"properties":["vehicleUsageCd"],"models":["AutoVehicle"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_8", NS_AUTO_STATUS);

    // vin


    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__23");
    ns_web_url ("quote_st_1681537629423_ptid__23",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=261137&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__23_url_0_1_1681539358600.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__23", NS_AUTO_STATUS);
    ns_page_think_time(7.942);

    //Page Auto split for 
    ns_start_transaction("SAJGX2040XC042591");
    ns_web_url ("SAJGX2040XC042591",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csr/v1/policies/QCOAC226334300/vin-info/SAJGX2040XC042591",
        "METHOD=OPTIONS",
        "HEADER=Access-Control-Request-Method:GET",
        "HEADER=Access-Control-Request-Headers:authorization,x-api-key",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("SAJGX2040XC042591", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("SAJGX2040XC042591_2");
    ns_web_url ("SAJGX2040XC042591_2",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csr/v1/policies/QCOAC226334300/vin-info/SAJGX2040XC042591",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("SAJGX2040XC042591_2", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__24");
    ns_web_url ("quote_st_1681537629423_ptid__24",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=271149&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__24_url_0_1_1681539358633.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__24", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_9");
    ns_web_url ("metadata_9",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16","vehTypeCd":"Private Passenger Auto"},"filters":{"properties":["vehicleUsageCd"],"models":["AutoVehicle"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_9", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__25");
    ns_web_url ("quote_st_1681537629423_ptid__25",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=281155&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__25_url_0_1_1681539358663.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__25", NS_AUTO_STATUS);

    // save 
    // 
    // ==================


    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__26");
    ns_web_url ("quote_st_1681537629423_ptid__26",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=291164&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__26_url_0_1_1681539358694.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__26", NS_AUTO_STATUS);

    // add 2nd vehicles


    //Page Auto split for Method = POST
    ns_start_transaction("quote_14");
    ns_web_url ("quote_14",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=300813&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":7}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":1208},"rxSize":{"t":24},"duration":{"t":135},"cbTime":{"t":0},"time":{"t":240811}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/resources/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":6,"txSize":{"t":277009,"min":3617,"max":65842,"sos":16096748537,"c":6},"rxSize":{"t":216,"min":36,"max":36,"sos":7776,"c":6},"duration":{"t":566,"min":74,"max":146,"sos":56900,"c":6},"cbTime":{"t":1,"min":0,"max":1,"sos":1,"c":6},"time":{"t":1596875,"min":241123,"max":291174,"sos":426755079347,"c":6}}},{"params":{"method":"POST","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata","status":200},"metrics":{"count":2,"txSize":{"t":375,"min":169,"max":206,"sos":70997,"c":2},"rxSize":{"t":756,"min":378,"max":378,"sos":285768,"c":2},"duration":{"t":1311,"min":620,"max":691,"sos":861881,"c":2},"cbTime":{"t":0,"min":0,"max":0,"sos":0,"c":2},"time":{"t":521387,"min":250726,"max":270661,"sos":136120903997,"c":2}}},{"params":{"method":"GET","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csr/v1/policies/QCOAC226334300/vin-info/SAJGX2040XC042591","status":200},"metrics":{"count":1,"rxSize":{"t":375},"duration":{"t":1499},"cbTime":{"t":0},"time":{"t":269164}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_14", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_15");
    ns_web_url ("quote_15",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=300815&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.7;2,,5dgm,fi,,,'POST,5k,'api-perf.n01.csaa-insurance.aaa.com:443,'/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata,4p,ai,,'0,!!!;2,,5ros,nk,,,'GET,5k,1,'/polexp-property/ent/pasgw/pasperf4/api/csr/v1/policies/QCOAC226334300/vin-info/SAJGX2040XC042591,,af,,3,!!!;2,,5sud,hd,,,0,5k,1,2,5q,ai,,3,!!!",
        BODY_END
    );

    ns_end_transaction("quote_15", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__27");
    ns_web_url ("quote_st_1681537629423_ptid__27",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=301177&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__27_url_0_1_1681539358731.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__27", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_10");
    ns_web_url ("metadata_10",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16"},"filters":{"properties":["vehicleUsageCd"],"models":["AutoVehicle"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_10", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__28");
    ns_web_url ("quote_st_1681537629423_ptid__28",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=311192&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__28_url_0_1_1681539358763.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__28", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__29");
    ns_web_url ("quote_st_1681537629423_ptid__29",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=321197&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"res":[{"n":"readystatechange","s":311194,"e":311194,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":311334,"e":311334,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":311334,"e":311334,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":311335,"e":311335,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"setTimeout","s":311192,"e":311196,"o":"window","t":"timer"},{"n":"setTimeout","s":312117,"e":312176,"o":"window","t":"timer"},{"n":"progress","s":311334,"e":311334,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":311335,"e":311335,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":311335,"e":311335,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":311335,"e":311335,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"Ajax","s":311194,"e":311335,"o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"ajax"},{"n":"xmlhttprequest","s":311195,"e":311333,"o":"https://bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"resource"},{"n":"setInterval","s":311595,"e":311595,"o":"window","t":"timer"},{"n":"setInterval","s":312587,"e":312587,"o":"window","t":"timer"},{"n":"setInterval","s":313592,"e":313592,"o":"window","t":"timer"},{"n":"setInterval","s":314596,"e":314596,"o":"window","t":"timer"},{"n":"setInterval","s":315598,"e":315598,"o":"window","t":"timer"},{"n":"setInterval","s":316586,"e":316586,"o":"window","t":"timer"},{"n":"setInterval","s":317592,"e":317592,"o":"window","t":"timer"},{"n":"setInterval","s":318595,"e":318595,"o":"window","t":"timer"},{"n":"setInterval","s":319593,"e":319594,"o":"window","t":"timer"},{"n":"setInterval","s":320583,"e":320583,"o":"window","t":"timer"},{"n":"pointerover","s":320412,"e":320413,"t":"event","o":"input#mui-78.MuiInputBase-input.MuiFilledInput-input.Mui-disabled.MuiInputBase-inputAdornedEnd.MuiAutocomplete-input.MuiAutocomplete-inputFocused.css-1a8q6ac"},{"n":"pointerover","s":320413,"e":320413,"t":"event","o":"input#mui-78.MuiInputBase-input.MuiFilledInput-input.Mui-disabled.MuiInputBase-inputAdornedEnd.MuiAutocomplete-input.MuiAutocomplete-inputFocused.css-1a8q6ac"},{"n":"pointerover","s":320413,"e":320413,"t":"event","o":"input#mui-78.MuiInputBase-input.MuiFilledInput-input.Mui-disabled.MuiInputBase-inputAdornedEnd.MuiAutocomplete-input.MuiAutocomplete-inputFocused.css-1a8q6ac"},{"n":"pointerover","s":320413,"e":320413,"t":"event","o":"input#mui-78.MuiInputBase-input.MuiFilledInput-input.Mui-disabled.MuiInputBase-inputAdornedEnd.MuiAutocomplete-input.MuiAutocomplete-inputFocused.css-1a8q6ac"},{"n":"mousing","s":320413,"e":320414,"t":"event","o":"input#mui-78.MuiInputBase-input.MuiFilledInput-input.Mui-disabled.MuiInputBase-inputAdornedEnd.MuiAutocomplete-input.MuiAutocomplete-inputFocused.css-1a8q6ac"},{"n":"pointermove","s":320414,"e":320414,"t":"event","o":"input#mui-78.MuiInputBase-input.MuiFilledInput-input.Mui-disabled.MuiInputBase-inputAdornedEnd.MuiAutocomplete-input.MuiAutocomplete-inputFocused.css-1a8q6ac"},{"n":"pointermove","s":320414,"e":320414,"t":"event","o":"input#mui-78.MuiInputBase-input.MuiFilledInput-input.Mui-disabled.MuiInputBase-inputAdornedEnd.MuiAutocomplete-input.MuiAutocomplete-inputFocused.css-1a8q6ac"},{"n":"pointermove","s":320414,"e":320414,"t":"event","o":"input#mui-78.MuiInputBase-input.MuiFilledInput-input.Mui-disabled.MuiInputBase-inputAdornedEnd.MuiAutocomplete-input.MuiAutocomplete-inputFocused.css-1a8q6ac"},{"n":"pointermove","s":320414,"e":320414,"t":"event","o":"input#mui-78.MuiInputBase-input.MuiFilledInput-input.Mui-disabled.MuiInputBase-inputAdornedEnd.MuiAutocomplete-input.MuiAutocomplete-inputFocused.css-1a8q6ac"}]}",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__29", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("config_json_4");
    ns_web_url ("config_json_4",
        "URL=https://c.go-mpulse.net/api/config.json?key=8GSRP-JVCR4-6J3AN-EWLKW-WZ2FU&d=dash-perf.pas.n01.csaa-insurance.aaa.com&t=5605127&v=1.720.0&if=&sl=1&si=71e7dab5-3521-484e-9b84-4069866ed516-rt56ql&r=&bcn=%2F%2F17de4c0e.akstat.io%2F&acao=&ak.ai=780488",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("config_json_4", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__30");
    ns_web_url ("quote_st_1681537629423_ptid__30",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=331201&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__30_url_0_1_1681539358790.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__30", NS_AUTO_STATUS);
    ns_page_think_time(9.703);


    // enter VIN no.
    // 
    // 
    // 
    // =====================

    //Page Auto split for 
    ns_start_transaction("JH4KA3160JC002842");
    ns_web_url ("JH4KA3160JC002842",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csr/v1/policies/QCOAC226334300/vin-info/JH4KA3160JC002842",
        "METHOD=OPTIONS",
        "HEADER=Access-Control-Request-Method:GET",
        "HEADER=Access-Control-Request-Headers:authorization,x-api-key",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("JH4KA3160JC002842", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("JH4KA3160JC002842_2");
    ns_web_url ("JH4KA3160JC002842_2",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csr/v1/policies/QCOAC226334300/vin-info/JH4KA3160JC002842",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("JH4KA3160JC002842_2", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__31");
    ns_web_url ("quote_st_1681537629423_ptid__31",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=341220&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__31_url_0_1_1681539358821.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__31", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_11");
    ns_web_url ("metadata_11",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16","vehTypeCd":"Private Passenger Auto"},"filters":{"properties":["vehicleUsageCd"],"models":["AutoVehicle"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_11", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__32");
    ns_web_url ("quote_st_1681537629423_ptid__32",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=351240&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__32_url_0_1_1681539358859.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__32", NS_AUTO_STATUS);

    // save 2nd vehicles


    //Page Auto split for Method = POST
    ns_start_transaction("quote_16");
    ns_web_url ("quote_16",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=360826&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":8}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":1851},"rxSize":{"t":24},"duration":{"t":73},"cbTime":{"t":0},"time":{"t":300814}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/events/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":313},"rxSize":{"t":24},"duration":{"t":131},"cbTime":{"t":0},"time":{"t":300815}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/resources/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":6,"txSize":{"t":215839,"min":4111,"max":61595,"sos":9611783365,"c":6},"rxSize":{"t":216,"min":36,"max":36,"sos":7776,"c":6},"duration":{"t":537,"min":71,"max":141,"sos":51403,"c":6},"cbTime":{"t":0,"min":0,"max":0,"sos":0,"c":6},"time":{"t":1957243,"min":301180,"max":351241,"sos":640220766013,"c":6}}},{"params":{"method":"POST","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata","status":200},"metrics":{"count":2,"txSize":{"t":375,"min":169,"max":206,"sos":70997,"c":2},"rxSize":{"t":756,"min":378,"max":378,"sos":285768,"c":2},"duration":{"t":1185,"min":535,"max":650,"sos":708725,"c":2},"cbTime":{"t":0,"min":0,"max":0,"sos":0,"c":2},"time":{"t":645233,"min":302681,"max":342552,"sos":208957660465,"c":2}}},{"params":{"method":"GET","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csr/v1/policies/QCOAC226334300/vin-info/JH4KA3160JC002842","status":200},"metrics":{"count":1,"rxSize":{"t":381},"duration":{"t":1573},"cbTime":{"t":0},"time":{"t":340980}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_16", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_17");
    ns_web_url ("quote_17",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=360829&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.7;2,,6hjt,d7,,,'POST,5k,'api-perf.n01.csaa-insurance.aaa.com:443,'/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata,4p,ai,,'0,!!!;2,,7b3o,ri,,,'GET,5k,1,'/polexp-property/ent/pasgw/pasperf4/api/csr/v1/policies/QCOAC226334300/vin-info/JH4KA3160JC002842,,al,,3,!!!;2,,7cbc,g4,,,0,5k,1,2,5q,ai,,3,!!!",
        BODY_END
    );

    ns_end_transaction("quote_17", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__33");
    ns_web_url ("quote_st_1681537629423_ptid__33",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=361248&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__33_url_0_1_1681539358886.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__33", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__34");
    ns_web_url ("quote_st_1681537629423_ptid__34",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=371266&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__34_url_0_1_1681539358912.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__34", NS_AUTO_STATUS);

    // more info needed in drivers
    // 
    // 
    // ===============


    //Page Auto split for Method = POST
    ns_start_transaction("metadata_12");
    ns_web_url ("metadata_12",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16","driverRelToApplicantCd":"Self"},"filters":{"properties":["driverType"],"models":["AutoDriverType"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_12", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__35");
    ns_web_url ("quote_st_1681537629423_ptid__35",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=381270&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__35_url_0_1_1681539358945.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__35", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__36");
    ns_web_url ("quote_st_1681537629423_ptid__36",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=391280&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__36_url_0_1_1681539358976.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__36", NS_AUTO_STATUS);

    // save driver1


    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__37");
    ns_web_url ("quote_st_1681537629423_ptid__37",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=401289&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__37_url_0_1_1681539359007.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__37", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__38");
    ns_web_url ("quote_st_1681537629423_ptid__38",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=411295&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__38_url_0_1_1681539359029.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__38", NS_AUTO_STATUS);

    // Add driver 2


    //Page Auto split for Method = POST
    ns_start_transaction("metadata_13");
    ns_web_url ("metadata_13",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16"},"filters":{"properties":["driverType"],"models":["AutoDriverType"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_13", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_18");
    ns_web_url ("quote_18",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=420840&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":8}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":2156},"rxSize":{"t":24},"duration":{"t":71},"cbTime":{"t":0},"time":{"t":360827}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/events/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":313},"rxSize":{"t":24},"duration":{"t":75},"cbTime":{"t":0},"time":{"t":360830}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/resources/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":6,"txSize":{"t":250186,"min":13200,"max":98573,"sos":15233825010,"c":6},"rxSize":{"t":216,"min":36,"max":36,"sos":7776,"c":6},"duration":{"t":563,"min":77,"max":132,"sos":54855,"c":6},"cbTime":{"t":1,"min":0,"max":1,"sos":1,"c":6},"time":{"t":2317664,"min":361252,"max":411296,"sos":897014090834,"c":6}}},{"params":{"method":"POST","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata","status":200},"metrics":{"count":2,"txSize":{"t":368,"min":168,"max":200,"sos":68224,"c":2},"rxSize":{"t":546,"min":273,"max":273,"sos":149058,"c":2},"duration":{"t":1369,"min":639,"max":730,"sos":941221,"c":2},"cbTime":{"t":0,"min":0,"max":0,"sos":0,"c":2},"time":{"t":800006,"min":380114,"max":419892,"sos":320795944660,"c":2}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_18", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_19");
    ns_web_url ("quote_19",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=420842&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.7;2,,85aq,ib,,,'POST,5k,'api-perf.n01.csaa-insurance.aaa.com:443,'/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata,5k,7l,,'0,!!!;2,,8zzo,fa,,,0,5k,1,2,4o,7l,,3,!!!",
        BODY_END
    );

    ns_end_transaction("quote_19", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__39");
    ns_web_url ("quote_st_1681537629423_ptid__39",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=421298&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__39_url_0_1_1681539359065.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__39", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__40");
    ns_web_url ("quote_st_1681537629423_ptid__40",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=431309&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__40_url_0_1_1681539359083.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__40", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__41");
    ns_web_url ("quote_st_1681537629423_ptid__41",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=441316&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__41_url_0_1_1681539359113.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__41", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__42");
    ns_web_url ("quote_st_1681537629423_ptid__42",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=451337&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__42_url_0_1_1681539359153.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__42", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__43");
    ns_web_url ("quote_st_1681537629423_ptid__43",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=461343&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__43_url_0_1_1681539359177.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__43", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_14");
    ns_web_url ("metadata_14",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16","driverRelToApplicantCd":"Other"},"filters":{"properties":["driverType"],"models":["AutoDriverType"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_14", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__44");
    ns_web_url ("quote_st_1681537629423_ptid__44",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=471356&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__44_url_0_1_1681539359205.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__44", NS_AUTO_STATUS);

    // save 2nd driver


    //Page Auto split for Method = POST
    ns_start_transaction("quote_20");
    ns_web_url ("quote_20",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=480843&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":8}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":1775},"rxSize":{"t":24},"duration":{"t":129},"cbTime":{"t":0},"time":{"t":420840}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/events/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":180},"rxSize":{"t":24},"duration":{"t":134},"cbTime":{"t":0},"time":{"t":420842}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/resources/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":6,"txSize":{"t":413917,"min":46844,"max":93791,"sos":29743407475,"c":6},"rxSize":{"t":216,"min":36,"max":36,"sos":7776,"c":6},"duration":{"t":655,"min":81,"max":215,"sos":85057,"c":6},"cbTime":{"t":0,"min":0,"max":0,"sos":0,"c":6},"time":{"t":2677975,"min":421301,"max":471360,"sos":1197012502615,"c":6}}},{"params":{"method":"POST","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata","status":200},"metrics":{"count":1,"txSize":{"t":201},"rxSize":{"t":273},"duration":{"t":781},"cbTime":{"t":0},"time":{"t":462403}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_20", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_21");
    ns_web_url ("quote_21",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=480846&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.7;2,,9wsj,j4,,,'POST,5k,'api-perf.n01.csaa-insurance.aaa.com:443,'/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata,5l,7l,,'0,!!!",
        BODY_END
    );

    ns_end_transaction("quote_21", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__45");
    ns_web_url ("quote_st_1681537629423_ptid__45",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=481365&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__45_url_0_1_1681539359241.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__45", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__46");
    ns_web_url ("quote_st_1681537629423_ptid__46",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=501373&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__46_url_0_1_1681539359259.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__46", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__47");
    ns_web_url ("quote_st_1681537629423_ptid__47",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=511389&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__47_url_0_1_1681539359271.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__47", NS_AUTO_STATUS);
    ns_page_think_time(6.948);


    // update quote
    // ===========================

    //Page Auto split for Button '' Clicked by User
    ns_start_transaction("QCOAC226334300");
    ns_web_url ("QCOAC226334300",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOAC226334300",
        "METHOD=OPTIONS",
        "HEADER=Access-Control-Request-Method:PATCH",
        "HEADER=Access-Control-Request-Headers:authorization,content-type,x-api-key",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("QCOAC226334300", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("QCOAC226334300_2");
    ns_web_url ("QCOAC226334300_2",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOAC226334300",
        "METHOD=PATCH",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"patch":[{"op":"add","path":"/vehicles/0","value":{"ownershipTypeCd":"OWN","vehicleUsageCd":"Pleasure","antiTheft":"None","airBags":"none","vehicleOID":"++2019ce2c-d7b2-4b47-8dc7-701ace7d95df","vehIdentificationNo":"SAJGX2040XC042591","residentialAddressInd":false,"year":1999,"make":"JAGUAR","model":"XK8","series":"XK8","engineCc":"244","bodyType":"CONVERTIBLE","vehTypeCd":"CON","partialVin":false,"type":"Private Passenger Auto"}},{"op":"add","path":"/vehicles/1","value":{"ownershipTypeCd":"OWN","vehicleUsageCd":"Pleasure","antiTheft":"None","airBags":"none","vehicleOID":"++06aeaad6-7536-4fd0-9a6d-7fe01affe624","vehIdentificationNo":"JH4KA3160JC002842","residentialAddressInd":false,"year":1988,"make":"ACURA","model":"LEGEND","series":"LEGEND LS","engineCc":"165","bodyType":"COUPE","vehTypeCd":"CPE","partialVin":false,"type":"Private Passenger Auto"}},{"op":"replace","path":"/drivers/0/gender","value":"male"},{"op":"replace","path":"/drivers/0/maritalStatus","value":"S"},{"op":"add","path":"/drivers/1","value":{"type":{"driverType":"afr"},"ageFirstLicensed":16,"driverOID":"++02f420c1-b6cd-4035-ba4e-ccbea454d567","namedInsuredIndicator":false,"drivingLicense":{"stateLicensed":"CO"},"firstName":"perf","lastName":"customer","birthDate":"2000-01-01","gender":"male","maritalStatus":"S","relationship":"Other"}},{"op":"replace","path":"/orderInsuranceScore","value":true}],"partnerId":"PE2"}",
        BODY_END
    );

    ns_end_transaction("QCOAC226334300_2", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__48");
    ns_web_url ("quote_st_1681537629423_ptid__48",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=521396&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__48_url_0_1_1681539359304.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__48", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__49");
    ns_web_url ("quote_st_1681537629423_ptid__49",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=531402&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__49_url_0_1_1681539359332.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__49", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_15");
    ns_web_url ("metadata_15",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16","subTypeOfPolicy":"SS"},"filters":{"properties":["typeOfPolicy","elc","thirdPartyDesignee","residenceType","policyType","policyTerm","salesChannelType","officeType","agencyCd","agencyLocation","agentCd","birthDate","firstName","lastName","maritalStatus","relationship","gender","rideShareIndicator","military","aarpNumber","driverAssignment","defensiveDriverRefresher","nationalOrigin","driverType","reasonExcluded","reasonNAFR","driverRelToApplicantCd","antiTheft","antiLockBrakes","airBags","ownershipTypeCd","vehicleUsageCd","vehIdentificationNo","year","make","model","series","residentialAddressInd","odometerReading","registeredOwner","vehicleClassification","bodyType","type","priorBiLimit","insuredSince","licenseNumber","stateLicensed","licenseStatus","county"],"models":["AutoQuoteInfo","ProducerInfo","AutoDriver","AutoDriverType","AutoVehicle","AutoCarrierInfo","AutoDrivingLicense","AutoContactInfoAddress"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_15", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_22");
    ns_web_url ("quote_22",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=540862&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":7}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":1580},"rxSize":{"t":24},"duration":{"t":73},"cbTime":{"t":0},"time":{"t":480844}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/events/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":145},"rxSize":{"t":24},"duration":{"t":78},"cbTime":{"t":0},"time":{"t":480846}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/resources/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":5,"txSize":{"t":176761,"min":11224,"max":62879,"sos":7951376891,"c":5},"rxSize":{"t":180,"min":36,"max":36,"sos":6480,"c":5},"duration":{"t":478,"min":80,"max":140,"sos":48250,"c":5},"cbTime":{"t":1,"min":0,"max":1,"sos":1,"c":5},"time":{"t":2546938,"min":481369,"max":531403,"sos":1298860828028,"c":5}}},{"params":{"method":"PATCH","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOAC226334300","status":206},"metrics":{"count":1,"txSize":{"t":1406},"rxSize":{"t":23463},"duration":{"t":15755},"cbTime":{"t":0},"time":{"t":518473}}},{"params":{"method":"POST","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata","status":200},"metrics":{"count":1,"txSize":{"t":1021},"rxSize":{"t":13723},"duration":{"t":1304},"cbTime":{"t":0},"time":{"t":534226}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_22", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_23");
    ns_web_url ("quote_23",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=540865&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.7;2,,b421,bta,,,'PATCH,5q,'api-perf.n01.csaa-insurance.aaa.com:443,'/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOAC226334300,132,i3r,,'0,!!!;2,,bg7m,ot,,,'POST,5k,1,'/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata,sd,al7,,3,!!!",
        BODY_END
    );

    ns_end_transaction("quote_23", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__50");
    ns_web_url ("quote_st_1681537629423_ptid__50",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=541421&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__50_url_0_1_1681539359365.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__50", NS_AUTO_STATUS);

    // save and continue


    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__51");
    ns_web_url ("quote_st_1681537629423_ptid__51",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=551437&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"res":[{"n":"readystatechange","s":541423,"e":541423,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":541501,"e":541501,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":541501,"e":541501,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":541502,"e":541502,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"setTimeout","s":541421,"e":541424,"o":"window","t":"timer"},{"n":"setTimeout","s":550802,"e":550803,"o":"window","t":"timer"},{"n":"progress","s":541501,"e":541501,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":541502,"e":541502,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":541502,"e":541502,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":541502,"e":541502,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"Ajax","s":541423,"e":541502,"o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"ajax"},{"n":"xmlhttprequest","s":541423,"e":541500,"o":"https://bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"resource"},{"n":"setInterval","s":541591,"e":541591,"o":"window","t":"timer"},{"n":"setInterval","s":542584,"e":542584,"o":"window","t":"timer"},{"n":"setInterval","s":543586,"e":543586,"o":"window","t":"timer"},{"n":"setInterval","s":544589,"e":544590,"o":"window","t":"timer"},{"n":"setInterval","s":545596,"e":545596,"o":"window","t":"timer"},{"n":"setInterval","s":546586,"e":546586,"o":"window","t":"timer"},{"n":"setInterval","s":547592,"e":547592,"o":"window","t":"timer"},{"n":"setInterval","s":548584,"e":548584,"o":"window","t":"timer"},{"n":"setInterval","s":549587,"e":549587,"o":"window","t":"timer"},{"n":"setInterval","s":550598,"e":550598,"o":"window","t":"timer"},{"n":"pointerover","s":551005,"e":551005,"t":"event","o":"label.MuiFormControlLabel-root.MuiFormControlLabel-labelPlacementEnd.material-form-control-label.css-1lhz32o"},{"n":"pointerover","s":551006,"e":551006,"t":"event","o":"label.MuiFormControlLabel-root.MuiFormControlLabel-labelPlacementEnd.material-form-control-label.css-1lhz32o"},{"n":"pointerover","s":551006,"e":551006,"t":"event","o":"label.MuiFormControlLabel-root.MuiFormControlLabel-labelPlacementEnd.material-form-control-label.css-1lhz32o"},{"n":"pointerover","s":551006,"e":551006,"t":"event","o":"label.MuiFormControlLabel-root.MuiFormControlLabel-labelPlacementEnd.material-form-control-label.css-1lhz32o"},{"n":"mousing","s":551006,"e":551009,"t":"event","o":"label.MuiFormControlLabel-root.MuiFormControlLabel-labelPlacementEnd.material-form-control-label.css-1lhz32o"},{"n":"pointermove","s":551007,"e":551007,"t":"event","o":"label.MuiFormControlLabel-root.MuiFormControlLabel-labelPlacementEnd.material-form-control-label.css-1lhz32o"},{"n":"pointermove","s":551007,"e":551007,"t":"event","o":"label.MuiFormControlLabel-root.MuiFormControlLabel-labelPlacementEnd.material-form-control-label.css-1lhz32o"},{"n":"pointermove","s":551007,"e":551008,"t":"event","o":"label.MuiFormControlLabel-root.MuiFormControlLabel-labelPlacementEnd.material-form-control-label.css-1lhz32o"},{"n":"pointermove","s":551008,"e":551008,"t":"event","o":"label.MuiFormControlLabel-root.MuiFormControlLabel-labelPlacementEnd.material-form-control-label.css-1lhz32o"}]}",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__51", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__52");
    ns_web_url ("quote_st_1681537629423_ptid__52",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=561457&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__52_url_0_1_1681539359395.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__52", NS_AUTO_STATUS);

    // coverages and premium


    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__53");
    ns_web_url ("quote_st_1681537629423_ptid__53",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=571468&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"res":[{"n":"readystatechange","s":561460,"e":561460,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":561554,"e":561555,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":561555,"e":561555,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":561555,"e":561555,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"setTimeout","s":561455,"e":561462,"o":"window","t":"timer"},{"n":"setTimeout","s":562586,"e":562674,"o":"window","t":"timer"},{"n":"setTimeout","s":570884,"e":570884,"o":"window","t":"timer"},{"n":"progress","s":561555,"e":561555,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":561555,"e":561555,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":561555,"e":561555,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":561555,"e":561556,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"Ajax","s":561460,"e":561556,"o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"ajax"},{"n":"xmlhttprequest","s":561461,"e":561553,"o":"https://bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"resource"},{"n":"setInterval","s":561593,"e":561593,"o":"window","t":"timer"},{"n":"setInterval","s":562674,"e":562674,"o":"window","t":"timer"},{"n":"setInterval","s":563598,"e":563598,"o":"window","t":"timer"},{"n":"setInterval","s":564583,"e":564583,"o":"window","t":"timer"},{"n":"setInterval","s":565585,"e":565585,"o":"window","t":"timer"},{"n":"setInterval","s":566592,"e":566592,"o":"window","t":"timer"},{"n":"setInterval","s":567588,"e":567588,"o":"window","t":"timer"},{"n":"setInterval","s":568598,"e":568598,"o":"window","t":"timer"},{"n":"setInterval","s":569587,"e":569587,"o":"window","t":"timer"},{"n":"setInterval","s":570587,"e":570588,"o":"window","t":"timer"},{"n":"pointerover","s":568390,"e":568390,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.MuiGrid-grid-xs-6.MuiGrid-grid-sm-9.css-e3509b"},{"n":"pointerover","s":568390,"e":568390,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.MuiGrid-grid-xs-6.MuiGrid-grid-sm-9.css-e3509b"},{"n":"pointerover","s":568391,"e":568391,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.MuiGrid-grid-xs-6.MuiGrid-grid-sm-9.css-e3509b"},{"n":"pointerover","s":568391,"e":568391,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.MuiGrid-grid-xs-6.MuiGrid-grid-sm-9.css-e3509b"},{"n":"mousing","s":568391,"e":568392,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.MuiGrid-grid-xs-6.MuiGrid-grid-sm-9.css-e3509b"},{"n":"mousing","s":570463,"e":570464,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.MuiGrid-grid-xs-6.MuiGrid-grid-sm-9.css-e3509b"},{"n":"pointermove","s":568392,"e":568392,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.MuiGrid-grid-xs-6.MuiGrid-grid-sm-9.css-e3509b"},{"n":"pointermove","s":568392,"e":568392,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.MuiGrid-grid-xs-6.MuiGrid-grid-sm-9.css-e3509b"},{"n":"pointermove","s":568392,"e":568392,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.MuiGrid-grid-xs-6.MuiGrid-grid-sm-9.css-e3509b"},{"n":"pointermove","s":568392,"e":568392,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.MuiGrid-grid-xs-6.MuiGrid-grid-sm-9.css-e3509b"},{"n":"typing","s":570213,"e":570241,"t":"event","o":"body"},{"n":"pointerout","s":570463,"e":570463,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.MuiGrid-grid-xs-6.MuiGrid-grid-sm-9.css-e3509b"},{"n":"pointerout","s":570463,"e":570463,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.MuiGrid-grid-xs-6.MuiGrid-grid-sm-9.css-e3509b"},{"n":"pointerout","s":570463,"e":570463,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.MuiGrid-grid-xs-6.MuiGrid-grid-sm-9.css-e3509b"},{"n":"pointerout","s":570463,"e":570463,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.MuiGrid-grid-xs-6.MuiGrid-grid-sm-9.css-e3509b"}]}",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__53", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__54");
    ns_web_url ("quote_st_1681537629423_ptid__54",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=591491&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"res":[{"n":"readystatechange","s":571469,"e":571469,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":571597,"e":571598,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":571598,"e":571598,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":571598,"e":571598,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"setTimeout","s":571468,"e":571470,"o":"window","t":"timer"},{"n":"setTimeout","s":580810,"e":580811,"o":"window","t":"timer"},{"n":"setTimeout","s":581478,"e":581480,"o":"window","t":"timer"},{"n":"setInterval","s":571593,"e":571593,"o":"window","t":"timer"},{"n":"setInterval","s":572586,"e":572586,"o":"window","t":"timer"},{"n":"setInterval","s":573589,"e":573589,"o":"window","t":"timer"},{"n":"setInterval","s":574594,"e":574594,"o":"window","t":"timer"},{"n":"setInterval","s":575583,"e":575583,"o":"window","t":"timer"},{"n":"setInterval","s":576592,"e":576592,"o":"window","t":"timer"},{"n":"setInterval","s":577595,"e":577595,"o":"window","t":"timer"},{"n":"setInterval","s":578595,"e":578595,"o":"window","t":"timer"},{"n":"setInterval","s":579597,"e":579597,"o":"window","t":"timer"},{"n":"setInterval","s":580592,"e":580593,"o":"window","t":"timer"},{"n":"setInterval","s":581589,"e":581589,"o":"window","t":"timer"},{"n":"setInterval","s":582594,"e":582595,"o":"window","t":"timer"},{"n":"setInterval","s":583587,"e":583587,"o":"window","t":"timer"},{"n":"setInterval","s":584594,"e":584594,"o":"window","t":"timer"},{"n":"setInterval","s":585596,"e":585596,"o":"window","t":"timer"},{"n":"setInterval","s":586588,"e":586588,"o":"window","t":"timer"},{"n":"setInterval","s":587593,"e":587593,"o":"window","t":"timer"},{"n":"setInterval","s":588592,"e":588593,"o":"window","t":"timer"},{"n":"setInterval","s":589584,"e":589585,"o":"window","t":"timer"},{"n":"setInterval","s":590583,"e":590583,"o":"window","t":"timer"},{"n":"progress","s":571598,"e":571598,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":571598,"e":571598,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":571598,"e":571598,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":571598,"e":571599,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"Ajax","s":571469,"e":571599,"o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"ajax"},{"n":"xmlhttprequest","s":571469,"e":571596,"o":"https://bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"resource"}]}",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__54", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_24");
    ns_web_url ("quote_24",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=600870&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":7}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/events/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":271},"rxSize":{"t":24},"duration":{"t":70},"cbTime":{"t":1},"time":{"t":540865}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":1973},"rxSize":{"t":24},"duration":{"t":130},"cbTime":{"t":0},"time":{"t":540863}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/resources/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":5,"txSize":{"t":140410,"min":2889,"max":93333,"sos":10070465224,"c":5},"rxSize":{"t":180,"min":36,"max":36,"sos":6480,"c":5},"duration":{"t":453,"min":73,"max":130,"sos":43311,"c":5},"cbTime":{"t":0,"min":0,"max":0,"sos":0,"c":5},"time":{"t":2817282,"min":541423,"max":591492,"sos":1588899668398,"c":5}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_24", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__55");
    ns_web_url ("quote_st_1681537629423_ptid__55",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=601501&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"res":[{"n":"readystatechange","s":591492,"e":591492,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":591564,"e":591564,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":591564,"e":591564,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":591565,"e":591565,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":600870,"e":600870,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/jserrors/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":600940,"e":600940,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/jserrors/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":600940,"e":600940,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/jserrors/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":600940,"e":600941,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/jserrors/1/NRJS-caa2993fd9f89f03d7d"},{"n":"setTimeout","s":591491,"e":591493,"o":"window","t":"timer"},{"n":"setTimeout","s":600870,"e":600871,"o":"window","t":"timer"},{"n":"setTimeout","s":600872,"e":600872,"o":"window","t":"timer"},{"n":"setTimeout","s":600885,"e":600885,"o":"window","t":"timer"},{"n":"progress","s":591564,"e":591564,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"progress","s":600940,"e":600940,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/jserrors/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":591565,"e":591565,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":591565,"e":591565,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":591565,"e":591565,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":600941,"e":600941,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/jserrors/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":600941,"e":600941,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/jserrors/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":600941,"e":600941,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/jserrors/1/NRJS-caa2993fd9f89f03d7d"},{"n":"Ajax","s":591492,"e":591565,"o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"ajax"},{"n":"Ajax","s":600870,"e":600941,"o":"200 POST: bam-cell.nr-data.net:443/jserrors/1/NRJS-caa2993fd9f89f03d7d","t":"ajax"},{"n":"xmlhttprequest","s":591492,"e":591562,"o":"https://bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"resource"},{"n":"xmlhttprequest","s":600870,"e":600938,"o":"https://bam-cell.nr-data.net:443/jserrors/1/NRJS-caa2993fd9f89f03d7d","t":"resource"},{"n":"setInterval","s":591584,"e":591584,"o":"window","t":"timer"},{"n":"setInterval","s":592583,"e":592583,"o":"window","t":"timer"},{"n":"setInterval","s":593590,"e":593590,"o":"window","t":"timer"},{"n":"setInterval","s":594597,"e":594597,"o":"window","t":"timer"},{"n":"setInterval","s":595592,"e":595592,"o":"window","t":"timer"},{"n":"setInterval","s":596584,"e":596584,"o":"window","t":"timer"},{"n":"setInterval","s":597587,"e":597587,"o":"window","t":"timer"},{"n":"setInterval","s":598593,"e":598593,"o":"window","t":"timer"},{"n":"setInterval","s":599584,"e":599584,"o":"window","t":"timer"},{"n":"setInterval","s":600592,"e":600592,"o":"window","t":"timer"}]}",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__55", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__56");
    ns_web_url ("quote_st_1681537629423_ptid__56",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=611513&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__56_url_0_1_1681539359448.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__56", NS_AUTO_STATUS);

    // click on agent 





















    


    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__57");
    ns_web_url ("quote_st_1681537629423_ptid__57",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=621525&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__57_url_0_1_1681539359472.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__57", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_16");
    ns_web_url ("metadata_16",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16"},"filters":{"properties":["agentCd"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_16", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_17");
    ns_web_url ("metadata_17",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16"},"filters":{"properties":["subProducerCd"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_17", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_18");
    ns_web_url ("metadata_18",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16"},"filters":{"properties":[],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_18", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_19");
    ns_web_url ("metadata_19",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16"},"filters":{"properties":["agencyCd"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_19", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_20");
    ns_web_url ("metadata_20",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16"},"filters":{"properties":["producerCd"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_20", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_21");
    ns_web_url ("metadata_21",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16"},"filters":{"properties":["salesChannelType"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_21", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_22");
    ns_web_url ("metadata_22",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16"},"filters":{"properties":["agencyLocation"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_22", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__58");
    ns_web_url ("quote_st_1681537629423_ptid__58",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=631541&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__58_url_0_1_1681539359521.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__58", NS_AUTO_STATUS);

    // edit
    // 
    // ==================


    //Page Auto split for Method = POST
    ns_start_transaction("metadata_23");
    ns_web_url ("metadata_23",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16"},"filters":{"properties":[],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_23", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_24");
    ns_web_url ("metadata_24",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16"},"filters":{"properties":["agencyCd"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_24", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_25");
    ns_web_url ("metadata_25",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16"},"filters":{"properties":["salesChannelType"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_25", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_26");
    ns_web_url ("metadata_26",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16"},"filters":{"properties":["agencyLocation"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_26", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_27");
    ns_web_url ("metadata_27",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16"},"filters":{"properties":["agentCd"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_27", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_28");
    ns_web_url ("metadata_28",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16"},"filters":{"properties":[],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_28", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_29");
    ns_web_url ("metadata_29",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16"},"filters":{"properties":["agencyCd"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_29", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_30");
    ns_web_url ("metadata_30",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16"},"filters":{"properties":["salesChannelType"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_30", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_31");
    ns_web_url ("metadata_31",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16"},"filters":{"properties":["agencyLocation"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_31", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_32");
    ns_web_url ("metadata_32",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16"},"filters":{"properties":["agentCd"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_32", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__59");
    ns_web_url ("quote_st_1681537629423_ptid__59",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=641569&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__59_url_0_1_1681539359583.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__59", NS_AUTO_STATUS);

    // channel type


    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__60");
    ns_web_url ("quote_st_1681537629423_ptid__60",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=651609&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__60_url_0_1_1681539359619.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__60", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_33");
    ns_web_url ("metadata_33",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16","officeType":"AZ Club Agent"},"filters":{"properties":["agencyCd"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_33", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_34");
    ns_web_url ("metadata_34",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16","officeType":"AZ Club Agent"},"filters":{"properties":["agencyLocation"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_34", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_35");
    ns_web_url ("metadata_35",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16","officeType":"AZ Club Agent"},"filters":{"properties":["agentCd"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_35", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_25");
    ns_web_url ("quote_25",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=660880&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":7}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":1213},"rxSize":{"t":24},"duration":{"t":71},"cbTime":{"t":0},"time":{"t":600870}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/resources/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":6,"txSize":{"t":289000,"min":3617,"max":111852,"sos":20109302342,"c":6},"rxSize":{"t":216,"min":36,"max":36,"sos":7776,"c":6},"duration":{"t":573,"min":76,"max":145,"sos":58263,"c":6},"cbTime":{"t":0,"min":0,"max":0,"sos":0,"c":6},"time":{"t":3759287,"min":601502,"max":651611,"sos":2357130623111,"c":6}}},{"params":{"method":"POST","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata","status":200},"metrics":{"count":20,"txSize":{"t":3388,"min":154,"max":199,"sos":576826,"c":20},"rxSize":{"t":9205,"min":224,"max":1660,"sos":8448551,"c":20},"duration":{"t":16589,"min":531,"max":2106,"sos":17650031,"c":20},"cbTime":{"t":2,"min":0,"max":1,"sos":2,"c":20},"time":{"t":12662172,"min":621370,"max":653742,"sos":8018819830496,"c":20}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_25", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_26");
    ns_web_url ("quote_26",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=660882&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.7;2,,dbga,ey,,,'POST,5k,'api-perf.n01.csaa-insurance.aaa.com:443,'/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata,4j,6b,,'0,!!!;2,,dbgd,f6,,,0,5k,1,2,4k,68,,3,!!!;2,,dbgb,fp,,,0,5k,1,2,4p,6m,,3,!!!;2,,dbge,gq,,,0,5k,1,2,4m,6h,,3,!!!;2,,dbgf,h8,,,0,5k,1,2,4s,6n,,3,!!!;2,,dbgg,hz,,,0,5k,1,2,4q,6s,,3,!!!;2,,dbgc,mp,,,0,5k,1,2,4a,z7,,3,!!!;2,,dle8,cx,,,0,5k,1,2,4a,z7,,3,!!!;2,,dlec,es,,,0,5k,1,2,4j,6b,,3,!!!;2,,dleb,ik,,,0,5k,1,2,4q,6s,,3,!!!;2,,dle9,nw,,,0,5k,1,2,4k,68,,3,!!!;2,,dlea,1el,,,0,5k,1,2,4s,6n,,3,!!!;2,,dmqu,c8,,,0,5k,1,2,4a,z7,,3,!!!;2,,dmqy,fp,,,0,5k,1,2,4s,6n,,3,!!!;2,,dmr1,ge,,,0,5k,1,2,4j,6b,,3,!!!;2,,dmqw,lm,,,0,5k,1,2,4k,68,,3,!!!;2,,dmqz,n0,,,0,5k,1,2,4q,6s,,3,!!!;2,,e0fg,cj,,,0,5k,1,2,5d,1a4,,3,!!!;2,,e0fh,f7,,,0,5k,1,2,5j,6s,,3,!!!;2,,e0fi,he,,,0,5k,1,2,5c,6b,,3,!!!",
        BODY_END
    );

    ns_end_transaction("quote_26", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("config_json_5");
    ns_web_url ("config_json_5",
        "URL=https://c.go-mpulse.net/api/config.json?key=8GSRP-JVCR4-6J3AN-EWLKW-WZ2FU&d=dash-perf.pas.n01.csaa-insurance.aaa.com&t=5605128&v=1.720.0&if=&sl=1&si=71e7dab5-3521-484e-9b84-4069866ed516-rt56ql&r=&bcn=%2F%2F17de4c0e.akstat.io%2F&acao=&ak.ai=780488",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("config_json_5", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__61");
    ns_web_url ("quote_st_1681537629423_ptid__61",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=661626&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__61_url_0_1_1681539359660.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__61", NS_AUTO_STATUS);

    // agency


    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__62");
    ns_web_url ("quote_st_1681537629423_ptid__62",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=671642&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__62_url_0_1_1681539359678.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__62", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_36");
    ns_web_url ("metadata_36",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16","producerCd":"500001021"},"filters":{"properties":["salesChannelType"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_36", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_37");
    ns_web_url ("metadata_37",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16","officeType":"AZ Club Agent","producerCd":"500001021"},"filters":{"properties":["agencyLocation"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_37", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_38");
    ns_web_url ("metadata_38",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16","officeType":"AZ Club Agent","producerCd":"500001021"},"filters":{"properties":["agentCd"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_38", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__63");
    ns_web_url ("quote_st_1681537629423_ptid__63",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=681660&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__63_url_0_1_1681539359721.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__63", NS_AUTO_STATUS);

    // sales channel


    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__64");
    ns_web_url ("quote_st_1681537629423_ptid__64",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=691665&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__64_url_0_1_1681539359754.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__64", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__65");
    ns_web_url ("quote_st_1681537629423_ptid__65",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=701687&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__65_url_0_1_1681539359780.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__65", NS_AUTO_STATUS);

    // agency location 
    // 
    // ======================


    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__66");
    ns_web_url ("quote_st_1681537629423_ptid__66",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=711702&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__66_url_0_1_1681539359802.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__66", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_39");
    ns_web_url ("metadata_39",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16","officeType":"AZ Club Agent","producerCd":"500001021","agencyLocation":"500005275"},"filters":{"properties":["agentCd"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_39", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_27");
    ns_web_url ("quote_27",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=720883&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":8}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":1488},"rxSize":{"t":24},"duration":{"t":130},"cbTime":{"t":0},"time":{"t":660881}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/events/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":812},"rxSize":{"t":24},"duration":{"t":137},"cbTime":{"t":1},"time":{"t":660882}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/resources/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":6,"txSize":{"t":321669,"min":19118,"max":79891,"sos":19202217973,"c":6},"rxSize":{"t":216,"min":36,"max":36,"sos":7776,"c":6},"duration":{"t":560,"min":77,"max":151,"sos":56394,"c":6},"cbTime":{"t":0,"min":0,"max":0,"sos":0,"c":6},"time":{"t":4119999,"min":661629,"max":711705,"sos":2830820407119,"c":6}}},{"params":{"method":"POST","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata","status":200},"metrics":{"count":4,"txSize":{"t":884,"min":197,"max":246,"sos":196590,"c":4},"rxSize":{"t":14659,"min":371,"max":6432,"sos":84906665,"c":4},"duration":{"t":3291,"min":613,"max":962,"sos":2789029,"c":4},"cbTime":{"t":0,"min":0,"max":0,"sos":0,"c":4},"time":{"t":2735987,"min":672643,"max":718052,"sos":1872952562787,"c":4}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_27", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_28");
    ns_web_url ("quote_28",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=720886&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.7;2,,ef0n,da,,,'POST,5k,'api-perf.n01.csaa-insurance.aaa.com:443,'/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata,61,4yo,,'0,!!!;2,,ef0j,hz,,,0,5k,1,2,5h,ab,,3,!!!;2,,ef0l,og,,,0,5k,1,2,68,13k,,3,!!!;2,,fe1w,md,,,0,5k,1,2,6u,4yo,,3,!!!",
        BODY_END
    );

    ns_end_transaction("quote_28", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__67");
    ns_web_url ("quote_st_1681537629423_ptid__67",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=721723&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__67_url_0_1_1681539359846.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__67", NS_AUTO_STATUS);

    // agent
    // 
    // ===================


    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__68");
    ns_web_url ("quote_st_1681537629423_ptid__68",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=731729&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__68_url_0_1_1681539359878.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__68", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__69");
    ns_web_url ("quote_st_1681537629423_ptid__69",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=741748&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__69_url_0_1_1681539359898.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__69", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__70");
    ns_web_url ("quote_st_1681537629423_ptid__70",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=751755&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__70_url_0_1_1681539359927.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__70", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__71");
    ns_web_url ("quote_st_1681537629423_ptid__71",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=761770&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__71_url_0_1_1681539359955.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__71", NS_AUTO_STATUS);
    ns_page_think_time(6.466);


    // save changes      
    // 
    // 
    // 
    // 
    // ======================

    //Page Auto split for Button 'button' Clicked by User
    ns_start_transaction("QCOSS226334300");
    ns_web_url ("QCOSS226334300",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOSS226334300",
        "METHOD=OPTIONS",
        "HEADER=Access-Control-Request-Method:PATCH",
        "HEADER=Access-Control-Request-Headers:authorization,content-type,x-api-key",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("QCOSS226334300", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("QCOSS226334300_2");
    ns_web_url ("QCOSS226334300_2",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOSS226334300",
        "METHOD=PATCH",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"patch":[{"op":"replace","path":"/producerInfo/agencyLocation","value":"500005275"},{"op":"replace","path":"/producerInfo/agentCd","value":"500005463"},{"op":"replace","path":"/producerInfo/salesChannelType","value":"2506"},{"op":"replace","path":"/producerInfo/agencyCd","value":"500001021"},{"op":"replace","path":"/producerInfo/officeType","value":"AZ Club Agent"}],"partnerId":"PE2"}",
        BODY_END
    );

    ns_end_transaction("QCOSS226334300_2", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_40");
    ns_web_url ("metadata_40",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16","officeType":"AZ Club Agent","producerCd":"500001021","agencyLocation":"500005275"},"filters":{"properties":["agentCd"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_40", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_41");
    ns_web_url ("metadata_41",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16","agentCd":"500005463"},"filters":{"properties":["subProducerCd"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_41", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_42");
    ns_web_url ("metadata_42",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16"},"filters":{"properties":[],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_42", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_43");
    ns_web_url ("metadata_43",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16","officeType":"AZ Club Agent"},"filters":{"properties":["agencyCd"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_43", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_44");
    ns_web_url ("metadata_44",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16","officeType":"AZ Club Agent","agencyCd":"500001021"},"filters":{"properties":["producerCd"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_44", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_45");
    ns_web_url ("metadata_45",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16","producerCd":"500001021"},"filters":{"properties":["salesChannelType"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_45", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_46");
    ns_web_url ("metadata_46",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16","officeType":"AZ Club Agent","producerCd":"500001021"},"filters":{"properties":["agencyLocation"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_46", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__72");
    ns_web_url ("quote_st_1681537629423_ptid__72",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=771774&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__72_url_0_1_1681539359995.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__72", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_29");
    ns_web_url ("quote_29",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=780886&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":8}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":1787},"rxSize":{"t":24},"duration":{"t":69},"cbTime":{"t":0},"time":{"t":720884}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/events/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":253},"rxSize":{"t":24},"duration":{"t":74},"cbTime":{"t":0},"time":{"t":720886}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/resources/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":6,"txSize":{"t":313884,"min":21721,"max":80209,"sos":19940787998,"c":6},"rxSize":{"t":216,"min":36,"max":36,"sos":7776,"c":6},"duration":{"t":590,"min":72,"max":141,"sos":63096,"c":6},"cbTime":{"t":0,"min":0,"max":0,"sos":0,"c":6},"time":{"t":4480516,"min":721726,"max":771778,"sos":3347591173270,"c":6}}},{"params":{"method":"POST","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata","status":200},"metrics":{"count":7,"txSize":{"t":1423,"min":154,"max":246,"sos":294471,"c":7},"rxSize":{"t":11625,"min":233,"max":6432,"sos":48007863,"c":7},"duration":{"t":5155,"min":550,"max":1009,"sos":3954477,"c":7},"cbTime":{"t":0,"min":0,"max":0,"sos":0,"c":7},"time":{"t":5378087,"min":768294,"max":768301,"sos":4131974254267,"c":7}}},{"params":{"method":"PATCH","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOSS226334300","status":206},"metrics":{"count":1,"txSize":{"t":388},"rxSize":{"t":21509},"duration":{"t":9340},"cbTime":{"t":0},"time":{"t":768302}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_29", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_30");
    ns_web_url ("quote_30",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=780892&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.7;2,,ggtp,f1,,,'POST,5k,'api-perf.n01.csaa-insurance.aaa.com:443,'/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata,5h,ab,,'0,!!!;2,,ggti,h4,,,0,5k,1,2,6u,4yo,,3,!!!;2,,ggto,hp,,,0,5k,1,2,62,6h,,3,!!!;2,,ggtm,il,,,0,5k,1,2,5d,1a4,,3,!!!;2,,ggtk,ku,,,0,5k,1,2,5b,6m,,3,!!!;2,,ggtp,og,,,0,5k,1,2,68,13k,,3,!!!;2,,ggtl,rq,,,0,5k,1,2,4a,z7,,3,!!!;2,,ggtq,6x7,,,'PATCH,5q,1,'/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOSS226334300,as,glh,,3,!!!",
        BODY_END
    );

    ns_end_transaction("quote_30", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_47");
    ns_web_url ("metadata_47",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16","producerCd":"500001021","subProducerCd":"500005463","agentCd":"500005463"},"filters":{"properties":["subProducerCd"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_47", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_48");
    ns_web_url ("metadata_48",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16","officeType":"AZ Club Agent","producerCd":"500001021","agencyCd":"500001021"},"filters":{"properties":["producerCd"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_48", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__73");
    ns_web_url ("quote_st_1681537629423_ptid__73",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=781783&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__73_url_0_1_1681539360040.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__73", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__74");
    ns_web_url ("quote_st_1681537629423_ptid__74",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=791798&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__74_url_0_1_1681539360067.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__74", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__75");
    ns_web_url ("quote_st_1681537629423_ptid__75",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=801812&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__75_url_0_1_1681539360083.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__75", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__76");
    ns_web_url ("quote_st_1681537629423_ptid__76",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=811831&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__76_url_0_1_1681539360109.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__76", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__77");
    ns_web_url ("quote_st_1681537629423_ptid__77",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=821843&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"res":[{"n":"readystatechange","s":811834,"e":811834,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":811974,"e":811974,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":811974,"e":811974,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"readystatechange","s":811974,"e":811975,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"setTimeout","s":811830,"e":811836,"o":"window","t":"timer"},{"n":"setTimeout","s":820881,"e":820881,"o":"window","t":"timer"},{"n":"pointerout","s":811837,"e":811837,"t":"event","o":"div.MuiGrid-root.MuiGrid-container.MuiGrid-item.MuiGrid-direction-xs-column.MuiGrid-grid-xs-12.MuiGrid-grid-md-6.css-16a6gg6"},{"n":"pointerout","s":811837,"e":811837,"t":"event","o":"div.MuiGrid-root.MuiGrid-container.MuiGrid-item.MuiGrid-direction-xs-column.MuiGrid-grid-xs-12.MuiGrid-grid-md-6.css-16a6gg6"},{"n":"pointerout","s":811837,"e":811837,"t":"event","o":"div.MuiGrid-root.MuiGrid-container.MuiGrid-item.MuiGrid-direction-xs-column.MuiGrid-grid-xs-12.MuiGrid-grid-md-6.css-16a6gg6"},{"n":"pointerout","s":811837,"e":811837,"t":"event","o":"div.MuiGrid-root.MuiGrid-container.MuiGrid-item.MuiGrid-direction-xs-column.MuiGrid-grid-xs-12.MuiGrid-grid-md-6.css-16a6gg6"},{"n":"pointerout","s":811859,"e":811859,"t":"event","o":"p.MuiTypography-root.MuiTypography-body1.toolbar-h4-title-bold.css-113rmp3"},{"n":"pointerout","s":811859,"e":811859,"t":"event","o":"p.MuiTypography-root.MuiTypography-body1.toolbar-h4-title-bold.css-113rmp3"},{"n":"pointerout","s":811859,"e":811859,"t":"event","o":"p.MuiTypography-root.MuiTypography-body1.toolbar-h4-title-bold.css-113rmp3"},{"n":"pointerout","s":811859,"e":811859,"t":"event","o":"p.MuiTypography-root.MuiTypography-body1.toolbar-h4-title-bold.css-113rmp3"},{"n":"pointerout","s":811890,"e":811890,"t":"event","o":"div.MuiGrid-root.css-8gbp3c"},{"n":"pointerout","s":811890,"e":811890,"t":"event","o":"div.MuiGrid-root.css-8gbp3c"},{"n":"pointerout","s":811890,"e":811890,"t":"event","o":"div.MuiGrid-root.css-8gbp3c"},{"n":"pointerout","s":811890,"e":811890,"t":"event","o":"div.MuiGrid-root.css-8gbp3c"},{"n":"pointerout","s":812086,"e":812086,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointerout","s":812086,"e":812086,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointerout","s":812086,"e":812087,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointerout","s":812087,"e":812087,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointerover","s":811838,"e":811838,"t":"event","o":"p.MuiTypography-root.MuiTypography-body1.toolbar-h4-title-bold.css-113rmp3"},{"n":"pointerover","s":811838,"e":811838,"t":"event","o":"p.MuiTypography-root.MuiTypography-body1.toolbar-h4-title-bold.css-113rmp3"},{"n":"pointerover","s":811838,"e":811838,"t":"event","o":"p.MuiTypography-root.MuiTypography-body1.toolbar-h4-title-bold.css-113rmp3"},{"n":"pointerover","s":811838,"e":811838,"t":"event","o":"p.MuiTypography-root.MuiTypography-body1.toolbar-h4-title-bold.css-113rmp3"},{"n":"pointerover","s":811859,"e":811859,"t":"event","o":"div.MuiGrid-root.css-8gbp3c"},{"n":"pointerover","s":811860,"e":811860,"t":"event","o":"div.MuiGrid-root.css-8gbp3c"},{"n":"pointerover","s":811860,"e":811860,"t":"event","o":"div.MuiGrid-root.css-8gbp3c"},{"n":"pointerover","s":811860,"e":811860,"t":"event","o":"div.MuiGrid-root.css-8gbp3c"},{"n":"pointerover","s":811890,"e":811890,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointerover","s":811890,"e":811890,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointerover","s":811890,"e":811890,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointerover","s":811890,"e":811890,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"mousing","s":811838,"e":811838,"t":"event","o":"div.MuiGrid-root.MuiGrid-container.MuiGrid-item.MuiGrid-direction-xs-column.MuiGrid-grid-xs-12.MuiGrid-grid-md-6.css-16a6gg6"},{"n":"mousing","s":811838,"e":811860,"t":"event","o":"p.MuiTypography-root.MuiTypography-body1.toolbar-h4-title-bold.css-113rmp3"},{"n":"mousing","s":811860,"e":811891,"t":"event","o":"div.MuiGrid-root.css-8gbp3c"},{"n":"mousing","s":811891,"e":812087,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointermove","s":811838,"e":811838,"t":"event","o":"p.MuiTypography-root.MuiTypography-body1.toolbar-h4-title-bold.css-113rmp3"},{"n":"pointermove","s":811838,"e":811838,"t":"event","o":"p.MuiTypography-root.MuiTypography-body1.toolbar-h4-title-bold.css-113rmp3"},{"n":"pointermove","s":811838,"e":811838,"t":"event","o":"p.MuiTypography-root.MuiTypography-body1.toolbar-h4-title-bold.css-113rmp3"},{"n":"pointermove","s":811838,"e":811839,"t":"event","o":"p.MuiTypography-root.MuiTypography-body1.toolbar-h4-title-bold.css-113rmp3"},{"n":"pointermove","s":811860,"e":811860,"t":"event","o":"div.MuiGrid-root.css-8gbp3c"},{"n":"pointermove","s":811860,"e":811860,"t":"event","o":"div.MuiGrid-root.css-8gbp3c"},{"n":"pointermove","s":811860,"e":811860,"t":"event","o":"div.MuiGrid-root.css-8gbp3c"},{"n":"pointermove","s":811860,"e":811860,"t":"event","o":"div.MuiGrid-root.css-8gbp3c"},{"n":"pointermove","s":811891,"e":811891,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointermove","s":811891,"e":811891,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointermove","s":811891,"e":811891,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointermove","s":811891,"e":811891,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointermove","s":811921,"e":811921,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointermove","s":811921,"e":811921,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointermove","s":811921,"e":811921,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointermove","s":811921,"e":811921,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointermove","s":811952,"e":811952,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointermove","s":811952,"e":811952,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointermove","s":811952,"e":811952,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointermove","s":811952,"e":811952,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointermove","s":811985,"e":811985,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointermove","s":811985,"e":811985,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointermove","s":811985,"e":811985,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointermove","s":811985,"e":811985,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointermove","s":812085,"e":812085,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointermove","s":812085,"e":812085,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointermove","s":812085,"e":812085,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"pointermove","s":812085,"e":812085,"t":"event","o":"div.MuiGrid-root.MuiGrid-item.css-1wxaqej"},{"n":"progress","s":811974,"e":811974,"t":"event","o":"undefined POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":811975,"e":811975,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":811975,"e":811975,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"load","s":811975,"e":811975,"t":"event","o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d"},{"n":"Ajax","s":811834,"e":811975,"o":"200 POST: bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"ajax"},{"n":"xmlhttprequest","s":811835,"e":811972,"o":"https://bam-cell.nr-data.net:443/resources/1/NRJS-caa2993fd9f89f03d7d","t":"resource"},{"n":"setInterval","s":812583,"e":812583,"o":"window","t":"timer"},{"n":"setInterval","s":813583,"e":813584,"o":"window","t":"timer"},{"n":"setInterval","s":814588,"e":814588,"o":"window","t":"timer"},{"n":"setInterval","s":815592,"e":815592,"o":"window","t":"timer"},{"n":"setInterval","s":816595,"e":816595,"o":"window","t":"timer"},{"n":"setInterval","s":817593,"e":817593,"o":"window","t":"timer"},{"n":"setInterval","s":818588,"e":818588,"o":"window","t":"timer"},{"n":"setInterval","s":819593,"e":819593,"o":"window","t":"timer"},{"n":"setInterval","s":820595,"e":820595,"o":"window","t":"timer"},{"n":"setInterval","s":821593,"e":821593,"o":"window","t":"timer"},{"n":"focusout","s":813372,"e":813373,"t":"event","o":"button.MuiButtonBase-root.MuiIconButton-root.MuiIconButton-sizeLarge.current-user-avatar.css-1w8s6so"},{"n":"focusout","s":813373,"e":813373,"t":"event","o":"button.MuiButtonBase-root.MuiIconButton-root.MuiIconButton-sizeLarge.current-user-avatar.css-1w8s6so"},{"n":"focusout","s":813373,"e":813412,"t":"event","o":"button.MuiButtonBase-root.MuiIconButton-root.MuiIconButton-sizeLarge.current-user-avatar.css-1w8s6so"},{"n":"focusout","s":813412,"e":813412,"t":"event","o":"button.MuiButtonBase-root.MuiIconButton-root.MuiIconButton-sizeLarge.current-user-avatar.css-1w8s6so"}]}",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__77", NS_AUTO_STATUS);

    // click on modify
    // 
    // 
    // ===========


    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__78");
    ns_web_url ("quote_st_1681537629423_ptid__78",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=831857&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__78_url_0_1_1681539360136.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__78", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_31");
    ns_web_url ("quote_31",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=840897&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":8}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/events/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":482},"rxSize":{"t":24},"duration":{"t":134},"cbTime":{"t":1},"time":{"t":780892}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":2177},"rxSize":{"t":24},"duration":{"t":140},"cbTime":{"t":0},"time":{"t":780887}}},{"params":{"method":"POST","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata","status":200},"metrics":{"count":2,"txSize":{"t":487,"min":243,"max":244,"sos":118585,"c":2},"rxSize":{"t":9759,"min":269,"max":9490,"sos":90132461,"c":2},"duration":{"t":1270,"min":587,"max":683,"sos":811058,"c":2},"cbTime":{"t":0,"min":0,"max":0,"sos":0,"c":2},"time":{"t":1561011,"min":780505,"max":780506,"sos":1218377671061,"c":2}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/resources/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":6,"txSize":{"t":216064,"min":9535,"max":68638,"sos":11045602130,"c":6},"rxSize":{"t":216,"min":36,"max":36,"sos":7776,"c":6},"duration":{"t":545,"min":71,"max":141,"sos":52789,"c":6},"cbTime":{"t":0,"min":0,"max":0,"sos":0,"c":6},"time":{"t":4840937,"min":781786,"max":831859,"sos":3907533700195,"c":6}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_31", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_32");
    ns_web_url ("quote_32",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=840899&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.7;2,,gq8q,g3,,,'POST,5k,'api-perf.n01.csaa-insurance.aaa.com:443,'/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata,6r,7h,,'0,!!!;2,,gq8p,ir,,,0,5k,1,2,6s,7bm,,3,!!!",
        BODY_END
    );

    ns_end_transaction("quote_32", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__79");
    ns_web_url ("quote_st_1681537629423_ptid__79",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=841864&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__79_url_0_1_1681539360172.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__79", NS_AUTO_STATUS);

    // Entered Bi limits


    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__80");
    ns_web_url ("quote_st_1681537629423_ptid__80",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=851871&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__80_url_0_1_1681539360209.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__80", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__81");
    ns_web_url ("quote_st_1681537629423_ptid__81",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=861886&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__81_url_0_1_1681539360242.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__81", NS_AUTO_STATUS);

    // save and return


    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__82");
    ns_web_url ("quote_st_1681537629423_ptid__82",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=871905&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__82_url_0_1_1681539360281.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__82", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("QCOSS226334300_3");
    ns_web_url ("QCOSS226334300_3",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOSS226334300",
        "METHOD=PATCH",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"patch":[],"coveragePatch":[{"op":"replace","path":"/policyCoverages/1/coverageLimit","value":"100000"}],"partnerId":"PE2"}",
        BODY_END
    );

    ns_end_transaction("QCOSS226334300_3", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_st_1681537629423_ptid__83");
    ns_web_url ("quote_st_1681537629423_ptid__83",
        "URL=https://bam-cell.nr-data.net/resources/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=881917&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote&st=1681537629423&ptid=be2199fa-0001-b9f4-bb9c-018783740092",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "$CAVINCLUDE$=http_request_body/quote_st_1681537629423_ptid__83_url_0_1_1681539360320.body",
        BODY_END
    );

    ns_end_transaction("quote_st_1681537629423_ptid__83", NS_AUTO_STATUS);

    // property damage liability
    // 
    // 
    // 
    // 
    // ===================


    //Page Auto split for Method = POST
    ns_start_transaction("quote_33");
    ns_web_url ("quote_33",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=900899&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":7}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":1784},"rxSize":{"t":24},"duration":{"t":77},"cbTime":{"t":0},"time":{"t":840898}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/events/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":181},"rxSize":{"t":24},"duration":{"t":77},"cbTime":{"t":0},"time":{"t":840900}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/resources/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":5,"txSize":{"t":349934,"min":37284,"max":93609,"sos":26216119332,"c":5},"rxSize":{"t":180,"min":36,"max":36,"sos":6480,"c":5},"duration":{"t":510,"min":82,"max":145,"sos":54526,"c":5},"cbTime":{"t":2,"min":0,"max":1,"sos":2,"c":5},"time":{"t":4309461,"min":841867,"max":881920,"sos":3715293624093,"c":5}}},{"params":{"method":"PATCH","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOSS226334300","status":202},"metrics":{"count":1,"txSize":{"t":200},"rxSize":{"t":24483},"duration":{"t":9877},"cbTime":{"t":0},"time":{"t":865619}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_33", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_34");
    ns_web_url ("quote_34",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=900901&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.7;2,,ijwz,5ht,,,'PATCH,5m,'api-perf.n01.csaa-insurance.aaa.com:443,'/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOSS226334300,5k,iw3,,'0,!!!",
        BODY_END
    );

    ns_end_transaction("quote_34", NS_AUTO_STATUS);

    // update quote
    // 
    // 
    // ==========================


    //Page Auto split for application/json type
    ns_start_transaction("QCOSS226334300_4");
    ns_web_url ("QCOSS226334300_4",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOSS226334300",
        "METHOD=PATCH",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"patch":[{"op":"add","path":"/consents/1","value":{"consentType":"reportsDisclosure","consentGranted":true,"ipAddress":"Dash","consentGrantedBy":"Processed by Agent","consentTimeStamp":"2023-04-14T22:47:09-07:00"}},{"op":"add","path":"/drivers/1/drivingLicense/licenseNumber","value":"963852014"},{"op":"add","path":"/drivers/1/emailUBIDriver","value":"test@gmail.com"},{"op":"add","path":"/drivers/0/drivingLicense/licenseNumber","value":"741085296"},{"op":"add","path":"/drivers/0/emailUBIDriver","value":"test.user@gmail.com"}],"flags":["orderDriverReports"],"partnerId":"PE2"}",
        BODY_END
    );

    ns_end_transaction("QCOSS226334300_4", NS_AUTO_STATUS);

    // view sidef by side


    //Page Auto split for Method = POST
    ns_start_transaction("quote_35");
    ns_web_url ("quote_35",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=960907&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":2}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":1603},"rxSize":{"t":24},"duration":{"t":135},"cbTime":{"t":0},"time":{"t":900900}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/events/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":169},"rxSize":{"t":24},"duration":{"t":135},"cbTime":{"t":0},"time":{"t":900901}}},{"params":{"method":"PATCH","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOSS226334300","status":202},"metrics":{"count":1,"txSize":{"t":124},"rxSize":{"t":24482},"duration":{"t":12763},"cbTime":{"t":1},"time":{"t":931527}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_35", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_36");
    ns_web_url ("quote_36",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=960909&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.7;2,,jyrr,7r1,,,'PATCH,5m,'api-perf.n01.csaa-insurance.aaa.com:443,'/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOSS226334300,3g,iw2,,'0,!!!",
        BODY_END
    );

    ns_end_transaction("quote_36", NS_AUTO_STATUS);

    // save & return


    //Page Auto split for application/json type
    ns_start_transaction("config_json_6");
    ns_web_url ("config_json_6",
        "URL=https://c.go-mpulse.net/api/config.json?key=8GSRP-JVCR4-6J3AN-EWLKW-WZ2FU&d=dash-perf.pas.n01.csaa-insurance.aaa.com&t=5605129&v=1.720.0&if=&sl=1&si=71e7dab5-3521-484e-9b84-4069866ed516-rt56ql&r=&bcn=%2F%2F17de4c0e.akstat.io%2F&acao=&ak.ai=780488",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("config_json_6", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_37");
    ns_web_url ("quote_37",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=1020922&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":2}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/events/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":169},"rxSize":{"t":24},"duration":{"t":73},"cbTime":{"t":0},"time":{"t":960909}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":1089},"rxSize":{"t":24},"duration":{"t":78},"cbTime":{"t":1},"time":{"t":960908}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_37", NS_AUTO_STATUS);

    // save and continue


    //Page Auto split for Method = POST
    ns_start_transaction("quote_38");
    ns_web_url ("quote_38",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=1080933&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":1}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":696},"rxSize":{"t":24},"duration":{"t":73},"cbTime":{"t":1},"time":{"t":1020923}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_38", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_39");
    ns_web_url ("quote_39",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=1140938&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":1}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":390},"rxSize":{"t":24},"duration":{"t":132},"cbTime":{"t":0},"time":{"t":1080934}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_39", NS_AUTO_STATUS);

    // yesthe consumer wishes to proceed


    //Page Auto split for Method = POST
    ns_start_transaction("quote_40");
    ns_web_url ("quote_40",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=1200946&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":1}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":391},"rxSize":{"t":24},"duration":{"t":69},"cbTime":{"t":0},"time":{"t":1140939}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_40", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_41");
    ns_web_url ("quote_41",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=1260950&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":1}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":390},"rxSize":{"t":24},"duration":{"t":71},"cbTime":{"t":0},"time":{"t":1200947}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_41", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_42");
    ns_web_url ("quote_42",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=1320967&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":1}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":390},"rxSize":{"t":24},"duration":{"t":130},"cbTime":{"t":0},"time":{"t":1260950}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_42", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("config_json_7");
    ns_web_url ("config_json_7",
        "URL=https://c.go-mpulse.net/api/config.json?key=8GSRP-JVCR4-6J3AN-EWLKW-WZ2FU&d=dash-perf.pas.n01.csaa-insurance.aaa.com&t=5605130&v=1.720.0&if=&sl=1&si=71e7dab5-3521-484e-9b84-4069866ed516-rt56ql&r=&bcn=%2F%2F17de4c0e.akstat.io%2F&acao=&ak.ai=780488",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("config_json_7", NS_AUTO_STATUS);

    // save and continue


    //Page Auto split for Method = POST
    ns_start_transaction("quote_43");
    ns_web_url ("quote_43",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=1380974&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":1}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":391},"rxSize":{"t":24},"duration":{"t":79},"cbTime":{"t":0},"time":{"t":1320968}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_43", NS_AUTO_STATUS);

    // confirm andd continue


    //Page Auto split for application/json type
    ns_start_transaction("QCOSS226334300_5");
    ns_web_url ("QCOSS226334300_5",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOSS226334300",
        "METHOD=PATCH",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"patch":[{"op":"replace","path":"/proofConfirmation/priorInsuranceProof","value":true}],"partnerId":"PE2"}",
        BODY_END
    );

    ns_end_transaction("QCOSS226334300_5", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_49");
    ns_web_url ("metadata_49",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16"},"filters":{"properties":["thirdPartyDesignee"],"models":["AutoQuoteInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_49", NS_AUTO_STATUS);

    // required to bind : yes


    //Page Auto split for Method = POST
    ns_start_transaction("quote_44");
    ns_web_url ("quote_44",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=1440984&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":1}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":390},"rxSize":{"t":24},"duration":{"t":134},"cbTime":{"t":1},"time":{"t":1380977}}},{"params":{"method":"PATCH","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOSS226334300","status":202},"metrics":{"count":1,"txSize":{"t":581},"rxSize":{"t":24883},"duration":{"t":13713},"cbTime":{"t":0},"time":{"t":1383122}}},{"params":{"method":"POST","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata","status":200},"metrics":{"count":1,"txSize":{"t":175},"rxSize":{"t":296},"duration":{"t":549},"cbTime":{"t":0},"time":{"t":1396833}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_44", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_45");
    ns_web_url ("quote_45",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=1440988&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.7;2,,tn82,abo,,,'PATCH,5m,'api-perf.n01.csaa-insurance.aaa.com:443,'/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOSS226334300,g5,j77,,'0,!!!;2,,txsx,f3,,,'POST,5k,1,'/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata,4v,88,,3,!!!",
        BODY_END
    );

    ns_end_transaction("quote_45", NS_AUTO_STATUS);

    // update quote


    //Page Auto split for application/json type
    ns_start_transaction("QCOSS226334300_6");
    ns_web_url ("QCOSS226334300_6",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOSS226334300",
        "METHOD=PATCH",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"patch":[{"op":"add","path":"/contactInfo/phoneNumber","value":"7410852963"}],"flags":["generatePrebindDocuments"],"partnerId":"PE2"}",
        BODY_END
    );

    ns_end_transaction("QCOSS226334300_6", NS_AUTO_STATUS);

    // issue auto policy


    //Page Auto split for Method = POST
    ns_start_transaction("quote_46");
    ns_web_url ("quote_46",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=1501000&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":2}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":1149},"rxSize":{"t":24},"duration":{"t":72},"cbTime":{"t":0},"time":{"t":1440985}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/events/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":269},"rxSize":{"t":24},"duration":{"t":139},"cbTime":{"t":1},"time":{"t":1440989}}},{"params":{"method":"PATCH","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOSS226334300","status":202},"metrics":{"count":1,"txSize":{"t":107},"rxSize":{"t":24797},"duration":{"t":8625},"cbTime":{"t":0},"time":{"t":1449229}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_46", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_47");
    ns_web_url ("quote_47",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=1501002&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.7;2,,v28d,6jv,,,'PATCH,5m,'api-perf.n01.csaa-insurance.aaa.com:443,'/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOSS226334300,2z,j4t,,'0,!!!",
        BODY_END
    );

    ns_end_transaction("quote_47", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("QCOSS226334300_7");
    ns_web_url ("QCOSS226334300_7",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOSS226334300",
        "METHOD=PATCH",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"patch":[{"op":"add","path":"/contactInfo/email","value":"test.user@gmail.com"},{"op":"replace","path":"/paymentPlanSelected","value":"payInFull"}],"partnerId":"PE2"}",
        BODY_END
    );

    ns_end_transaction("QCOSS226334300_7", NS_AUTO_STATUS);

    // electronically signed


    // mail id 


    // pay in full
    // 
    // 
    // 
    // ==========================================


    //Page Auto split for Method = POST
    ns_start_transaction("quote_48");
    ns_web_url ("quote_48",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=1561007&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":2}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/events/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":169},"rxSize":{"t":24},"duration":{"t":73},"cbTime":{"t":0},"time":{"t":1501002}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":1090},"rxSize":{"t":24},"duration":{"t":83},"cbTime":{"t":0},"time":{"t":1501001}}},{"params":{"method":"PATCH","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOSS226334300","status":202},"metrics":{"count":1,"txSize":{"t":134},"rxSize":{"t":25065},"duration":{"t":8542},"cbTime":{"t":0},"time":{"t":1498392}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_48", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_49");
    ns_web_url ("quote_49",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=1561009&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.7;2,,w460,6bk,,,'PATCH,5m,'api-perf.n01.csaa-insurance.aaa.com:443,'/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOSS226334300,3q,jc9,,'0,!!!",
        BODY_END
    );

    ns_end_transaction("quote_49", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("QCOSS226334300_8");
    ns_web_url ("QCOSS226334300_8",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOSS226334300",
        "METHOD=PATCH",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"patch":[{"op":"add","path":"/consents/2","value":{"consentType":"salesAgentAgreement","consentGranted":true,"ipAddress":"Dash","consentGrantedBy":"Processed by Agent","consentTimeStamp":"2023-04-14T22:47:09-07:00"}}],"partnerId":"PE2"}",
        BODY_END
    );

    ns_end_transaction("QCOSS226334300_8", NS_AUTO_STATUS);
    ns_page_think_time(27.605);


    // add payment method
    // 
    // 
    // ========================

    //Page Auto split for 
    ns_start_transaction("autocomplete_17");
    ns_web_url ("autocomplete_17",
        "URL=https://api-qa.n01.csaa-insurance.aaa.com/address-v1/validate/autocomplete?ff=381+Bent+Ave%2C+Akron%2C+CO+80720-1433&maxrecords=10&country=US",
        "METHOD=OPTIONS",
        "HEADER=Access-Control-Request-Method:GET",
        "HEADER=Access-Control-Request-Headers:authorization,x-api-key",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("autocomplete_17", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("autocomplete_18");
    ns_web_url ("autocomplete_18",
        "URL=https://api-qa.n01.csaa-insurance.aaa.com/address-v1/validate/autocomplete?ff=381+Bent+Ave%2C+Akron%2C+CO+80720-1433&maxrecords=10&country=US",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("autocomplete_18", NS_AUTO_STATUS);

    // card number


    // exp date


    //Page Auto split for Method = POST
    ns_start_transaction("quote_50");
    ns_web_url ("quote_50",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=1621010&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":2}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/events/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":169},"rxSize":{"t":24},"duration":{"t":131},"cbTime":{"t":0},"time":{"t":1561009}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":1089},"rxSize":{"t":24},"duration":{"t":137},"cbTime":{"t":0},"time":{"t":1561008}}},{"params":{"method":"PATCH","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOSS226334300","status":202},"metrics":{"count":1,"txSize":{"t":167},"rxSize":{"t":24787},"duration":{"t":6560},"cbTime":{"t":0},"time":{"t":1556260}}},{"params":{"method":"GET","hostname":"api-qa.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-qa.n01.csaa-insurance.aaa.com:443","pathname":"/address-v1/validate/autocomplete","status":200},"metrics":{"count":1,"rxSize":{"t":1342},"duration":{"t":1995},"cbTime":{"t":0},"time":{"t":1590267}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_50", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_51");
    ns_web_url ("quote_51",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=1621011&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.7;2,,xctg,4yf,,,'PATCH,5m,'api-perf.n01.csaa-insurance.aaa.com:443,'/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOSS226334300,4n,j4j,,'0,!!!;2,,y323,1j7,,,'GET,5k,'api-qa.n01.csaa-insurance.aaa.com:443,'/address-v1/validate/autocomplete,,11a,,3,!!!",
        BODY_END
    );

    ns_end_transaction("quote_51", NS_AUTO_STATUS);
    ns_page_think_time(25.49);


    // save card details

    //Page Auto split for Button '' Clicked by User
    ns_start_transaction("dash");
    ns_web_url ("dash",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session/serviceAccountAccessToken/dash",
        "METHOD=OPTIONS",
        "HEADER=Access-Control-Request-Method:GET",
        "HEADER=Access-Control-Request-Headers:authorization,x-api-key",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("dash", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("dash_2");
    ns_web_url ("dash_2",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session/serviceAccountAccessToken/dash",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        INLINE_URLS,
            "URL=https://wiremock-apphub.apps.d1.ent.rt.csaa.com/csaa/v1/paymentaccount/record", "METHOD=OPTIONS", "HEADER=Access-Control-Request-Method:POST", "HEADER=Access-Control-Request-Headers:authorization,content-type", "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com", "HEADER=Sec-Fetch-Mode:cors", "HEADER=Sec-Fetch-Site:cross-site", "HEADER=Sec-Fetch-Dest:empty", "HEADER=Accept-Language:en-US,en;q=0.9", END_INLINE
    );

    ns_end_transaction("dash_2", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("record");
    ns_web_url ("record",
        "URL=https://wiremock-apphub.apps.d1.ent.rt.csaa.com/csaa/v1/paymentaccount/record",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULlhGd2pQMnQxRFRoVTZOS3dNRU1jellQT1Ffai1SU0lKMFdYTENEWDlocXciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1MzkyNzYsImV4cCI6MTY4MTUzOTU3NiwiY2lkIjoiMG9hMThyZHp6eW9xb1A5dTMwaDgiLCJzY3AiOlsiZGVmYXVsdCIsImJlYXJlcl90b2tlbiIsIm13Z2tjIl0sInN1YiI6IjBvYTE4cmR6enlvcW9QOXUzMGg4IiwibXdna2Nfcm9sZSI6IkdycFNTT19NV0dLZXlDbG9hayIsImNsaWVudF9pZCI6IjBvYTE4cmR6enlvcW9QOXUzMGg4In0.DNmO7ah3i55OKJdWI-C1s_doc8iE7XWIIdIy_TMq2gafLEaEUc5b0ceUOj7z1TvQKd8mF8-anyZQpcp6JZI8JaYJSepnnOdKku0C71jgxUGjDab_ncfeF5bjTn-PZCygbUVMVTKMRhnoCTrn_xL8bqcHBOCqABh-dhimo6Q4K8VQT01HKqdKmnd2ExGJeVWsGqysiOIkKSYuJyF64qXHuo5SX3r_sRfmOOp78MHWijIZXQq9OSEzQ6Pw_kA4bh5_mTvvd_49uPqjIwJPa2dW02iuRFHBC5RNS1nekQLygGdE-Ra0gPgFd9q4vUrVCqbwvfHSevws9RHbiFP8jkldLw",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"paymentSourceSystem":"PAS","paymentAcctFopType":"CRDC","paymentCardAddrLine1":"381 Bent Ave","paymentCardCity":"Akron","paymentCardState":"CO","paymentCardZip":"80720-1433","correlationId":"83a34a3d-87a7-459a-a8ad-9d8d912d1b8c","paymentCardNumber":"4111111111111111","paymentCardHolderName":"Perf Test","paymentCardExpirationDate":"2025-12-01"}",
        BODY_END
    );

    ns_end_transaction("record", NS_AUTO_STATUS);

    //Page Auto split for application/json type
    ns_start_transaction("config_json_8");
    ns_web_url ("config_json_8",
        "URL=https://c.go-mpulse.net/api/config.json?key=8GSRP-JVCR4-6J3AN-EWLKW-WZ2FU&d=dash-perf.pas.n01.csaa-insurance.aaa.com&t=5605131&v=1.720.0&if=&sl=1&si=71e7dab5-3521-484e-9b84-4069866ed516-rt56ql&r=&bcn=%2F%2F17de4c0e.akstat.io%2F&acao=&ak.ai=780488",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("config_json_8", NS_AUTO_STATUS);

    // issue 
    // 
    // 
    // ==============================


    //Page Auto split for Method = POST
    ns_start_transaction("quote_52");
    ns_web_url ("quote_52",
        "URL=https://bam-cell.nr-data.net/jserrors/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=1681028&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "{"sm":[{"params":{"name":"Ajax/Events/Excluded/Agent"},"stats":{"c":2}}],"xhr":[{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/jserrors/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":1407},"rxSize":{"t":24},"duration":{"t":77},"cbTime":{"t":1},"time":{"t":1621010}}},{"params":{"method":"POST","hostname":"bam-cell.nr-data.net","port":"443","protocol":"https","host":"bam-cell.nr-data.net:443","pathname":"/events/1/NRJS-caa2993fd9f89f03d7d","status":200},"metrics":{"count":1,"txSize":{"t":277},"rxSize":{"t":24},"duration":{"t":77},"cbTime":{"t":0},"time":{"t":1621012}}},{"params":{"method":"GET","hostname":"api-perf.n01.csaa-insurance.aaa.com","port":"443","protocol":"https","host":"api-perf.n01.csaa-insurance.aaa.com:443","pathname":"/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session/serviceAccountAccessToken/dash","status":200},"metrics":{"count":1,"rxSize":{"t":912},"duration":{"t":895},"cbTime":{"t":0},"time":{"t":1646573}}},{"params":{"method":"POST","hostname":"wiremock-apphub.apps.d1.ent.rt.csaa.com","port":"443","protocol":"https","host":"wiremock-apphub.apps.d1.ent.rt.csaa.com:443","pathname":"/csaa/v1/paymentaccount/record","status":200},"metrics":{"count":1,"txSize":{"t":346},"rxSize":{"t":396},"duration":{"t":536},"cbTime":{"t":0},"time":{"t":1647466}}}]}",
        BODY_END
    );

    ns_end_transaction("quote_52", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("quote_53");
    ns_web_url ("quote_53",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=1681030&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.7;2,,zai5,oq,,,'GET,5k,'api-perf.n01.csaa-insurance.aaa.com:443,'/polexp-property/ent/pasgw/pasperf4/api/csr/v1/session/serviceAccountAccessToken/dash,,pc,,'0,!!!;2,,zb6y,3g,,,'POST,5k,'wiremock-apphub.apps.d1.ent.rt.csaa.com:443,'/csaa/v1/paymentaccount/record,9m,b0,,3,!!!",
        BODY_END
    );

    ns_end_transaction("quote_53", NS_AUTO_STATUS);

    // confirm & continue


    //Page Auto split for application/json type
    ns_start_transaction("QCOSS226334300_9");
    ns_web_url ("QCOSS226334300_9",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOSS226334300",
        "METHOD=PATCH"
    );

    ns_end_transaction("QCOSS226334300_9", NS_AUTO_STATUS);
    ns_page_think_time(0.231);

    //Page Auto split for Button '' Clicked by User
    ns_start_transaction("issue");
    ns_web_url ("issue",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/common/v1/quotes/QCOSS226334300/issue",
        "METHOD=OPTIONS",
        "HEADER=Access-Control-Request-Method:POST",
        "HEADER=Access-Control-Request-Headers:authorization,content-type,x-api-key",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9"
    );

    ns_end_transaction("issue", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("issue_2");
    ns_web_url ("issue_2",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/common/v1/quotes/QCOSS226334300/issue",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"requestHeader":{"partnerId":"PE2"},"documentIds":["PAA_o-tYP_pv32QGh2K8uSJAdQ"],"enrollSMS":false,"signedMethodDocuments":"eSignature","downPaymentAmount":1693,"downPaymentDetails":{"paymentAccountToken":"b1fdc363-6250-4662-ae0a-2c79b777038a"},"autoPaySelected":false,"billToMortgagee":false,"paperlessPreferences":true,"paperlessEmail":"test.user@gmail.com","consents":[{"consentType":"Paperless","consentGranted":true,"ipAddress":"Dash","consentGrantedBy":"Processed by Agent","consentTimeStamp":"2023-04-14T22:47:09-07:00"}]}",
        BODY_END,
        INLINE_URLS,
            "URL=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/dash/confirmation", END_INLINE
    );

    ns_end_transaction("issue_2", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("confirmation");
    ns_web_url ("confirmation",
        "URL=https://bam-cell.nr-data.net/events/1/NRJS-caa2993fd9f89f03d7d?a=1385889614&sa=1&v=1212.e95d35c&t=Unnamed%20Transaction&rst=1696107&ck=0&ref=https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/dash/confirmation",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=content-type:text/plain",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:cross-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        "COOKIE=JSESSIONID",
        BODY_BEGIN,
            "bel.7;1,2,102fv,a9x,ba,58,'click,'https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/property/quote,'https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/auto/quote,'https://dash-perf.pas.n01.csaa-insurance.aaa.com/pasperf4/dash/confirmation,,1,!!!!'ad1324d1-d5d0-4673-89e6-c2cc37d53e3b,'668,!!;5,'actionText,'Confirm and Continue;2,1,55,5q5,c8,5z,'PATCH,5m,'api-perf.n01.csaa-insurance.aaa.com:443,'/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/quotes-express/QCOSS226334300,6l,j4k,,'669,!!!;2,,618,42b,6e,2o,'POST,5m,9,'/polexp-property/ent/pasgw/pasperf4/api/csaa/common/v1/quotes/QCOSS226334300/issue,eq,7hv,,'670,!!!;",
        BODY_END
    );

    ns_end_transaction("confirmation", NS_AUTO_STATUS);

    //Page Auto split for Method = POST
    ns_start_transaction("metadata_50");
    ns_web_url ("metadata_50",
        "URL=https://api-perf.n01.csaa-insurance.aaa.com/polexp-property/ent/pasgw/pasperf4/api/csaa/auto/v1/metadata",
        "METHOD=POST",
        "HEADER=sec-ch-ua:\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\"",
        "HEADER=Authorization:Bearer eyJraWQiOiJkVGxhd09RZ1ZMU05qU1JsYy1qeW1jeW9CM2ZhcWVwd0xtYmRhM0wxRFNFIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnB6MjhpcmV4NlFwMFhNT3A2Umt0cTBjR1AxTkhhSW96NjB5RVlVTVdKYzQub2FyMjIycjF2N3F3TTNpbTAwaDciLCJpc3MiOiJodHRwczovL2NzYWEub2t0YXByZXZpZXcuY29tL29hdXRoMi9hdXNvbmtiZmI1MFF4QVlHVjBoNyIsImF1ZCI6ImNzYWEiLCJpYXQiOjE2ODE1Mzc2MjgsImV4cCI6MTY4MTU0MTIyOCwiY2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDciLCJ1aWQiOiIwMHVvZ29sbDgwVDZja2RpYTBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBvbGljeWV4cHJlc3MiLCJvcGVuaWQiXSwiYXV0aF90aW1lIjoxNjgxNTM3NjI1LCJzdWIiOiJCYXJhY3VkYTcuVGhvcm43QGNzYWEtaWcuY29tIiwicGVfZ2lkIjoiY2FzZXB0MDAwNyIsInBlX3JvbGVzIjoiW0YzNSxNNDJdIiwiY2xpZW50X2lkIjoiMG9hdTc4N2dwY3hjcmU5OGcwaDcifQ.VuuUJdUl37PuKE-DR1AA6OBtNW1Z_R7hBytliQY1f6MCSBm_Oi1poewmyWkOaSgTAHUfBnO1TBVsfVwnAg2tOy_rJfiiDpuNPHiowXeVp47anF3W9R-B6Y-4oLqC378VK_Xe7i6kxwfD2bugE2ay7mZ2F9aZwJeBlSKf5gsbqKHB1NSiPwfpEqxZDINl60b3v1cvKOpoPGTpCxIueB0EmAwTsXXu8u4bFUIVTE9E5gEH4J-1_LAi3Kzksy6Kx23TXOsEsaqSvBqx7WTfHtiNJzc8VAeoZOFCtkTSSM7k7__Muv5X_jmNkbNgs08FrR51M1yjc2CkEn0T92GA76CoLA",
        "HEADER=sec-ch-ua-mobile:?0",
        "HEADER=x-api-key:csaa_policyexpressui",
        "HEADER=Content-Type:application/json;charset=UTF-8",
        "HEADER=Origin:https://dash-perf.pas.n01.csaa-insurance.aaa.com",
        "HEADER=Sec-Fetch-Site:same-site",
        "HEADER=Sec-Fetch-Mode:cors",
        "HEADER=Sec-Fetch-Dest:empty",
        "HEADER=Accept-Language:en-US,en;q=0.9",
        BODY_BEGIN,
            "{"dimensions":{"riskState":"CO","typeOfPolicy":"Auto","effectiveDate":"2023-04-16","officeType":"AZ Club Agent"},"filters":{"properties":["agencyCd"],"models":["ProducerInfo"],"rootModels":[]}}",
        BODY_END
    );

    ns_end_transaction("metadata_50", NS_AUTO_STATUS);
    ns_page_think_time(8.79);

}
