![Public Sector Accelerators logo](/docs/Logo_GPSAccelerators_v01.png)

# Actionable Alerts
**Interact with Record Alerts through an enhanced experience to better support your constituents.**

View: [Accelerator Site Listing](https://pubsec-accelerators.my.site.com/accelerators/accelerator/a0wDo0000024955IAA)

## Description
Actionable Alerts provides an enhanced, action-oriented interface for better using Record Alerts in the flow of work.

Record Alerts is a powerful, out-of-the-box feature provided as a Salesforce Common Industry Component. It provides user awareness of special circumstances that need attention or action on a given record. Alerts can be created by users, through automation, and even by external systems, and are available for reporting and analytics. However, the standard way of viewing Record Alerts is informational only, leaving users without any way to quickly act on them.

This Accelerator provides a new interface for seeing these alerts - and taking immediate action to support related constituents. A configurable Lightning Web Component (LWC) improves how users see and manage their alerts, and buttons open relevant flows for working or resolving each individual alert.

This Accelerator includes a sample flow that allows users to take a number of actions. The actions are configured as subflows that can be changed as needed. The set of actions can be configured to be specific to each Record Alert category, allowing admins to provide tailored paths for different alert types. Admins can extend the available actions by creating new subflows, such as a subflow to launch Slack Case Swarming.

**Key Features and Benefits for Users**
- Manage Alerts on Records
   - Update the status of an alert
   - Change button labels
   - Configure the number of alerts to show on a record page
   - Show or hide snoozed alerts
   - Filter by alert severity
   - Open an alert and keep it open in context within tabs and sub-tabs on records (if used from a console app)
- Manage Alerts with Mass Actions
   - Leverage a pre-built flow for mass actions or build your own
   - Use mass/bulk actions to manage the status of alerts

**Key Features and Benefits for Administrators**
- Configure the severity levels of alerts and which types of severities are displayed in red in the record page for the LWC
- Configure row-level and mass actions to manage alerts
- Leverage flows to display actions on records for your staff
- Define alert categories and use/extend pre-configured categories
- Manage pre-defined alert icons (custom and SLDS icons)

Actionable Alerts empowers Education, Nonprofit, and Public Sector teams to efficiently manage alerts directly on records, and makes it easy for administrators to customize alerts to enhance productivity and ensure critical information and processes are easily accessible. With features like configurable severity levels, mass action capabilities, and customizable alert categories, this solution streamlines alert handling and adapts to organizational needs.

## Included Assets
This Accelerator includes the following key assets:

1. An <strong>unmanaged package</strong> (link below; metadata is also found in the /force-app/main/default/ folder) that includes:
   - Apex classes (x12)
   - Custom fields on the standard RecordAlert object (x2)
   - Custom metadata type
   - Flows (x12)
   - Lightning Web Components (x6)
   - Permission set for end users
   - Record Alert Categories (x5)
   - Static resources for sample custom icons (x3)
2. <strong>Documentation</strong>

## Before You Install

<!--[Required. Pre-requisites, dependencies, license requirements, and other assumptions and caveats should be declared here. Consider content that's specific to the Accelerator and the type of product or technology involved. The PMO may also add assumptions or notes that more broadly apply to the entire program.]-->

### **License Requirements** 
Industry Solutions (e.g., Education Cloud, Nonprofit Cloud, Public Sector Solutions) - requires Foundations or Advanced licenses for internal users; requires an industry-based Experience Cloud license for external users.

For more information on license requirements, please refer to the [Industry Cloud Products: User, Feature, and Permission Set Licenses](https://www.salesforce.com/ap/solutions/industries/).​

### **General Assumptions**
* You are using this Accelerator in a sandbox or test environment. It is recommended that you not install any Accelerator directly into production environments.
* If you do not have a Salesforce org licensed to you, you may try Public Sector Solutions for free with one of our [trial environments](https://developer.salesforce.com/free-trials/comparison/public-sector).
* You are using this Accelerator in conjunction with the Salesforce Lightning Experience (LEX) - not the Classic UI.

## Installation

Unmanaged package installation link: [https://test.salesforce.com/packaging/installPackage.apexp?p0=04tao00000108bJ](https://test.salesforce.com/packaging/installPackage.apexp?p0=04tao00000108bJ)

1. **Log in to Your Salesforce Environment**:
   - Use the installation link provided above to log in to your Salesforce sandbox environment.
   - **Note:** If installing in a production org, replace `test.salesforce.com` with `login.salesforce.com` in the installation URL.

2. **Install the Package**:
   - On the installation page, select "Install for Admins Only".
   - Under the section "What if existing component names conflict with ones in this package?", choose an option that aligns with your implementation requirements. This will determine how the package handles naming conflicts with existing components.

## Post-Install Setup & Configuration
1. **Assign the "Record_Alert_Display" Permission Set to End Users**.

2. **Place and Configure the Component on Lightning Record Pages**
   - Navigate to the Lightning Record Page:  
      - Go to the Lightning record page where you want to place the actionable alerts component.  
      - Click on the gear icon at the top right and select "Edit Page" from the dropdown menu.  
   - Add the Record Alert Display Component:  
      - Search for "Record Alert Display" in the components list.  
      - Drag the component (with the orange bell icon) onto the page.  
   - Configure the Component Properties:
      - Record Alert Getter Flow (required): This defaults to the one provided with the asset, but you can create a custom getter flow if needed. See [Custom Getter Flow](#custom-getter-flow-optional).  
      - Maximum Number of Alerts (optional): Set the maximum number of alerts to display.  
      - Important Alert Severity (optional): Set the severity for important alerts, which will be highlighted in red.  
      - Mass Action Flow (optional): Set a mass action flow to handle the record alerts. If not set, no button will display. The default value for this is "UX\_Record\_Alert\_Mass\_Action." See [Custom Record Alerts Mass Action Action](#custom-record-alerts-mass-action-action-optional).  
      - Button Label for Mass Action (optional): Set the button label for mass actions. The default value for this is "Manage Alerts."  
      - Button Label for Alert Level Action (optional): Set the button label for alert-level actions. The default value for this is "Manage Alert."
   - Save the Lightning Record Page:  
      - Once all configurations are set, save the Lightning record page. Your actionable alerts component should now be properly configured and displayed on the Lightning record page.


### Optional Configuration

1. **Custom Record Alert Display Config (Optional)**.  If you'd like to set a custom icon or action for a given Record Alert Category)**:
   - Navigate to Salesforce Setup (Gear Icon → Setup):  
      - Start by going to the Salesforce Setup area.  
      - Use the search bar to find "Custom Metadata Types."  
   - Open Custom Metadata Types:  
      - Once you locate the Custom Metadata Types page, find and open the "Record Alert Display Config" custom metadata type.  
      - Click on the "Manage Records" button.  
   - Create a New Record:  
      - Click on "New Record" to create a new custom metadata record.  
      - Fill in the Record Details:
         - Label: Enter the label for the Record Alert Category you want to map to an icon or process.  
         - Display Configuration Name: This should match the label you entered.  
         - Record Alert Category Developer Name: Enter the developer name for the Record Alert Category. This can be found by navigating to Setup, searching for "Record Alert Categories"  
         - Record Alert Icon: You can either enter the [SLDS icon](https://www.lightningdesignsystem.com/icons/) name (i.e. utility:alert) or the developer name of a custom Static Resource you have uploaded. See [Custom Record Alert Icon](#custom-record-alert-icon-optional).  
         - Flow Action API Name: Enter the API name of the screen flow that will be launched from alerts of this Record Alert Category. See [Custom Record Alert Action](#custom-record-alert-action-optional).
         - Button Label for Alert Level Action (optional): Set the button label for alert-level actions. The default value for this is "Manage Alert."
      - Save the Custom Metadata Record:  
         - Once all fields are populated, save the new custom metadata record.

2. **Custom Getter Flow (Optional)**.  If you'd like to configure which alerts are displayed on a record page:
   - From Salesforce Setup, create a new autolaunched flow.
   - Create a **recordId** variable:
      - API Name: `recordId`  
      - Data Type: `Text`
      - Available for input: `true`
   - Create a **recordAlerts** variable:
      - API Name: `recordAlerts`
      - Data Type: `Record`
      - Allow multiple values (collection): `true`
      - Object: `Record Alert`
      - Available for output: `true`
   - Build the logic necessary using the recordId variable to populate the recordAlerts variable.
   - Save and Activate your flow.
   - Add your flow as the **Record Alert Getter Flow** when placing the component on a Lightning Record Page.

3. **Custom Record Alerts Mass Action Action (Optional)**.  If you'd like to configure a custom mass action for your alerts displayed:
   - From Salesforce Setup, create a new screen flow.
   - Create the **recordIds** variable:
      - API Name: `recordIds`
      - Data Type: `Text`
      - Allow multiple values (collection): `true`  
      - Available for input: `true`
   - Build the logic necessary using the recordIds variable to display or take action on those Record Alerts.
   - Save and Activate your flow.  
   - Add your Flow as the **Mass Action Flow** when placing the component on a Lightning Record Page.

4. **Custom Record Alert Action (Optional)**.
   - **To make a custom set of actions for a specific Record Alert Category**, admins can clone the provided sample:
      - From Salesforce Setup, open the sample flow called "Take Action".
      - Save as a new flow.
      - Edit your new flow as desired.
      - When finished, map your flow to the desired Record Alert Categories  :
         - From Salesforce Setup, use the search bar to find "Custom Metadata Types".
         - Click "Manage Records" next to "Record Alert Display Config".
         - Edit or Create the record for the Record Alert Category you'd like to map the flow to.
         - Paste the API name into the "Flow Action API Name Field" and Save.

   - **To make a single custom action to take against record alerts of a specific Record Alert Category**, you can create a new subflow using the provided examples as a guide:
      - From Salesforce Setup, create a new screen flow.
      - Create the input variables you will need for passing data to your subflow.
         - Example:  **alertId**
            - API Name: `alertId`
            - Data Type: `Text`
            - Available for input: `true`
         - Example: **parentId**
            - API Name: `parentId`
            - Data Type: `Text`
            - Available for input: `true`
         - Example: **whatId**
            - API Name: `whatId`
            - Data Type: `Text`
            - Available for input: `true`
      - Build the logic necessary using the recordId variable to display or take action on that Record Alert or related records.  You can leverage some of the pre-built flows to take action on these.
      - Save and Activate your flow.
      - If you are using only this single flow to take action, add your Flow API Name to the Flow Action API Name field when creating a Record Alert Display Config record as described in the preceding section.
      - If you are using this as a subflow of a larger action flow, add your new flow as a subflow and map data to the input variables you created above.
         - If you need data for your flow that is not available, edit the sample flow "UX | Record Alerts | Get Related Record Details" to pull the data from the records related to the triggering Record Alert.

5. **Custom Record Alert Icon (Optional)**.  If you'd like to configure a custom icons to associate with record alerts of a specific Record Alert Category:

   - Navigate to Salesforce Setup (Gear Icon → Setup):  
      - Start by going to the Salesforce Setup area.  
      - Use the search bar to find "Static Resources."  
   - Create a new Static Resource:  
      - Once you locate the Static Resources page, select "New."  
      - Make sure your uploaded file is a .jpg or .png that is less than 5MB.
      - Set Cache Control to `Public`.
      - Save the static resource and add it to the Record Alert Icon field when creating a Record Alert Display Config record.

## **FAQs**

**_Q: Can I use this for non-Education customers?_**

A: Absolutely! While this Accelerator was initially designed with Education Cloud in mind, its versatility extends far beyond that. The component's functionality can be seamlessly applied to a wide range of industries and use cases that require actionable alerts. Its flexibility allows for easy customization to align with various business processes. Although it comes pre-configured with some basic Education-specific record alert categories, these can be easily modified, repurposed, or removed to suit your specific needs. The adaptability of this component makes it a valuable tool for enhancing alert management across diverse sectors.

**_Q: Does my org need to be an Education Cloud org to use this?_**

A: No, your org does not need to be an Education Cloud org to use this Accelerator. The Record Alerts component can be implemented in any Salesforce Industries Cloud org, regardless of the industry-specific cloud it's using. The core functionality is built on standard Salesforce features and can be adapted to different contexts. Please review [License Requirements](#license-requirements).

**_Q: Can I customize the alert types and criteria?_**

A: Yes, you can fully customize the alert types, criteria, and conditions through the configuration settings. This allows you to tailor the alerts to your organization's specific needs and requirements.

**_Q: Is this compatible with Lightning Experience and Classic?_**

A: The Record Alerts component is designed for and compatible with Lightning Experience. While some functionality may work in Classic, we recommend using Lightning Experience for the best experience and full feature set.

**_Q: Can I use this with custom objects?_**

A: Yes, the Record Alerts component can be configured to work with both standard and custom objects in your Salesforce org. You can set up alerts for any object that supports custom fields and triggers.

**_Q: Why is the Send Email action not pulling an email address?_**

A: The available email recipients depend on the records associated with the alert. The default flow assumes the Parent Record of a record alert is a Case or an Account, and the What Record is the record associated with the alert itself. To ensure email addresses populate, make sure your associated records are tied to Accounts/Contacts with email addresses.

For example, a record triggered by a low midterm grade may have the Parent Record of the student's Academic Case and the What Record as the course with the low midterm. In this example, the student and the faculty member will be available to email if they are associated with the course.

To support other objects and data strategies, customize the UX | Record Alert | Get Related Record Details and UX | Record Alert | Mange Alert sample flows.

**_Q: What Object does the Create Program Enrollment action connect to?_**

A: The sample flow connects participants to program enrollments by linking their Contact record, as this follows [Salesforce's standard data model for Program Enrollment](https://developer.salesforce.com/docs/atlas.en-us.252.0.nonprofit_cloud.meta/nonprofit_cloud/sforce_api_objects_programenrollment.htm) where Contact is the primary way to model an individual participant. You can adjust the flow to link to an Account instead if you have alerts on organizations and need to enroll them in programs, or if your implementation uses a different data model. The Program Enrollment object supports both Contact and Account relationships through the ContactId and AccountId fields respectively.

**_Q: Why does the Take a Note action show an error?_**

A: On October 25, 2024, we noticed some trial orgs have an error that hides a critical field on Interaction Summaries from all users, including the System Administrator. If you are unable to view the content of Interaction Summaries, or receive an error when using the Take a Note action, check if the Meeting Notes field is accessible. If not, we recommend using a permission set to extend access to that field to the appropriate users.

**_Q: How can I use this with generative AI?_**

A: The Record Alerts component can be integrated with generative AI in several ways. For example:
1. You could use AI to generate alert content based on certain triggers or data patterns.
2. AI could be used to categorize alerts automatically based on their content.
3. You could implement AI-powered suggestions for actions to take on specific alerts.
4. Generative AI could be used to summarize multiple alerts or provide context for complex situations.

To implement these integrations, you would need to create custom prompt templates, flows or Apex classes that interact with your chosen AI service and connect them to the Record Alerts component.

## **Additional Resources**

* [Record Alerts Documentation](https://help.salesforce.com/s/articleView?id=sf.record_alerts.htm&type=5)
* [Trail: Build Flows with Flow Builder](https://trailhead.salesforce.com/content/learn/trails/build-flows-with-flow-builder)

<!--\[Optional. Summary list of additional links and references that you think are useful to. These links should be restricted to official Salesforce web resources and should not include third party references. Use an unordered list.\]-->

## **Revision History**

2.0 Release (26 Feb 2025) - Enhanced functionality and bug fixes:
* Enhanced control on row-level alert actions with configurable button names in metadata
* Resolved task subflow bug
* Removed Education Cloud dependency for broader compatibility
* Enhanced UX improvements to manage alert flow
* Fixed email picklist fields bug

1.0 Initial release (29 Oct 2024) - Provides a lightning web component, sample metadata, and sample automation to enhance the Industries Record Alerts to enable end users to take action on alerts.

## **Acknowledgements**

* Contributor: Bradley Beecher, Ed.D., Distinguished Solution Engineer
* Contributor: Andrew Chalon, Senior Solution Engineer
* Contributor: Stephanie Brewster, Lead Solution Engineer

## Terms of Use

Thank you for using Global Public Sector (GPS) Accelerators.  Accelerators are provided by Salesforce.com, Inc., located at 1 Market Street, San Francisco, CA 94105, United States.

By using this site and these accelerators, you are agreeing to these terms. Please read them carefully.

Accelerators are not supported by Salesforce, they are supplied as-is, and are meant to be a starting point for your organization. Salesforce is not liable for the use of accelerators.

For more about the Accelerator program, visit: [https://gpsaccelerators.developer.salesforce.com/](https://gpsaccelerators.developer.salesforce.com/)
