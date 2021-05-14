*** Keywords ***

Test Navigates to chrome Home Page

Begin WebTest

    OPEN BROWSER                                       about:blank                         ${BROWSER}
    #Maximize Browser Window

Go To Web Page
     Load Page
     Verify Page Loaded

Load Page
     Go to                                            ${URL}

Verify Page Loaded
    ${actualTerm}                                     get text                          xpath:/html/body/app-root/app-welcome/h1
    Should Be Equal                                   ${Welcome_Message}                ${actualTerm}

All Owners
    Click Element                                    xpath:/html/body/app-root/div[1]/nav/div/ul/li[2]/a
    Click Element                                    xpath:/html/body/app-root/div[1]/nav/div/ul/li[2]/ul/li[1]/a
    Wait until page contains                         Owners

Select A Owner From The List
    Wait until page contains element                 xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[9]/td[1]/a
    Click Element                                    xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[9]/td[1]/a


Add New Pet
     Wait until page contains                        Owner Information
     Click Element                                   xpath:/html/body/app-root/app-owner-detail/div/div/button[3]

Input New Pet Detalis
    Wait until page contains                         Add Pet
    Click Element                                    id=name

Pet Details
    [Arguments]                                      ${Pet_Name}                          ${Birth_Date}
    Name                                             ${Pet_Name}
    Birth Date                                       ${Birth_Date}
    Click Element                                    id=type
    Click Element                                    xpath://*[@id="type"]/option[2]
    Click Element                                    xpath:/html/body/app-root/app-pet-add/div/div/form/div[6]/div/button[2]
    Wait until page contains                         Owner Information

Name
    [Arguments]                                       ${Pet_Name}
    Input Text                                        id=name                             ${Pet_Name}

Birth Date
    [Arguments]                                       ${Birth_Date}
    Input Text                                        xpath:/html/body/app-root/app-pet-add/div/div/form/div[4]/div/input          ${Birth_Date}

#-----------------------------------------

Verify Pet Adedd To owner
   Wait until page contains                          Owner Information
   ${pet_added}                                      get text                             xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list[2]/table/tr/td[1]/dl/dd[1]
   Should Contain                                    ${Verify_Pet_Added_1}                 ${pet_added}
   Delete Pet After Verifying

Delete Pet After Verifying
    Wait until page contains                         Owner Information
    Click Element                                    xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list[2]/table/tr/td[1]/dl/button[2]

#------------------------------------

Verify Pet Added To Invalid Owner
    Click Element                                    xpath:/html/body/app-root/div[1]/nav/div/ul/li[2]/a
    #Click Element                                   xpath:/html/body/app-root/div[1]/nav/div/ul/li[2]/ul/li[1]/a/span[2]
    Click Element                                    xpath:/html/body/app-root/div[1]/nav/div/ul/li[2]/ul/li[1]/a
    Wait until page contains                         Owners
    Sleep                                            0.1 s
    Click Element                                    xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[3]/td[1]/a
    ${link_text}                                    Get Title
    Should Not Be Equal                             ${Verify_Pet_Added_1}                  ${link_text}
    Delete Pet After Verifying in Invalid Owner

Delete Pet After Verifying in Invalid Owner

    All Owners
    Select A Owner From The List
    Wait until page contains                        Owner Information
    Delete Pet After Verifying

#--------------------------------
Verifying Pet Can Add Multiple Times

    ${2nd_Pet_Added}                                get text                             xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list[2]/table/tr/td[1]/dl/dd[1]
    Should Be Equal                                 ${Verify_Pet_Added_2}                  ${2nd_Pet_Added}
    Delete Pet After Adding multiple Times And Verifying

Delete Pet After Adding multiple Times And Verifying
    Wait until page contains                        Owner Information
    Click Element                                   xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list[2]/table/tr/td[1]/dl/button[2]
    #Click Back Button
    Click Element                                   xpath:/html/body/app-root/app-owner-detail/div/div/button[1]

    Select A Owner From The List
    Wait until page contains                        Owners
    Click Element                                   xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list[3]/table/tr/td[1]/dl/button[2]
    Click Element                                   xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list[2]/table/tr/td[1]/dl/button[2]

Deleting A Newly Added pet
    Wait until page contains                        Owner Information
    Click Element                                   xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list[2]/table/tr/td[1]/dl/button[2]
    Verify Pet deleted

Verify Pet deleted

    ${Verify_DeletedPet}                            Get Title
    Should Not Be Equal                             ${Verify_Pet_Added_4}                  ${Verify_DeletedPet}

#-------------------------------------------------------------------------------------------------------------------------

Edit Owner
    Wait until page contains                        Owner Information
    Click Element                                   xpath:/html/body/app-root/app-owner-detail/div/div/button[2]

Owner New Detalis
    [Arguments]                                    ${OwnerNew_Adress}                    ${OwnerNew_City}                    ${OwnerNew_Telephone}
    Wait until page contains                       Edit Owner
    Adress                                         ${OwnerNew_Adress}
    City                                           ${OwnerNew_City}
    Telephone                                      ${OwnerNew_Telephone}
    Click Element                                  xpath:/html/body/app-root/app-owner-edit/div/div/form/div[7]/div/button[2]

Adress
    [Arguments]                                    ${OwnerNew_Adress}
    Input Text                                     id=address                             ${OwnerNew_Adress}

City
    [Arguments]                                    ${OwnerNew_City}
    Input Text                                     id=city                               ${OwnerNew_City}

