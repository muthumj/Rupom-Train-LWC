public with sharing class Integone {
    @AuraEnabled
    public static String getProductName(string sku) {
        // Construct the URL
        String endpoint = 'https://th-superbadge-apex.herokuapp.com/equipment?sku=';
        
        // Create HTTP request and send it
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        String responseBody = response.getBody();
        
        // Parse the JSON response
        String productName = '';
       /* if(response.getStatusCode() == 200) {
            JSONParser parser = JSON.createParser(responseBody);
            while(parser.nextToken() != null) {
                if(parser.getText() == 'name') {
                    parser.nextToken();
                    productName = parser.getText();
                    break;
                }
            }
        }*/

        system.jsonparser jp = JSON.createParser(responseBody);
        while (jp.nextToken() != null)
        {
            if(jp.gettext() == 'name')
            {
                jp.nextToken();
                productName = (jp.gettext());
            }
        }
        
        return productName;
    }
}
