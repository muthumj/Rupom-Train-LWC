public with sharing class ImperativeUpdateClass {
    @AuraEnabled
    public static void updateAccount(Id accountId, String accountName, String phone) {
        // Query the Account by ID
        Account acc = [SELECT Id, Name, Phone FROM Account WHERE Id = :accountId LIMIT 1];

        // Update the fields with new values
        acc.Name = accountName;
        acc.Phone = phone;

        // Update the record in the database
        update acc;
    }
}