Telephone
    [Arguments]                                    ${OwnerNew_Telephone}
    Input Text                                     id=telephone                          ${OwnerNew_Telephone}

Verify Owner New Detalis Added
    Wait until page contains                       Owner Information
    ${OwnerNew_Details_Added}                      get text                             xpath:/html/body/app-root/app-owner-detail/div/div/table[1]/tr[2]/td
    Should Be Equal                                ${New_Adress}                        ${OwnerNew_Details_Added}

Verify Erorr Message Displayed Or Not
   ${Invalid_PhoneNo}                              get text                              xpath:/html/body/app-root/app-owner-edit/div/div/form/div[6]/div/span[2]
    Should Contain                                 ${ErorrMessage_AcceptsDigits}         ${Invalid_PhoneNo}

#--------------------------------------

Owner Detalis With Empty Box
    Clear element text                             xpath://*[@id="address"]
    Click element                                  xpath://*[@id="address"]
    Press Keys                                     xpath://*[@id="address"]               a    BACKSPACE
    [Arguments]                                    ${OwnerNew_Telephone}
    Only TelephoneNo                               ${OwnerNew_Telephone}

Only TelephoneNo
    [Arguments]                                    ${OwnerNew_Telephone}
    Input Text                                     id=telephone                          ${OwnerNew_Telephone}

Verify Erorr Messages With Red Box
   ${Required_message}                             get text                              xpath:/html/body/app-root/app-owner-edit/div/div/form/div[4]/div/span[2]
    Should Match                                 ${ErorrMessge_Required}                 ${Required_message}

#------------------------------------------------------------------------------------------------------------------------

that the user is on the landing page

    Go To Web Page

a user Creates a new owner

    Click Element                                  xpath://a[contains(text(),'Owners')]
    wait until page contains                       Owners
    Click Element                                  xpath://a[contains(text(),'Owners')]/../ul/li[2]/a
    wait until page contains                       Owners
    Input Text                                     id=firstName                           ${Firstname}
    Input Text                                     id=lastName                            ${Lastname}
    Input Text                                     id=address                             ${Adress1}
    Input Text                                     id=city                                ${City1}
    Input Text                                     id=telephone                           ${Mobile1}
    Click Element                                  xpath://div/button[contains(string(), "Add Owner")]

a new owner should be created

    Click Element                                 xpath://a[contains(text(),'Owners')]
    wait until page contains                      Owners
    Click Element                                 xpath://a/span[contains(text(),'All')]
    page should contain                           ${Firstname}

#--------------------------------
#test 2

that the user has acces to the web page
    Go To Web Page

a user creates a new owner with variables instead of letters

    Click Element                                xpath://a[contains(text(),'Owners')]
    wait until page contains                     Owners
    Click Element                                xpath://a[contains(text(),'Owners')]/../ul/li[2]/a
    wait until page contains                     Owners
    Input Text                                   id=firstName                              ${Firstname2}
    Input Text                                   id=lastName                               ${Firstname2}
    Input Text                                   id=address                                ${Adress2}
    Input Text                                   id=city                                   ${City2}
    Input Text                                   id=telephone                              ${Mobile2}
    Click Element                                xpath://div/button[contains(string(), "Add Owner")]

a new owner should be added to the list

    Click Element                                xpath://a[contains(text(),'Owners')]
    wait until page contains                     Owners
    Click Element                                xpath://a/span[contains(text(),'All')]
    wait until page contains                     All
    Page should contain                          ${Firstname2}

#_____________________________________
#test 3

user is on the landing page
    Go To Web Page

the user Creates a new owner

    Click Element                               xpath://a[contains(text(),'Owners')]
    wait until page contains                    Owners
    Click Element                               xpath://a[contains(text(),'Owners')]/../ul/li[2]/a
    wait until page contains                    Owners

put already existing personal data

    Input Text                                  id=firstName                                 ${Firstname}
    Input Text                                  id=lastName                                  ${Lastname}
    Input Text                                  id=address                                   ${Adress1}
    Input Text                                  id=city                                      ${City1}
    Input Text                                  id=telephone                                 ${Mobile1}
    Click Element                               xpath://div/button[contains(string(), "Add Owner")]

a duplicate of the owner should be added

    Click Element                              xpath://a[contains(text(),'Owners')]
    wait until page contains                   Owners
    Click Element                              xpath://a/span[contains(text(),'All')]
    page should contain                        ${Firstname}

#___________________________________
#test4

user is located on landing page

    Go To Web Page

the user creates new owner

    Click Element                            xpath://a[contains(text(),'Owners')]
    wait until page contains                 Owners
    Click Element                            xpath://a[contains(text(),'Owners')]/../ul/li[2]/a
    wait until page contains                 Owners

use special signs for input in name field

    Click Element                            xpath://a[contains(text(),'Owners')]
    wait until page contains                 Owners
    Click Element                            xpath://a[contains(text(),'Owners')]/../ul/li[2]/a
    wait until page contains                 Owners
    Input Text                               id=firstName                                   ${Firstname3}
    Input Text                               id=lastName                                    ${Lastname3}
    Input Text                               id=address                                     ${Adress2}
    Input Text                               id=city                                        ${City2}
    Input Text                               id=telephone                                   ${Mobile2}
    Click Element                            xpath://div/button[contains(string(), "Add Owner")]

