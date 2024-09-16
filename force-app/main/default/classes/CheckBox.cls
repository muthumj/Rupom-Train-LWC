public with sharing class CheckBox {

   public static void chekaccbox(list<contact> cont)
   {
    set<id> ids = new set<id>();
    for(contact cl : cont)
    {
        if(cl.accountid != null)
        {
            ids.add(cl.accountid);
        }
    }

    list<account> al = [select name from account where id in :ids];

    list<account> uplst = new list<account>();

    for(account df : al)
    {
        df.Only_Default_Contact__c = true;
        uplst.add(df);

    }


    update uplst;
   }
    
}