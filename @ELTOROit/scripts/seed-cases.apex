// ─── CASES ─────────────────────────────────────────────────────────────────
// Category__c is pre-filled so Flow 1 (ET_Case_Assign_Category) does not fire.
// All 30 cases inserted in a single DML call.

Map<String, Id> accMap = new Map<String, Id>();
for (Account a : [SELECT Id, Name FROM Account WHERE Name IN ('Acme Learning Corp','TechCorp Solutions','BigBank Financial','SmallCo Ltd','Absent & Associates','First Consulting','Wandering Stars','Ring & Bell Services')]) {
    accMap.put(a.Name, a.Id);
}

Map<String, Id> conMap = new Map<String, Id>();
for (Contact c : [SELECT Id, FirstName, LastName FROM Contact WHERE Email LIKE '%example.com']) {
    conMap.put(c.FirstName + ' ' + c.LastName, c.Id);
}

List<Case> allCases = new List<Case>();

// The 4 sorting duplicates — demo centerpiece
allCases.add(new Case(Subject='Add sorting to table',        Category__c='Feature Request', Status='New', AccountId=accMap.get('Acme Learning Corp'),  ContactId=conMap.get('May Q\'Learn'),       Description='I want to sort by column. I have clicked the headers 47 times. Nothing happens.'));
allCases.add(new Case(Subject='Table sorting not available', Category__c='Feature Request', Status='New', AccountId=accMap.get('TechCorp Solutions'),  ContactId=conMap.get('Joe King'),           Description='Need sorting capability. Our team has a bet on whether this will ever get fixed.'));
allCases.add(new Case(Subject='Sorting is missing',          Category__c='Feature Request', Status='New', AccountId=accMap.get('SmallCo Ltd'),          ContactId=conMap.get('Colin Sik'),         Description='This is nice, but the sorting is not adjustable. I sorted my desk drawer instead.'));
allCases.add(new Case(Subject='Can\'t sort columns',         Category__c='Feature Request', Status='New', AccountId=accMap.get('BigBank Financial'),    ContactId=conMap.get('Willie Makit'),       Description='I would like to have the ability to sort. My spreadsheet has sorting. Your app does not.'));

