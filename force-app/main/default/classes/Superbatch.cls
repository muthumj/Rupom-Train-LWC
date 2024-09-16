public with sharing class Superbatch 
{

    
    @AuraEnabled(cacheable=true)
    public static String getitemname(String skuds) {
        try {
            // Create HTTP request
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            
            // Set the endpoint (replace with actual API endpoint)
            String endpoint = 'https://th-superbadge-apex.herokuapp.com/equipment?sku=' + skuds;
            request.setEndpoint(endpoint);
            request.setMethod('GET');
            
            // Send the request
            HttpResponse response = http.send(request);
            
            // Check if the response is successful
            if (response.getStatusCode() == 200) {
                // Parse the JSON response (a List of equipment data)
                List<Object> equipmentList = (List<Object>) JSON.deserializeUntyped(response.getBody());
                
                // Search for the equipment with the matching SKU
                for (Object obj : equipmentList) {
                    Map<String, Object> equipmentItem = (Map<String, Object>) obj;
                    if (equipmentItem.get('sku') == skuds) {
                        // Return the name of the equipment
                        return (String) equipmentItem.get('name');
                    }
                }
                
                // If no matching SKU is found, return a message
                return 'No equipment found with the specified SKU';
            } else {
                throw new CalloutException('Failed to retrieve data. Status Code: ' + response.getStatusCode());
            }
        } catch (Exception e) {
            throw new CalloutException('Error during API call: ' + e.getMessage());
        }
    }
    
    
}