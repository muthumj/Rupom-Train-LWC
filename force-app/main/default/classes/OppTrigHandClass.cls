public class OppTrigHandClass {
    
    public static void uptoamtAcc(list<opportunity> tlt , map<id,opportunity> mp)
    {
        set<id> ids = new set<id>();
        for(opportunity ol : tlt)
        {
            if(ol.stagename == 'closed won' && ol.accountid != null  )
            {
                
                    ids.add(ol.accountid);
               
             	   
            }
            
             if(ol.StageName != 'closed won')
            {
				ids.add(ol.accountid);                
            }
        }
        
        list<aggregateresult> ag = new  list<aggregateresult>([select sum(amount) sumamt , accountid from opportunity where accountid in :ids and 
                                                               stagename = 'closed won' group by  
                                                              accountid]);
        
        map<id,decimal> lk = new map<id,decimal>();
        
        for(aggregateresult agg : ag)
        {
            lk.put((id)agg.get('accountid'), (decimal)agg.get('sumamt') );
        }
        
        //list<account> acc = [select id from account where id in :ids];
        
        list<account> uplst = new list<account>();
        
        for(id ac : lk.keyset())
        {
            
            Account a = new account(id = ac);
           
            a.Total_OppAmt_Closed__c = lk.containsKey(a.Id) ? lk.get(a.Id) : 0;
            uplst.add(a);
        }
        
        update uplst;
        
       
        
        

    }
    
    
    
    
    
    public static void upOpStageNmtoAcc (list<opportunity> tlt , map<id,opportunity> mp)
    {
        
        set<id> ids = new set<id>();
        
        for(opportunity eo : tlt)
        {
            if(eo.stagename != mp.get(eo.id).stagename && eo.accountid != null)
            {
                ids.add(eo.accountid);
            }
        }
        
        //list<account> alst = [select id ,(select id , accountid, stagename from opportunities order by stagename desc limit 1 ) from account where id in :ids];
        
      list<opportunity> olst = [select accountid , stagename from opportunity where accountid in :ids];
        
        map<id,string> mh = new map<id,string>();
        
        for(opportunity eo : olst)
        {
            mh.put(eo.AccountId,eo.StageName);
        }
        
        list<account> alst = [select id from account where id in :ids];
        
        list<account> uplst = new list<account>();
        
        for(account ea : alst)
        {
            ea.description = mh.get(ea.id);
            uplst.add(ea);
            
        }
        
        update uplst;
            
        
    }
    
     public static void upOpClsdatetoAcc (list<opportunity> tlt , map<id,opportunity> mp )
     {
         set<id> ids = new set<id>();
         for(opportunity ol : tlt)
         {
             if(ol.stagename == 'closed won'  && ol.AccountId != null && ol.CloseDate != mp.get(ol.id).closedate)
             {
                 ids.add(ol.AccountId);
             }
         }
         
       //list<account> als = [select id ,(select accountid , closedate from opportunities where stagename = 'closed won' order by closedate desc limit 1) from account where id in :ids];
         
         /*list<account> alst = new list<account>();
         for(account al : als)
         {
             al.SLAExpirationDate__c  = al.opportunities[0].closedate;
             alst.add(al);
         }
         
         update alst;*/
         
         map<id,account> als = new map<id,account>([select id , description from account where id in :ids]);
         map<id,account> uplas = new map<id,account>();
         
         for(opportunity kl : tlt)
         {
             if(als.containskey(kl.accountid))
             {
                 account acc = als.get(kl.accountid);
                 acc.SLAExpirationDate__c = kl.closedate;
                 uplas.put(acc.id,acc);
                 
             }
         }
         
         update uplas.values();
         
         
         
         
         
         
      }
    
    public static void stoponeoppinse (list<opportunity> tlt )
    {
        
        set<id> ids = new set<id>();
        for(opportunity ol : tlt)
        {
            if(ol.AccountId != null)
            {
                ids.add(ol.AccountId);
            }
        }
        
       	//map<id,account> mp = new map<id,account>([select id from account where id in :ids]); 
       	//
       	list<aggregateresult> ar = [select count(id) cnt , accountid from opportunity where accountid in : ids and createddate = today group by accountid ];
       
        system.debug(limits.getqueries());
        
        map<id,integer> llp = new map<id,integer>();
        
        for(aggregateresult rrl : ar)
        {
            llp.put((id)rrl.get('accountid'),(integer)rrl.get('cnt'));
        }
        
        for(opportunity el : tlt)
        {
            if(llp.containskey(el.accountid) && llp.get(el.accountid) > 0)
            {
                el.adderror('You cannot insert more than one opportunity');
            }
        }
        
    }
    
    public static void crttaskoruptsk (list<opportunity> tlt , map<id,opportunity> op)
        
    {
        set<id> ids = new set<id>();
         for(opportunity ol : tlt)
        {
            if(ol.StageName != op.get(ol.id).stagename )
            {
                ids.add(ol.id);
                
            }
        }
        
        list<task> tsk = [select id , whatid from task where whatid in :ids];
        
        map<id,task> mptsk  = new map<id,task>();
        
        for(task tk : tsk)
        {
            mptsk.put(tk.WhatId,tk);
        }
        
        
        for(opportunity tl : tlt)
        {
            if(mptsk.containskey(tl.id))
            {
                task tu = mptsk.get(tl.Id);
              		tu.Description = tl.StageName;
                
            }
            
            else
            {
                task lk = new task();
                lk.whatid = tl.Id;
                
            }
        }
        
        
        
        
        
    }
    
    public static void countotopp(list<opportunity> tlt , list<opportunity> op)
    {
        
        set<id> ids = new set<id>();
        
        for(opportunity kl : tlt)
        {
            if(kl.AccountId != null)
            {
                ids.add(kl.AccountId);
            }
        }
        
        for(opportunity hl : op)
        {
            if(hl.accountid != null)
            {
                ids.add(hl.AccountId);
            }
        }
        
        list<account> ldt = [select id , (select id from opportunities where stagename = 'closed won') from account where id in :ids];
        
        list<account> rt  = new list<account>();
        
        for(account ac : ldt)
        {
            ac.NumberofLocations__c = ac.opportunities.size();
            rt.add(ac);
        }
        
        update rt;
    }
    
     public static void usermail(list<opportunity> tlt )
     {
         set<id> ids = new set<id>();
         set<id> uids = new set<id>();
         for(opportunity rl : tlt)
         {
             if(rl.Amount > 10000 && rl.Notification_Sent_c__c	 == false)
             {
                 ids.add(rl.id);
                 uids.add(rl.OwnerId);
                 
             }
         }
         
         list<user> ur = [select name , email from user where id in :uids];
         
         list<string> st = new list<string>();
         
         for(user dd : ur)
         {
             st.add(dd.email);
         }
         
         for(opportunity no : tlt)
         {
             
              if(no.Amount > 10000 && no.Notification_Sent_c__c	 == false)
              {
                  no.Notification_Sent_c__c	 = True;
                  no.StageName = 'Negotiation/Review';
                  
                  
                   Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            // Set recipients to two contact IDs.
            // Replace IDs with valid record IDs in your org.
            message.toAddresses = st;
            message.optOutPolicy = 'FILTER';
            message.subject = 'Alert! 10,000 ' ;
           message.setHTMLBody('Hi Sir, <p></p>You have changes the amount more than 10,000 <p></p> Thanks & Regards <p></p> ')  ;
        
            Messaging.SingleEmailMessage[] messages = 
                new List<Messaging.SingleEmailMessage> {message};
                     Messaging.SendEmail(messages);
                  
                  
              }
             
             
             
         }
         
        
         
     }
    
    public static void ststinacc(list<opportunity> tlt  )
    {
        set<id> ids = new set<id>();
        for(opportunity wl : tlt)
        {
            if(wl.accountid != null)
            {
                ids.add(wl.accountid);
            }
        }
        
        
        
        
        map<id,account> mp = new map<id,account>([select name from account where id in  :ids]);
        
        map<id,account> uplst = new map<id,account>();
        
        for(opportunity yul  : tlt)
        {
            if(mp.containskey(yul.accountid))
            {
                account a = mp.get(yul.accountid);
                a.Description = yul.StageName;
                uplst.put(a.id,a);
            }
        }
        
        
        
        update uplst.values();
        
    }
    
     public static void latesamtinacc(list<opportunity> tlt  )
     {
			set<id> ids  = new set<id>();        
         for(opportunity lk : tlt)
         {
             if(lk.accountid != null && lk.amount != null)
             {
                 ids.add(lk.accountid);
             }
         }
         
         map<id,account> amp = new map<id,account>([select id , AnnualRevenue from account where id in :ids]);
         
         map<id,account> tru = new map<id,account>();
         
         for(opportunity tr  : tlt)
         {
          	if(amp.containskey(tr.accountid))
            {
                account a = amp.get(tr.accountid);
                a.AnnualRevenue = tr.Amount;
                tru.put(a.id,a);
                
                
                
            }
             
         }
         
         update tru.values();
         
     }
    
	public static void accstat(list<opportunity> tlt)
    {	
        set<id> ids = new set <id>();
        for(opportunity op : tlt)
        {
            if(op.accountid != null)
            {
                ids.add(op.accountid);
            }
        }
        
        map<id,account> ac = new map<id,account>([select id , Current_Opp_Stage__c from account where id in :ids]);
        
        //list<account> al  = [select name, (select stagename from opportunities ) from account where id in :ids];
        
        //list<opportunity> wq = [select name , accountid from opportunity where accountid in :ids];
        
        
        
        map<id,account> upmap = new map<id,account>();
        
        for(opportunity de : tlt)
        {
            if(ac.containskey(de.accountid))
            {
                account a  = ac.get(de.AccountId);
                if(de.StageName == 'Negotiation/Review' || de.StageName == 'Proposal/Price Quote' )
                {
                    a.Current_Opp_Stage__c = 'In Progress';
                }
                else if(de.StageName == 'Closed Won' || de.StageName == 'Closed Lost'  )
                {
                    a.Current_Opp_Stage__c = 'Completed';
                }
                else
                {
                    a.Current_Opp_Stage__c = 'Pending';
                }
                upmap.put(a.id,a);
            }
            
        }
        update upmap.values();
    }
       
public static void stageduration (list<opportunity> tlt , map<id,opportunity> mp)
{
   set<id> ids = new set<id>();
    for(opportunity ol :tlt)
    {
        if(ol.StageName != mp.get(ol.id).stagename && mp.get(ol.id).Status_Start_date__c != null)
        {
           Integer daysSpent = mp.get(ol.id).Status_Start_date__c.daysBetween(System.today());
                ol.DaysInPreviousStage__c = daysSpent;
            ol.Status_Start_date__c = System.today();
        }
        else if( ol.StageName != mp.get(ol.id).stagename && mp.get(ol.id).Status_Start_date__c == null)
        {
            ol.Status_Start_date__c = System.today();
        }
        
    }
    
    
}
    
    public static void closdainacc(list<opportunity> tlt )
    {
        set<id> ids = new set<id>();
        for(opportunity el : tlt)
        {
            if(el.StageName == 'closed won' && el.AccountId != null)
            {
                ids.add(el.accountid);
            }
        }
        
        map<id,account> tr = new map<id,account>([select id , Opp_Close_Date__c  from account where id in :ids]);
        
        map<id,account> upma = new map<id,account>();
        
         for(opportunity ew : tlt)
         {
             if(tr.containskey(ew.AccountId))
             {
                 account a = tr.get(ew.AccountId);
                 a.Opp_Close_Date__c = ew.CloseDate;
                 upma.put(a.id,a);
                 
             }
         }
        
        update upma.values();
        
    }
    
     public static void upaccclsopp(list<opportunity> tlt )
   {
       set<id> ids = new set<id>();
       for(opportunity lk : tlt)
       {
           if(lk.accountid != null )
           {
               ids.add(lk.accountid);
           }
       }
       
       
        Map<Id, Boolean> accountClosedMap = new Map<Id, Boolean>();

    // Query all related opportunities for the collected Account IDs
    List<Opportunity> relatedOpportunities = [SELECT AccountId, StageName FROM Opportunity WHERE AccountId IN :ids];

    // Initialize accountClosedMap with true, assuming all are closed initially
    for (Opportunity opp : relatedOpportunities) {
        if (!accountClosedMap.containsKey(opp.AccountId)) {
            accountClosedMap.put(opp.AccountId, true);
        }
        // If any opportunity is not 'Closed Won' or 'Closed Lost', set to false
        if (opp.StageName != 'Closed Won' && opp.StageName != 'Closed Lost') {
            accountClosedMap.put(opp.AccountId, false);
        }
    }
       
       
       list<account> acc = [select id , All_Opportunity_Closed__c from account where id in :ids];
       
       list<account> uplst = new list<account>();
       
       for (Account accc : acc) {
        Boolean allClosed = accountClosedMap.get(accc.Id);
        if (accc.All_Opportunity_Closed__c != allClosed) {
            accc.All_Opportunity_Closed__c = allClosed;
            uplst.add(accc);
        }
       
       
       
       
       
       
       
       
       
       
       /*for(account ds : acc)
       {
           ds.All_Opportunity_Closed__c = true;
           uplst.add(ds);
       }*/
       
       update uplst;
   }
    
   
}
    
    
    public static void sumcntofamt(list<opportunity> tlt )
    {
        set<id> ids = new set<id>();
        for(opportunity er : tlt)
        {
            if(er.AccountId != null)
            {
                ids.add(er.AccountId);
            }
            
            
        }
        
        list<aggregateresult> ag = [select sum(amount) amt  , count(id) cnt , accountid from opportunity where accountid in :ids 
                                    and stagename = 'closed won' group by accountid];
        
         Map<Id, Decimal> accountAmountMap = new Map<Id, Decimal>();
        Map<Id, Integer> accountCountMap = new Map<Id, Integer>();
        
        
        for(aggregateresult agg : ag)
        {
            accountAmountMap.put((id)agg.get('accountid') , (decimal)agg.get('amt'));
            accountAmountMap.put((id)agg.get('accountid') , (Integer)agg.get('cnt'));
        }
        
        
        
    }
    
     public static void modifidatetod(list<opportunity> tlt , map<id,opportunity> mp)
     {
         set<id> ids = new set<id>();
         for(opportunity tr : tlt)
         {
             if(tr.StageName != mp.get(tr.id).stagename)
             {
					ids.add(tr.AccountId);
             }
         }
         
         
         list<account> al = [select id from account where id in :ids];
         
         list<account> uplst = new list<account>();
         
         for(account er : al)
         {
             er.Opp_Close_Date__c = system.today();
             uplst.add(er);
         }
         
         update uplst;
         
     }
    
    public static void crettsk(list<opportunity> tlt)
    {
         List<Task> tasksToCreate = new List<Task>();
        for(opportunity tl : tlt)
        {
            if(tl.StageName == 'Negotiation/Review')
            {
                
                Task t = new task();
                t.WhatId = tl.Id;
                t.Subject = 'Follow-up on Negotiation';
                t.OwnerId = tl.OwnerId;
                t.ActivityDate = Date.today().addDays(3);
                
                tasksToCreate.add(t);
                
            }
        }
        
        insert tasksToCreate;
        
    }
    
    
    public static void lineper(list<opportunity> tlt)
    {
        
        set<id> ids = new set<id>();
        for(opportunity ol : tlt)
        {
            if(ol.StageName == 'closed won')
            {
                ids.add(ol.id);
            }
        }
        
        list<OpportunityLineItem>  ot = [select OpportunityId from OpportunityLineItem where OpportunityId in :ids  ];
        
        
        for(OpportunityLineItem tr : ot)
        {
            tr.Discount_Percentage__c = tr.UnitPrice * 0.1; 
        }
    } 
    
    
    public static void nochg( list<opportunity> lp , map<id,opportunity> np  )
    {
        
        
        for(opportunity tr :  lp)
        {
            if(tr.StageName == 'closed won' )
            {
                np.get(tr.Id).adderror('You cannot modify a closed Opportunity');
            }
                      
        }
    }
    
    public static void accownnot(list<opportunity> tlt)
    {
        set<id> ids = new set<id>();
        
        for(opportunity tr : tlt)
        {
          if(tr.stagename == 'closed won'  && tr.Amount > 10000)
          {
              ids.add(tr.AccountId);
          }
        }
        
       list<user> al = [select  id , email from user where id in (select ownerid from account where id in :ids)];
        
        list<string> st = new list<string>();
        
        for(user ul : al)
        {
            st.add(ul.Email);
        }
		
        for(opportunity te : tlt)
        {
            if(te.stagename == 'closed won'  && te.Amount > 10000)
            {
                   Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            // Set recipients to two contact IDs.
            // Replace IDs with valid record IDs in your org.
            message.toAddresses = st;
            message.optOutPolicy = 'FILTER';
            message.subject = 'Alert! 10,000 ' ;
           message.setHTMLBody('Hi Sir, <p></p>You have changes opp ' +te.Name +' the amount more than 10,000 with close date' + te.CloseDate +' <p></p> Thanks & Regards <p></p> ')  ;
        
            Messaging.SingleEmailMessage[] messages = 
                new List<Messaging.SingleEmailMessage> {message};
                     Messaging.SendEmail(messages);
                }
                  
        }
        
        
        
        }
        
        
public static void updatedate(list<opportunity> tlt)
{
    set<id> ids = new set<id>();
    for(opportunity nl : tlt)
    {
        if(nl.stagename == 'Closed Lost' && nl.accountid != null)
        {
            ids.add(nl.accountid);
        }
    }

    list<account> al = [select id from account where id in :ids];

    list<account> uplst = new list<account>();

    for(account fr : al)
    {
        fr.Opp_Close_Date__c = system.today();
        uplst.add(fr);
    }

    update uplst; 
}
    
   
}