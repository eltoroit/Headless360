delete [SELECT Id, IsMaster__c FROM Case WHERE IsMaster__c = TRUE];

List<Case> cases = [SELECT Id, CaseNumber, IsMaster__c, ParentId, Status, isClosed FROM Case WHERE Status != 'New'];
for (Case c : cases) {
	c.Status = 'New';
}
update cases;

System.debug([SELECT Id, CaseNumber, IsMaster__c, ParentId, Status, isClosed, LastModifiedDate FROM Case ORDER BY LastModifiedDate DESC]);
