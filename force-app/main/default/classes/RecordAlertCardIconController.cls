public without sharing class RecordAlertCardIconController {

    @AuraEnabled(cacheable=true)
    public static String getStaticResourceUrl(String recordAlertCategoryId) {
        // Retrieve the RecordAlertCategory DeveloperName based on the ID
        RecordAlertCategory category;
        try{
            category = [SELECT DeveloperName FROM RecordAlertCategory WHERE Id = :recordAlertCategoryId LIMIT 1];
        } catch (QueryException e) {
            throw new AuraHandledException('Record Alert is not assigned a Record Alert Category');
        }

        Record_Alert_Display_Config__mdt displayConfig;
        try{
            displayConfig = [SELECT Record_Alert_Icon__c FROM Record_Alert_Display_Config__mdt WHERE Record_Alert_Category_Developer_Name__c = :category.DeveloperName LIMIT 1];
        } catch (QueryException e){
            throw new AuraHandledException('No Record_Alert_Display_Config__mdt created for Record Alert Category: ' + category.DeveloperName);
        }

        // Retrieve the StaticResource record with ContentType
        List<StaticResource> staticResources = [SELECT Id, Name, ContentType FROM StaticResource WHERE Name = :displayConfig.Record_Alert_Icon__c LIMIT 1];
        String icon;

        if (!staticResources.isEmpty()) {
            // Validate if the static resource has a valid image content type
            StaticResource staticResource = staticResources[0];
            String contentType = staticResource.ContentType;
            if (!contentType.startsWith('image/')) {
                throw new AuraHandledException('The static resource ' + staticResource.Name + ' is not an image.');
            }

            // Generate the URL for the static resource
            icon = '/resource/' + staticResource.Name;
        } else if(displayConfig.Record_Alert_Icon__c.contains(':')) {
            icon = displayConfig.Record_Alert_Icon__c;
        } else {
            throw new AuraHandledException('No static resource or icon found with the name: ' + displayConfig.Record_Alert_Icon__c);
        }

        return icon;
    }
}