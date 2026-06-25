global with sharing class ET_CaseAnalysis {
	private static final String SAMPLE_CASE_SUMMARY_LIST;
	private static final String SAMPLE_ANALYSIS_RESULT;

	static {
		SAMPLE_CASE_SUMMARY_LIST = makeSampleCaseSummaryList();
		SAMPLE_ANALYSIS_RESULT = makeSampleAnalysisResult();
	}

    global class CaseAnalysisOutput {
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

	@InvocableMethod(label='Analyze Cases and Recommend Consolidation' description='Analyzes open cases, generates recommendations, and consolidates if needed.')
	global static List<CaseAnalysisOutput> analyzeCases(List<String> dummyInput) {
		CaseAnalysisOutput output;
        ET_CaseConsolidator.ConsolidatorOutput temp;

		Boolean doStepOpenCases = true;
		Boolean doStepAnalyzeDuplicates = true;
		String caseSummaryList = getOpenCases(doStepOpenCases);
		String analysisResult = analyzeDuplicates(doStepAnalyzeDuplicates, caseSummaryList);
		temp = consolidateCases(analysisResult);
		System.debug('Consolidation Result:');
		System.debug(JSON.serialize(temp));

        output = new CaseAnalysisOutput();
        output.message = temp.message;
        output.masterCase = temp.masterCase;
        output.children = temp.children;
        output.masterCaseCreated = temp.masterCaseCreated;
        output.summary = temp.summary;
        output.recommendation = temp.recommendation;
        output.reason = temp.reason;
		System.debug('Final Output:');
		System.debug(JSON.serialize(output));

		return new List<CaseAnalysisOutput>{output};
	}

	private static String getOpenCases(Boolean doStepOpenCases) {
		String caseSummaryList;

		if (doStepOpenCases) {
			ET_GetOpenCases.OpenCasesInput input = new ET_GetOpenCases.OpenCasesInput();
			input.dummyText = 'Dummy text to be ignored';
			List<ET_GetOpenCases.OpenCasesInput> inputs = new List<ET_GetOpenCases.OpenCasesInput>();
			inputs.add(input);
			List<ET_GetOpenCases.OpenCasesOutput> outputs = ET_GetOpenCases.getOpenCases(inputs);
			ET_GetOpenCases.OpenCasesOutput output = outputs[0];
			caseSummaryList = output.openCasesJSON;
		} else {
			caseSummaryList = SAMPLE_CASE_SUMMARY_LIST;
		}

		System.debug('Case Summary List:');
		System.debug(caseSummaryList);
		return caseSummaryList;
	}

	private static String analyzeDuplicates(Boolean doStepAnalyzeDuplicates, String caseSummaryList) {
		String analysisResult;
		if (doStepAnalyzeDuplicates) {
			ConnectApi.WrappedValue ptCaseSummaryList = new ConnectApi.WrappedValue();
			ptCaseSummaryList.value = caseSummaryList;

			Map<String, ConnectApi.WrappedValue> inputParams = new Map<String, ConnectApi.WrappedValue>();
			inputParams.put('Input:caseSummaryList', ptCaseSummaryList);

			ConnectApi.EinsteinPromptTemplateGenerationsInput ptGenInput = new ConnectApi.EinsteinPromptTemplateGenerationsInput();
			ptGenInput.inputParams = inputParams;
			ptGenInput.additionalConfig = new ConnectApi.EinsteinLlmAdditionalConfigInput();
			ptGenInput.additionalConfig.numGenerations = 1;
			ptGenInput.additionalConfig.applicationName = 'PromptTemplateGenerationsInvocable';
			ptGenInput.isPreview = false;

			ConnectApi.EinsteinPromptTemplateGenerationsRepresentation ptGenResult = ConnectApi.EinsteinLLM.generateMessagesForPromptTemplate('ET_Case_Duplicate_Analysis', ptGenInput);
			if (ptGenResult != null && ptGenResult.generations != null && !ptGenResult.generations.isEmpty()) {
				analysisResult = ptGenResult.generations[0].text;
				if (String.isBlank(analysisResult)) {
					throw new HandledException('No prompt template generations result found');
				}
			} else {
				throw new HandledException('No prompt template generations result found');
			}
		} else {
			analysisResult = SAMPLE_ANALYSIS_RESULT;
		}
		System.debug('Prompt Template Generations Analysis Result:');
		System.debug(analysisResult);
		return analysisResult;
	}

	private static ET_CaseConsolidator.ConsolidatorOutput consolidateCases(String analysisResult) {
		ET_CaseConsolidator.ConsolidatorInput input = new ET_CaseConsolidator.ConsolidatorInput();
		input.analysisJSON = analysisResult;
		List<ET_CaseConsolidator.ConsolidatorInput> inputs = new List<ET_CaseConsolidator.ConsolidatorInput>();
		inputs.add(input);
		List<ET_CaseConsolidator.ConsolidatorOutput> outputs = ET_CaseConsolidator.consolidate(inputs);
		ET_CaseConsolidator.ConsolidatorOutput output = outputs[0];
		// System.debug('Consolidation Result:');
		// System.debug(output);
		return output;
	}

	private static String makeSampleCaseSummaryList() {
		String output = '';
		output = '''
		[
		    { "subject": "Assignee field on tasks", "slaStatus": "At-Risk", "riskLevel": "At-Risk", "renewalDate": "2026-08-05", "id": "500KS000002PTJ5YAO" },
		    { "subject": "Progress bar per task", "slaStatus": "Normal", "riskLevel": "Normal", "renewalDate": null, "id": "500KS000002PTJOYA4" },
		    { "subject": "Comment threads on tasks", "slaStatus": "Normal", "riskLevel": "VIP", "renewalDate": null, "id": "500KS000002PTJNYA4" },
		    { "subject": "Colour-coded priority", "slaStatus": "Normal", "riskLevel": "Normal", "renewalDate": null, "id": "500KS000002PTJMYA4" },
		    { "subject": "Multiple sort columns", "slaStatus": "At-Risk", "riskLevel": "At-Risk", "renewalDate": "2026-08-05", "id": "500KS000002PTJLYA4" },
		    { "subject": "Broken link in help docs", "slaStatus": "Normal", "riskLevel": "Normal", "renewalDate": null, "id": "500KS000002PTJKYA4" },
		    { "subject": "Export data to CSV", "slaStatus": "Normal", "riskLevel": "At-Risk", "renewalDate": "2026-09-04", "id": "500KS000002PTJJYA4" },
		    { "subject": "Drag and drop reorder", "slaStatus": "Normal", "riskLevel": "VIP", "renewalDate": null, "id": "500KS000002PTJIYA4" },
		    { "subject": "Two-factor auth", "slaStatus": "Normal", "riskLevel": "Normal", "renewalDate": null, "id": "500KS000002PTJHYA4" },
		    { "subject": "Recurring tasks", "slaStatus": "Normal", "riskLevel": "VIP", "renewalDate": null, "id": "500KS000002PTJGYA4" },
		    { "subject": "Inline edit in table", "slaStatus": "Normal", "riskLevel": "Normal", "renewalDate": null, "id": "500KS000002PTJFYA4" },
		    { "subject": "Add keyboard shortcuts", "slaStatus": "Normal", "riskLevel": "Normal", "renewalDate": null, "id": "500KS000002PTJEYA4" },
		    { "subject": "Filter by date range", "slaStatus": "Breached", "riskLevel": "At-Risk", "renewalDate": "2026-07-06", "id": "500KS000002PTJDYA4" },
		    { "subject": "Accessibility improvements", "slaStatus": "Breached", "riskLevel": "At-Risk", "renewalDate": "2026-07-06", "id": "500KS000002PTJCYA4" },
		    { "subject": "Status change history", "slaStatus": "At-Risk", "riskLevel": "At-Risk", "renewalDate": "2026-08-05", "id": "500KS000002PTJ4YAO" },
		    { "subject": "Duplicate records appearing", "slaStatus": "Normal", "riskLevel": "VIP", "renewalDate": null, "id": "500KS000002PTJ3YAO" },
		    { "subject": "Search is too slow", "slaStatus": "Normal", "riskLevel": "At-Risk", "renewalDate": "2026-09-04", "id": "500KS000002PTJ2YAO" },
		    { "subject": "Bulk edit items", "slaStatus": "At-Risk", "riskLevel": "At-Risk", "renewalDate": "2026-08-05", "id": "500KS000002PTJ1YAO" },
		    { "subject": "Dark mode please", "slaStatus": "Normal", "riskLevel": "VIP", "renewalDate": null, "id": "500KS000002PTJ0YAO" },
		    { "subject": "App crashes on large datasets", "slaStatus": "Normal", "riskLevel": "At-Risk", "renewalDate": "2026-09-04", "id": "500KS000002PTIzYAO" },
		    { "subject": "Can't sort columns", "slaStatus": "At-Risk", "riskLevel": "At-Risk", "renewalDate": "2026-08-05", "id": "500KS000002PTIyYAO" },
		    { "subject": "Sorting is missing", "slaStatus": "Normal", "riskLevel": "Normal", "renewalDate": null, "id": "500KS000002PTIxYAO" },
		    { "subject": "Table sorting not available", "slaStatus": "Normal", "riskLevel": "VIP", "renewalDate": null, "id": "500KS000002PTIwYAO" },
		    { "subject": "Add sorting to table", "slaStatus": "Breached", "riskLevel": "At-Risk", "renewalDate": "2026-07-06", "id": "500KS000002PTIvYAO" },
		    { "subject": "Session timeout too short", "slaStatus": "Normal", "riskLevel": "Normal", "renewalDate": null, "id": "500KS000002PTJBYA4" },
		    { "subject": "App unresponsive after update", "slaStatus": "Normal", "riskLevel": "Normal", "renewalDate": null, "id": "500KS000002PTJAYA4" },
		    { "subject": "Saved filter presets", "slaStatus": "Normal", "riskLevel": "Normal", "renewalDate": null, "id": "500KS000002PTJ9YAO" },
		    { "subject": "Voice input for new tasks", "slaStatus": "Normal", "riskLevel": "Normal", "renewalDate": null, "id": "500KS000002PTJ8YAO" },
		    { "subject": "Offline mode", "slaStatus": "Normal", "riskLevel": "VIP", "renewalDate": null, "id": "500KS000002PTJ7YAO" },
		    { "subject": "Embed in Slack", "slaStatus": "Normal", "riskLevel": "At-Risk", "renewalDate": "2026-09-04", "id": "500KS000002PTJ6YAO" },
		    { "subject": "Breached SLA items: accessibility, filter by date range, and add sorting to table are past SLA and require immediate attention", "slaStatus": null, "riskLevel": null, "renewalDate": null,"id": "500KS000002PTJZYA4"}
		]
		''';
		return output;
	}
	private static String makeSampleAnalysisResult() {
		String output = '';
		output = '''
		    {
		        "analysisSummary": "I reviewed all open cases and grouped them by underlying functional issues. Priority was assigned according to breached SLAs first, then At-Risk accounts, VIP accounts, upcoming renewals, and finally duplicate counts. Similar sorting-related issues were consolidated into a single sorting group. Note that one descriptive case lists breached items; it was treated as informational and mapped to the corresponding breached groups.",
		        "recommendation": "Address Breached SLA groups immediately: the sorting, filter-by-date-range, and accessibility issues must be triaged and staffed. Next, escalate At-Risk groups that affect account renewals and multiple cases (sorting-related At-Risk items, bulk edit, assignee/status history). Then engage VIP customers for their feature/bug reports (comments, drag-and-drop, recurring tasks, duplicate records, dark mode, offline mode, table sorting VIP report). For cases tied to upcoming renewals within 60–90 days, provide proactive account outreach and status updates. Consolidate duplicate sorting tickets into a single engineering issue to reduce work duplication. Acknowledge receipt to all VIP and Breached SLA customers within the hour and set next-step timelines for At-Risk customers within 24 hours.",
		        "casesGrouped": [
		            {
		            "count": 7,
		            "Reason": "Sorting functionality; includes breached and At-Risk items related to adding or fixing table/column sorting and poor sorting behavior. Contains at least one Breached SLA.",
		            "cases": [
		                { "caseId": "500KS000002PTIvYAO", "subject": "Add sorting to table" },
		                { "caseId": "500KS000002PTIyYAO", "subject": "Can't sort columns" },
		                { "caseId": "500KS000002PTIxYAO", "subject": "Sorting is missing" },
		                { "caseId": "500KS000002PTIwYAO", "subject": "Table sorting not available" },
		                { "caseId": "500KS000002PTJLYA4", "subject": "Multiple sort columns" },
		                { "caseId": "500KS000002PTJOYA4", "subject": "Progress bar per task" },
		                { "caseId": "500KS000002PTJFYA4", "subject": "Inline edit in table" }
		            ]
		            },
		            {
		            "count": 3,
		            "Reason": "Breached SLA: filter by date range and accessibility issues require immediate attention and remediation.",
		            "cases": [
		                { "caseId": "500KS000002PTJDYA4", "subject": "Filter by date range" },
		                { "caseId": "500KS000002PTJCYA4", "subject": "Accessibility improvements" },
		                { "caseId": "500KS000002PTJZYA4", "subject": "Breached SLA items: accessibility, filter by date range, and add sorting to table are past SLA and require immediate attention" }
		            ]
		            },
		            {
		            "count": 4,
		            "Reason": "At-Risk account feature/bug reports affecting productivity and upcoming renewals; prioritize outreach and fixes.",
		            "cases": [
		                { "caseId": "500KS000002PTJ5YAO", "subject": "Assignee field on tasks" },
		                { "caseId": "500KS000002PTJ4YAO", "subject": "Status change history" },
		                { "caseId": "500KS000002PTJ1YAO", "subject": "Bulk edit items" },
		                { "caseId": "500KS000002PTJ6YAO", "subject": "Embed in Slack" }
		            ]
		            },
		            {
		            "count": 4,
		            "Reason": "Performance and stability issues for At-Risk customers and near-term renewals; requires investigation.",
		            "cases": [
		                { "caseId": "500KS000002PTJ2YAO", "subject": "Search is too slow" },
		                { "caseId": "500KS000002PTIzYAO", "subject": "App crashes on large datasets" },
		                { "caseId": "500KS000002PTJJYA4", "subject": "Export data to CSV" },
		                { "caseId": "500KS000002PTJBYA4", "subject": "Session timeout too short" }
		            ]
		            },
		            {
		            "count": 6,
		            "Reason": "VIP customer feature requests and usability concerns; maintain high-touch communication and roadmap alignment.",
		            "cases": [
		                { "caseId": "500KS000002PTJNYA4", "subject": "Comment threads on tasks" },
		                { "caseId": "500KS000002PTJIYA4", "subject": "Drag and drop reorder" },
		                { "caseId": "500KS000002PTJGYA4", "subject": "Recurring tasks" },
		                { "caseId": "500KS000002PTJ3YAO", "subject": "Duplicate records appearing" },
		                { "caseId": "500KS000002PTJ0YAO", "subject": "Dark mode please" },
		                { "caseId": "500KS000002PTJ7YAO", "subject": "Offline mode" }
		            ]
		            },
		            {
		            "count": 5,
		            "Reason": "General feature requests and minor bugs not currently high-risk; schedule for product backlog grooming.",
		            "cases": [
		                { "caseId": "500KS000002PTJKYA4", "subject": "Broken link in help docs" },
		                { "caseId": "500KS000002PTJ8YAO", "subject": "Voice input for new tasks" },
		                { "caseId": "500KS000002PTJ9YAO", "subject": "Saved filter presets" },
		                { "caseId": "500KS000002PTJEYA4", "subject": "Add keyboard shortcuts" },
		                { "caseId": "500KS000002PTJAYA4", "subject": "App unresponsive after update" }
		            ]
		            },
		            {
		            "count": 1,
		            "Reason": "Feature request for UI customization; single-case group for prioritization.",
		            "cases": [
		                { "caseId": "500KS000002PTJMYA4", "subject": "Colour-coded priority" }
		            ]
		            },
		            {
		            "count": 1,
		            "Reason": "Security/Authentication request; single-case group for tracking.",
		            "cases": [
		                { "caseId": "500KS000002PTJHYA4", "subject": "Two-factor auth" }
		            ]
		            }
		        ]
		    }
		''';
		return output;
	}
}