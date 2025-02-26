@IsTest
private class RecordAlertCardActionControllerTest {
    @IsTest
    static void testGetCategoryActions_Success() {
        
        RecordAlertCategory testCategory = [SELECT Id, DeveloperName FROM RecordAlertCategory WHERE DeveloperName = 'RecordAlert_Academic' LIMIT 1];
        Record_Alert_Display_Config__mdt testConfig = [SELECT Id,Flow_Action_ApiName__c FROM Record_Alert_Display_Config__mdt WHERE Record_Alert_Category_Developer_Name__c = :testCategory.DeveloperName LIMIT 1];
        FlowDefinitionView testFlow = [SELECT Id, Label, ApiName FROM FlowDefinitionView WHERE ApiName = :testConfig.Flow_Action_ApiName__c LIMIT 1];
    

        // Mock the database calls
        Test.startTest();
        String result = RecordAlertCardActionController.getCategoryActions(testCategory.Id);
        Test.stopTest();

        // Assert the result
        System.assertEquals(testConfig.Flow_Action_ApiName__c, result, 'The returned API name should match the test flow');
    }

    @IsTest
    static void testGetCategoryActions_InvalidCategoryId() {
        Test.startTest();
        try {
            String result = RecordAlertCardActionController.getCategoryActions('InvalidId');
            System.assert(false, 'Expected an exception to be thrown');
        } catch (Exception e) { 
            System.assertEquals('Script-thrown exception', e.getMessage());
        } 
        Test.stopTest();
    }

    @IsTest
    static void testGetCategoryActions_InvalidRecordAlertDisplayConfig() {
        RecordAlertCategory testCategory = [SELECT Id, DeveloperName FROM RecordAlertCategory WHERE DeveloperName = 'RecordAlert_Financial' LIMIT 1];

        Test.startTest();
        try {
            String result = RecordAlertCardActionController.getCategoryActions(testCategory.Id);
            System.assert(false, 'Expected an exception to be thrown');
        } catch (Exception e) { 
            System.assertEquals('Script-thrown exception', e.getMessage());
        } 
        Test.stopTest();
    }

    @IsTest
    static void testGetButtonLabel_Success() {
        RecordAlertCategory testCategory = [SELECT Id, DeveloperName FROM RecordAlertCategory WHERE DeveloperName = 'RecordAlert_Academic' LIMIT 1];
        Record_Alert_Display_Config__mdt testConfig = [SELECT Id, Flow_Action_Button_Label__c FROM Record_Alert_Display_Config__mdt 
                                                      WHERE Record_Alert_Category_Developer_Name__c = :testCategory.DeveloperName LIMIT 1];

        Test.startTest();
        String result = RecordAlertCardActionController.getButtonLabel(testCategory.Id);
        Test.stopTest();

        System.assertEquals(testConfig.Flow_Action_Button_Label__c, result, 'The returned button label should match the test config');
    }

    @IsTest
    static void testGetButtonLabel_InvalidCategoryId() {
        Test.startTest();
        try {
            String result = RecordAlertCardActionController.getButtonLabel('InvalidId');
            System.assert(false, 'Expected an exception to be thrown');
        } catch (Exception e) {
            System.assertEquals('Script-thrown exception', e.getMessage());
        }
        Test.stopTest();
    }

    @IsTest
    static void testGetButtonLabel_InvalidRecordAlertDisplayConfig() {
        RecordAlertCategory testCategory = [SELECT Id, DeveloperName FROM RecordAlertCategory WHERE DeveloperName = 'RecordAlert_Financial' LIMIT 1];

        Test.startTest();
        try {
            String result = RecordAlertCardActionController.getButtonLabel(testCategory.Id);
            System.assert(false, 'Expected an exception to be thrown');
        } catch (Exception e) {
            System.assertEquals('Script-thrown exception', e.getMessage());
        }
        Test.stopTest();
    }
}