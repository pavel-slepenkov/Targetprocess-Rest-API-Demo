/**
 * @Author          Pavel Slepenkov(pavel.slepenkov@targetprocess.com)
 * @Since           09 January, 2017
 * @Description     @future annotation should be used in Trigger context in otder to avoid
 *                  Runtime exception based on Salesforce limits
 */
public class TriggerCalloutProxy {

    @future(callout=true)
    public static void postBug(Id taskId) {

        Task bug = [SELECT Id, Description, Subject, ActivityDate FROM Task WHERE Id =: taskId LIMIT 1];
        if (bug != null) {
            TargetprocessRESTAPIClient client = new TargetprocessRESTAPIClient();
            String result = client.postBug(bug, 'QA13');
            System.debug(LoggingLevel.DEBUG, result);
        }
    }

}
