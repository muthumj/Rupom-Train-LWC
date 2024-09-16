public class AccTrigHandleClass extends TriggerHandler
{
    
    
    public override void beforeinsert()
    {
        AccDupCheck.dupcheck(trigger.new);
    }
        public override void afterinsert()
    {
        
        
    }
        public override void beforeupdate()
    {
         
    }
        public override void afterupdate()
    {
       AccDupCheck.dupcheck(trigger.new );
    }
        public override void beforedelete()
    {
        
    }
   		public override void afterdelete()
    {
        
    }
    	public override void afterundelete()
    {
        
    }

}