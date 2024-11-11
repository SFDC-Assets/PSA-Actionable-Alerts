/*
*********************************************************
LWC Name       : recordAlertDisplayItem
Created Date    : 9/12/2024
@description    : This component dynamically loads each record alert card.
@version        : 1.0
@author         : Andrew Chalon
Modification Log:
- Ver 1.0 [9/12/2024] [Andrew Chalon] Initial Version
*********************************************************
*/

import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class RecordAlertDisplayItem extends NavigationMixin(LightningElement)  {
    @api alert;
    @api importantAlertSeverities;
    @api buttonLabel;

    get important(){
        let array = this.stringToArray(this.importantAlertSeverities)
        return array.includes(this.alert.Severity?.toLowerCase()) ? true : false;
    }

    get badgeClass(){
        let array = this.stringToArray(this.importantAlertSeverities)
        return array.includes(this.alert.Severity?.toLowerCase()) ? 'slds-m-left_small slds-theme_error badge-important' : 'slds-m-left_small';
    }

    get badgeClassMobile(){
        let array = this.stringToArray(this.importantAlertSeverities)
        return array.includes(this.alert.Severity?.toLowerCase()) ? 'slds-m-left_medium slds-theme_error badge-important' : 'slds-m-left_medium';
    }

    get subjectClass(){
        let array = this.stringToArray(this.importantAlertSeverities);
        return array.includes(this.alert.Severity?.toLowerCase()) ? 'slds-text-color_error' : '';
    }

    get descClass(){
        let array = this.stringToArray(this.importantAlertSeverities);
        return array.includes(this.alert.Severity?.toLowerCase()) ? 'slds-text-color_error slds-truncate' : 'slds-truncate';
    }

    get descClassMobile(){
        let array = this.stringToArray(this.importantAlertSeverities);
        return array.includes(this.alert.Severity?.toLowerCase()) ? 'slds-p-around_medium slds-text-color_error slds-truncate' : 'slds-p-around_medium slds-truncate';
    }

    stringToArray(inputString) {
        if (!inputString) return [];
        return inputString
          .split(/[\s,]+/)  // Split by one or more spaces or commas
          .filter(Boolean)  // Remove empty elements
          .map(item => item.trim().toLowerCase());  // Trim and convert to lowercase
    }

    navigateToRecord() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.alert.Id,
                objectApiName: 'RecordAlert', // e.g., 'Case' or 'Account'
                actionName: 'view'
            }
        });
    }
}