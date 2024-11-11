@IsTest
private class RecordAlertFlowGetterPickListTest {
    @isTest
    static void testAllValues() {
        // Creates own values to get consistent test results without relying on Custom Metadata Types existing in org
        List<FlowDefinitionView> flowList = [
            SELECT Id,ApiName, IsActive, Label, ProcessType, TriggerObjectOrEventLabel, TriggerType 
            FROM FlowDefinitionView
            WHERE IsActive = TRUE 
            AND ProcessType = 'AutoLaunchedFlow'
            AND ApiName LIKE 'Record_Alert_Display%' 
            ORDER BY Label ASC
        ];
        RecordAlertFlowGetterPickList rAFGPL = new RecordAlertFlowGetterPickList();
        VisualEditor.DynamicPickListRows rows = rAFGPL.getValues();
        System.assertEquals(flowList.size(), rows.size(), 'No Brands were found');

    }

    @isTest
    static void testDefaultValue() {
        RecordAlertFlowGetterPickList rAFGPL = new RecordAlertFlowGetterPickList();
        VisualEditor.DataRow row = rAFGPL.getDefaultValue();
        System.assertEquals('Record Alert Display | Get Record Alerts', row.getLabel(), 'Record Alert Display | Get Record Alerts was not the default value');

    }
}