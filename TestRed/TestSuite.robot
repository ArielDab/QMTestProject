*** Settings ***
Library    SeleniumLibrary
Library    WebDriverManagerRobot.py
# Library    pabo
Suite Setup    Open Browser With Given Url And Browser   ${tested_web_url}    ${browser}
Suite Teardown        Close All Browsers 
*** Variables ***
${browser}    chrome
${tested_web_url}    http://www.qualityminds.de
#expected
${expected_mailto_value}    mailto:hello@qualityminds.com
${expected_download_flyer_value}    https://qualityminds.de/app/uploads/2018/11/Find-The-Mobile-Bug-Session.pdf
${expected_file_name_to_be_uploaded}    test.txt
#buttons
${button_cookies_allow}    //a[@class='cc-btn cc-allow']
${button_kontakt_main_xpath}    //ul[@id='top-menu']//a[contains(text(),'Kontakt')]
${button_kontakt_mail_xpath}    //a[contains(text(),'Kontakt aufnehmen')]
${mail_kontakt_xpath}    //*[contains(text(),'hello@qualityminds.de')]
${button_portfolio_main_xpath}    //ul[@id='top-menu']//a[contains(text(),'Portfolio')]//..
${button_portfolio_submenu_webautoandmobile_xpath}    //ul[@id='top-menu']//a[contains(text(),'Web, Automation & Mobile Testing')]
${button_portfolio_webautoandmobile_mobile_xpath}    //div[@id='team-tab-three-title-desktop']//div[@class='sb_mod_acf_single_item clearfix'][contains(text(),'Mobile')]
${button_portfolio_webautoandmobile_mobile_flyer_downl_xpath}    //a[contains(text(),'Flyer Find the Bug Session')]
${button_main_kariere_xpath}    //ul[@id='top-menu']//a[contains(text(),'Karriere')]
${button_kariere_bewirb_dich_jetztz}    //a[contains(text(),'Bewirb dich jetzt!')]
${button_kontaktformular_jetzt_bewerben_xpath}    //input[@type='submit']
${button_kontaktformular_DateienHochladen}    //input[@type='file']
${expected_file_to_be_uploaded_xpath}    //span[contains(text(),'${expected_file_name_to_be_uploaded}')]
#labels,warnings,etc
${warning_not_accepted}    //*[contains(text(),'Dies ist ein Pflichtfeld.')]
#inputs
${input_kontaktformular_Vorname}    //input[@placeholder='Vorname*']
${input_kontaktformular_Nachname}    //input[@placeholder='Nachname*']
${input_kontaktformular_Email}    //input[@placeholder='Email*']
#file upload classes
${upload_class_dateienhochladen}    class=btn btn-block
#checkboxes
${checkbox_kontaktformular_xpath}    //input[@type='checkbox']

*** Keywords ***
Go To Main Page
    Go To    ${tested_web_url}
Open Browser With Given Url And Browser
    [Arguments]    ${tested_web_url}    ${browser}
    Download Newest Driver    ${browser}
    Open Browser    ${tested_web_url}    ${browser}
    Set Window Size    1400   800
    Run Keyword And Ignore Error    Click Element    xpath:${button_cookies_allow}
Download Newest Driver
    [Arguments]    ${browser}    ${path}=${None}
    ${current_path}    Set Variable If    ${path}==${None}    ${CURDIR}    ${path}
    Log    ${current_path}
    Download Newest Webdriver    ${current_path}    ${browser}
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### #### ### ### ### ### ### ###
Click Submit Button Kontakt Formular
    Wait Until Element Is Enabled   xpath:${button_kontaktformular_jetzt_bewerben_xpath}
    # Scroll Element Into View    xpath=${button_kontaktformular_jetzt_bewerben_xpath}
    Click Element    xpath:${button_kontaktformular_jetzt_bewerben_xpath}
Verify that “Kontakt aufnehmen” button links to email hello@qualityminds_de
    #tc1_stp2
    ${mail_button_value}    Get Element Attribute    xpath:${button_kontakt_mail_xpath}    href
    ${tc1_stp2_fail_msg}    Set Variable    At main page for kontakt button there is value [${mail_button_value}], should be [${expected_mailto_value}]
    Run Keyword And Continue On Failure   Run Keyword If	'${mail_button_value}'!='${expected_mailto_value}'    Fail    ${tc1_stp2_fail_msg}
Verify that the page contains same email address
    #tc1_stp4
    [Arguments]    ${current_location}
    ${status_mail_kontakt}    Run Keyword And Return Status    Get WebElement    ${mail_kontakt_xpath}
    ${tc1_stp4_fail_msg}    Set Variable    On ${current_location} there is no [${expected_mailto_value}] text.
    Run Keyword And Continue On Failure   Run Keyword If    ${status_mail_kontakt}==False    Fail    ${tc1_stp4_fail_msg}
