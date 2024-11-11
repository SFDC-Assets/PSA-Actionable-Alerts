@IsTest
public class GetObjectSObjectAPINameTest {
    
    @IsTest
    static void testValidAccountId() {
        // Create test data
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        // Prepare input
        GetObjectSObjectAPIName.Input input = new GetObjectSObjectAPIName.Input();
        input.recordId = testAccount.Id;
        List<GetObjectSObjectAPIName.Input> inputList = new List<GetObjectSObjectAPIName.Input>{input};
        
        // Call the method
        Test.startTest();
        List<GetObjectSObjectAPIName.Output> results = GetObjectSObjectAPIName.getSObjectApiName(inputList);
        Test.stopTest();
        
        // Assert results
        System.assertEquals(1, results.size(), 'Should return one result');
        System.assertEquals('Account', results[0].sObjectApiName, 'Should return Account as SObject API Name');
    }
    
    @IsTest
    static void testInvalidRecordId() {
        // Prepare input with invalid ID
        GetObjectSObjectAPIName.Input input = new GetObjectSObjectAPIName.Input();
        input.recordId = 'InvalidId';
        List<GetObjectSObjectAPIName.Input> inputList = new List<GetObjectSObjectAPIName.Input>{input};
        
        // Call the method
        Test.startTest();
        List<GetObjectSObjectAPIName.Output> results = GetObjectSObjectAPIName.getSObjectApiName(inputList);
        Test.stopTest();
        
        // Assert results
        System.assertEquals(1, results.size(), 'Should return one result');
        System.assertEquals('Error: Invalid Record ID', results[0].sObjectApiName, 'Should return error message for invalid ID');
    }
    
    @IsTest
    static void testNullRecordId() {
        // Prepare input with null ID
        GetObjectSObjectAPIName.Input input = new GetObjectSObjectAPIName.Input();
        input.recordId = null;
        List<GetObjectSObjectAPIName.Input> inputList = new List<GetObjectSObjectAPIName.Input>{input};
        
        // Call the method
        Test.startTest();
        List<GetObjectSObjectAPIName.Output> results = GetObjectSObjectAPIName.getSObjectApiName(inputList);
        Test.stopTest();
        
        // Assert results
        System.assertEquals(1, results.size(), 'Should return one result');
        System.assertEquals('Error: Invalid Record ID', results[0].sObjectApiName, 'Should return error message for null ID');
    }
    
    @IsTest
    static void testMultipleInputs() {
        // Create test data
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        Contact testContact = new Contact(LastName = 'Test Contact');
        insert testContact;
        
        // Prepare inputs
        List<GetObjectSObjectAPIName.Input> inputList = new List<GetObjectSObjectAPIName.Input>();
        
        GetObjectSObjectAPIName.Input input1 = new GetObjectSObjectAPIName.Input();
        input1.recordId = testAccount.Id;
        inputList.add(input1);
        
        GetObjectSObjectAPIName.Input input2 = new GetObjectSObjectAPIName.Input();
        input2.recordId = testContact.Id;
        inputList.add(input2);
        
        GetObjectSObjectAPIName.Input input3 = new GetObjectSObjectAPIName.Input();
        input3.recordId = 'InvalidId';
        inputList.add(input3);
        
        // Call the method
        Test.startTest();
        List<GetObjectSObjectAPIName.Output> results = GetObjectSObjectAPIName.getSObjectApiName(inputList);
        Test.stopTest();
        
        // Assert results
        System.assertEquals(3, results.size(), 'Should return three results');
        System.assertEquals('Account', results[0].sObjectApiName, 'First result should be Account');
        System.assertEquals('Contact', results[1].sObjectApiName, 'Second result should be Contact');
        System.assertEquals('Error: Invalid Record ID', results[2].sObjectApiName, 'Third result should be an error message');
    }
}