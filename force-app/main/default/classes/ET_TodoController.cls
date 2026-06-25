/**
 * ET_TodoController.cls
 * Author: Andres Perez (ELTOROit)
 *
 * This class is used to get the contacts and todos.
 * It is used by the todoApp.js and todoTable.js.
 * It is used to get the contacts and todos for the todoApp.
 * It is used to get the todos for the todoTable.
 * **SYSTEM MODE** It's used by the Digital Experience site, so it must be "without sharing" to allow access to the contacts and todos for the users that are not internal.
 * https://developer.salesforce.com/docs/atlas.en-us.262.0.apexcode.meta/apexcode/apex_classes_enforce_usermode.htm
 */
public without sharing class ET_TodoController {
	@AuraEnabled(cacheable=true)
	public static List<Contact> getContacts() {
		return [
			SELECT Id, Name
			FROM Contact
			WITH SYSTEM_MODE
			ORDER BY Name ASC
			LIMIT 200
		];
	}

	@AuraEnabled(cacheable=true)
	public static Map<String, Object> getTodos(Id contactId) {
		return new Map<String, Object>{
			'todos' => [
				SELECT Id, Title__c, Description__c, Status__c, Priority__c, DueDate__c, Contact__c
				FROM TODO__c
				WHERE Contact__c = :contactId
				WITH SYSTEM_MODE
				ORDER BY DueDate__c ASC NULLS LAST
			],
			'contact' => [
				SELECT Id, Name
				FROM Contact
				WHERE Id = :contactId
				WITH SYSTEM_MODE
			][0] // get the first contact
		};
	}

	@AuraEnabled
	public static TODO__c createTodo(String title, String description, String status, String priority, Date dueDate, Id contactId) {
		TODO__c t = new TODO__c(Title__c = title, Description__c = description, Status__c = status, Priority__c = priority, DueDate__c = dueDate, Contact__c = contactId);
		insert as system t;
		return t;
	}

	@AuraEnabled
	public static TODO__c updateTodo(Id todoId, String title, String description, String status, String priority, Date dueDate) {
		TODO__c t = new TODO__c(Id = todoId, Title__c = title, Description__c = description, Status__c = status, Priority__c = priority, DueDate__c = dueDate);
		update as system t;
		return t;
	}

	@AuraEnabled
	public static void deleteTodo(Id todoId) {
		delete as system new TODO__c(Id = todoId);
	}
}