Verify that the Portfolio menu is hightlighted
    #tc2_stp4
    Wait Until Element Is Visible   xpath:${button_portfolio_main_xpath}    
    ${class_values}    Get Element Attribute    xpath:${button_portfolio_main_xpath}    class
    ${status_highlighted_value}    Run Keyword And Return Status    Should Contain    ${class_values}    current-menu-ancestor
    ${tc2_stp4_fail_msg}    Set Variable    Porfolio button is not hightlighted
    Run Keyword And Continue On Failure   Run Keyword If    ${status_highlighted_value}==False    Fail    ${tc2_stp4_fail_msg}
Verify the download link for the flyer
    #tc2_stp6
    ${button_value_href}    Get Element Attribute    ${button_portfolio_webautoandmobile_mobile_flyer_downl_xpath}    href
    ${tc2_stp6_fail_msg}    Set Variable    There is [${button_value_href}] but should be ${expected_download_flyer_value}
    Run Keyword And Continue On Failure    Run Keyword If    '${button_value_href}'!='${expected_download_flyer_value}'    Fail   ${tc2_stp6_fail_msg}         
Verify if file is available via download link
    #tc2_stp7
    ${button_value_href}    Get Element Attribute    ${button_portfolio_webautoandmobile_mobile_flyer_downl_xpath}    href
    ${status_ok}    Run Keyword And Return Status    Go To    ${button_value_href}
    ${tc2_stp7_fail_msg}    Set Variable    
    Run Keyword And Continue On Failure    Run Keyword If    ${status_ok}==False    Fail    ${tc2_stp7_fail_msg}
Verify the correct warnig message is displayed
    #tc3_stp5
    ${warning_status}    Run Keyword And Return Status    Page Should Contain Element    xpath:${warning_not_accepted}      
    ${tc3_stp5_fail_msg}    Set Variable    There is no warnig status.
    Run Keyword And Continue On Failure    Run Keyword If    ${warning_status}==False   Fail   ${tc3_stp5_fail_msg}  
Attach file with Weiter Dateien hochaden button
    #tc3_stp11
    # Click Element    xpath:${button_kontaktformular_DateienHochladen}
    Choose File    xpath:${button_kontaktformular_DateienHochladen}    ${CURDIR}\\${expected_file_name_to_be_uploaded}
    ${upload_file_status}    Run Keyword And Return Status    Wait Until Element Is Visible    xpath:${expected_file_to_be_uploaded_xpath}
    ${tc3_stp11_fail_msg}    Set Variable    There is no uploaded file - [${expected_file_name_to_be_uploaded}]
    Run Keyword And Continue On Failure    Run Keyword If    ${upload_file_status}==False   Fail   ${tc3_stp11_fail_msg}
*** Test Cases ***
Test case 1
    [Setup]    Go To Main Page
    #step 2
    Verify that “Kontakt aufnehmen” button links to email hello@qualityminds_de
    #step 3
    Click Element    xpath:${button_kontakt_main_xpath}
    ${current_location}    Get Location
    #step 4
    Verify that the page contains same email address    ${current_location}
Test case 2
    [Setup]    Go To Main Page
    #step 2
    Wait Until Element Is Visible    xpath:${button_portfolio_main_xpath}    
    Mouse Over    xpath:${button_portfolio_main_xpath}
    #step 3
    Wait Until Element Is Visible        xpath:${button_portfolio_submenu_webautoandmobile_xpath}
    Click Element    xpath:${button_portfolio_submenu_webautoandmobile_xpath}
    #step 4
    Verify that the Portfolio menu is hightlighted
    #step 5
    Wait Until Element Is Visible    xpath:${button_portfolio_webautoandmobile_mobile_xpath}    
    Click Element    xpath:${button_portfolio_webautoandmobile_mobile_xpath}
    #step 6
    Verify the download link for the flyer
    #step 7
    Verify if file is available via download link
Test Case 3
    [Setup]    Go To Main Page
    #step 2
    Wait Until Element Is Visible    xpath:${button_main_kariere_xpath}
    Click Element    xpath:${button_main_kariere_xpath}
    #step 3
    Wait Until Element Is Visible    xpath:${button_kariere_bewirb_dich_jetztz}
    Click Element    xpath:${button_kariere_bewirb_dich_jetztz}
    #step 4
    Click Submit Button Kontakt Formular
    #step 5
    Verify the correct warnig message is displayed
    #step 6
    Input Text    xpath:${input_kontaktformular_Vorname}    Ariel
    #step 7
    Click Submit Button Kontakt Formular
    #step 8
    Verify the correct warnig message is displayed
    #step 9
    Input Text    xpath:${input_kontaktformular_Email}    dabkowski.ariel@gmail.com
    #step 10
    Click Submit Button Kontakt Formular
    #step 11
    Attach file with Weiter Dateien hochaden button
    #step 12
    Click Element    xpath:${checkbox_kontaktformular_xpath}
       
    
    