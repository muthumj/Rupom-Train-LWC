public with sharing class LWC_NeatAway_Wire {
    
    @AuraEnabled(cacheable=true)
    
   
    public static list<Budget__c> getallbud() 
    {
        Return [select Name,Amount__c,Area__c from Budget__c];
    }

    
    @AuraEnabled(cacheable=true)
    public static string morning() 
    {
        Return 'hi guys how are you';
    }
}