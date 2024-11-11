public class RecordAlertFlowCaller {
    @AuraEnabled(cacheable=true)
    public static List<RecordAlert> callMyFlow(String flowName, String recordId) {
        List<FlowDefinitionView> flowList = [
            SELECT Id,ApiName, IsActive 
            FROM FlowDefinitionView
            WHERE ApiName = :flowName
        ];
        if(flowList[0].IsActive == false) {
            throw new AuraHandledException('Problem with ' + flowName + ' Getter Flow. The flow is not active.');
        }

        // Create a map to hold input variables
        Map<String, Object> flowInputs = new Map<String, Object>();
        if(recordId == null) {
            throw new AuraHandledException('Problem with ' + flowName + ' Getter Flow. The flow must have an input varibale of type string with the name: recordId.');
        } else {
            flowInputs.put('recordId', recordId); // Replace with your input variable names and values
        }

        // Create an instance of the Flow
        Flow.Interview flowInterview = Flow.Interview.createInterview(flowName, flowInputs);

        // Start the Flow
        flowInterview.start();

        // Retrieve the output variable which is a list of RecordAlert
        List<RecordAlert> outputAlerts = (List<RecordAlert>) flowInterview.getVariableValue('recordAlerts'); // Replace with your output variable name
        // Process the output list

        if (outputAlerts == null) {
            throw new AuraHandledException('Problem with ' + flowName + ' Getter Flow. The flow must have an input varibale of type string with the name: recordId and an output variable of type RecordAlert list with the name: recordAlerts.');
        } else if (outputAlerts.isEmpty()) {
            
        }

        return outputAlerts;
    }
}