public with sharing class casechekcon {
    
    public static void csaccco(list<case> cs)
    {   
        set<id> ids = new set<id>();
        for(case tr : cs)
        {
            if(tr.accountid != null && tr.Create_Task__c == true ) 
            {
                ids.add(tr.accountid); 
            }
        }

       // list<account> al = [select id from account where id in :ids];

        list<contact> cl = [select accountid , id from contact where accountid in :ids and Primary_Contact_c__c	= true];

        map<id,id>  mp = new map<id,id>();

        for(contact fg : cl )
        {
            mp.put(fg.accountid,fg.id);
        }


        list<task> fs = new list<task>();

        for(case fgh : cs)
        {
            if(mp.containskey(fgh.accountid) && fgh.Create_Task__c == true )
            {
                task newtk = new task();
                newtk.subject = 'Follow up task for You today';
                newtk.whoid = mp.get(fgh.accountid);
                newtk.status = 'Not started';
                fs.add(newtk);

            }
            
        }

        insert fs;
    }

}