// 26 supporting cases — all contacts represented
allCases.add(new Case(Subject='App crashes on large datasets',  Category__c='Bug',             Status='New', AccountId=accMap.get('First Consulting'),    ContactId=conMap.get('Hugo First'),         Description='Crashes loading more than 1000 items. It does not just crash — it commits to crashing.'));
allCases.add(new Case(Subject='Dark mode please',               Category__c='Feature Request', Status='New', AccountId=accMap.get('Absent & Associates'), ContactId=conMap.get('Norma Leigh Absent'), Description='Please add dark mode. My eyes are writing a formal complaint.'));
allCases.add(new Case(Subject='Bulk edit items',                Category__c='Feature Request', Status='New', AccountId=accMap.get('BigBank Financial'),   ContactId=conMap.get('Manuel Labor'),       Description='Can we edit multiple items at once? I have 200 records. I have 200 regrets.'));
allCases.add(new Case(Subject='Search is too slow',             Category__c='Bug',             Status='New', AccountId=accMap.get('First Consulting'),    ContactId=conMap.get('Earl E. Bird'),       Description='Search takes 10 or more seconds. I have made coffee, reconsidered my career. Still loading.'));
allCases.add(new Case(Subject='Duplicate records appearing',    Category__c='Bug',             Status='New', AccountId=accMap.get('TechCorp Solutions'),  ContactId=conMap.get('Percy Vere'),         Description='Same contact shows up twice. Double the contacts, double the fun. Right?'));
allCases.add(new Case(Subject='Status change history',          Category__c='Feature Request', Status='New', AccountId=accMap.get('BigBank Financial'),   ContactId=conMap.get('Warren Peace'),       Description='Need to see when each task changed status. Audit trail for the team.'));
allCases.add(new Case(Subject='Assignee field on tasks',        Category__c='Feature Request', Status='New', AccountId=accMap.get('BigBank Financial'),   ContactId=conMap.get('Mona Lott'),          Description='Need to assign a task to a specific team member, not just the logged-in user.'));
allCases.add(new Case(Subject='Embed in Slack',                 Category__c='Feature Request', Status='New', AccountId=accMap.get('First Consulting'),    ContactId=conMap.get('Hugo First'),         Description='A Slack integration to create and update tasks without leaving Slack.'));
allCases.add(new Case(Subject='Offline mode',                   Category__c='Feature Request', Status='New', AccountId=accMap.get('TechCorp Solutions'),  ContactId=conMap.get('Percy Vere'),         Description='App is unusable when the internet drops. Basic offline read access would help.'));
allCases.add(new Case(Subject='Voice input for new tasks',      Category__c='Feature Request', Status='New', AccountId=accMap.get('Wandering Stars'),     ContactId=conMap.get('Wynn Dosaplikayshun'),Description='Allow dictating a task title by voice. My hands are always busy.'));
allCases.add(new Case(Subject='Saved filter presets',           Category__c='Feature Request', Status='New', AccountId=accMap.get('Wandering Stars'),     ContactId=conMap.get('Al Zeimers'),         Description='I filter by Status=In Progress every day. Let me save that filter before I forget again.'));
allCases.add(new Case(Subject='App unresponsive after update',  Category__c='Bug',             Status='New', AccountId=accMap.get('Wandering Stars'),     ContactId=conMap.get('Dee Mandingboss'),    Description='After the latest update the app freezes on load. This was needed yesterday.'));
allCases.add(new Case(Subject='Session timeout too short',      Category__c='Bug',             Status='New', AccountId=accMap.get('Ring & Bell Services'),ContactId=conMap.get('Constance Noring'),   Description='Session expires while I am reading. I blink — or doze — and I am logged out.'));
allCases.add(new Case(Subject='Accessibility improvements',     Category__c='Escalation',      Status='New', AccountId=accMap.get('Acme Learning Corp'),  ContactId=conMap.get('May Q\'Learn'),       Description='Screen reader support is broken. Tab order is random. This needs a full a11y audit.'));
allCases.add(new Case(Subject='Filter by date range',           Category__c='Feature Request', Status='New', AccountId=accMap.get('Acme Learning Corp'),  ContactId=conMap.get('May Q\'Learn'),       Description='Need to filter todos by due date range. No way to do this currently.'));
allCases.add(new Case(Subject='Add keyboard shortcuts',         Category__c='Feature Request', Status='New', AccountId=accMap.get('SmallCo Ltd'),          ContactId=conMap.get('Colin Sik'),         Description='Add keyboard navigation. I am a keyboard person. This app is not.'));
allCases.add(new Case(Subject='Inline edit in table',           Category__c='Feature Request', Status='New', AccountId=accMap.get('SmallCo Ltd'),          ContactId=conMap.get('Colin Sik'),         Description='Double-clicking a cell to edit in place would be much faster than opening a modal.'));
allCases.add(new Case(Subject='Recurring tasks',                Category__c='Feature Request', Status='New', AccountId=accMap.get('Absent & Associates'), ContactId=conMap.get('Norma Leigh Absent'), Description='Some tasks repeat every week. A recurring option would save a lot of time.'));
allCases.add(new Case(Subject='Two-factor auth',                Category__c='Escalation',      Status='New', AccountId=accMap.get('Wandering Stars'),     ContactId=conMap.get('Dee Mandingboss'),    Description='Security team requires 2FA before we can use this app in production. Needed now.'));
allCases.add(new Case(Subject='Drag and drop reorder',          Category__c='Feature Request', Status='New', AccountId=accMap.get('TechCorp Solutions'),  ContactId=conMap.get('Joe King'),           Description='Want to drag tasks to reorder by priority manually. Sorting by field is not enough.'));
allCases.add(new Case(Subject='Export data to CSV',             Category__c='Feature Request', Status='New', AccountId=accMap.get('First Consulting'),    ContactId=conMap.get('Earl E. Bird'),       Description='Need CSV export. My boss wants a report. I want a raise. Neither is happening.'));
allCases.add(new Case(Subject='Broken link in help docs',       Category__c='Bug',             Status='New', AccountId=accMap.get('Ring & Bell Services'),ContactId=conMap.get('Constance Noring'),   Description='The Help link in the footer returns 404. This is embarrassing for everyone.'));
allCases.add(new Case(Subject='Multiple sort columns',          Category__c='Feature Request', Status='New', AccountId=accMap.get('BigBank Financial'),   ContactId=conMap.get('Warren Peace'),       Description='Need to sort by Priority first, then DueDate. Single-column sort is not enough.'));
allCases.add(new Case(Subject='Colour-coded priority',          Category__c='Feature Request', Status='New', AccountId=accMap.get('Wandering Stars'),     ContactId=conMap.get('Al Zeimers'),         Description='High priority tasks should show in red. I keep forgetting which ones matter.'));
allCases.add(new Case(Subject='Comment threads on tasks',       Category__c='Feature Request', Status='New', AccountId=accMap.get('TechCorp Solutions'),  ContactId=conMap.get('Percy Vere'),         Description='Team needs to discuss tasks without leaving the app. I will keep trying until this is added.'));
allCases.add(new Case(Subject='Progress bar per task',          Category__c='Feature Request', Status='New', AccountId=accMap.get('Ring & Bell Services'),ContactId=conMap.get('Constance Noring'),   Description='A mini progress indicator would help track partially completed work between naps.'));

insert allCases;
System.debug('Cases inserted: ' + allCases.size());
