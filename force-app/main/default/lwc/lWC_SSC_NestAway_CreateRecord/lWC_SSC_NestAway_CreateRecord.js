import { LightningElement } from 'lwc';
import CreateBud from '@salesforce/apex/LWC_NestAway_CreateBudget.CreateBud';





export default class LWC_SSC_NestAway_CreateRecord extends LightningElement 
{

    Nam;
    Amtu;
    Aralu;

    capname(event)
    {
        this.Nam= event.target.value;
    }
    capAmt(event)
    {
        this.Amtu= event.target.value;
    }

    capAre(event)
    {
        this.Aralu= event.target.value;
    }

    Saveme(event)
    {
        CreateBud({Nm : this.Nam, Am : this.Amtu, Ar : this.Aralu}).then(result=>{}).catch(error=>{});
    }
    
    


}