the new owner should be created

    Click Element                           xpath://a[contains(text(),'Owners')]
    wait until page contains                Owners
    Click Element                           xpath://a/span[contains(text(),'All')]
    wait until page contains                All
    Page should contain                     ${Firstname3}

#------------------------------------------------------------------------------------------------------------------------

Select an owner
     Wait until page contains                      Owners
     ${Expecting_Owner1}                           Get Text    xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[8]/td[1]/a
     ${Expecting_Pet1}                             Get Text    xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[8]/td[5]/tr
     Click element                                 xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[8]/td[1]/a

Inspect same owner and pet but click on different owner

     ${Expecting_Owner1}                           Get Text    xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[8]/td[1]/a
     ${Expecting_Pet1}                             Get Text    xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[8]/td[5]/tr

Click on different owner
     Wait until page contains                      Owners
     Click element                                 xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[7]/td[1]/a

Inspect on one owner and other's pet but click on same owner
     Wait until page contains                      Owners
     ${Expecting_Owner2}                           Get Text    xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[9]/td[1]/a
     ${Expecting_Pet2}                             Get Text    xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[5]/td[5]/tr
     Click element                                 xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[4]/td[1]/a

Select an owner with 2 pets
     Wait until page contains                    Owners
     ${Expecting_Owner3}                         Get Text    xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[3]/td[1]/a
     ${Expecting_PetA}                           Get Text    xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[3]/td[5]/tr[1]
     ${Expecting_PetB}                           Get Text    xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[3]/td[5]/tr[2]
     Click element                               xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[3]/td[1]/a

Verify selected Owner is with rightful pet 1
     Wait until page contains                      Owner Information
     ${Actual_Pet1}                                Get Text     xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[1]/dl/dd[1]
     ${Actual_Owner1}                              Get Text     xpath:/html/body/app-root/app-owner-detail/div/div/table[1]/tr[1]/td/b
     Should Be Equal                               ${Expecting_Owner1}${Expecting_Pet1}    ${Actual_Owner1}${Actual_Pet1}

Verify selected Owner is not with rightful pet 1 or test case fails
     Wait until page contains                      Owner Information
     ${Actual_Pet1}                                 Get Text      xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[1]/dl/dd[1]
     ${Actual_Owner1}                               Get Text       xpath:/html/body/app-root/app-owner-detail/div/div/table[1]/tr[1]/td/b
     #Should Be Equal                                ${Expecting_Owner1}${Expecting_Pet1}    ${Actual_Owner1}${Actual_Pet1}
     Should Not Be Equal                            ${Expecting_Owner1}${Expecting_Pet1}    ${Actual_Owner1}${Actual_Pet1}

Verify selected Owner is not with rightful pet 2 or testcase fails
     Wait until page contains                      Owner Information
     ${Actual_Pet2}                                 Get Text       xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[1]/dl/dd[1]
     ${Actual_Owner2}                               Get Text       xpath:/html/body/app-root/app-owner-detail/div/div/table[1]/tr[1]/td/b
    #Should Be Equal(testcase fails)                ${Expecting_Owner2}${Expecting_Pet2}    ${Actual_Owner2} ${Actual_Pet2}
     Should Not Be Equal                            ${Expecting_Owner2}${Expecting_Pet2}    ${Actual_Owner2} ${Actual_Pet2}

Verify whether selected Owner is with rightful pet(2 pets)
     Wait until page contains                      Owner Information
     ${Actual_PetA}                              Get Text     xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list[1]/table/tr/td[1]/dl/dd[1]
     ${Actual_PetB}                              Get Text     xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list[2]/table/tr/td[1]/dl/dd[1]
     ${Actual_Owner3}                            Get Text     xpath:/html/body/app-root/app-owner-detail/div/div/table[1]/tr[1]/td/b
     Should Be Equal                             ${Expecting_Owner3}${Expecting_PetA}${Expecting_PetB}     ${Actual_Owner3}${Actual_PetA}${Actual_PetB}

#------------------------------------
#Add Pet Type - Jonna

Go to Pet Types

    User is on the landing page
    Click element                                 xpath:/html/body/app-root/div[1]/nav/div/ul/li[4]/a/span[2]
    Verify on the right page

Verify on the right page

    ${Actual_Pettypes_Page}                       Get Text    xpath:/html/body/app-root/app-pettype-list/div/div/h2
    Should be equal                               ${Actual_Pettypes_Page}   ${Expected_Pettypes_Page}

Add a new Pet Type

    Click button                                  xpath:/html/body/app-root/app-pettype-list/div/div/div/button[2]
    Wait until page contains                      New Pet Type
    Click element                                 id:name
    Input Text                                    id:name           ${New_Pettype_Name}
    Click element                                 xpath://*[@id="pettype"]/div[2]/div/button

Verify added Pet Type

    ${Actual_Pettype_Name}                        Get Value     xpath://*[@id="6"]
    Should be equal                               ${Actual_Pettype_Name}    ${New_Pettype_Name}

Teardown Add New Pet Type

    Click button                                  xpath://*[@id="pettypes"]/tbody/tr[7]/td[2]/button[2]
    Wait until page contains                      Pet Types
    Page should not contain element               xpath://*[@id="6"]

#Gherkin Syntax for Add New Pet Type:

user is on the Pet Types page

  Go to Pet Types

a user have added a new Pet Type

  Add a new Pet Type

