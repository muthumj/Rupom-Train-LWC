public with sharing class ImperativeClass {
    
    @AuraEnabled
    public static Id createAccount(String accountName, String phone) {
        // Create a new Account record
        Account acc = new Account();
        acc.Name = accountName;
        acc.Phone = phone;

        // Insert the record and return the newly created Account Id
        insert acc;
        return acc.Id;
    }
}