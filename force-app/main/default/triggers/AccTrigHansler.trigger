trigger AccTrigHansler on Account (before insert,after insert , before update , after update, before delete ,after delete, after undelete) 
{		
    
    if(trigger.isbefore && trigger.isinsert)
    {
        //AccDupCheck.dupcheck(trigger.new);
        //AccDupCheck.biiasship(trigger.new);
         //AccDupCheck.ckeph(trigger.new);
    }
    
    if(trigger.isafter && trigger.isupdate)
    {
       	//AccDupCheck.upconPh(trigger.new , trigger.oldmap , trigger.newmap);
       // AccDupCheck.upconStat(trigger.new , trigger.oldmap , trigger.newmap);
        //AccDupCheck.upoppstage(trigger.new , trigger.oldmap , trigger.newmap);
       //AccDupCheck.ClosOpp(trigger.new , trigger.oldmap );
         AccDupCheck.phtocon(trigger.new , trigger.oldmap );
        
    }
    if(trigger.isbefore && trigger.isupdate)
    {
        //AccDupCheck.upsalesrep(trigger.new , trigger.oldmap);
         //AccDupCheck.upRatcase(trigger.new , trigger.oldmap);
    }
    
    if(trigger.isbefore && trigger.isdelete)
    {
        //AccDupCheck.delchekonopp(trigger.old);
    }
     
    

}