a user should be able to see the new Pet Type in the list

  Verify added Pet Type
  Teardown Add New Pet Type

#Add existing Pet Type - Jonna

Add existing pet

   Click button                                  xpath:/html/body/app-root/app-pettype-list/div/div/div/button[2]
   Wait until page contains                      New Pet Type
   Click element                                 id:name
   Input Text                                    id:name           ${Existing_Pettype_Name}
   Click element                                 xpath://*[@id="pettype"]/div[2]/div/button

Verify added existing Pet Type

   ${Actual_New_Pettype_Name}                    Get Value     xpath://*[@id="6"]
   Should be equal                               ${Actual_New_Pettype_Name}    ${Existing_Pettype_Name}

a user has added a new Pet Type that already exists

  Add existing pet

a user should see two fields with the same Pet Type

  Verify added existing Pet Type
  Teardown Add New Pet Type

#--------------------------------------------------------------------------------------------------------------------------
#Change/Edit Pet Type

User Clicks On PetTypes
        Go To Web Page
        Click Element                                    xpath://html/body/app-root/div[1]/nav/div/ul/li[4]/a

User Edit's A Pet Type
        Wait until page contains                         Pet Types
        Click element                                    xpath://*[@id="pettypes"]/tbody/tr[4]/td[2]/button[1]
        Wait until page contains                         Edit Pet Type
        Input Text                                       id=name                              ${New_Edited_PetType_Name}
        Click Element                                    xpath://*[@id="pettype"]/div[2]/div/button[1]
        TearDown After Verifying

User Verifies Edited Pet Added
       Wait until page contains                         Pet Types
       ${Edited_PetType_Updated}                        Get Text                               xpath://*[@id="3"]
       Should Contain                                   ${New_Edited_PetType_Name}              ${Edited_PetType_Updated}

TearDown After Verifying
        Wait until page contains                         Pet Types
        Click Element                                    xpath://*[@id="pettypes"]/tbody/tr[4]/td[2]/button[1]
        Input Text                                       id=name                              ${Actual_PetType_Name}
        Click Element                                    xpath://*[@id="pettype"]/div[2]/div/button[1]

User Edit's PetTypes with Same Name
        Wait until page contains                         Pet Types
        Click Element                                    xpath://*[@id="pettypes"]/tbody/tr[4]/td[2]/button[1]
        Input Text                                       id=name                              ${New_Edited_PetType_Name}
        Click Element                                    xpath://*[@id="pettype"]/div[2]/div/button[1]
        Wait until page contains                         Pet Types
        Click Element                                    xpath://*[@id="pettypes"]/tbody/tr[6]/td[2]/button[1]
        Input Text                                       id=name                              ${New_Edited_PetType_Name}
        Click Element                                    xpath://*[@id="pettype"]/div[2]/div/button[1]

User Verifies Same Pet Type Name Can Add Multiple Times
        Wait until page contains                         Pet Types
        User Verifies Edited Pet Added
        ${link_text}                                    Get Value                            xpath://*[@id="5"]
        Should Not Be Equal                             ${Verify_Old_PetType_existed}        ${link_text}
        TearDown After Verifying
        TearDown Second Edited PetType After Verifying

TearDown Second Edited PetType After Verifying
        Wait until page contains                         Pet Types
        Click Element                                    xpath://*[@id="pettypes"]/tbody/tr[6]/td[2]/button[1]
        Input Text                                       id=name                              ${Second_petType_Acutal_name}
        Click Element                                    xpath://*[@id="pettype"]/div[2]/div/button[1]

#-------------------------------------------------------------------------------------------------------------------------
#Home Button From Veterinarians

User Clicks On Veterinarians Page
        Go To Web Page
        Click Element                                   xpath:/html/body/app-root/div[1]/nav/div/ul/li[3]/a
User Selects All Veterinarians
        User Clicks On Veterinarians Page
        Click Element                                   xpath:/html/body/app-root/div[1]/nav/div/ul/li[3]/ul/li[1]/a

User Is At Veterinarians Page
        Page Should Contain button                      Home

User Can Go Back To Home Page
        Wait until page contains                        Veterinarians
        Sleep                                           0.1 s
        Click Button                                    xpath:/html/body/app-root/app-vet-list/div/div/div/button[1]

User Back To Home Page
      Wait until page contains                           ${Welcome_Message}
      Page should Contain                                ${Welcome_Message}

User Clicks On Edit Vet
       Wait until page contains                         Veterinarians
       Click Element                                    xpath://*[@id="vets"]/tbody/tr[5]/td[3]/button[1]
       #Page should Contain Element                      xpath://*[@id="vet_form"]/div[5]/div/button[2]
       Wait until page contains                         Edit Veterinarian
       Page Should Not Contain Button                   Home
       Click Element                                    xpath://*[@id="vet_form"]/div[5]/div/button[2]
       User Can Go Back To Home Page

User Clicks On Add New
        User Clicks On Veterinarians Page
        Click Element                                   xpath:/html/body/app-root/div[1]/nav/div/ul/li[3]/ul/li[2]/a/span[2]
        Wait until page contains                        New Veterinarian
        Page Should Not Contain Button                  Home
        Click Element                                   xpath://*[@id="vet"]/div[5]/div/button[1]

#-----------------------------------------------------------------------------------
#Edit pet: Isac

Go to list of owners

    Go to Web Page
    All Owners

