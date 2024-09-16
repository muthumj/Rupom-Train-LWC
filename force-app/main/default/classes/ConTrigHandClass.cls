public class ConTrigHandClass {
    
    public static void upAccPrio(list<contact> cont)
    {
        set<id> ids = new set<id>();
        for(contact cl : cont)
        {
            if(cl.title == 'CEO' && cl.accountid != null)
            {
                ids.add(cl.accountid);
            }
        }
        
        list<account> al = new list<account>([select id , (select title , accountid from contacts) from account where id in :ids]);
        
        list<account> uplst = new list<account>();
        
        for(account ea : al)
        {
            ea.Active__c = 'Priority';
            uplst.add(ea);
            
        }
        
        update uplst;
        
    }
    
    public static void upaccdes(list<contact> cont , map<id,contact> ocon )
    {
        set<id> ids = new set<id>();
        for(contact con : cont)
        {
            if(con.accountid != null && con.Description != ocon.get(con.id).description)
            {
                ids.add(con.accountid);
            }
        }
        
        list<account> al = [select id , description from account where id in :ids];
        
        map<id,account> mk = new   map<id,account>([select id , description from account where id in :ids]);
        
        
        map<id,account> upma = new map<id,account>();
        for(contact cl : cont)
        {
            if(mk.containskey(cl.AccountId))
            {
                Account acc = mk.get(cl.AccountId);
                acc.Description = cl.Description;
                upma.put(acc.id,acc);
            }
            
        }
        
        update upma.values();
        
       
        
        
    }
    
    public static void restwocononact(list<contact> cont , map<id,contact> ocon )
    {
        set<id> ids = new set<id>();
        for(contact ol : cont)
        {
            if(ol.AccountId != null && ol.AccountId != ocon.get(ol.Id).accountid)
            {
                ids.add(ol.AccountId);
            }
        }
        
        list<aggregateresult> ar = [select accountid , count(id) cnt from contact where accountid in :ids group by accountid];
        
        system.debug(limits.getqueries());
        
        map<id,integer> lre = new map<id,integer>();
        
        for(aggregateresult arr : ar)
        {
         lre.put((id)arr.get('accountid'),(integer)arr.get('cnt'));   
        }
        
        for(contact sl : cont)
        {
            if(lre.containskey(sl.accountid) && lre.get(sl.accountid) > 2)
            {
                
                
            }
        }
        
    }
    
    public static void mostreccont(list<contact> cont , map<id,contact> ocon )
    {
        set<id> ids = new set<id>();
        for(contact ct : cont)
        {
            if(ct.accountid != null)
            {
                ids.add(ct.accountid);
            }
            
        }
        
        list<contact> sf = [select id from contact where accountid in : ids order by createddate desc ];
        
        map<id,contact> df = new map<id,contact>();
            
            for(contact de  : sf)
        {
            df.put(de.AccountId,de);
        }
        
        for(contact er : sf)
        {
            
        }
        
        
        
        
        
    }
    
    public static void emaidom(list<contact> cont)
    {
        set<id> ids = new set<id>();
        for(contact dr  : cont)
        {
           ids.add(dr.id);
        }
        
        
        list<account> lt = [select name from account where name ='Example Inc'];
        
        
    }
    
     public static void primconaccins(list<contact> cont)
     {
         set<id> ids = new set<id>();
         for(contact cl : cont)
         {
             if(cl.AccountId != null && cl.Primary_Contact_c__c == true)
             {
                 ids.add(cl.AccountId);
             }
         }
         
         map<id,account> tr = new map<id,account>([select id , Primary_Contact_Phone_c__c
                                                   , Primary_Contact_Email_c__c	 from account where id in :ids]);
         
         
         map<id,account> upmap = new map<id,account>();
         
         for(contact cd : cont)
         {
             if(tr.containskey(cd.accountid) && cd.Primary_Contact_c__c == true)
             {
                 account a = tr.get(cd.AccountId);
                 a.Primary_Contact_Phone_c__c = cd.Phone;
                 a.Primary_Contact_Email_c__c = cd.Email;
                 upmap.put(a.Id,a);
                 
                 
             }
             
         }
           
          update upmap.values();   
           
     }
    public static void primconaccupd(list<contact> cont)
    {
        set<id> ids = new set<id>();
        for(contact cd : cont)
        {
           if(cd.AccountId != null && (cd.Primary_Contact_c__c == true || cd.Primary_Contact_c__c == false ))
              {
                  ids.add(cd.AccountId);
              }
        }
        map<id,account> tr = new map<id,account>([select id , Primary_Contact_Phone_c__c
                                                   , Primary_Contact_Email_c__c	 from account where id in :ids]);
         
         
         map<id,account> upmap = new map<id,account>();
         
         for(contact cd : cont)
         {
             if(tr.containskey(cd.accountid) && cd.Primary_Contact_c__c == true)
             {
                 account a = tr.get(cd.AccountId);
                 a.Primary_Contact_Phone_c__c = cd.Phone;
                 a.Primary_Contact_Email_c__c = cd.Email;
                 upmap.put(a.Id,a);
                 
                 
             }
             else if(tr.containskey(cd.accountid) && cd.Primary_Contact_c__c == false)
             {
                 account a = tr.get(cd.AccountId);
                 a.Primary_Contact_Phone_c__c = null;
                 a.Primary_Contact_Email_c__c = null;
                 upmap.put(a.Id,a);
                 
                 
             }
             
         }
           
          update upmap.values();   
           
        
    }
    
    public static void primconval(list<contact> cont  )
    {
        set<id> ids = new set<id>();
        map<id,contact> othercon = new map<id,contact>();
        for(contact ct : cont)
        {
            if(ct.accountid != null  && ct.Primary_Contact_c__c == true)
                
            {
                ids.add(ct.AccountId);
                othercon.put(ct.id,ct);
            }
        }
        
      	list<contact> pt = [select id from contact where accountid in :ids and Primary_Contact_c__c = true ];
        
        list<contact> upc = new list<contact>();
        
        for(contact cv : pt)
        {
            if(!othercon.containskey(cv.id))
            {
                cv.Primary_Contact_c__c = false;
                upc.add(cv);
            }
        }
        
        update upc;
    }

    public static void prevcon(list<contact> cont )
    {
        set<id> ids = new set<id>();
        for(contact cl : cont)
        {
            if(cl.accountid != null)
            {
                ids.add(cl.accountid);
            }
        }

        list<aggregateresult> tr = [select count(id) cs , accountid from contact where 
        accountid in :ids group by accountid];

        map<id,integer> mk = new map<id,integer>();

        for(aggregateresult re : tr )
        {
            mk.put((id)re.get('accountid'),(integer)re.get('cs'));

        }

        for(contact cl : cont)
        {
            if(mk.containskey(cl.accountid) && mk.get(cl.accountid) > 10)
            {
                cl.adderror('You cannot add more than 10 contacts');
            }
        }




    }

  
    
}