import { LightningElement } from 'lwc';

export default class LWC_IfCondition extends LightningElement 
{
    num1;
    num2;
    num3;

    cnum1(event)
    {
        this.num1= event.target.value
    }
    cnum2(event)
    {
        this.num2= event.target.value
    }
    cnum3(event)
    {
        this.num3= event.target.value
    }
    callme(event)
    {
        if( this.num1 > this.num2 && this.num1 > this.num3  )
        {
            alert('The greatest number is ' + this.num1)
        }
         else if( this.num2 > this.num1 && this.num2 > this.num3  )
        {
            alert('The greatest number is ' + this.num2)
        }
         else
        {
            alert('The greatest number is ' + this.num3)
        }
    }
}