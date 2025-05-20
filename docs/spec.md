# E-commerce API Specification

## Overview
This document outlines the specifications for a proof-of-concept e-commerce backend API built with .NET 9 Minimal API. The current scope is limited to CRUD operations for product categories, with potential for future expansion.

## Technology Stack
- **.NET 9**: Core framework
- **Minimal API**: Lightweight API approach
- **JSON File Storage**: Simple data persistence using JSON files

## API Structure
The API follows RESTful principles with the following endpoints:

| Method | Endpoint | Description | Status Code(s) |
|--------|----------|-------------|---------------|
| GET    | /categories | Retrieve all categories | 200 OK |
| GET    | /categories/{id} | Retrieve a specific category | 200 OK, 404 Not Found |
| POST   | /categories | Create a new category | 201 Created, 400 Bad Request |
| PUT    | /categories/{id} | Update an existing category | 200 OK, 400 Bad Request, 404 Not Found |
| DELETE | /categories/{id} | Delete a category | 204 No Content, 404 Not Found |

## Data Model
The Category model has the following structure:

```csharp
public class Category
{
    public int Id { get; set; }
    public required string Name { get; set; }
    public required string Description { get; set; }
}
```

## Project Structure
```
EcommerceAPI/
├── Models/
│   └── Category.cs           // Category data model
├── Services/
│   ├── ICategoryService.cs   // Interface for category operations
│   └── CategoryService.cs    // Implementation of category operations
├── Extensions/
│   └── ServiceCollectionExtensions.cs  // DI registration extensions
└── Program.cs                // API endpoints and application setup
```

## Data Storage
Categories will be stored in and retrieved from `/data/categories.json`. The file has the following structure:

```json
{
  "categories": [
    {
      "id": 1,
      "name": "Smartphones",
      "description": "Modern mobile devices with advanced computing capabilities"
    },
    ...
  ]
}
```

## Validation Rules
- All fields (id, name, description) are required
- No additional validation is applied for this PoC

## Error Handling
The API will use standard HTTP status codes:
- 200 OK for successful GET and PUT operations
- 201 Created for successful POST operations
- 204 No Content for successful DELETE operations
- 400 Bad Request for invalid input
- 404 Not Found for non-existent resources

Error responses will be direct and not wrapped in any standard format.

## Authentication & Authorization
No authentication or authorization is implemented for this PoC.

## Implementation Plan
1. Create the Category model
2. Implement the CategoryService for file I/O operations
3. Set up dependency injection
4. Implement the API endpoints in Program.cs
5. Test each endpoint

## Testing Strategy
Testing should include:
- Unit tests for the CategoryService
- Integration tests for each endpoint
- Validation of proper error handling
- Performance testing with larger datasets

For testing, use the existing `EcommerceAPI.Tests` project.

## Future Enhancements
Potential future enhancements could include:
- Product management
- User authentication and authorization
- Database integration
- Improved validation
- Pagination for list operations

## Related Documentation
- [.NET 9 Minimal API Documentation](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/minimal-apis)
- [System.Text.Json Documentation](https://learn.microsoft.com/en-us/dotnet/standard/serialization/system-text-json/overview)
- 


- This is an example line for the workshop