Click on a owner

    Wait until page contains                        Owners
    Click Element                                   xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[1]/td[1]/a
    ${EXPECTED_OWNER}                               Get Text    xpath:/html/body/app-root/app-owner-detail/div/div/table[1]/tr[1]/td/b
    Should Be Equal                                 ${EXPECTED_OWNER}   ${CONFIGURED_OWNER}

Click edit on it's pet

    Click Element                                   xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[1]/dl/button[1]

Edit infomation on the pet

    Input Text                                      id=name     ${CONFIGURED_PET}
    ${EXPECTED_PET}                                 Get Value    id=name
    Should Be Equal                                 ${EXPECTED_PET}   ${CONFIGURED_PET}
    Press Keys                                      xpath:/html/body/app-root/app-pet-edit/div/div/form/div[4]/input     CTRL+A   BACKSPACE
    Input Text                                      xpath:/html/body/app-root/app-pet-edit/div/div/form/div[4]/input     ${CONFIGURED_DATE}
    ${EXPECTED_DATE}                                Get Value    xpath:/html/body/app-root/app-pet-edit/div/div/form/div[4]/input
    Should Be Equal                                 ${EXPECTED_DATE}   ${CONFIGURED_DATE}
    Click Element                                   xpath://*[@id="type"]/option[2]
    ${EXPECTED_PET2}                                Get Text    xpath://*[@id="type"]/option[2]
    Should Be Equal                                 ${EXPECTED_PET2}   ${CONFIGURED_PET2}
    Click Element                                   xpath:/html/body/app-root/app-pet-edit/div/div/form/div[6]/div/button[2]

Verify that all information has been edited
    Wait until page contains                        Owner Information
    ${EXPECTED_PET}                                 Get Text    xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[1]/dl/dd[1]
    Should Be Equal                                 ${EXPECTED_PET}     ${CONFIGURED_PET}
    ${EXPECTED_DATE}                                Get Text    xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[1]/dl/dd[2]
    Should Be Equal                                 ${EXPECTED_DATE}    ${CONFIGURED_DATE}
    ${EXPECTED_PET2}                                Get Text    xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[1]/dl/dd[3]
    Should Be Equal                                 ${EXPECTED_PET2}    ${CONFIGURED_PET2}
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Specialty HOME Button by Renu

User Is On Specialities Page
    Go To Web Page
    Wait Until Element Is Visible   xpath://html/body/app-root/div[1]/nav/div/ul/li[5]/a
    click element                   xpath://html/body/app-root/div[1]/nav/div/ul/li[5]/a
    Page Should Contain Element     xpath://*[@id="specialties"]

User Is On Edit Specialities Page
    User Is On Specialities Page
    Page Should Contain Element     xpath://*[@id="specialties"]/tbody/tr[2]/td[2]/button[1]
    Click Button                    xpath://*[@id="specialties"]/tbody/tr[2]/td[2]/button[1]
    Page Should Contain Element     xpath:/html/body/app-root/app-specialty-edit/div/div/h2
    Element Should Be Visible       xpath:/html/body/app-root/app-specialty-edit/div/div/h2
    Page Should Not Contain Button   Home
    #Click Element                   xpath:/html/body/app-root/div[1]/nav/div/ul/li[1]/a/span[2]
    Click Button                    xpath://*[@id="specialty"]/div[2]/div/button[1]

Clicks on Home Button
    page should contain button       Home
    click button                     Home

Comes back to the Home Page
    Page Should Contain             ${WELCOME_MESSAGE}
    Element Should Be Visible       xpath:/html/body/app-root/app-welcome/div/div/div/div/img


#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Remove Pet Visit by Renu

User Clicks Owners
    Go To Web Page
    Wait Until Element Is Visible               xpath:/html/body/app-root/div[1]/nav/div/ul/li[2]/a
    Element Should Be Visible                   xpath:/html/body/app-root/div[1]/nav/div/ul/li[2]/a         # Owners Tab
    Click Element                               xpath:/html/body/app-root/div[1]/nav/div/ul/li[2]/a

Clicks All Owners
    Element Should Be Visible                   xpath://*[@routerlink="/owners"]
    Click Element                               xpath://*[@routerlink="/owners"]
    Page Should Contain Element         xpath:/html/body/app-root/app-owner-list/div/div/h2               #Owners List
    Element Should Be Visible           xpath:/html/body/app-root/app-owner-list/div/div/h2
    Page Should Contain Element         xpath://*[@class="table table-striped"]
    Element Should Be Visible           xpath://*[@class="table table-striped"]

Visit is Added To The Pet
    Wait Until Element Is Visible       xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[2]/td[1]/a
    Element Should Be Visible           xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[2]/td[1]/a
    Click Element                       xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[2]/td[1]/a

    Wait Until Element Is Visible       xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[1]/dl/button[3]
    Element Should Be Visible           xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[1]/dl/button[3]
    Click Element                       xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[1]/dl/button[3]
    Input Text                          //*[@id="visit"]/div[1]/div[1]/div/input    ${VISIT_DATE}
    Input Text                          //*[@id="description"]    ${VISIT_DESCRIPTION}
    Click Button                        //*[@id="visit"]/div[2]/div/button[2]
    Wait Until Page Contains Element    xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list[1]/table/tr/td[1]/dl/dd[2]
    Element Should Be VIsible           xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list[1]/table/tr/td[1]/dl/dd[2]


