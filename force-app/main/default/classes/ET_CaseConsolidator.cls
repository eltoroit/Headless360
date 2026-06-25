/**
 * ET_CaseConsolidator.cls
 * Author: Andres Perez (ELTOROit)
 * 
 * This class is used to consolidate cases from the analysis result.
 * It is used by the ET_Case_Consolidation_Agent.agent.
 * It is used to create a master case and link the children cases to the master case.
 * It is used to set the Status field on the master case to 'New'.
 * It is used to set the Priority field on the master case to 'High'.
 * 

DELETE [SELECT Id, IsMaster__c FROM Case WHERE IsMaster__c = true];
 */
public without sharing class ET_CaseConsolidator {
	public class ConsolidatorInput {
		@InvocableVariable(label='AnalysisJSON' Description='JSON analysis result from the prompt template' required=true)
		public String analysisJSON;
	}

	public class ConsolidatorOutput {
		@InvocableVariable(label='ConsolidationResult' Description='Result of the consolidation process')
		public String message;
		@InvocableVariable(label='MasterCase' Description='Master Case created from the consolidation process')
		public Case masterCase;
		@InvocableVariable(label='Children' Description='Children Cases linked to the master case')
		public List<Case> children;
		@InvocableVariable(label='MasterCaseCreated' Description='Whether the master case was created')
		public Boolean masterCaseCreated;
		@InvocableVariable(label='AnalysisSummary' Description='Summary of the analysis process')
		public String summary;
		@InvocableVariable(label='Recommendation' Description='Recommendation from the analysis process')
		public String recommendation;
		@InvocableVariable(label='Reason' Description='Reason for the consolidation process')
		public String reason;
	}

	@InvocableMethod(label='Consolidate Cases From Analysis' description='Parses agent analysis JSON, if the first group has 2+ cases, creates a master Case and links the children.')
	public static List<ConsolidatorOutput> consolidate(List<ConsolidatorInput> inputs) {
		ConsolidatorOutput output = new ConsolidatorOutput();

		String analysisJSON = inputs[0].analysisJSON;
		if (String.isBlank(analysisJSON)) {
			output.message = 'No analysis JSON provided.';
			return new List<ConsolidatorOutput>{ output };
		}

		Map<String, Object> analysis = (Map<String, Object>) JSON.deserializeUntyped(analysisJSON);
		String analysisSummary = (String) analysis.get('analysisSummary');
		if (String.isBlank(analysisSummary)) {
			output.message = 'No analysis summary found in analysis JSON.';
			return new List<ConsolidatorOutput>{ output };
		}

		String recommendation = (String) analysis.get('recommendation');
		if (String.isBlank(recommendation)) {
			output.message = 'No recommendation found in analysis JSON.';
			return new List<ConsolidatorOutput>{ output };
		}

		List<Object> rawGroups = (List<Object>) analysis.get('casesGrouped');
		if (rawGroups == null || rawGroups.isEmpty()) {
			output.message = 'No casesGrouped found in analysis JSON.';
			return new List<ConsolidatorOutput>{ output };
		}

		Map<String, Object> firstGroup = (Map<String, Object>) rawGroups[0];
		if (firstGroup == null) {
			output.message = 'No groups found in analysis JSON. Nothing to consolidate.';
			return new List<ConsolidatorOutput>{ output };
		}

		List<Object> rawCases = (List<Object>) firstGroup.get('cases');
		if (rawCases == null || rawCases.isEmpty()) {
			output.message = 'No cases found in the first group of analysis JSON. Nothing to consolidate.';
			return new List<ConsolidatorOutput>{ output };
		}

		String reason = (String) firstGroup.get('Reason');
		if (String.isBlank(reason)) {
			output.message = 'No reason found in the first group of analysis JSON. Nothing to consolidate.';
			return new List<ConsolidatorOutput>{ output };
		}

		// Process cases
		Set<Id> allCaseIds = new Set<Id>();
		for (Object cObj : rawCases) {
			Map<String, Object> cMap = (Map<String, Object>) cObj;
			allCaseIds.add((Id) cMap.get('caseId'));
		}

		case masterCase = null;
		Boolean masterCaseCreated = false;
		List<Case> children = new List<Case>();
		Map<Id, Case> existingCases = new Map<Id, Case>([SELECT Id, CaseNumber, Subject, IsMaster__c FROM Case WHERE Id IN :allCaseIds AND Status != 'Closed']);
		for (Case c : existingCases.values()) {
			if (c.IsMaster__c) {
				masterCase = c;
			} else {
				children.add(c);
			}
		}
		if (masterCase == null) {
			masterCase = buildMasterCase(reason, recommendation, children);
			insert masterCase;
			masterCase = [SELECT Id, CaseNumber, Subject, IsMaster__c FROM Case WHERE Id = :masterCase.Id];
			masterCaseCreated = true;
		}

		for (Case c : children) {
			c.ParentId = masterCase.Id;
		}
		update children;

		// Generate information for Agentforce
		output.message = '''
			You should work on master case # ${masterCase_CaseNumber} ${masterCase_Status} (Subject: ${masterCase_Subject}). It has ${children_size} case(s) linked as children.
		'''.template(new Map<String, Object> {
			'masterCase_CaseNumber' => masterCase.CaseNumber,
			'masterCase_Subject' => masterCase.Subject,
			'masterCase_Status' => masterCaseCreated ? '(created)' : '(already exists)',
			'masterCase_Created' => masterCaseCreated,
			'children_size' => children.size()

		});
		output.masterCase = masterCase;
		output.children = children;
		output.masterCaseCreated = masterCaseCreated;
		output.summary = analysisSummary;
		output.recommendation = recommendation;
		output.reason = reason;
		return new List<ConsolidatorOutput>{ output };
	}

	private static Case buildMasterCase(String reason, String recommendation, List<Case> children) {
		// Derive a short subject from the first sentence of reason
		String shortReason = reason.contains('.') ? reason.substringBefore('.') : reason;
		return new Case(
			Subject = shortReason,
			Description = 'Reason: ' + reason + '\n\n' + 'Recommendation: ' + recommendation,
			Status = 'New',
			Priority = 'High',
			IsMaster__c = true
		);
	}

	// private static List<ConsolidatorOutput> wrap(String msg) {
	// 	return wrap(null, msg);
	// }

	// private static List<ConsolidatorOutput> wrap(Case masterCase, String msg) {
	// 	ConsolidatorOutput out = new ConsolidatorOutput();
	// 	out.message = msg;
	// 	out.masterCase = masterCase;
	// 	return new List<ConsolidatorOutput>{ out };
	// }
}