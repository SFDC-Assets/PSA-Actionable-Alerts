@isTest
public with sharing class RecordAlertMassActionFlowPickListTest {
    @isTest
    static void testAllValues() {
        // Creates own values to get consistent test results without relying on Custom Metadata Types existing in org
        List<FlowDefinitionView> flowList = [
            SELECT Id,ApiName, IsActive, Label, ProcessType, TriggerObjectOrEventLabel, TriggerType 
            FROM FlowDefinitionView
            WHERE IsActive = TRUE
            AND ProcessType = 'Flow'
            AND TriggerType = ''
            ORDER BY Label ASC
        ];
        RecordAlertMassActionFlowPickList rAMAFPL = new RecordAlertMassActionFlowPickList();
        VisualEditor.DynamicPickListRows rows = rAMAFPL.getValues();
        System.assertEquals(flowList.size(), rows.size(), 'No Brands were found');

    }

    @isTest
    static void testDefaultValue() {
        RecordAlertMassActionFlowPickList rAMAFPL = new RecordAlertMassActionFlowPickList();
        VisualEditor.DataRow row = rAMAFPL.getDefaultValue();
        System.assertEquals('UX | Record Alert | Mass Action', row.getLabel(), 'UX | Record Alert | Mass Action was not the default value');

    }
    
}