Deletes Pet Visit
    Wait Until Page Contains Element   xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[2]/app-visit-list/table/tr/td[3]/button[2]
    Element Should Be Visible          xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list[1]/table/tr/td[2]/app-visit-list/table/tr/td[3]/button[2]
    Click Element                      xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[2]/app-visit-list/table/tr/td[3]/button[2]

Verify Visit is Deleted
     Wait Until Element Is Not Visible     ${VISIT_DATE}
     Element Should Not Be Visible         ${VISIT_DATE}
     Wait Until Element Is Not Visible     ${VISIT_DESCRIPTION}
     Element Should Not Be Visible         ${VISIT_DESCRIPTION}

User Selects Owner 6
    User Clicks Owners
    Click Element                               xpath://*[@routerlink="/owners"]
    Page Should Contain Element         xpath:/html/body/app-root/app-owner-list/div/div/h2               #Owners List
    Element Should Be Visible           xpath:/html/body/app-root/app-owner-list/div/div/h2
    Wait Until Element Is Visible       xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[6]/td[1]/a
    Element Should Be Visible           xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[6]/td[1]/a
    Click Element                       xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[6]/td[1]/a

Selects Pet Samantha
    Wait until page contains            Owner Information
    Page Should Contain Element         xpath:/html/body/app-root/app-owner-detail/div/div/h2[2]
    Page Should Contain Element         xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list[2]/table/tr/td[1]/dl/dd[1]
    Element Should Be Visible           xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list[2]/table/tr/td[1]/dl/dd[1]
    Page Should Contain Element         xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list[2]/table/tr/td[2]/app-visit-list/table/tr[2]/td[1]
    Page Should Contain Element         xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list[2]/table/tr/td[2]/app-visit-list/table/tr[2]/td[2]
    #Element Should Be Visible        ${SVISIT_DATE}
    #Element Should Be Visible        ${SVISIT_DESCRIPTION}

Deletes Visit For Rabies Shot
    Page Should Contain Element         xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list[2]/table/tr/td[2]/app-visit-list/table/tr[2]/td[3]/button[2]

    Element Should Be Visible           xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list[2]/table/tr/td[2]/app-visit-list/table/tr[2]/td[3]/button[2]
    Click Button                        xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list[2]/table/tr/td[2]/app-visit-list/table/tr[2]/td[3]/button[2]

Verify Visit is Deleted For Rabies Shot
    Wait Until Element Is Not Visible     ${SVISIT_DATE}
    Element Should Not Be Visible         ${SVISIT_DATE}
    Wait Until Element Is Not Visible     ${SVISIT_DESCRIPTION}
    Element Should Not Be Visible         ${SVISIT_DESCRIPTION}
    Click Button                        xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list[1]/table/tr/td[1]/dl/button[3]
    Input Text                          xpath://*[@id="visit"]/div[1]/div[1]/div/input    ${SVISIT_DATE}
    Input Text                          xpath://*[@id="description"]                      ${SVISIT_DESCRIPTION}
    Click Button                        xpath://*[@id="visit"]/div[2]/div/button[2]

#------------------------------------
#Click on Home button from Owners section - Jonna

Check if button exist                       # BUG CONFIRMED // Remove when Home button exists
  Page should not contain button            ${Home_Button}      # BUG CONFIRMED // Remove when Home button exists

Check each owner if there is a Home button
  ${All_Links_Count}                        Get element count    xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr
  Log                                       ${All_Links_Count}
  @{Owner_Id_List}=                         Create list    ${All_Links_Count}
  FOR    ${Owner_Id}  IN RANGE              @{Owner_Id_List}
    ${Owner_Id}=                            Evaluate      ${Owner_Id}+1
    Click element                           xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[${Owner_Id}]/td[1]/a
    Wait until page contains                Owner Information
    Run Keyword And Continue On Failure     Check if button exist      # BUG CONFIRMED // Remove when Home button exists
    #Run Keyword And Continue On Failure    Click Home button            BUG CONFIRMED // Activate when Home button exists
    User is on Owners page
    Wait until page contains                Owners
  END

Click Home button
  Click button                          ${Home_Button}
  Wait until page contains              ${Welcome_Message}

Verify back on Home Page
  ${Actual_Welcome_Message}             Get text      xpath:/html/body/app-root/app-welcome/h1
  Should be equal                       ${Actual_Welcome_Message}       ${Welcome_Message}


#Gherkin syntax

user is on Owners page
  Go To Web Page
  All owners

user clicks on Home button
  Check if button exist
  #Click Home button                    BUG CONFIRMED // Activate when Home button exists

user should be back on Home Page
  Verify back on Home Page

user clicks on an owner and clicks the Home button
  Check each owner if there is a Home button

#------------------------------------------------------------------------------------------------------------------------------------
#Performance Task

User Adds An Owner
        Go To Web Page
        A User Creates A New Owner
        Wait Until Page Contains                        ${Firstname}
        User Verifies Owner Added
User Verifies Owner Added
        Page Should Contain Element                     xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[11]/td[1]/a

User Adds Two Pets To The Owner
         Click Element                                  xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[11]/td[1]/a
         Add New Pet
         Input New Pet Detalis
         Pet Details                                    ${Give_New_PetName_1}                ${NewPet_BirthDate}
         Wait Until Page Contains                         Owner Information
         Add New Pet
         Input New Pet Detalis
         Pet Details                                    ${Give_New_PetName_2}                ${NewPet_BirthDate}
         Wait Until Page Contains                       Owner Information
         User Verifies Two Pets Adedd To The owner
