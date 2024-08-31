public with sharing class LWC_NestAway_CreateBudget 
{
    @AuraEnabled

    public static string CreateBud(string Nm, Double Am , String Ar)
    {
        String msg;
        try 
        {
            Budget__c B = New Budget__c	();
            B.Name = Nm;
            B.Amount__c = Am;
            B.Area__c = Ar;
            Insert B;
            msg = 'Budget created successfully' + B.id;
            
        } catch (Exception e) 
        {
            msg = 'Budget creation failed with error id' + e.getmessage();
        }
        Return msg;
    }
    
}