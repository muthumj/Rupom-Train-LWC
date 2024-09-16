public with sharing class ContactTable {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList(String accId) {
        return [
            SELECT AccountId, Id, FirstName, LastName, Title, Phone, Email
            FROM Contact
            WHERE AccountId = :accId
            limit 20
        ];
    }


}