import { LightningElement } from 'lwc';

import NestWay from '@salesforce/apex/lwc_Nest.NestWay';
import Budget_ID from '@salesforce/schema/Budget__c.id';
import Budget_creby from '@salesforce/schema/Budget__c.CreatedById';
import Budget_credat from '@salesforce/schema/Budget__c.Created_Date__c';
import Budget_sts from '@salesforce/schema/Budget__c.Status__c';
//import Budget_role from '@salesforce/schema/Budget__c.id';
import Budget_mod from '@salesforce/schema/Budget__c.LastModifiedById';


export default class LWC_Project_NestWay extends LightningElement 
{


    myfields=  [Budget_ID,Budget_creby,Budget_credat,Budget_sts,Budget_mod];

    nam;
    amut;
    arie;
    sub;

    capname(event)
    {
        this.nam=event.target.value;
    }
    capamt(event)
    {
        this.amut=event.target.value;
    }

    capare(event)
    {
        this.arie=event.target.value;
    }

    capsub(event)
    {
        this.sub=event.target.value;
    }

    saveme(event)
    {
        NestWay({nm : this.nam , amt : this.amut , are : this.arie , sb : this.sub }).then(result=>{}).catch(error=>{});
    }


}