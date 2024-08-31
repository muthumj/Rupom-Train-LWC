public with sharing class lwc_Nest 

{
    @AuraEnabled
    public static string NestWay(string nm,double amt,  string are, string sb)
    {
        string msg;
        try 
        {
            Budget__c	B = New Budget__c();
            B.Name = nm;
            B.Amount__c = amt; 
            B.Area__c= are;
            B.Sub_Area__c = sb;
            insert B;
            msg = 'Budget created';
        } 
        catch (Exception e) 
        {
            msg= 'Buget creation failed' + e.getmessage();
        }
        return msg;
    }   
   
}