public with sharing class ContactController {
    @AuraEnabled
    public static Id createContact(Contact contactRecord) {
        try {
            insert contactRecord;
            return contactRecord.Id;
        } catch (Exception e) {
            throw new AuraHandledException('Error inserting contact: ' + e.getMessage());
        }
    }
}