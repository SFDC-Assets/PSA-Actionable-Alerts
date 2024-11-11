/*
*********************************************************
LWC Name       : richTextAreaScreenFlow
Created Date    : 9/12/2024
@description    : This component is a rich text editor for screen flows.
@version        : 1.0
@author         : Stephanie Brewster
Modification Log:
- Ver 1.0 [9/12/2024] [Stephanie Brewster] Initial Version
*********************************************************
*/

import { LightningElement, api } from 'lwc';

export default class ScreenFlowRichText extends LightningElement {
    @api fieldValue =" ";
    @api fieldLabel;
    @api required; 
    @api fieldLength;
    @api visibleLines;
    @api recordId;
    @api validity;
    

    allowedFormats = [
        'font',
        'size',
        'bold',
        'italic',
        'underline',
        'strike',
        'list',
        'indent',
        'align',
        'link',
        'image',
        'clean',
        'table',
        'header',
        'color',
        'background',
        'code',
        'code-block',
        'script',
        'blockquote',
        'direction',
    ];

    connectedCallback() {
        this.validity=true;
        document.documentElement.style.setProperty('--rta-visiblelines', (this.visibleLines * 2) + 'em');
    }

    handleChange(event) {
        if((event.target.value).length > this.fieldLength){
            this.validity=false;
            this.errorMessage = "You have exceeded the max length";
        }
       else{
        this.validity = true;
        this.fieldValue = event.target.value;
       }
    }
}