@IsTest
public with sharing class RecordAlertCardIconControllerTest {
    @IsTest
    static void testGetCategoryIcons_StaticResource_Success() {
        RecordAlertCategory testCategory = [SELECT Id, DeveloperName FROM RecordAlertCategory WHERE DeveloperName = 'RecordAlert_Behavior' LIMIT 1];
        System.System.debug(testCategory);
        Record_Alert_Display_Config__mdt testConfig = [SELECT Id,Record_Alert_Icon__c FROM Record_Alert_Display_Config__mdt WHERE Record_Alert_Category_Developer_Name__c = :testCategory.DeveloperName LIMIT 1];
        System.System.debug(testConfig);
        StaticResource testResource = [SELECT Id, Name, ContentType FROM StaticResource WHERE Name = :testConfig.Record_Alert_Icon__c LIMIT 1];
        System.System.debug(testResource);
        String testUrl = '/resource/' + testResource.Name;
        
        Test.startTest();
        String result = RecordAlertCardIconController.getStaticResourceUrl(testCategory.Id);
        Test.stopTest();

        // Assert the result
        System.assertEquals(testUrl, result, 'The returned API name should match the test flow');
    }
    
    @IsTest
    static void testGetCategoryIcons_SldsIcon_Success() {
        RecordAlertCategory testCategory = [SELECT Id, DeveloperName FROM RecordAlertCategory WHERE DeveloperName = 'RecordAlert_Academic' LIMIT 1];
        System.System.debug(testCategory);
        Record_Alert_Display_Config__mdt testConfig = [SELECT Id,Record_Alert_Icon__c FROM Record_Alert_Display_Config__mdt WHERE Record_Alert_Category_Developer_Name__c = :testCategory.DeveloperName LIMIT 1];
        System.System.debug(testConfig);
        String testUrl = testConfig.Record_Alert_Icon__c;
        
        Test.startTest();
        String result = RecordAlertCardIconController.getStaticResourceUrl(testCategory.Id);
        Test.stopTest();

        // Assert the result
        System.assertEquals(testUrl, result, 'The returned API name should match the test flow');
    }

    @IsTest
    static void testGetCategoryIcons_InvalidCategoryId() {
        Test.startTest();
        try {
            RecordAlertCardIconController.getStaticResourceUrl('InvalidId');
            System.assert(false, 'Expected an exception to be thrown');
        } catch (Exception e) { 
            System.assertEquals('Script-thrown exception', e.getMessage());
        } 
        Test.stopTest();
    }

    @IsTest
    static void testGetCategoryIcons_InvalidDisplayConfig() {
        RecordAlertCategory testCategory = [SELECT Id, DeveloperName FROM RecordAlertCategory WHERE DeveloperName = 'RecordAlert_Financial' LIMIT 1];

        Test.startTest();
        try {
            String result = RecordAlertCardIconController.getStaticResourceUrl(testCategory.Id);
            System.assert(false, 'Expected an exception to be thrown');
        } catch (Exception e) { 
            System.assertEquals('Script-thrown exception', e.getMessage());
        } 
        Test.stopTest();
    }

}