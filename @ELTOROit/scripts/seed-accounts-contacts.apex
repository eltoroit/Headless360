// ─── CLEANUP (idempotent re-run) ───────────────────────────────────────────
Set<String> seedAccountNames = new Set<String>{
    'Acme Learning Corp','TechCorp Solutions','BigBank Financial','SmallCo Ltd',
    'Absent & Associates','First Consulting','Wandering Stars','Ring & Bell Services'
};
List<Account> existingAccounts = [SELECT Id FROM Account WHERE Name IN :seedAccountNames];
if (!existingAccounts.isEmpty()) {
    Set<Id> accIds = new Map<Id, Account>(existingAccounts).keySet();
    delete [SELECT Id FROM Case    WHERE AccountId IN :accIds];
    delete [SELECT Id FROM TODO__c WHERE Contact__r.AccountId IN :accIds];
    delete [SELECT Id FROM Contact WHERE AccountId IN :accIds];
    delete existingAccounts;
}

// ─── ACCOUNTS ──────────────────────────────────────────────────────────────
List<Account> accounts = new List<Account>{
    new Account(Name='Acme Learning Corp',   RiskLevel__c='At-Risk', SupportSlaStatus__c='Breached', RenewalDate__c=Date.today().addDays(30)),
    new Account(Name='TechCorp Solutions',   RiskLevel__c='VIP',     SupportSlaStatus__c='Normal'),
    new Account(Name='BigBank Financial',    RiskLevel__c='At-Risk', SupportSlaStatus__c='At-Risk',  RenewalDate__c=Date.today().addDays(60)),
    new Account(Name='SmallCo Ltd',          RiskLevel__c='Normal',  SupportSlaStatus__c='Normal'),
    new Account(Name='Absent & Associates',  RiskLevel__c='VIP',     SupportSlaStatus__c='Normal'),
    new Account(Name='First Consulting',     RiskLevel__c='At-Risk', SupportSlaStatus__c='Normal',   RenewalDate__c=Date.today().addDays(90)),
    new Account(Name='Wandering Stars',      RiskLevel__c='Normal',  SupportSlaStatus__c='Normal'),
    new Account(Name='Ring & Bell Services', RiskLevel__c='Normal',  SupportSlaStatus__c='Normal')
};
insert accounts;
System.debug('Accounts inserted: ' + accounts.size());

Map<String, Id> accMap = new Map<String, Id>();
for (Account a : [SELECT Id, Name FROM Account WHERE Name IN ('Acme Learning Corp','TechCorp Solutions','BigBank Financial','SmallCo Ltd','Absent & Associates','First Consulting','Wandering Stars','Ring & Bell Services')]) {
    accMap.put(a.Name, a.Id);
}

// ─── CONTACTS ──────────────────────────────────────────────────────────────
List<Contact> contacts = new List<Contact>{
    new Contact(FirstName='May',        LastName='Q\'Learn',       AccountId=accMap.get('Acme Learning Corp'),   Email='may.qlearn@acme.example.com'),
    new Contact(FirstName='Joe',        LastName='King',           AccountId=accMap.get('TechCorp Solutions'),   Email='joe.king@techcorp.example.com'),
    new Contact(FirstName='Willie',     LastName='Makit',          AccountId=accMap.get('BigBank Financial'),    Email='willie.makit@bigbank.example.com'),
    new Contact(FirstName='Colin',      LastName='Sik',            AccountId=accMap.get('SmallCo Ltd'),          Email='colin.sik@smallco.example.com'),
    new Contact(FirstName='Manuel',     LastName='Labor',          AccountId=accMap.get('BigBank Financial'),    Email='manuel.labor@bigbank.example.com'),
    new Contact(FirstName='Norma Leigh',LastName='Absent',         AccountId=accMap.get('Absent & Associates'),  Email='norma.absent@absent.example.com'),
    new Contact(FirstName='Earl E.',    LastName='Bird',           AccountId=accMap.get('First Consulting'),     Email='earl.bird@first.example.com'),
    new Contact(FirstName='Warren',     LastName='Peace',          AccountId=accMap.get('BigBank Financial'),    Email='warren.peace@bigbank.example.com'),
    new Contact(FirstName='Mona',       LastName='Lott',           AccountId=accMap.get('BigBank Financial'),    Email='mona.lott@bigbank.example.com'),
    new Contact(FirstName='Hugo',       LastName='First',          AccountId=accMap.get('First Consulting'),     Email='hugo.first@first.example.com'),
    new Contact(FirstName='Percy',      LastName='Vere',           AccountId=accMap.get('TechCorp Solutions'),   Email='percy.vere@techcorp.example.com'),
    new Contact(FirstName='Al',         LastName='Zeimers',        AccountId=accMap.get('Wandering Stars'),      Email='al.zeimers@wandering.example.com'),
    new Contact(FirstName='Wynn',       LastName='Dosaplikayshun', AccountId=accMap.get('Wandering Stars'),      Email='wynn.dos@wandering.example.com'),
    new Contact(FirstName='Dee',        LastName='Mandingboss',    AccountId=accMap.get('Wandering Stars'),      Email='dee.mandingboss@wandering.example.com'),
    new Contact(FirstName='Constance',  LastName='Noring',         AccountId=accMap.get('Ring & Bell Services'), Email='constance.noring@ring.example.com')
};
insert contacts;
System.debug('Contacts inserted: ' + contacts.size());
