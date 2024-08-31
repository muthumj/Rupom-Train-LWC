public with sharing class LWC_NestAwat_SearchTab
 {

    @AuraEnabled(cacheable=true)
    
   
    public static list<Budget__c> getallbud(String searchkey) 
    {
        string sk='%' +searchkey + '%' ;
         
        Return [select Name,Amount__c,Area__c from Budget__c where Name LIKE :sk];

    }
    
    
}