User Verifies Two Pets Adedd To The owner
        ${pet_1_added}                                   get text                           xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list[2]/table/tr/td[1]/dl/dd[1]
        Should Contain                                   ${Verify_pet_1_Added}              ${pet_1_added}
        ${pet_2_added}                                   get text                            xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list[1]/table/tr/td[1]/dl/dd[1]
        Should Be Equal                                  ${Verify_Pet_2_Added}               ${pet_2_added}

User Removes A Pet
        Wait Until Page Contains                         Owner Information
        Click Element                                    xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list[2]/table/tr/td[1]/dl/button[2]
        #Tear Down 2nd Pet
        User Verifies Pet Removed

User Verifies Pet Removed
        Page Should Not Contain button                   ${Give_New_PetName_1}
Tear Down 2nd Pet
        Click Element                                    xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[1]/dl/button[2]

User Changes The Last Name Of The Owner
        Click Element                                   xpath:/html/body/app-root/app-owner-detail/div/div/button[2]
        Click Element                                   id=lastName
        Input Text                                      id=lastName                          ${Updated_Last_Name}
        Click Element                                   xpath:/html/body/app-root/app-owner-edit/div/div/form/div[7]/div/button[2]
        Wait Until Page Contains                        Owner Information
        User Verifies Updated Last Name
User Verifies Updated Last Name
       ${Link_Text}                                     Get Text                             xpath:/html/body/app-root/app-owner-detail/div/div/table[1]/tr[1]/td/b
       Should Contain                                   ${Verify_Last_Name}                  ${Link_Text}

The Owner Has One Pet And Updated LastName
        Page Should Contain                             ${Give_New_PetName_2}                  ${Updated_Last_Name}

User Adds A New PetType
        Go to Pet Types
        Verify on the right page
        Add a new Pet Type
User Verifies PetType Added
        Verify added Pet Type

User Deletes The PetType
       Wait until page contains                          ${Expected_Pettypes_Page}
       Click Element                                     xpath://*[@id="pettypes"]/tbody/tr[7]/td[2]/button[2]
       Wait until page contains                          ${Expected_Pettypes_Page}
PetType Is Removed From The List
      Wait until page contains                           ${Expected_Pettypes_Page}
      Page Should Not Contain Element                    xpath://*[@id="6"]

#------------------------------------

#Add visit to a pet  -- Swetha
User selects an owner
     Go To Web Page
     All Owners
     #Set Selenium speed                          .25
     Click Element                                xpath:/html/body/app-root/app-owner-list/div/div/div/table/tbody/tr[2]/td[1]/a
     Set Selenium speed                          .25
     Wait Until Page Contains                     Betty Davis
Click Add Visit button
     Click Button                                 xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[1]/dl/button[3]
     Wait Until Page Contains                     New Visit
Pet Visit details
     [Arguments]                                   ${Pet_Visit_Date}        ${Pet_Visit_Description}
     Visit Date                                    ${Pet_VisitDate}
     Description                                   ${PetVisit_Description}
     #Set Selenium Speed                           .5
Visit Date
     [Arguments]                                  ${Pet_VisitDate}
     Input Text                                   xpath://*[@id="visit"]/div[1]/div[1]/div/input       ${Pet_VisitDate}
Description
     [Arguments]                                  ${PetVisit_Description}
     Input Text                                   xpath://*[@id="description"]     ${PetVisit_Description}
#Click on Add Visit Button
     Click Button                                  xpath://*[@id="visit"]/div[2]/div/button[2]
Verify visit added to a pet
     #Sleep                                   0.5 s
     ${Verify_Pet_Visit_Date_Added}          get text        xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[2]/app-visit-list/table/tr/td[1]

     ${Verify_Pet_Visit_Description_Added}   get text        xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[2]/app-visit-list/table/tr/td[2]
     #Sleep                                   0.5 s
     Table should contain                    xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[2]/app-visit-list/table     ${Verify_Pet_Visit_Date_Added}  ${Verify_Pet_Visit_Description_Added}
Teardown added pet visit
     Click button                             xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[2]/app-visit-list/table/tr/td[3]/button[2]
     Sleep                                    0.1 s
#take path of complete row or visit date added
     Page should not contain element          ${Row_Path1}
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Verify able to add multiple pet visits
     #Sleep                                         0.5 s
     ${Verify_Pet_Visit_Date2_Added}              get text        xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[2]/app-visit-list/table/tr/td[1]
     ${Verify_Pet_Visit_Description2_Added}       get text        xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[2]/app-visit-list/table/tr/td[2]
     ${Verify_Pet_Visit_Date3_Added}              get text        xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[2]/app-visit-list/table/tr[1]/td[1]
     ${Verify_Pet_Visit_Description3_Added}       get text        xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[2]/app-visit-list/table/tr[1]/td[2]
     Table should contain                         xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[2]/app-visit-list/table      ${Verify_Pet_Visit_Date2_Added} ${Verify_Pet_Visit_Description2_Added}
     Table should contain                         xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[2]/app-visit-list/table      ${Verify_Pet_Visit_Date3_Added} ${Verify_Pet_Visit_Description3_Added}
