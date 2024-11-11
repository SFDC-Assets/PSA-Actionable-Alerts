public with sharing class RecordAlertsDisplayController {
    @AuraEnabled(cacheable=true)
    public static List<RecordAlert> getRecordAlerts(Id recordId, Boolean parentAlerts, String excludedRecordAlertCategories) {
        if (recordId == null) {
            return new List<RecordAlert>();
        }

        List<RecordAlertCategory> excludedCategories = new List<RecordAlertCategory>();
        excludedCategories = [
            SELECT Id
            FROM RecordAlertCategory
            WHERE DeveloperName IN :convertStringToList(excludedRecordAlertCategories)
        ];

        List<RecordAlert> alerts = new List<RecordAlert>();

        if(parentAlerts == true){
            alerts = [
                SELECT Id, Name, Subject, Severity, CreatedDate, RecordAlertCategoryId, Description, SnoozeUntilDate
                FROM RecordAlert 
                WHERE (ParentId = :recordId 
                OR WhatId = :recordId)
                AND RecordAlertCategoryId NOT IN :excludedCategories
                ORDER BY CreatedDate DESC
            ]; 
        } else {
            alerts = [
                SELECT Id, Name, Subject, Severity, CreatedDate, RecordAlertCategoryId, Description, SnoozeUntilDate
                FROM RecordAlert 
                WHERE WhatId = :recordId
                AND RecordAlertCategoryId NOT IN :excludedCategories
                ORDER BY CreatedDate DESC
            ]; 
        }

        return alerts;
    }

    public static List<String> convertStringToList(String input) {
        
        if (String.isEmpty(input)) {
            return new List<String>();
        }
        List<String> resultList = input.split('\\s*,\\s*');

        for (Integer i = 0; i < resultList.size(); i++) {
            resultList[i] = resultList[i].trim();
        }

        return resultList;
    }
}