global with sharing class RecordAlertMassActionFlowPickList  extends VisualEditor.DynamicPickList {
    global override VisualEditor.DataRow getDefaultValue() {
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow(
            'UX | Record Alert | Mass Action',
            'UX_Record_Alert_Mass_Action'
        );
        return defaultValue;
    }

    global override VisualEditor.DynamicPickListRows getValues() {
        VisualEditor.DynamicPickListRows picklistValues = new VisualEditor.DynamicPickListRows();
        List<FlowDefinitionView> flowList = [
            SELECT Id,ApiName, IsActive, Label, ProcessType, TriggerObjectOrEventLabel, TriggerType 
            FROM FlowDefinitionView
            WHERE IsActive = TRUE
            AND ProcessType = 'Flow'
            AND TriggerType = ''
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