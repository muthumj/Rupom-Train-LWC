public class AccDupCheck {
    
    
    public static void dupcheck(list<account> act)
    {
        
        set<string> st = new set<string>();
        
        for(account al : act)
        {
            st.add(al.name);
        }
        
        
        list<account> asclist = new list<account> ([select name from account where name in :st ]);
        
        map<string,account> macc = new map<string,account>();
        for(account att : asclist)
        {
            macc.put(att.name,att);
        }
        
        for(account na :act )
            
        {
            if(macc.containskey(na.Name))
            {
                na.adderror('Please check the name. Name starting with "'+ na.Name + '" already exist');
            }
            
        }
    }
    
    
    
    public static void upconPh(list<account> act , map<id,account> oat, map<id,account> nat)
    {
        set<id> ids = new set<id>();
       
       
        for(account al : act)
        {if(al.Phone != oat.get(al.id).phone)
            ids.add(al.id);
        }
        
        list<contact> cl = new list<contact>([select phone , accountid from contact where accountid in :ids ]);
        
        list<contact> uplist = new list<contact>();
        
      
        
        
        
        
        
        for(contact ccl : cl)
            
        {
            ccl.Phone = nat.get(ccl.AccountId).phone;
            
            uplist.add(ccl);
            
        }
        
     
        
        update uplist;
        
        
    }
    
    public static void upconStat(list<account> act , map<id,account> oat, map<id,account> nat)
    {
        set<id> ids = new set<id>();
        for(account acc : act)
        {
            if(acc.status__c != oat.get(acc.id).status__c)
            {
                ids.add(acc.id);
                
            }
        }
        
        list<contact> clst = new list<contact>([select status__c , accountid from contact where accountid in :ids]); 
        
        list<contact> uplst = new list<contact>();
        
        for(contact ec : clst)
        {
            ec.Status__c = nat.get(ec.AccountId).status__c;
            uplst.add(ec);
        }
        
        update uplst;
        
        
    }
    
    
    public static void upsalesrep(list<account> act , map<id,account> oat)
    {
        
        set<id> ids = new set<id>();
     	for(account ay : act)
        {
            if(ay.OwnerId != oat.get(ay.id).ownerid)
            {
                ids.add(ay.OwnerId);
            }
            
        }
        
        list<user> urlst  = new list<user>([select name from user where id in :ids]);
        
        map<id,string> mp = new map<id,string>();
        
        for(user eu : urlst )
        {
            mp.put(eu.id , eu.Name );
        }
        
      
        for(account ea : act)
        {
            ea.Sales_rep__c = mp.get(ea.OwnerId);
            
        }
        
    
        
        
        
    }
    
    //This trigger will update all related opportunity with closed won when the status in account is changed to 
    // inactive
     public static void upoppstage(list<account> act , map<id,account> oat , map<id,account> nat)
     {
         set<id> ids = new set<id>();
         for(account al : act)
         {
             if(al.Status__c != oat.get(al.id).status__c &&  al.Status__c == 'Inactive')
             {
                 ids.add(al.id);
             }
         }
         
         list<opportunity> opplst = new list<opportunity>([select id , stagename , accountid from opportunity where accountid in :ids]);
         
         list<opportunity> uplsst = new  list<opportunity>();
         
         for(opportunity ol : opplst)
         {
             ol.stagename = 'closed won';
             uplsst.add(ol);
             
         }
         
         update uplsst;
         
         
     }
    
     public static void sendMailOwnOnUp(list<account> act , map<id,account> oat)
     {		
         
         set<id> ids = new set<id>();
         set<id> uids = new set<id>();
         for(account ac : act)
         {
             ids.add(ac.id);
             uids.add(ac.OwnerId);
                 
             
         }
         
         list<user> ur = [select name , id , email from user where id in :uids];
         
         map<id,string> umr = new map<id,string>();
         
         list<string> str = new list<string>();
         
         for(user urr : ur)
         {
             str.add(urr.Email);
             umr.put(urr.Id , urr.Name);
             
             
         }
         
         
         
         
         
         
         list<contact> ct = [select name , id ,accountid from contact where accountid in :ids];
         
         map<id,string> mc = new map<id,string>();
         
         for(contact cl : ct )
         {
             mc.put(cl.accountid , cl.name);
         }
         
         for(account afr : act)
         {
             
         Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            // Set recipients to two contact IDs.
            // Replace IDs with valid record IDs in your org.
            message.toAddresses = str;
            message.optOutPolicy = 'FILTER';
            message.subject = 'You have created a new Account with account name ' ;
           message.setHTMLBody('Hi Sir, <p></p>Thanks for creating the account <p></p> Thanks & Regards <p></p> ')  ;
        
            Messaging.SingleEmailMessage[] messages = 
                new List<Messaging.SingleEmailMessage> {message};
                     Messaging.SendEmail(messages);

             
             
             
         }
         
         

         
     }
    
    public static void accphcon(list<account> act , map<id,account> nat)
    {
        set<id> ids = new set <id>();
        for(account al : act)
        {
            if(al.Phone != null)
            {
                ids.add(al.id);
            }
        }
        
      list<contact> cl = [select phone , accountid from contact where accountid in :ids];
        
        list<contact> clst = new list<contact>();
        
        for(contact ccl : cl)
        {
            ccl.Phone = nat.get(ccl.AccountId).phone;
            clst.add(ccl);
        }
        update clst;
    }
    
    public static void delchekonopp(list<account> oct )
    {
        set<id> ids = new set<id>();
        for(account al : oct)
        {
            ids.add(al.Id);
        }
        list<opportunity> olst = [select id , accountid from opportunity where accountid in :ids and stagename != 'closed won'];
        
        map<id,opportunity> mp = new map<id,opportunity>();
        
        for(opportunity ol : olst)
        {
            mp.put(ol.AccountId,ol);
        }
        
        for(account al : oct)
        {
            if(mp.containskey(al.id))
            {
                al.adderror('Cant delete having related opp');
            }
                
                
            
            
            
        }
         
    }
    
    public static void mailtoconontypch(list<account> act  , map<id,account> oat)
    {	
        set<id> ids = new set<id>();
        for(account al  : act)
        {
            if(al.Type != oat.get(al.id).type)
            {
                ids.add(al.id);
            }
        }
        
        list<contact> cl = [select id , email , name , accountid from contact where accountid in : ids];
        
        map<id,string> ml = new map<id,string>();
        list<string> mml = new list<string>();
        
        for(contact ccl : cl)
        {
            ml.put(ccl.AccountId,ccl.name);
            mml.add(ccl.Email);
        }
        
        for(account rt : act )
        {
            if(ml.containskey(rt.id))
               {
                    Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            // Set recipients to two contact IDs.
            // Replace IDs with valid record IDs in your org.
            message.toAddresses = mml;
            message.optOutPolicy = 'FILTER';
            message.subject = 'You have created a new Account with account name ' ;
           message.setHTMLBody('Hi Sir, <p></p>Thanks for creating the account <p></p> Thanks & Regards <p></p> ')  ;
        
            Messaging.SingleEmailMessage[] messages = 
                new List<Messaging.SingleEmailMessage> {message};
                     Messaging.SendEmail(messages);

               }
            
        }
        
        
        
        
    }
    
    public static void ClosOpp(list<account> act , map<id,account> oat)
        
    {		set<id> ids = new set<id>();
         	for(account al : act)
            {
                if(al.Close_all_Opps__c == true )
                {
                    ids.add(al.Id);
                }
            }
     
     list<opportunity> ol = [select stagename from opportunity where accountid in :ids and stagename != 'closed won'];
     
     list<opportunity> uplst = new  list<opportunity>();
     for(opportunity nrl : ol)
     {
         nrl.StageName = 'closed won';
         uplst.add(nrl);
     }
     update uplst;
     
    }
    
    
    public static void ckeph(list<account> act)
    {
        
        for(account al : act)
        {
            if(al.Phone == null || al.Phone == '')
            {
                al.adderror('Phone field cannot be empty');
            }
        }
    }
     
    public static void phtocon(list<account> act , map<id,account> oat)
    {
        set<id> ids = new set<id>();
        for(account al : act)
        {
            if(al.Phone != null && al.phone != oat.get(al.id).phone  )
            {
                ids.add(al.id);
            }
        }
        
        map<id,contact> mp = new map<id,contact>([select id, accountid from contact where accountid in :ids]);
        map<id,contact> cr = new map<id,contact>();
        
        for(account de  : act)
        {
            if(mp.containskey(de.id))
            {
                contact c = mp.get(de.id);
                c.Phone = de.phone;
                cr.put(c.id,c);
            }
        }
        
        update cr.values();
    }

}