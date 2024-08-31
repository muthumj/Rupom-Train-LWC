public with sharing class AccountWire {

@AuraEnabled (cacheable = true)
public static list<account> getAccounts()
{
    return [SELECT Id, Name, Phone FROM Account LIMIT 10];
}

@AuraEnabled (cacheable = true)
public static list<contact> getContacts()
{
    return [SELECT Id, FirstName, LastName, Email FROM Contact LIMIT 10];

    
}

}