/**
 * @Author      Pavel Slepenkov(pavel.slepenkov@targetprocess.com)
 * @Since       12 January, 2017
 * @Description
 */
@isTest
global class TargetprocessRESTAPIMock implements HttpCalloutMock {

    public static final String TEST_TP_DOMAIN = 'https://targetprocessrestapitest.tpondeman.com/api/v1';

    private final String  getProjectsResponse   = '<Projects>'
                                                + '  <Project ResourceType="Project" Id="213" Name="Project Q">'
                                                + '    <Description nil="true" />'
                                                + '    <StartDate nil="true" />'
                                                + '    <EndDate nil="true" />'
                                                + '    <CreateDate>2017-01-11T07:57:02</CreateDate>'
                                                + '    <ModifyDate>2017-01-11T07:57:02</ModifyDate>'
                                                + '    <LastCommentDate nil="true" />'
                                                + '    <Tags></Tags>'
                                                + '    <NumericPriority>3</NumericPriority>'
                                                + '    <Effort>0.0000</Effort>'
                                                + '    <EffortCompleted>0.0000</EffortCompleted>'
                                                + '    <EffortToDo>0.0000</EffortToDo>'
                                                + '    <IsActive>true</IsActive>'
                                                + '    <IsProduct>false</IsProduct>'
                                                + '    <Abbreviation>O1</Abbreviation>'
                                                + '    <MailReplyAddress nil="true" />'
                                                + '    <Color nil="true" />'
                                                + '    <Progress>0.0000</Progress>'
                                                + '    <PlannedStartDate nil="true" />'
                                                + '    <PlannedEndDate nil="true" />'
                                                + '    <LastStateChangeDate>2017-01-11T07:57:02</LastStateChangeDate>'
                                                + '    <IsPrivate nil="true" />'
                                                + '    <Units>h</Units>'
                                                + '    <EntityType ResourceType="EntityType" Id="1" Name="Project" />'
                                                + '    <Process ResourceType="Process" Id="2" Name="Kanban" />'
                                                + '    <LastEditor ResourceType="GeneralUser" Id="1">'
                                                + '      <FirstName>Pavel</FirstName>'
                                                + '      <LastName>Slepenkov</LastName>'
                                                + '      <Login>admin</Login>'
                                                + '    </LastEditor>'
                                                + '    <Owner ResourceType="GeneralUser" Id="1">'
                                                + '      <FirstName>Pavel</FirstName>'
                                                + '      <LastName>Slepenkov</LastName>'
                                                + '      <Login>admin</Login>'
                                                + '    </Owner>'
                                                + '    <LastCommentedUser nil="true" />'
                                                + '    <Project nil="true" />'
                                                + '    <LinkedTestPlan nil="true" />'
                                                + '    <Program nil="true" />'
                                                + '    <EntityState ResourceType="EntityState" Id="119" Name="Open">'
                                                + '      <NumericPriority>1</NumericPriority>'
                                                + '    </EntityState>'
                                                + '    <Company nil="true" />'
                                                + '    <CustomFields />'
                                                + '  </Project>'
                                                + '  <Project ResourceType="Project" Id="212" Name="Project Alpha">'
                                                + '    <Description nil="true" />'
                                                + '    <StartDate nil="true" />'
                                                + '    <EndDate nil="true" />'
                                                + '    <CreateDate>2017-01-11T07:56:41</CreateDate>'
                                                + '    <ModifyDate>2017-01-11T07:56:41</ModifyDate>'
                                                + '    <LastCommentDate nil="true" />'
                                                + '    <Tags></Tags>'
                                                + '    <NumericPriority>2</NumericPriority>'
                                                + '    <Effort>0.0000</Effort>'
                                                + '    <EffortCompleted>0.0000</EffortCompleted>'
                                                + '    <EffortToDo>0.0000</EffortToDo>'
                                                + '    <IsActive>true</IsActive>'
                                                + '    <IsProduct>false</IsProduct>'
                                                + '    <Abbreviation>PA</Abbreviation>'
                                                + '    <MailReplyAddress nil="true" />'
                                                + '    <Color nil="true" />'
                                                + '    <Progress>0.0000</Progress>'
                                                + '    <PlannedStartDate nil="true" />'
                                                + '    <PlannedEndDate nil="true" />'
                                                + '    <LastStateChangeDate>2017-01-11T07:56:41</LastStateChangeDate>'
                                                + '    <IsPrivate nil="true" />'
                                                + '    <Units>pt</Units>'
                                                + '    <EntityType ResourceType="EntityType" Id="1" Name="Project" />'
                                                + '    <Process ResourceType="Process" Id="3" Name="Scrum" />'
                                                + '    <LastEditor ResourceType="GeneralUser" Id="1">'
                                                + '      <FirstName>Pavel</FirstName>'
                                                + '      <LastName>Slepenkov</LastName>'
                                                + '      <Login>admin</Login>'
                                                + '    </LastEditor>'
                                                + '    <Owner ResourceType="GeneralUser" Id="1">'
                                                + '      <FirstName>Pavel</FirstName>'
                                                + '      <LastName>Slepenkov</LastName>'
                                                + '      <Login>admin</Login>'
                                                + '    </Owner>'
                                                + '    <LastCommentedUser nil="true" />'
                                                + '    <Project nil="true" />'
                                                + '    <LinkedTestPlan nil="true" />'
                                                + '    <Program nil="true" />'
                                                + '    <EntityState ResourceType="EntityState" Id="123" Name="Open">'
                                                + '      <NumericPriority>1</NumericPriority>'
                                                + '    </EntityState>'
                                                + '    <Company nil="true" />'
                                                + '    <CustomFields />'
                                                + '  </Project>'
                                                + '</Projects>';

    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
//        System.assertEquals(TEST_TP_DOMAIN, req.getEndpoint());
//        System.assertEquals('GET', req.getMethod());

        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/xml');
        res.setBody(getProjectsResponse);

        res.setStatusCode(200);
        return res;
    }
}
