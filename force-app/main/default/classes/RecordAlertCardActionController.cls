public with sharing class RecordAlertCardActionController {
    @AuraEnabled(cacheable=true)
    public static String getCategoryActions(String recordAlertCategoryId) {
        RecordAlertCategory category;
        try{
            category = [SELECT DeveloperName FROM RecordAlertCategory WHERE Id = :recordAlertCategoryId LIMIT 1];
            
        } catch (QueryException e){
            throw new AuraHandledException('Record Alert is not assigned a Record Alert Category');
        }

        Record_Alert_Display_Config__mdt categoryFlowName;
        try{
            categoryFlowName = [SELECT Flow_Action_ApiName__c FROM Record_Alert_Display_Config__mdt WHERE Record_Alert_Category_Developer_Name__c = :category.DeveloperName LIMIT 1];
        } catch (QueryException e){
            throw new AuraHandledException('No Record_Alert_Display_Config__mdt created for this Record Alert Category');
        }

        FlowDefinitionView flowDefinition;
        try{
            flowDefinition = [SELECT Id, Label, ApiName FROM FlowDefinitionView WHERE ApiName = :categoryFlowName.Flow_Action_ApiName__c LIMIT 1];
        } catch (QueryException e) {
            throw new AuraHandledException('No Flow created for this Record Alert Category');
        }


        return flowDefinition.ApiName;
    }

    @AuraEnabled(cacheable=true)
    public static String getButtonLabel(String recordAlertCategoryId) {
        RecordAlertCategory category;
        try{
            category = [SELECT DeveloperName FROM RecordAlertCategory WHERE Id = :recordAlertCategoryId LIMIT 1];
            
        } catch (QueryException e){
            throw new AuraHandledException('Record Alert is not assigned a Record Alert Category');
        }

        Record_Alert_Display_Config__mdt categoryConfig;
        try{
            categoryConfig = [SELECT Flow_Action_Button_Label__c 
                            FROM Record_Alert_Display_Config__mdt 
                            WHERE Record_Alert_Category_Developer_Name__c = :category.DeveloperName LIMIT 1];
        } catch (QueryException e){
            throw new AuraHandledException('No Record_Alert_Display_Config__mdt created for this Record Alert Category');
        }

        return categoryConfig.Flow_Action_Button_Label__c;
    }
}