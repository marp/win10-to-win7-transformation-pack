        ��  ��                  �x  ,   U I F I L E   ���     0            <duixml>
<stylesheets>
<style resid="cp_style">
<Button accessible="true" contentalign="wrapleft"/>
<Element overhang="false" background="argb(0,0,0,0)"/>
<NavigateButton overhang="false" background="argb(0,0,0,0)"/>
<CCPushButton transparent="true" accessible="true" minsize="size(76rp,23rp)" font="gtf(CONTROLPANELSTYLE,14,0)" margin="rect(6rp,0rp,0rp,0rp)"/>
<CCCheckBox transparent="true" accessible="true" font="gtf(CONTROLPANELSTYLE,6,0)" foreground="gtc(CONTROLPANELSTYLE,6,0,3803)" background="themeable(dtb(CONTROLPANEL,2,0),window)"/>
<ComboBox transparent="true" accessible="true" font="gtf(CONTROLPANELSTYLE,14,0)"/>
<CCRadioButton transparent="true" accessible="true" font="gtf(CONTROLPANELSTYLE,6,0)" foreground="gtc(CONTROLPANELSTYLE,6,0,3803)" background="themeable(dtb(CONTROLPANEL,2,0),window)"/>
<CCSysLink transparent="true" accessible="true" font="gtf(CONTROLPANELSTYLE,6,0)" foreground="gtc(CONTROLPANELSTYLE,6,0,3803)" background="themeable(dtb(CONTROLPANEL,2,0), window)"/>
<Edit transparent="true" themedborder="true" width="120rp" accessible="true" accrole="text" height="20rp" font="gtf(CONTROLPANELSTYLE,6,0)" foreground="gtc(CONTROLPANELSTYLE,6,0,3803)"/>
<if class="cp_topbox">
<Element accessible="true" accrole="client" background="themeable(dtb(CONTROLPANEL,2,0),window)"/>
</if>
<if class="cp_hub_frame">
<Element padding="rect(13rp,1rp,1rp,10rp)"/>
</if>
<if class="cp_spoke_frame">
<Element padding="rect(0rp,19rp,0rp,10rp)"/>
</if>
<if class="cp_help_glyph">
<Button height="18rp" width="18rp" content="icon(99,sysmetric(49),sysmetric(50),library(imageres.dll))" padding="rect(1rp,1rp,1rp,1rp)" cursor="hand" accRole="link" accdefaction="click" accState="0x00100000" tooltip="true"/>
<if keyfocused="true">
<Button contentalign="focusrect"/>
</if>
</if>
<if class="cp_content_pane">
<Element width="600rp" padding="rect(10rp,0rp,10rp,0rp)" background="themeable(dtb(CONTROLPANEL,2,0),window)"/>
</if>
<if class="cp_content_instruction">
<Element contentalign="wrapleft" foreground="gtc(CONTROLPANELSTYLE,5,0,3803)" font="gtf(CONTROLPANELSTYLE, 5, 0)" accessible="true" accRole="statictext"/>
</if>
<if class="cp_content_v_spacer">
<Element height="7rp"/>
</if>
<if class="cp_content_text">
<Element font="gtf(CONTROLPANELSTYLE, 6, 0)" foreground="gtc(CONTROLPANELSTYLE,6,0,3803)" contentalign="wrapleft" accessible="true" accRole="statictext"/>
<PText font="gtf(CONTROLPANELSTYLE, 6, 0)" foreground="gtc(CONTROLPANELSTYLE,6,0,3803)" contentalign="wrapleft" accessible="true" accRole="statictext"/>
</if>
<if class="cp_content_title_text">
<Element font="gtf(CONTROLPANELSTYLE, 19, 0)" foreground="gtc(CONTROLPANELSTYLE,19,0,3803)" contentalign="wrapleft" accessible="true" accRole="statictext"/>
</if>
<if class="cp_help_link">
<Button accessible="true" accRole="link" accdefaction="click" foreground="gtc(CONTROLPANELSTYLE,7,1,3803)" font="gtf(CONTROLPANELSTYLE,7,1)" overhang="false"/>
<Element accessible="true" accRole="link" accdefaction="click" foreground="gtc(CONTROLPANELSTYLE,7,1,3803)" font="gtf(CONTROLPANELSTYLE,7,1)" overhang="false"/>
<if keyfocused="true">
<Button contentalign="wrapleft | focusrect"/>
<Element contentalign="wrapleft | focusrect"/>
</if>
<if enabled="false">
<Button foreground="gtc(CONTROLPANELSTYLE,7,4,3803)" font="gtf(CONTROLPANELSTYLE,7,4)"/>
<Element foreground="gtc(CONTROLPANELSTYLE,7,4,3803)" font="gtf(CONTROLPANELSTYLE,7,4)"/>
</if>
<if mousefocused="true">
<Button cursor="hand" foreground="gtc(CONTROLPANELSTYLE,7,2,3803)" font="gtf(CONTROLPANELSTYLE,7,2)"/>
<Element cursor="hand" foreground="gtc(CONTROLPANELSTYLE,7,2,3803)" font="gtf(CONTROLPANELSTYLE,7,2)"/>
</if>
</if>
<if class="cp_content_link">
<Button accessible="true" accRole="link" accdefaction="click" foreground="gtc(CONTROLPANELSTYLE,10,1,3803)" font="gtf(CONTROLPANELSTYLE,10,1)" overhang="false"/>
<Element accessible="true" accRole="link" accdefaction="click" foreground="gtc(CONTROLPANELSTYLE,10,1,3803)" font="gtf(CONTROLPANELSTYLE,10,1)" overhang="false"/>
<if keyfocused="true">
<Button contentalign="wrapleft | focusrect"/>
<Element contentalign="wrapleft | focusrect"/>
</if>
<if enabled="false">
<Button foreground="gtc(CONTROLPANELSTYLE,10,4,3803)" font="gtf(CONTROLPANELSTYLE,10,4)"/>
<Element foreground="gtc(CONTROLPANELSTYLE,10,4,3803)" font="gtf(CONTROLPANELSTYLE,10,4)"/>
</if>
<if mousefocused="true">
<Button cursor="hand" foreground="gtc(CONTROLPANELSTYLE,10,2,3803)" font="gtf(CONTROLPANELSTYLE,10,2)"/>
<Element cursor="hand" foreground="gtc(CONTROLPANELSTYLE,10,2,3803)" font="gtf(CONTROLPANELSTYLE,10,2)"/>
</if>
</if>
<if class="cp_content_divider_header">
<Element background="themeable(dtb(CONTROLPANEL,2,0),window)" foreground="gtc(CONTROLPANELSTYLE,9,0,3803)" font="gtf(CONTROLPANELSTYLE, 9, 0)" padding="rect(0rp,0rp,2rp,0rp)" contentalign="wrapleft" accessible="true" accRole="statictext"/>
</if>
<if class="cp_content_divider_line">
<Element height="1rp" width="565rp" background="themeable(dtb(CONTROLPANEL,17,0),buttonshadow)"/>
</if>
<if class="cp_content_banner_box">
<Element padding="rect(7rp,7rp,7rp,7rp)" background="themeable(dtb(CONTROLPANEL,18,0),window)" borderthickness="rect(1rp,1rp,1rp,1rp)" bordercolor="gtc(CONTROLPANELSTYLE,17,0,3821)"/>
</if>
<if class="cp_command_sink">
<Element layoutpos="bottom" background="themeable(dtb(CONTROLPANEL,12,0),window)"/>
</if>
<if class="cp_command_float">
<Element layoutpos="top" background="themeable(dtb(CONTROLPANEL,13,0),window)"/>
</if>
<if class="cp_command_button_box">
<Element padding="rect(0rp,10rp,10rp,10rp)" width="600rp"/> 
</if>
</style>
#pragma once
<style resid="healthcenter_style">
<if class="hc_content_box">
<Element padding="rect(12rp,5rp,12rp,5rp)" borderthickness="rect(1rp,1rp,1rp,1rp)" bordercolor="gtc(CONTROLPANELSTYLE,17,0,3821)"/>
</if>
<if class="hc_highcontrast_content_box">
<Element padding="rect(12rp,5rp,12rp,5rp)" borderthickness="rect(1rp,1rp,1rp,1rp)" bordercolor="activecaption"/>
</if>
<if class="hc_red_content_banner_box">
<Element background="gradient(RGB(172,1,0),RGB(222,1,0),1)" width="20rp"/>
</if>
<if class="hc_yellow_content_banner_box">
<Element background="gradient(RGB(242,177,0),RGB(255,206,73),1)" width="20rp"/>
</if>
<if class="hc_highcontrast_content_banner_box">
<Element background="activecaption" width="20rp"/>
</if>
<if class="cp_content_v_spacer">
<Element height="7rp"/>
</if>
<if class="ExpandoButtonText">
<Element font="gtf(CONTROLPANELSTYLE, 5, 0)" foreground="gtc(CONTROLPANELSTYLE,7,1,3803)" contentalign="wrapleft" layoutpos="top"/>
<if keyfocused="true">
<Element contentalign="wrapleft | focusrect"/>
</if>
<if id="atom(ExpandoTextExpanded)" selected="false">
<Element layoutpos="none" enabled="false"/>
</if>
<if id="atom(ExpandoTextCollapsed)" selected="true">
<Element layoutpos="none" enabled="false"/>
</if>
</if>
<if class="ExpandoStatusText">
<Element font="gtf(CONTROLPANELSTYLE, 5, 0)" foreground="gtc(CONTROLPANELSTYLE,6,0,3803)" contentalign="wrapleft" layoutpos="top"/>
</if>
<if class="GroupHeader">
<if mousewithin="true">
<Element background="themeable(dtb(Explorer::ListView,1,2), threedlightshadow)"/>
</if>
</if>
<if class="ExpandButtonNormal">
<Button height="themeable(gtmet(TaskDialog, 13, 0, 2417), '21rp')" width="themeable(gtmet(TaskDialog, 13, 0, 2416), '19rp')" background="themeable(dtb(TaskDialog, 13, 1), dfc(3, 0x0001))" margin="themeable(gtmar(TaskDialog, 20, 0, 3602), rect(0rp,0rp,10rp,0rp))"/>
<if keyfocused="true">
<Button contentalign="focusrect"/>
</if>
<if selected="true">
<Button background="themeable(dtb(TaskDialog, 13, 4),dfc(3, 0x0000))"/>
</if>
</if>
<if class="ExpandButtonHover">
<Button height="themeable(gtmet(TaskDialog, 13, 0, 2417), '21rp')" width="themeable(gtmet(TaskDialog, 13, 0, 2416), '19rp')" background="themeable(dtb(TaskDialog, 13, 2), dfc(3, 0x0001 | 0x1000))" margin="themeable(gtmar(TaskDialog, 20, 0, 3602), rect(0rp,0rp,10rp,0rp))"/>
<if keyfocused="true">
<Button contentalign="focusrect"/>
</if>
<if selected="true">
<Button background="themeable(dtb(TaskDialog, 13, 5), dfc(3, 0x0000 | 0x1000))"/>
</if>
</if>
<if class="ExpandButtonPressed">
<Button height="themeable(gtmet(TaskDialog, 13, 0, 2417), '21rp')" width="themeable(gtmet(TaskDialog, 13, 0, 2416), '19rp')" background="themeable(dtb(TaskDialog, 13, 3), dfc(3, 0x0001 | 0x0200) )" margin="themeable(gtmar(TaskDialog, 20, 0, 3602), rect(0rp,0rp,10rp,0rp))"/>
<if keyfocused="true">
<Button contentalign="focusrect"/>
</if>
<if selected="true">
<Button background="themeable(dtb(TaskDialog, 13, 6), dfc(3, 0x0000| 0x0200))"/>
</if>
</if>
</style>
</stylesheets>
<Element resid="RedModule" layoutpos="top" class="hc_content_box" layout="borderlayout()" accessible="true" accrole="pane" accname="Important message" padding="rect(0,0,0,0)">
<Element layoutpos="client" id="atom(redNotificationBox)" class="hc_content_box" layout="borderlayout()" padding="rect(0,0,0,0)">
<Element id="atom(redBanner)" class="hc_red_content_banner_box" layoutpos="left"/>
<Element layoutpos="client" layout="borderlayout()" padding="rect(12rp,14rp,14rp,7rp)">
<Element layoutpos="top" layout="borderlayout()">
<Element layoutpos="bottom" class="cp_content_v_spacer"/>
<Element layoutpos="right" layout="flowlayout(0,2,1,3)" sheet="cp_style" contentalign="middleright">
<viewer>
<NavigateButton id="atom(ActionButton)" layout="borderlayout()" layoutpos="right">
<CCPushButton id="atom(ButtonData)" layoutpos="right" active="mouse | keyboard" accessible="true" accrole="pushbutton"/>
</NavigateButton>
</viewer>
</Element>
<Element layoutpos="left" layout="borderlayout()" sheet="cp_style">
<Element layoutpos="top" layout="borderlayout()">
<Element layoutpos="top" layout="flowlayout(1,0,0,0)">
<Element class="cp_content_title_text" layoutpos="left" id="atom(TitleData)" accessible="true" accrole="text" padding="rect(0,0,5rp,0)"/>
<Element class="cp_content_title_text" layoutpos="right" id="atom(NotificationType)" accessible="true" accrole="text"/>
</Element>
<Element layoutpos="top" class="cp_content_v_spacer"/>
<Element layoutpos="top" layout="flowlayout(0,0,0,0)">
<Element id="atom(DetailIcon)" layoutpos="left" accessible="true" accrole="graphic" margin="rect(0rp,0rp,5rp,0rp)"/>
<Element class="cp_content_text" layoutpos="right" id="atom(DetailData)" contentalign="wrapleft" accessible="true" accrole="text"/>
</Element>
</Element>
</Element>
</Element>
<Element layoutpos="top" layout="tablelayout(0,0,0,0,-60,1,0,-40)" sheet="cp_style">
<NavigateButton layout="borderlayout()">
<Button class="cp_content_link" id="atom(TurnOffWarning)" layoutpos="left" content="resstr(501)" accessible="true" accrole="link"/>
</NavigateButton>
<Element layout="verticalflowlayout(1,1,1,2)" layoutpos="right">
<NavigateButton layout="borderlayout()">
<Button class="cp_content_link" id="atom(SecondaryLink)" contentalign="wrapright" accessible="true" accrole="link"/>
</NavigateButton>
<NavigateButton layout="borderlayout()" layoutpos="right">
<Button class="cp_content_link" id="atom(HelpNotification)" contentalign="wrapright" accessible="true" accrole="link"/>
</NavigateButton>
</Element>
</Element>
</Element>
</Element>
<Element layoutpos="bottom" class="cp_content_v_spacer"/>
</Element>
<Element resid="YellowModule" layoutpos="top" class="hc_content_box" layout="borderlayout()" accessible="true" accrole="pane" accname="Message" padding="rect(0,0,0,0)">
<Element layoutpos="client" id="atom(yellowNotificationBox)" class="hc_content_box" layout="borderlayout()" padding="rect(0,0,0,0)">
<Element id="atom(yellowBanner)" class="hc_red_content_banner_box" layoutpos="left"/>
<Element layoutpos="client" layout="borderlayout()" padding="rect(12rp,14rp,14rp,7rp)">
<Element layoutpos="top" layout="borderlayout()">
<Element layoutpos="bottom" class="cp_content_v_spacer"/>
<Element layoutpos="right" layout="flowlayout(0,2,1,3)" sheet="cp_style" contentalign="middleright">
<viewer>
<NavigateButton id="atom(ActionButton)" layout="borderlayout()" layoutpos="right">
<CCPushButton id="atom(ButtonData)" layoutpos="right" active="mouse | keyboard" accessible="true" accrole="pushbutton"/>
</NavigateButton>
</viewer>
</Element>
<Element layoutpos="left" layout="borderlayout()" sheet="cp_style">
<Element layoutpos="top" layout="borderlayout()">
<Element class="cp_content_title_text" layoutpos="top" id="atom(TitleData)" accessible="true" accrole="text"/>
<Element layoutpos="top" class="cp_content_v_spacer"/>
<Element layoutpos="top" layout="flowlayout(0,0,0,0)">
<Element id="atom(DetailIcon)" layoutpos="left" accessible="true" accrole="graphic" margin="rect(0rp,0rp,5rp,0rp)"/>
<Element class="cp_content_text" layoutpos="right" id="atom(DetailData)" contentalign="wrapleft" accessible="true" accrole="text"/>
</Element>
</Element>
</Element>
</Element>
<Element layoutpos="top" layout="tablelayout(0,0,0,0,-60,1,0,-40)" sheet="cp_style">
<NavigateButton layout="borderlayout()">
<Button class="cp_content_link" id="atom(TurnOffWarning)" layoutpos="left" content="resstr(501)" accessible="true" accrole="link"/>
</NavigateButton>
<Element layout="verticalflowlayout(1,1,1,2)">
<NavigateButton layout="borderlayout()" layoutpos="right">
<Button class="cp_content_link" id="atom(SecondaryLink)" contentalign="wrapright" accessible="true" accrole="link"/>
</NavigateButton>
<NavigateButton layout="borderlayout()" layoutpos="right">
<Button class="cp_content_link" id="atom(HelpNotification)" contentalign="wrapright" accessible="true" accrole="link"/>
</NavigateButton>
</Element>
</Element>
</Element>
</Element>
<Element layoutpos="bottom" class="cp_content_v_spacer"/>
</Element>
<Element resid="CheckModule" layoutpos="top" layout="borderlayout()" accessible="true" accrole="pane" accname="Check" sheet="cp_style" padding="rect(0,0,0,20rp)">
<Element layoutpos="top" layout="tablelayout(0,0,3,0,-70)">
<Element layoutpos="top" layout="flowlayout(0,0,3,0)" margin="rect(0,7rp,0,0)">
<Element class="cp_content_text" id="atom(CheckTitle)" contentalign="wrapleft" padding="rect(0,0,7rp,0)" accessible="true" accrole="text"/>
<Element class="cp_content_text" id="atom(CheckStatus)" contentalign="wrapright" accessible="true" accrole="text"/>
</Element>
</Element>
<Element layoutpos="top" layout="borderlayout()" padding="rect(20rp,7rp,0,0)">
<Element layoutpos="top" layout="flowlayout(0,2,0,0)" margin="rect(20rp,7rp,0rp,0rp)">
<Element id="atom(CheckIcon)" layoutpos="left" accessible="true" accrole="graphic" margin="rect(0rp,0rp,5rp,0rp)"/>
<Element class="cp_content_text" id="atom(CheckDescription)" layoutpos="left" accessible="true" accrole="text"/>
</Element>
<Element layoutpos="top" layout="flowlayout()" margin="rect(20rp,7rp,0rp,0rp)">
<NavigateButton layout="flowlayout(0,2,0,2)">
<Element layoutPos="left" id="atom(CheckLinkIcon1)" content="icon(78,sysmetric(49),sysmetric(50),library(imageres.dll))" contentalign="middleleft" accessible="true" accrole="graphic" accname="resstr(6)" margin="rect(0rp,0rp,5rp,0rp)"/>
<Button layoutPos="left" class="cp_content_link" id="atom(CheckLink1)" layoutpos="right" accessible="true" accrole="link"/>
</NavigateButton>
<NavigateButton layout="flowlayout(0,2,0,2)">
<Element class="cp_content_text" padding="rect(5rp,0rp,5rp,0rp)" layoutpos="left" accessible="false" content="resstr(539)"/>
<Element layoutPos="left" id="atom(CheckLinkIcon2)" content="icon(78,sysmetric(49),sysmetric(50),library(imageres.dll))" contentalign="middleleft" accessible="true" accrole="graphic" accname="resstr(6)" margin="rect(0rp,0rp,5rp,0rp)"/>
<Button layoutPos="left" class="cp_content_link" id="atom(CheckLink2)" layoutpos="top" accessible="true" accrole="link"/>
</NavigateButton>
<NavigateButton layout="flowlayout(0,2,0,2)">
<Element class="cp_content_text" padding="rect(5rp,0rp,5rp,0rp)" layoutpos="left" accessible="false" content="resstr(539)"/>
<Element layoutPos="left" id="atom(CheckLinkIcon3)" content="icon(78,sysmetric(49),sysmetric(50),library(imageres.dll))" contentalign="middleleft" accessible="true" accrole="graphic" accname="resstr(6)" margin="rect(0rp,0rp,5rp,0rp)"/>
<Button layoutPos="left" class="cp_content_link" id="atom(CheckLink3)" layoutpos="top" accessible="true" accrole="link"/>
</NavigateButton>
<NavigateButton layout="flowlayout(0,2,0,2)">
<Element class="cp_content_text" padding="rect(5rp,0rp,5rp,0rp)" layoutpos="left" accessible="false" content="resstr(539)"/>
<Element layoutPos="left" id="atom(CheckLinkIcon4)" content="icon(78,sysmetric(49),sysmetric(50),library(imageres.dll))" contentalign="middleleft" accessible="true" accrole="graphic" accname="resstr(6)" margin="rect(0rp,0rp,5rp,0rp)"/>
<Button layoutPos="left" class="cp_content_link" id="atom(CheckLink4)" layoutpos="top" accessible="true" accrole="link"/>
</NavigateButton>
</Element>
<NavigateButton layout="borderlayout()" layoutpos="top" margin="rect(12rp,7rp,0rp,0rp)">
<Button class="cp_content_link" id="atom(CheckHelp)" layoutpos="left" accessible="true" accrole="link"/>
</NavigateButton>
</Element>
</Element>
<HealthCenterCPLPage resid="main" id="atom(Hub)" layout="borderlayout()">
<Element sheet="cp_style" class="cp_topbox" layout="borderlayout()" layoutpos="client">
<ScrollViewer xscrollable="false" layoutpos="client" sheet="common">
<Element layout="borderlayout()" sheet="cp_style" class="cp_hub_frame" width="652rp" padding="rect(0,0,0,0)">
<Element layoutpos="top" layout="borderlayout()">
<Viewer layoutpos="right">
<Button class="cp_help_glyph" id="atom(helpHub)" accessible="true" accrole="graphic" accname="resstr(7)"/>
</Viewer>
</Element>
<FocusIndicator id="atom(FocusIndicator)" firsttabtarget="atom(startLinks)"/>
<Element id="atom(startLinks)" class="cp_cotent_pane" layoutpos="left" layout="borderlayout()" padding="rect(26rp,0,26rp,20rp)" accessible="true" accname="Action Center panel" accrole="pane">
<Element layoutpos="top" layout="flowlayout()">
<Element class="cp_content_instruction" accessible="true" accrole="text" content="resstr(4)"/>
</Element>
<Element layoutpos="top" class="cp_content_v_spacer"/>
<Element id="atom(NotInitialized)" layoutpos="top" layout="flowlayout()">
<Element class="cp_content_text" content="resstr(500)"/>
</Element>
<Element id="atom(NoActions)" layoutpos="top" layout="flowlayout()">
<Element class="cp_content_text" content="resstr(502)"/>
</Element>
<Element id="atom(AtRisk)" layoutpos="top" layout="flowlayout()">
<Element class="cp_content_text" content="resstr(503)"/>
</Element>
<Element layoutpos="top" class="cp_content_v_spacer"/>
<Element layoutpos="top" class="cp_content_v_spacer"/>
<Element layoutpos="top" class="cp_content_v_spacer"/>
<Element layoutpos="top" contentalign="middlecenter" layout="borderlayout()" accessible="true" accrole="pane" accname="Security section">
<Element layoutpos="top" class="cp_content_divider_line" width="700rp"/>
<WHCExpando id="atom(SecurityGroupExpando)" sheet="healthcenter_style" layout="borderlayout()" layoutpos="top">
<Element id="atom(HeaderButton)" class="GroupHeader" layout="borderlayout()" layoutpos="top" padding="rect(0,7rp,0,7rp)">
<Accessiblebutton id="atom(SecurityGroupHeading)" layout="borderlayout()" layoutpos="top" background="argb(0,0,0,0)" accessible="true" accname="resstr(564)" accrole="pushbutton">
<Element layout="flowlayout(0,2,0,2)" layoutpos="left" padding="rect(10rp,0rp,0rp,0rp)">
<Element class="ExpandoButtonText" content="resstr(509)" shortcut="auto"/>
</Element>
<Accessiblebutton id="atom(arrow)" layoutpos="right" layout="flowlayout()" padding="rect(12rp,0,12rp,0)" accessible="true" accrole="pushbutton" accname="resstr(511)" accdesc="resstr(512)">
<Button id="atom(ExpandoButtonImage)" class="ExpandButtonNormal" layoutpos="top" active="inactive"/>
</Accessiblebutton>
</Accessiblebutton>
</Element>
<WHCRepeater id="atom(RedSecurityList)" expand="RedModule" layout="borderlayout()" layoutpos="top">
<bind connect="ButtonData" property="ButtonData"/>
<bind connect="TitleData" property="TitleData"/>
<bind connect="NotificationType" property="NotificationType"/>
<bind connect="DetailData" property="DetailData"/>
<bind connect="SecondaryLink" property="SecondaryLink"/>
<bind connect="DetailIcon" property="DetailIcon"/>
<bind connect="HelpNotification" property="HelpNotification"/>
<bind connect="TurnOffWarning" property="TurnOffWarning"/>
</WHCRepeater>
<Element id="atom(SecurityYellowExpanded)" layoutpos="top" layout="borderlayout()">
<WHCRepeater id="atom(YellowSecurityList)" expand="YellowModule" layout="borderlayout()" layoutpos="top">
<bind connect="ButtonData" property="ButtonData"/>
<bind connect="TitleData" property="TitleData"/>
<bind connect="DetailData" property="DetailData"/>
<bind connect="SecondaryLink" property="SecondaryLink"/>
<bind connect="DetailIcon" property="DetailIcon"/>
<bind connect="HelpNotification" property="HelpNotification"/>
<bind connect="TurnOffWarning" property="TurnOffWarning"/>
</WHCRepeater>
</Element>
<Element id="atom(SecurityOverflow)" layoutpos="top" layout="borderlayout()" padding="rect(0,0,0,0)" accessible="true" accname="Overflow Notifications" accrole="pane">
<Element id="atom(SecurityOverflowBox)" class="hc_content_box" layoutpos="top" padding="rect(0,0,0,0)" layout="borderlayout()">
<Element id="atom(SecurityOverflowBanner)" class="hc_yellow_content_banner_box" layoutpos="left"/>
<Element layoutpos="client" layout="borderlayout()" padding="rect(12rp,14rp,12rp,14rp)">
<Element layoutpos="right" layout="borderlayout()" sheet="cp_style">
<Element layoutpos="top" layout="flowlayout(0,2,1,2)">
<viewer>
<NavigateButton layout="borderlayout()" layoutpos="left">
<CCPushButton id="atom(SecurityExpandOverflow)" content="resstr(513)" layoutpos="right" active="mouse | keyboard"/>
</NavigateButton>
</viewer>
</Element>
</Element>
<Element layoutpos="left" layout="borderlayout()" sheet="cp_style">
<Element class="cp_content_text" layoutpos="top" id="atom(SecurityOverflowText)"/>
</Element>
</Element>
</Element>
<Element layoutpos="bottom" class="cp_content_v_spacer"/>
</Element>
<Element id="atom(clipper)" sheet="cp_style" class="cp_content_pane" layoutpos="bottom" layout="borderlayout()" padding="rect(12rp,10rp,0,7rp)" animation="rectangleV | s | fast">
<WHCRepeater id="atom(SecurityCheckModule)" expand="CheckModule" layout="borderlayout()" layoutpos="top">
<bind connect="CheckTitle" property="CheckTitle"/>
<bind connect="CheckStatus" property="CheckStatus"/>
<bind connect="CheckDescription" property="CheckDescription"/>
<bind connect="CheckLink1" property="CheckLink1"/>
<bind connect="CheckLinkIcon1" property="CheckLinkIcon1"/>
<bind connect="CheckLink2" property="CheckLink2"/>
<bind connect="CheckLinkIcon2" property="CheckLinkIcon2"/>
<bind connect="CheckLink3" property="CheckLink3"/>
<bind connect="CheckLinkIcon3" property="CheckLinkIcon3"/>
<bind connect="CheckLink4" property="CheckLink4"/>
<bind connect="CheckLinkIcon4" property="CheckLinkIcon4"/>
<bind connect="CheckIcon" property="CheckIcon"/>
<bind connect="CheckHelp" property="CheckHelp"/>
</WHCRepeater>
<CCSysLink id="atom(securityHelpLink)" class="cp_content_text" layoutpos="top" content="resstr(37)" accessible="true" accname="resstr(555)" accrole="link" margin="rect(0,7rp,0,7rp)"/>
</Element>
</WHCExpando>
<Element id="atom(SecurityBottomLine)" layoutpos="top" class="cp_content_divider_line" width="700rp" animation="position | s | fast"/>
</Element>
<Element id="atom(SectionBelow)" layoutpos="top" background="themeable(dtb(CONTROLPANEL,2,0),window)" contentalign="middlecenter" layout="borderlayout()" accessible="true" accrole="pane" accname="Maintenance section" animation="position | s | fast">
<WHCExpando id="atom(MaintenanceGroupExpando)" sheet="healthcenter_style" layout="borderlayout()" layoutpos="top">
<Element id="atom(HeaderButton)" class="GroupHeader" layout="borderlayout()" layoutpos="top" padding="rect(0,7rp,0,7rp)">
<Accessiblebutton id="atom(MaintenanceGroupHeading)" layout="borderlayout()" layoutpos="top" background="argb(0,0,0,0)" accessible="true" accname="resstr(565)" accrole="pushbutton">
<Element layout="flowlayout(0,2,0,2)" layoutpos="left" padding="rect(10rp,0rp,0,0rp)">
<Element class="ExpandoButtonText" content="resstr(504)" shortcut="auto"/>
</Element>
<Accessiblebutton id="atom(arrow)" layoutpos="right" layout="flowlayout()" padding="rect(12rp,0,12rp,0)" accessible="true" accrole="pushbutton" accname="resstr(506)" accdesc="resstr(507)">
<Button id="atom(ExpandoButtonImage)" class="ExpandButtonNormal" layoutpos="top" active="inactive"/>
</Accessiblebutton>
</Accessiblebutton>
</Element>
<WHCRepeater id="atom(RedMaintenanceList)" expand="RedModule" layout="borderlayout()" layoutpos="top">
<bind connect="ButtonData" property="ButtonData"/>
<bind connect="TitleData" property="TitleData"/>
<bind connect="NotificationType" property="NotificationType"/>
<bind connect="DetailData" property="DetailData"/>
<bind connect="SecondaryLink" property="SecondaryLink"/>
<bind connect="DetailIcon" property="DetailIcon"/>
<bind connect="HelpNotification" property="HelpNotification"/>
<bind connect="TurnOffWarning" property="TurnOffWarning"/>
</WHCRepeater>
<Element id="atom(MaintenanceYellowExpanded)" layoutpos="top" layout="borderlayout()">
<WHCRepeater id="atom(YellowMaintenanceList)" expand="YellowModule" layout="borderlayout()" layoutpos="top">
<bind connect="ButtonData" property="ButtonData"/>
<bind connect="TitleData" property="TitleData"/>
<bind connect="DetailData" property="DetailData"/>
<bind connect="SecondaryLink" property="SecondaryLink"/>
<bind connect="DetailIcon" property="DetailIcon"/>
<bind connect="HelpNotification" property="HelpNotification"/>
<bind connect="TurnOffWarning" property="TurnOffWarning"/>
</WHCRepeater>
</Element>
<Element id="atom(MaintenanceOverflow)" layoutpos="top" layout="borderlayout()" padding="rect(0,0,0,0)" accessible="true" accname="Overflow Notifications" accrole="pane">
<Element id="atom(MaintenanceOverflowBox)" class="hc_content_box" layoutpos="top" padding="rect(0,0,0,0)" layout="borderlayout()">
<Element id="atom(MaintenanceOverflowBanner)" class="hc_yellow_content_banner_box" layoutpos="left"/>
<Element layoutpos="client" layout="borderlayout()" padding="rect(12rp,14rp,12rp,14rp)">
<Element layoutpos="right" layout="borderlayout()" sheet="cp_style">
<Element layoutpos="top" layout="flowlayout(0,2,1,2)">
<viewer>
<NavigateButton layout="borderlayout()" layoutpos="left">
<CCPushButton id="atom(MaintenanceExpandOverflow)" content="resstr(508)" layoutpos="right" active="mouse | keyboard"/>
</NavigateButton>
</viewer>
</Element>
</Element>
<Element layoutpos="left" layout="borderlayout()" sheet="cp_style">
<Element class="cp_content_text" layoutpos="top" id="atom(MaintenanceOverflowText)"/>
</Element>
</Element>
</Element>
<Element layoutpos="bottom" class="cp_content_v_spacer"/>
</Element>
<Element id="atom(clipper)" sheet="cp_style" class="cp_content_pane" layoutpos="bottom" layout="borderlayout()" padding="rect(12rp,10rp,0,7rp)" animation="rectangleV | s | fast">
<WHCRepeater id="atom(MaintenanceCheckModule)" expand="CheckModule" layout="borderlayout()" layoutpos="top">
<bind connect="CheckTitle" property="CheckTitle"/>
<bind connect="CheckStatus" property="CheckStatus"/>
<bind connect="CheckDescription" property="CheckDescription"/>
<bind connect="CheckLink1" property="CheckLink1"/>
<bind connect="CheckLinkIcon1" property="CheckLinkIcon1"/>
<bind connect="CheckLink2" property="CheckLink2"/>
<bind connect="CheckLinkIcon2" property="CheckLinkIcon2"/>
<bind connect="CheckLink3" property="CheckLink3"/>
<bind connect="CheckLinkIcon3" property="CheckLinkIcon3"/>
<bind connect="CheckLink4" property="CheckLink4"/>
<bind connect="CheckLinkIcon4" property="CheckLinkIcon4"/>
<bind connect="CheckIcon" property="CheckIcon"/>
<bind connect="CheckHelp" property="CheckHelp"/>
</WHCRepeater>
</Element>
</WHCExpando>
<Element id="atom(MaintenanceBottomLine)" layoutpos="top" class="cp_content_divider_line" width="700rp" animation="position | s | fast"/>
</Element>
<Element id="atom(HavingAProblem)" background="themeable(dtb(CONTROLPANEL,2,0),window)" layoutpos="client" layout="borderlayout()" accessible="true" accrole="pane" accname="Solution box" animation="position | s | fast">
<Element layoutpos="top" class="cp_content_v_spacer"/>
<Element layoutpos="top" class="cp_content_v_spacer"/>
<Element layoutpos="top" class="cp_content_v_spacer"/>
<Element id="atom(SolutonBoxHeading)" class="cp_content_text" layoutpos="top" content="resstr(514)"/>
<Element layout="gridlayout(1,2)" layoutpos="top" padding="rect(0,21rp,0,0)" background="themeable(dtb(CONTROLPANEL,2,0),window)">
<Element layout="flowlayout(0,0,0,0)" padding="rect(12rp,0,12rp,0)">
<NavigateButton layout="borderlayout()" layoutpos="left" navigationtargetroot="Microsoft.Troubleshooting">
<Button class="cp_content_link" id="atom(RunTroubleshooting)" layoutpos="left" content="icon(1021, 48rp, 48rp, library(imageres.dll))" accessible="true" accname="resstr(561)" accrole="pushbutton"/>
</NavigateButton>
<Element layout="borderlayout()" layoutpos="right" padding="rect(12rp,7rp,0,0)">
<NavigateButton layout="borderlayout()" layoutpos="top" navigationtargetroot="Microsoft.Troubleshooting">
<Button class="cp_content_link" id="atom(RunTroubleshooting)" layoutpos="left" content="resstr(518)" shortcut="auto" accessible="true" accrole="link"/>
</NavigateButton>
<Element class="cp_content_text" layoutpos="top" content="resstr(556)" padding="rect(0,5rp,0,0)"/>
</Element>
</Element>
<Element id="atom(SolutonBoxRecovery)" layout="flowlayout(0,0,0,0)" padding="rect(12rp,0,12rp,0)">
<NavigateButton layout="borderlayout()" layoutpos="left" navigationtargetroot="Microsoft.Recovery">
<Button class="cp_content_link" id="atom(RestoreYourPC)" layoutpos="left" content="icon(1022, 48rp, 48rp, library(imageres.dll))" accessible="true" accname="resstr(562)" accrole="pushbutton"/>
</NavigateButton>
<Element layout="borderlayout()" layoutpos="right" padding="rect(12rp,7rp,25rp,0)">
<NavigateButton layout="borderlayout()" layoutpos="top" navigationtargetroot="Microsoft.Recovery">
<Button class="cp_content_link" id="atom(RestoreYourPC)" layoutpos="left" content="resstr(557)" shortcut="auto" accessible="true" accrole="link"/>
</NavigateButton>
<Element class="cp_content_text" layoutpos="top" content="resstr(558)" padding="rect(0,5rp,0,0)"/>
</Element>
</Element>
</Element>
</Element>
</Element>
</Element>
</ScrollViewer>
</Element>
</HealthCenterCPLPage>
</duixml>
  �  ,   X M L F I L E   ��d     0	        <pagedefinition><properties elementprovider="{05F3561D-0358-4687-8ACD-A34D24C488DF}" initializer="{2C673043-FC2E-4d67-8920-517D24DEBD2C}" helptopic="mshelp://windows/?id=bbeaaca4-c6ae-47f8-8f2f-03deadf80271" layout="201" icon="ActionCenterCPL.dll,-1" displayname="@ActionCenterCPL.dll,-1" navpane="true" canonicalname="Hub" /><childpages><pagedefinition><properties layout="202" icon="ActionCenterCPL.dll,-1" displayname="@ActionCenterCPL.dll,-8" helptopic="mshelp://windows/?id=91558e3c-22f9-42dd-a132-f51482063c98" canonicalname="Settings" /></pagedefinition> <pagedefinition><properties elementprovider="{C3A43F75-FE02-47d8-B3EE-0B568C0C5043}" initializer="{CACA7238-3C7E-4a25-AD73-DE1A4F8C7214}"  layout="101" icon="werconcpl.dll,-6"  helptopic="mshelp://windows/?id=e28526df-4677-4fcb-bd6f-ad757e0afc02" displayname="@werconcpl.dll,-401" canonicalname="pageResponseArchive" /></pagedefinition> <pagedefinition><properties elementprovider="{C3A43F75-FE02-47d8-B3EE-0B568C0C5043}" initializer="{CACA7238-3C7E-4a25-AD73-DE1A4F8C7214}"  layout="110" icon="werconcpl.dll,-6"  helptopic="mshelp://windows/?id=ec44b3b6-0b87-4650-bd6c-9bcfdab45b28" displayname="@werconcpl.dll,-408" canonicalname="pageReliabilityView" /></pagedefinition> <pagedefinition><properties elementprovider="{C3A43F75-FE02-47d8-B3EE-0B568C0C5043}" initializer="{CACA7238-3C7E-4a25-AD73-DE1A4F8C7214}"  layout="106" icon="werconcpl.dll,-6"  displayname="@werconcpl.dll,-400" helptopic="mshelp://windows/?id=ef51691a-38e1-4c72-9d90-6e22f413ba3b" canonicalname="pageProblems" /><childpages><pagedefinition><properties elementprovider="{C3A43F75-FE02-47d8-B3EE-0B568C0C5043}" initializer="{CACA7238-3C7E-4a25-AD73-DE1A4F8C7214}"  layout="102" icon="werconcpl.dll,-6"  displayname="@werconcpl.dll,-403" helptopic="mshelp://windows/?id=743033cd-a522-4e37-8312-7d606c2737eb" canonicalname="pageReportDetails" /></pagedefinition> <pagedefinition><properties elementprovider="{C3A43F75-FE02-47d8-B3EE-0B568C0C5043}" initializer="{CACA7238-3C7E-4a25-AD73-DE1A4F8C7214}"  layout="107" icon="werconcpl.dll,-6"  displayname="@werconcpl.dll,-404" helptopic="mshelp://help/?id=escalation" canonicalname="pageDisplaySolution" /><childpages><pagedefinition><properties elementprovider="{C3A43F75-FE02-47d8-B3EE-0B568C0C5043}" initializer="{CACA7238-3C7E-4a25-AD73-DE1A4F8C7214}"  layout="105" icon="werconcpl.dll,-6"  displayname="@werconcpl.dll,-405" helptopic="mshelp://windows/?id=ef51691a-38e1-4c72-9d90-6e22f413ba3b" canonicalname="pageSolutionDetails" /></pagedefinition> </childpages> </pagedefinition> </childpages> </pagedefinition> <pagedefinition><properties elementprovider="{C3A43F75-FE02-47d8-B3EE-0B568C0C5043}" initializer="{CACA7238-3C7E-4a25-AD73-DE1A4F8C7214}"  layout="107" icon="werconcpl.dll,-6"  displayname="@werconcpl.dll,-404" helptopic="mshelp://help/?id=escalation" canonicalname="pageDisplaySolution" /><childpages><pagedefinition><properties elementprovider="{C3A43F75-FE02-47d8-B3EE-0B568C0C5043}" initializer="{CACA7238-3C7E-4a25-AD73-DE1A4F8C7214}"  layout="105" icon="werconcpl.dll,-6"  displayname="@werconcpl.dll,-405" helptopic="mshelp://windows/?id=ef51691a-38e1-4c72-9d90-6e22f413ba3b" canonicalname="pageSolutionDetails" /></pagedefinition> </childpages> </pagedefinition> <pagedefinition><properties elementprovider="{C3A43F75-FE02-47d8-B3EE-0B568C0C5043}" initializer="{CACA7238-3C7E-4a25-AD73-DE1A4F8C7214}"  layout="104" icon="werconcpl.dll,-6"  displayname="@werconcpl.dll,-402" helptopic="mshelp://windows/?id=ef51691a-38e1-4c72-9d90-6e22f413ba3b" canonicalname="pageSignoff" /><childpages><pagedefinition><properties elementprovider="{C3A43F75-FE02-47d8-B3EE-0B568C0C5043}" initializer="{CACA7238-3C7E-4a25-AD73-DE1A4F8C7214}"  layout="102" icon="werconcpl.dll,-6"  displayname="@werconcpl.dll,-403" helptopic="mshelp://windows/?id=743033cd-a522-4e37-8312-7d606c2737eb" canonicalname="pageReportDetails" /></pagedefinition> </childpages> </pagedefinition> <pagedefinition><properties elementprovider="{C3A43F75-FE02-47d8-B3EE-0B568C0C5043}" initializer="{CACA7238-3C7E-4a25-AD73-DE1A4F8C7214}"  layout="103" icon="werconcpl.dll,-6"  displayname="@werconcpl.dll,-406" helptopic="mshelp://windows/?id=5569a7bb-b6c5-4985-b5ab-c3cf224eae69" canonicalname="pageSettings" /><childpages><pagedefinition><properties elementprovider="{C3A43F75-FE02-47d8-B3EE-0B568C0C5043}" initializer="{CACA7238-3C7E-4a25-AD73-DE1A4F8C7214}"  layout="109" icon="werconcpl.dll,-6"  displayname="@werconcpl.dll,-407" helptopic="mshelp://windows/?id=ef51691a-38e1-4c72-9d90-6e22f413ba3b" canonicalname="pageAdvSettings" /></pagedefinition> </childpages> </pagedefinition> <pagedefinition><properties elementprovider="{C3A43F75-FE02-47d8-B3EE-0B568C0C5043}" initializer="{CACA7238-3C7E-4a25-AD73-DE1A4F8C7214}"  layout="102" icon="werconcpl.dll,-6"  displayname="@werconcpl.dll,-403" helptopic="mshelp://windows/?id=743033cd-a522-4e37-8312-7d606c2737eb" canonicalname="pageReportDetails" /></pagedefinition> <pagedefinition><properties elementprovider="{C3A43F75-FE02-47d8-B3EE-0B568C0C5043}" initializer="{CACA7238-3C7E-4a25-AD73-DE1A4F8C7214}"  layout="105" icon="werconcpl.dll,-6"  displayname="@werconcpl.dll,-405" helptopic="mshelp://windows/?id=ef51691a-38e1-4c72-9d90-6e22f413ba3b" canonicalname="pageSolutionDetails" /></pagedefinition> <pagedefinition><properties elementprovider="{C3A43F75-FE02-47d8-B3EE-0B568C0C5043}" initializer="{CACA7238-3C7E-4a25-AD73-DE1A4F8C7214}"  layout="109" icon="werconcpl.dll,-6"  displayname="@werconcpl.dll,-407" helptopic="mshelp://windows/?id=ef51691a-38e1-4c72-9d90-6e22f413ba3b" canonicalname="pageAdvSettings" /></pagedefinition> <pagedefinition><properties elementprovider="{6B34D24A-213B-4929-A8A1-F0A94EBDC8BF}" initializer="{2B1C6F4F-4F0D-490F-8D88-A3EAF66130AC}" layout="201"  icon="ActionCenterCPL.dll,-1" displayname="@maintenanceui.dll,-1"  canonicalname="MaintenanceSettings" /></pagedefinition> <pagedefinition><properties elementprovider="{4CEB9E2B-71A6-4364-9A0C-0237A1D9FDEF}" initializer="{2684E792-A2C5-4B47-9488-C5D38EEA9321}" layout="211" icon="genuinecenter.dll,-1" displayname="@genuinecenter.dll,-1002" helptopic="mshelp://windows/?id=4c0a49ef-9ac8-4acc-93b0-080dacda8ea1" canonicalname="genuinecenter" /></pagedefinition> </childpages> </pagedefinition> 
