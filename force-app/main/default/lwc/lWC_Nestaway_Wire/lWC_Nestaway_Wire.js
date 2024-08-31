import { LightningElement } from 'lwc';

import getallbud from '@salesforce/apex/LWC_NeatAway_Wire.getallbud';
import ret from '@salesforce/apex/LWC_NeatAway_Wire.morning';
import {wire} from 'lwc';

export default class LWC_Nestaway_Wire extends LightningElement 
{
    @wire(getallbud) muthubud;
    @wire(ret) rapid;
}