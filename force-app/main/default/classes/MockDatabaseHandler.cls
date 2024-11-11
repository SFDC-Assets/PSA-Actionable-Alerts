public class MockDatabaseHandler implements System.StubProvider {
    private Map<String, List<SObject>> queryResults = new Map<String, List<SObject>>();

    public MockDatabaseHandler mockQuery(Type sobjType, List<SObject> results) {
        queryResults.put(sobjType.getName(), results);
        return this;
    }

    public Object handleMethodCall(Object stubbedObject, String stubbedMethodName,
                                   Type returnType, List<Type> listOfParamTypes,
                                   List<String> listOfParamNames, List<Object> listOfArgs) {
        if (stubbedMethodName == 'query') {
            String soql = (String)listOfArgs[0];
            for (String key : queryResults.keySet()) {
                if (soql.contains(key)) {
                    return queryResults.get(key);
                }
            }
        }
        return null;
    }
}