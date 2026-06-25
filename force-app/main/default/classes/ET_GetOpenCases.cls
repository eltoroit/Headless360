/**
 * ET_GetOpenCases.cls
 * Author: Andres Perez (ELTOROit)
 * 
 * This class is used to get all open cases.
 * It is used by the ET_Case_Consolidation_Agent.agent.
 * It is used to get all open cases as a JSON array string for duplicate analysis.
 *

ET_GetOpenCases.OpenCasesInput input = new ET_GetOpenCases.OpenCasesInput();
input.dummyText = 'Dummy text to be ignored';
List<ET_GetOpenCases.OpenCasesInput> inputs = new List<ET_GetOpenCases.OpenCasesInput>();
inputs.add(input);
List<ET_GetOpenCases.OpenCasesOutput> outputs = ET_GetOpenCases.getOpenCases(inputs);
ET_GetOpenCases.OpenCasesOutput output = outputs[0];
System.debug(output);
*/
public without sharing class ET_GetOpenCases {
	public class OpenCasesInput {
		@InvocableVariable(label='DummyText' Description='Dummy text to be ignored' required=false)
		public String dummyText;
	}

	public class OpenCasesOutput {
		@InvocableVariable(label='OpenCasesJSON' Description='JSON array of open cases')
		public String openCasesJSON;
	}

	private class CaseData {
		public String id;
		public String subject;
		public Date renewalDate;
		public String slaStatus;
		public String riskLevel;
		// public String account;
		// public String contact;
	}

	@InvocableMethod(label='Get Open Cases' description='Returns all open Cases as a JSON array string for duplicate analysis')
	public static List<OpenCasesOutput> getOpenCases(List<OpenCasesInput> inputs) {
		// Agents require inputs, but we do not care for their value here!

		List<OpenCasesOutput> outputs = new List<OpenCasesOutput>();
		// if (inputs == null || inputs.isEmpty()) {
		// 	return outputs;
		// }

		List<Case> cases = [
			SELECT Id, Subject, Description, Status, Contact.Name, Account.Name, Account.RiskLevel__c, Account.SupportSlaStatus__c, Account.RenewalDate__c
			FROM Case
			WHERE Status != 'Closed'
			ORDER BY CreatedDate ASC
		];

		List<CaseData> result = new List<CaseData>();
		for (Case c : cases) {
			CaseData caseData = new CaseData();
			caseData.id = c.Id;
			caseData.subject = c.Subject;
			caseData.renewalDate = c.Account.RenewalDate__c;
			caseData.slaStatus = c.Account.SupportSlaStatus__c;
			caseData.riskLevel = c.Account.RiskLevel__c;
			// caseData.account = c.Account.Name;
			// caseData.contact = c.Contact.Name;
			result.add(caseData);
		}

		for (OpenCasesInput input : inputs) {
			// if (input == null) {
			// 	   // outputs.add(createErrorOutput('Input cannot be null'));
			//     // In this class, we do not care about the inputs!
			// } else {
			OpenCasesOutput output = new OpenCasesOutput();
			output.openCasesJSON = JSON.serialize(result);
			outputs.add(output);
			// }
		}

		System.debug('Outputs:');
		System.debug(JSON.serialize(outputs[0]));

		return outputs;
	}
}