Teardown added multiple visits
     Click button                                  xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[2]/app-visit-list/table/tr/td[3]/button[2]
     Click button                                  xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[2]/app-visit-list/table/tr/td[3]/button[2]
     Page should not contain element               xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[2]/app-visit-list/table/tr[1]/td[1]
     Page should not contain element               xpath:/html/body/app-root/app-owner-detail/div/div/table[2]/tr/app-pet-list/table/tr/td[2]/app-visit-list/table/tr[2]/td[1]

#---------------------------------------------------------------------------------
# Delete PetType -Swetha

Select the Pet Type to delete
     wait until page contains element              xpath://*[@id="6"]
     Page should contain element                   xpath://*[@id="6"]
Delete the added Pet Type
     Click button                                  xpath://*[@id="pettypes"]/tbody/tr[7]/td[2]/button[2]
Verify Pet Type is deleted
     wait until page contains                      Pet Types
     Page should not contain element               xpath://*[@id="6"]
--------------------------------------------------------------------------------------------------------------------------------------
# Deleting multiple PetTypes - Swetha
Delete multiple Pet Types
     wait until page contains element              xpath://*[@id="7"]
     Page should contain element                   xpath://*[@id="7"]
     Select the pettype to delete
     Click button                                  xpath://*[@id="pettypes"]/tbody/tr[8]/td[2]/button[2]
     Click button                                  xpath://*[@id="pettypes"]/tbody/tr[7]/td[2]/button[2]
Verify multiple Pet Types are deleted
     wait until page contains                      Pet Types
     Page should not contain element               xpath://*[@id="7"]
     Page should not contain element               xpath://*[@id="6"]
---------------------------------------------------------------------------------------------------------------------------------------------
#Swetha EDIT VETERINARIAN
Going to Veterinarians page
     Click Element                            xpath:/html/body/app-root/div[1]/nav/div/ul/li[3]/a
     Click Element                            xpath:/html/body/app-root/div[1]/nav/div/ul/li[3]/ul/li[2]/a/span[2]
Add New Veterinarian
     Input Text                               xpath://*[@id="firstName"]     ${New_Vet_Firstname}
     Input Text                               xpath://*[@id="lastName"]      ${New_Vet_Lastname}
     Select from list by label                id:specialties    ${Vet_Type}
     Click Button                             xpath://*[@id="vet"]/div[5]/div/button[2]
Select the Veterinarian to Edit
     Set selenium speed                       0.5s
     wait until page contains element         xpath://*[@id="vets"]/tbody/tr[7]/td[1]
     Page should contain element              xpath://*[@id="vets"]/tbody/tr[7]/td[1]
Edit added veterinarian
     Click Button                             xpath://*[@id="vets"]/tbody/tr[7]/td[3]/button[1]
     Input Text                               xpath://*[@id="firstName"]     ${Edited_Vet_Firstname}
     Click Button                             xpath://*[@id="vet_form"]/div[5]/div/button[2]
Verify veterinarian edited
     ${Actual_Vet_Name_edited}                get text   xpath://*[@id="vets"]/tbody/tr[7]/td[1]
     ${Actual_Specialties_added}              get text   xpath://*[@id="vets"]/tbody/tr[7]/td[2]/div
     Should be equal                          ${Edited_Vet_Firstname} ${New_Vet_Lastname}     ${Actual_Vet_Name_edited}
Teardown after veterinarian added and edited
      Click Button                             xpath://*[@id="vets"]/tbody/tr[7]/td[3]/button[2]
      Page should not contain                  xpath://*[@id="vets"]/tbody/tr[7]/td[1]

---------------------------------------------------------------------------------------
#Edit multiple veterinarians
Edit multiple veterinarians
   Add New Veterinarian
   Click Button                             xpath:/html/body/app-root/app-vet-list/div/div/div/button[2]
   Add New Veterinarian
   wait until page contains element         xpath://*[@id="vets"]/tbody/tr[8]/td[1]
   Page should contain element              xpath://*[@id="vets"]/tbody/tr[8]/td[1]
   sleep                                    0.2s
   Select the Veterinarian to Edit
    #edit button
   Click Button                             xpath://*[@id="vets"]/tbody/tr[8]/td[3]/button[1]
   Input Text                               xpath://*[@id="firstName"]     ${Edited_Vet_Firstname}
   #save
   Click Button                             xpath://*[@id="vet_form"]/div[5]/div/button[2]
   Edit added veterinarian
Verify multiple Veterinarians edited
    ${Actual_Vet_Name2_edited}               get text   xpath://*[@id="vets"]/tbody/tr[8]/td[1]
    ${Actual_Vet_Name_edited}                get text   xpath://*[@id="vets"]/tbody/tr[7]/td[1]
    ${Actual_Specialties_added}              get text   xpath://*[@id="vets"]/tbody/tr[7]/td[2]/div
    Should be equal                          ${Edited_Vet_Firstname} ${New_Vet_Lastname}      ${Actual_Vet_Name2_edited}
    Should be equal                          ${Edited_Vet_Firstname} ${New_Vet_Lastname}     ${Actual_Vet_Name_edited}
Teardown after multiple Veterinarians added and edited
    Set Selenium speed                     0.5s
    Click Button                           xpath://*[@id="vets"]/tbody/tr[8]/td[3]/button[2]
    Click Button                           xpath://*[@id="vets"]/tbody/tr[7]/td[3]/button[2]
    Page should not contain                xpath://*[@id="vets"]/tbody/tr[8]/td[1]
    Page should not contain                xpath://*[@id="vets"]/tbody/tr[7]/td[1]
End WebTest
    close browser
