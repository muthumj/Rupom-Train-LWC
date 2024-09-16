trigger ConTrigHandler on Contact (before insert, after insert, before update, after update, before delete , after delete , after undelete) 
{
    
    if(trigger.isafter && trigger.isinsert)
    {
        //ConTrigHandClass.upAccPrio(trigger.new);
         //ConTrigHandClass.primconaccins(trigger.new);
        
    }
    if(trigger.isafter && trigger.isupdate )
    {
        //ConTrigHandClass.upaccdes(trigger.new,trigger.oldmap);
        //ConTrigHandClass.primconaccupd(trigger.new);
        //ConTrigHandClass.primconval(trigger.new );
        CheckBox.chekaccbox(trigger.new);

    }
    

}