/**
 * @Author      Pavel Slepenkov(pavel.slepenkov@targetprocess.com)
 * @Since       08 January, 2017
 * @Description
 */

public with sharing class TargetprocessRESTAPIClient {

    private final String RESOURCE_GET_ALL_USERSTORIES = '/UserStories';
    private final String RESOURCE_POST_BUG = '/bugs';

    private final String REST_API_V1_ENDPOINT_URL;

    private String passwordBasedAccessToken;

    private Targetprocess_Integration_Settings__c settings;
    private String accessTokenURLParam;

    public TargetprocessRESTAPIClient() {
        getIntegrationSettings();
        if (settings.Is_Password_Auth_Enabled__c) {
            passwordBasedAccessToken = EncodingUtil.base64Encode(Blob.valueOf(settings.UserName__c + ':' + settings.Password__c));
            System.debug(LoggingLevel.DEBUG, passwordBasedAccessToken);
        } else {
            accessTokenURLParam = '?access_token=' + settings.Access_Token__c + '&';
        }
        REST_API_V1_ENDPOINT_URL = settings.TP_Instance__c + settings.TP_API_Version__c;
    }

    //https://dev.targetprocess.com/reference#generals
    //  Assignables, Projects, Programs, Releases, Iterations,
    //  Team Iterations, Teams, Test Cases, Builds, Impediments
    public HttpResponse getGeneralResource(String resource, List<String> fieldsToInclude) {
        HttpRequest request = initRequest('GET');
        String params = 'include=[' + String.join(fieldsToInclude, ',') + ']&take=10&orderbydesc=CreateDate';

        request.setEndpoint(REST_API_V1_ENDPOINT_URL + resource + (settings.Is_Password_Auth_Enabled__c ? '?' : accessTokenURLParam) + params);
        return (new Http()).send(request);
    }

    public String getProjectIdByName(String projectName) {
        String projectId;
        List<String> fieldsToInclude = new List<String>{'Id', 'Name', 'Owner', 'CreateDate', 'EntityType'};
        Dom.XMLNode projects = getGeneralResource('/Projects', fieldsToInclude).getBodyDocument().getRootElement();
        for(Dom.XMLNode child : projects.getChildElements()) {
            if (child.getAttributeValue('Name', null) == projectName) {
                projectId = child.getAttributeValue('Id', null);
                break;
            }
        }
        return projectId;
    }

    public String getUserStories() {
        HttpRequest request = initRequest('GET');

        String params = '';
        request.setEndpoint(REST_API_V1_ENDPOINT_URL + RESOURCE_GET_ALL_USERSTORIES + (settings.Is_Password_Auth_Enabled__c ? '?' : accessTokenURLParam) + params);

        HttpResponse response = (new Http()).send(request);
        System.debug(response.getBody());
        return response.getBody();
    }

    public String postBug(Task bug, String projectName) {
        HttpRequest request = initRequest('POST');
        String params = '';
        request.setEndpoint(REST_API_V1_ENDPOINT_URL + RESOURCE_POST_BUG + (settings.Is_Password_Auth_Enabled__c ? '?' : accessTokenURLParam) + params);
        request.setHeader('Content-type', 'application/json');
        // Generate request payload based on SalesForce task
        TargetprocessBug tpBug = new TargetprocessBug(bug, getProjectIdByName(projectName));
        request.setBody(tpBug.toJSONString());

        HttpResponse response = (new Http()).send(request);
        return response.getBody();
    }

    private HttpRequest initRequest(String httpMethod) {
        HttpRequest request = new HttpRequest();
        request.setMethod(httpMethod);
        if (settings.Is_Password_Auth_Enabled__c) {
            request.setHeader('Authorization', 'Basic ' + passwordBasedAccessToken);
        }
        return request;
    }

    private void getIntegrationSettings() {
        settings = Targetprocess_Integration_Settings__c.getInstance();
        if (settings == null) {
            settings = Targetprocess_Integration_Settings__c.getOrgDefaults();
            if (settings == null) {
                throw new TPIntegrationException('Integration custom settings not found');
            }
        }
    }

    public class TargetprocessBug {
        public String projectId;
        // SF Subject => Name
        public String name;
        // HTML-formatted text: SF Comments + link back to SF task => Description
        public String description;
        // SF Due date => Planned End Date
        public Date plannedEndDate;

        public TargetprocessBug(Task bug, String projectId) {
            name = bug.Subject;
            description = bug.Description + '\\n SF Task: ' + URL.getSalesforceBaseUrl().toExternalForm() + '/' + bug.Id;
            plannedEndDate = bug.ActivityDate;
            this.projectId = projectId;
        }

        public String toJSONString() {
            JSONGenerator gen = JSON.createGenerator(true);
            gen.writeStartObject();

            gen.writeFieldName('Project');
            gen.writeStartObject();
            gen.writeStringField('ID', projectId);
            gen.writeEndObject();

            gen.writeStringField('Name', name);
            gen.writeStringField('Description', description);
            gen.writeDateField('PlannedEndDate', plannedEndDate);
            gen.writeEndObject();

            return gen.getAsString();
        }
    }

    public class TPIntegrationException extends Exception {}

}
