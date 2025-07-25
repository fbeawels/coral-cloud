public with sharing class PersonalizedGuestExperiences {
    // Make this method available for grounding
    // the Generate_Personalized_Schedule prompt template
    @InvocableMethod(
        label='Get sessions of interest for today'
        description='Get today\'s sessions that match the user\'s interests.'
    )
    public static List<Response> getSessions(List<Request> requests) {
        Request input = requests[0];
        Contact contact = input.myContact;

        List<Session__c> sessions = ExperienceSessionController.getSessions(
            contact
        );

        // Create expected response
        List<Response> responses = new List<Response>();
        Response res = new Response();
        res.prompt = JSON.serialize(sessions);
        responses.add(res);
        return responses;
    }

    // The variables in this class need to match the prompt template inputs,
    // that may be different on each prompt template
    public class Request {
        @InvocableVariable(required=true)
        public Contact myContact;
    }

    public class Response {
        @InvocableVariable
        public String Prompt;
    }
}
