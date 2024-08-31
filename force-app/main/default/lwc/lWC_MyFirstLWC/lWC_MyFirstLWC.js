import { LightningElement } from 'lwc';

export default class LWC_MyFirstLWC extends LightningElement 
{
    nm = 'J Muthukumaran';

    callme(event)
    {
        this.nm = 'Sharukhan' ;
    }
}