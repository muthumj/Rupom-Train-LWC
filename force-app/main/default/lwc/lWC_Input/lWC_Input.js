import { LightningElement } from 'lwc';

export default class LWC_Input extends LightningElement 
{
    num1 = 100;
    num2 = 200;
    num3 = 300;

    cnum1(event)
    {
        this.num1=event.target.value;
    }
    cnum2(event)
    {
        this.num2=event.target.value;
    }
    cnum3(event)
    {
        this.num3=event.target.value;
    }
    callme(event)
    {
        alert('The value of Num1 is' + this.num1 +'The value of Num2 is' + this.num2 +'The value of Num3 is' + this.num3)
    }
}