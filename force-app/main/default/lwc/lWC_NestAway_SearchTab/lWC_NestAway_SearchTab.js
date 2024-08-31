import { LightningElement } from 'lwc';

import getllbud from '@salesforce/apex/LWC_NestAwat_SearchTab.getallbud';

import {wire} from 'lwc';

const colss = 
[
    {label:'Budget Name', fieldName: 'Name' , type : 'text'},
    {label:'Budget Amount', fieldName: 'Amount__c' , type : 'number'},
    {label:'Budget Area', fieldName: 'Area__c' , type : 'text'}
    
];


export default class LWC_NestAway_SearchTab extends LightningElement 
{

    st;
    st1;
    col=colss;

    @wire(getllbud,{searchkey : '$st'}) mutubud;

    capst(event)
    {
        this.st1=event.target.value;
    }
    searchme(event)
    {
        this.st=this.st1;
    }
   

}