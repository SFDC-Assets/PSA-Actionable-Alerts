public class GetObjectSObjectAPIName {
    
    // Define the Input and Output class structures for the Invocable Method
    public class Input {
        @InvocableVariable(required=true)
        public String recordId;  // Input parameter to accept the record Id
    }
    
    public class Output {
        @InvocableVariable
        public String sObjectApiName;  // Output parameter to return the SObject API Name
    }
    
    // The Invocable Method
    @InvocableMethod(label='Get SObject API Name' description='Returns the SObject API Name for the given Record ID')
    public static List<Output> getSObjectApiName(List<Input> request) {
        List<Output> results = new List<Output>();

        // Process each input record
        for (Input input : request) {
            Output result = new Output();
            
            if (String.isNotBlank(input.recordId) && input.recordId.length() == 18) {
                try {
                    // Convert the string to Id type
                    Id recordId = Id.valueOf(input.recordId);
                    // Get the SObject Type from the Id
                    Schema.SObjectType sObjType = recordId.getSObjectType();
                    // Get the API name of the SObject
                    result.sObjectApiName = sObjType.getDescribe().getName();
                } catch (Exception e) {
                    result.sObjectApiName = 'Error: ' + e.getMessage();
                }
            } else {
                result.sObjectApiName = 'Error: Invalid Record ID';
            }

            results.add(result);
        }
        return results;
    }
}