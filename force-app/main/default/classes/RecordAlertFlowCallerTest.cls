@isTest
public with sharing class RecordAlertFlowCallerTest {
    @TestSetup
    static void setup() {
        // Create and insert an account
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Create and insert a contact associated with the account
        Contact testContact = new Contact(
            FirstName = 'Jane', 
            LastName = 'Doe', 
            AccountId = testAccount.Id
        );
        insert testContact;

        RecordAlert testRecordAlert = new RecordAlert(
            ParentId = testContact.Id,
            WhatId = testAccount.Id,
            EffectiveDate = Date.today(),
            ValidUntilDate = Date.today().addDays(30),
            Subject = 'Test Alert'
        );
        insert testRecordAlert;

    }

    @isTest
    static void testRecordAlertFlowCaller_Success() {
        // Query the test RecordAlert
        RecordAlert testAlert = [SELECT Id, ParentId, WhatId, EffectiveDate, ValidUntilDate, Subject 
                                 FROM RecordAlert 
                                 WHERE Subject = 'Test Alert' 
                                 LIMIT 1];
        
        Test.startTest();
        List<RecordAlert> results = RecordAlertFlowCaller.callMyFlow('Record_Alert_Display_Get_Record_Alerts', testAlert.ParentId);
        Test.stopTest();
        
        // Assert that the result contains the test RecordAlert
        System.assertEquals(1, results.size(), 'Expected one RecordAlert in the results');
        System.assertEquals(testAlert.Id, results[0].Id, 'Expected the test RecordAlert to be returned');
    }
    
    @isTest
    static void testRecordAlertFlowCaller_InvalidId() {
        Test.startTest();
        try {
            List<RecordAlert> results = RecordAlertFlowCaller.callMyFlow('Record_Alert_Display_Get_Record_Alerts', 'InvalidId');
            System.assert(false, 'Expected an exception to be thrown');
        } catch (Exception e) {
            System.debug(e);
            System.assert(e.getMessage().startsWith('This error occurred when the flow tried to look up records:'), 'This error occurred when the flow tried to look up records:');
        }
        Test.stopTest();
    }
}