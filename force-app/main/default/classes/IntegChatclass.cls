public with sharing class IntegChatclass 
{

    @AuraEnabled(cacheable=true)
    public static String getPostTitle(Integer postId) {
        try {
            // Create HTTP request
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            
            // Set the endpoint with the post ID
            String endpoint = 'https://jsonplaceholder.typicode.com/posts/' + postId;
            request.setEndpoint(endpoint);
            request.setMethod('GET');
            
            // Send the request
            HttpResponse response = http.send(request);
            
            // Check the response status
            if (response.getStatusCode() == 200) {
                // Parse the JSON response
                Map<String, Object> post = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                
                // Return the title of the post
                return (String) post.get('title');
            } else {
                return 'Error: Unable to retrieve post. Status Code: ' + response.getStatusCode();
            }
            
        } catch (Exception e) {
            return 'Error: ' + e.getMessage();
        }
    }
    
}