public with sharing class DeleteBudget {

    @AuraEnabled
    public static void deleteContact(List<Id> budgetid) {
        try {
            delete [SELECT Id FROM Budget__c WHERE Id IN :budgetid];
        } catch (Exception e) {
            throw new AuraHandledException('Unable to delete Contact: ' + e.getMessage());
        }
    }
    
}