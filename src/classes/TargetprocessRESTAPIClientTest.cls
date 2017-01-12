/**
 * @Author          Pavel Slepenkov(pavel.slepenkov@targetprocess.com)
 * @Since           08 January, 2017
 * @Description
 */
@isTest
private class TargetprocessRESTAPIClientTest {

    @isTest
    static void smokeGetProjects() {

        Targetprocess_Integration_Settings__c settings = new Targetprocess_Integration_Settings__c(
                TP_API_Version__c = '/api/v1'
                , TP_Instance__c = 'https://targetprocessrestapitest.tpondeman.com'
                , Access_Token__c = 'aldkjfhalkdfjhaskfhalskfhjw29834729uhfa9'
                , UserName__c = 'admin'
                , Password__c = 'admin'
        );
        insert settings;
        Test.setMock(HttpCalloutMock.class, new TargetprocessRESTAPIMock());

        Test.startTest();

        TargetprocessRESTAPIClient client = new TargetprocessRESTAPIClient();
        System.assertEquals('213', client.getProjectIdByName('Project Q'));
        Test.stopTest();

    }

}
