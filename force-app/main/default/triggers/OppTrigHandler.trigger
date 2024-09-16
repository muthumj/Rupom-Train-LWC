trigger OppTrigHandler on Opportunity (before insert , after insert , before update , after update , before delete, after delete , after undelete)
{
    
    //OppTrigHandClass.countotopp(trigger.new , trigger.old);
    
    if(trigger.isafter && trigger.isupdate)
    {
        //OppTrigHandClass.uptoamtAcc(trigger.new, trigger.oldmap);
        //OppTrigHandClass.upOpStageNmtoAcc (trigger.new, trigger.oldmap);
       //OppTrigHandClass.upOpClsdatetoAcc(trigger.new, trigger.oldmap);
       //OppTrigHandClass.ststinacc(trigger.new);
       //OppTrigHandClass.accstat(trigger.new);
      // OppTrigHandClass.closdainacc(trigger.new);
       //OppTrigHandClass.upaccclsopp(trigger.new);
       //OppTrigHandClass.modifidatetod(trigger.new, trigger.oldmap);
       //OppTrigHandClass.crettsk(trigger.new);
       //OppTrigHandClass.accownnot(trigger.new);
       OppTrigHandClass.updatedate(trigger.new);
    }
    
    if(trigger.isbefore && trigger.isinsert)
    {
        //OppTrigHandClass.stoponeoppinse(trigger.new);
        //
        //OppTrigHandClass.latesamtinacc(trigger.new);
    }
    
    if(trigger.isbefore && trigger.isupdate)
    {
       // OppTrigHandClass.usermail(trigger.new);
       	 //OppTrigHandClass.stageduration(trigger.new,trigger.oldmap);
       	 //OppTrigHandClass.nochg(trigger.old , trigger.newmap);
       	 
    }
    
    if(trigger.isafter && trigger.isinsert)
    {
        //OppTrigHandClass.ststinacc(trigger.new);
        
    }

}