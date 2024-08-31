public with sharing class lwc_Project_NestWay 

{   @AuraEnabled
public static string NestWay(string nm, string amt, string are, string sb )
{
    try 
    {
        Budget__c	B = New Budget__c();
            B.Name = nm;
            B.Amount__c = amt;
            B.Area__c= are;
            B.Sub_Area__c = sb;
            insert B;
    } 
    
    catch (Exception e) 
    {
        throw new AuraHandledException(e.getMessage());
    }
}

    
}