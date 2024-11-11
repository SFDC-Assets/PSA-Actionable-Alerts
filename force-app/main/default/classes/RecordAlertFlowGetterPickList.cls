global with sharing class RecordAlertFlowGetterPickList extends VisualEditor.DynamicPickList {
    global override VisualEditor.DataRow getDefaultValue() {
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow(
            'Record Alert Display | Get Record Alerts',
            'Record_Alert_Display_Get_Record_Alerts'
        );
        return defaultValue;
    }

    global override VisualEditor.DynamicPickListRows getValues() {
        VisualEditor.DynamicPickListRows picklistValues = new VisualEditor.DynamicPickListRows();
        List<FlowDefinitionView> flowList = [
            SELECT Id,ApiName, IsActive, Label, ProcessType, TriggerObjectOrEventLabel, TriggerType 
            FROM FlowDefinitionView
            WHERE IsActive = TRUE 
            AND ProcessType = 'AutoLaunchedFlow'
            AND ApiName LIKE 'Record_Alert_Display%' 
            ORDER BY Label ASC
        ];
        for (FlowDefinitionView flow : flowList) {
            VisualEditor.DataRow value = new VisualEditor.DataRow(
                flow.Label,
                flow.APiName
            );
            picklistValues.addRow(value);
        }
        return picklistValues;
    }
}