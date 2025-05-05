# E-commerce API Project Plan

This document provides a structured implementation plan for building the E-commerce API based on the [specification](spec.md). The plan is organized into iterative steps, each with clear implementation prompts.

## Project Overview

We will be building a .NET 9 Web API for an e-commerce platform, focusing initially on Category CRUD operations with JSON file persistence.

## Implementation Steps

### Phase 1: Basic Project Setup and Model Creation

#### Step 1.1: Create the Category Model

```
Create a Category model class in the Models folder. The model should represent a product category with Id, Name, and Description properties. The Name and Description should be marked as required. Ensure the model matches the structure in the categories.json file.
```

### Phase 2: Data Access Layer

#### Step 2.1: Create Category Service Interface

```
Create an interface ICategoryService in the Services folder that defines all CRUD operations for categories (GetAll, GetById, Create, Update, Delete). Each method should have appropriate return types and parameters. Document the interface with XML comments explaining what each method does.
```

#### Step 2.2: Implement the Category Service

```
Implement the CategoryService class in the Services folder that implements the ICategoryService interface. The service should read from and write to the categories.json file in the data directory. Use System.Text.Json for JSON serialization/deserialization. Implement proper error handling and ensure thread safety for file operations. The service should implement all CRUD operations defined in ICategoryService.
```

### Phase 3: Dependency Injection Setup

#### Step 3.1: Create Service Collection Extensions

```
Create a ServiceCollectionExtensions class in the Extensions folder with a method to register the CategoryService with the dependency injection container. This should allow for easy registration of all services in Program.cs.
```

### Phase 4: API Endpoints Implementation

#### Step 4.1: Update Program.cs with Category Endpoints - GET Methods

```
Update the Program.cs file to include GET endpoints for categories. Add two endpoints: one to get all categories and another to get a category by ID. Register the necessary services using the extension method created earlier. Ensure proper error handling and status codes are returned.
```

#### Step 4.2: Update Program.cs with Category Endpoints - POST Method

```
Add the POST endpoint to Program.cs for creating new categories. The endpoint should validate that all required fields are provided, generate a new unique ID, and return a 201 Created status code with the new category. Update the existing code rather than starting from scratch.
```

#### Step 4.3: Update Program.cs with Category Endpoints - PUT Method

```
Add the PUT endpoint to Program.cs for updating existing categories. The endpoint should validate that the category exists and all required fields are provided. Return appropriate status codes and error messages.
```

#### Step 4.4: Update Program.cs with Category Endpoints - DELETE Method

```
Add the DELETE endpoint to Program.cs for deleting categories. The endpoint should validate that the category exists and return a 204 No Content status code if successful.
```

### Phase 5: Testing and Refinement

#### Step 5.1: Basic Unit Tests for CategoryService

```
Create unit tests for the CategoryService in the EcommerceAPI.Tests project. Test each CRUD operation to ensure it behaves as expected. Use mocking if needed to avoid actual file operations during testing.
```

#### Step 5.2: Integration Tests for API Endpoints

```
Create integration tests for the API endpoints in the EcommerceAPI.Tests project. Test each endpoint to ensure it returns the expected status codes and responses.
```

## Detailed Implementation Prompts

### Prompt 1: Category Model

```
Create a Category.cs file in the Models folder with a Category class that has the following properties:
- int Id
- string Name (required)
- string Description (required)

The model should match the structure in the categories.json file. Use C# 10+ features like required properties where appropriate.
```

### Prompt 2: Category Service Interface

```
Create an ICategoryService.cs file in the Services folder with an interface that defines the following methods:
- Task<IEnumerable<Category>> GetAllCategoriesAsync()
- Task<Category?> GetCategoryByIdAsync(int id)
- Task<Category> CreateCategoryAsync(Category category)
- Task<Category?> UpdateCategoryAsync(int id, Category category)
- Task<bool> DeleteCategoryAsync(int id)

Add XML documentation comments to each method explaining its purpose, parameters, and return values.
```

### Prompt 3: Category Service Implementation

```
Create a CategoryService.cs file in the Services folder that implements ICategoryService. The implementation should:

1. Have a constructor that accepts the file path as a parameter (with a default value pointing to /data/categories.json)
2. Implement all methods from ICategoryService
3. Use System.Text.Json for JSON operations
4. Handle file I/O exceptions appropriately
5. Ensure thread safety for file operations using locking or semaphores
6. Generate unique IDs for new categories (max existing ID + 1)

For GetAllCategoriesAsync:
- Read the JSON file
- Deserialize the "categories" array
- Return the list of categories

For GetCategoryByIdAsync:
- Read the JSON file
- Find the category with the matching ID
- Return the category or null if not found

For CreateCategoryAsync:
- Validate that Name and Description are not null or empty
- Generate a new unique ID
- Add the category to the list
- Save the updated list to the file
- Return the created category

For UpdateCategoryAsync:
- Validate that the category exists
- Update the category properties
- Save the updated list to the file
- Return the updated category or null if not found

For DeleteCategoryAsync:
- Validate that the category exists
- Remove the category from the list
- Save the updated list to the file
- Return true if deleted, false if not found
```

### Prompt 4: Service Collection Extensions

```
Create a ServiceCollectionExtensions.cs file in the Extensions folder with an extension method for IServiceCollection that registers the ICategoryService and CategoryService. The method should:

1. Be named AddCategoryServices
2. Accept IServiceCollection as a parameter
3. Register CategoryService as a scoped service for ICategoryService
4. Add any configuration needed for the CategoryService
5. Return the IServiceCollection for method chaining

Use appropriate namespace declarations and ensure the extension method is public and static.
```

### Prompt 5: Program.cs - GET Endpoints

```
Update Program.cs to include two GET endpoints for categories:

1. GET /categories - Returns all categories
   - Use app.MapGet("/categories", ...)
   - Inject ICategoryService using dependency injection
   - Call GetAllCategoriesAsync()
   - Return 200 OK with the list of categories

2. GET /categories/{id} - Returns a specific category
   - Use app.MapGet("/categories/{id}", ...)
   - Inject ICategoryService using dependency injection
   - Call GetCategoryByIdAsync(id)
   - Return 200 OK with the category if found, 404 Not Found otherwise

Also add the service registration by:
1. Adding using statements for your Models, Services, and Extensions namespaces
2. Calling builder.Services.AddCategoryServices() before building the app

Make sure to keep all existing code in Program.cs, just add these new endpoints and service registrations.
```

### Prompt 6: Program.cs - POST Endpoint

```
Update Program.cs to include a POST endpoint for creating categories:

1. POST /categories - Creates a new category
   - Use app.MapPost("/categories", ...)
   - Inject ICategoryService using dependency injection
   - Accept a Category object from the request body
   - Validate that Name and Description are provided
   - Call CreateCategoryAsync(category)
   - Return 201 Created with the created category and a location header

Make sure to:
- Include appropriate error handling
- Validate the request model
- Return a 400 Bad Request if validation fails
- Keep all existing endpoints and code
```

### Prompt 7: Program.cs - PUT Endpoint

```
Update Program.cs to include a PUT endpoint for updating categories:

1. PUT /categories/{id} - Updates an existing category
   - Use app.MapPut("/categories/{id}", ...)
   - Inject ICategoryService using dependency injection
   - Accept an int id parameter from the route and a Category object from the request body
   - Validate that the id in the route matches the id in the category object
   - Call UpdateCategoryAsync(id, category)
   - Return 200 OK with the updated category if found, 404 Not Found otherwise

Make sure to:
- Include appropriate error handling
- Validate the request model
- Return a 400 Bad Request if validation fails
- Keep all existing endpoints and code
```

### Prompt 8: Program.cs - DELETE Endpoint

```
Update Program.cs to include a DELETE endpoint for deleting categories:

1. DELETE /categories/{id} - Deletes a category
   - Use app.MapDelete("/categories/{id}", ...)
   - Inject ICategoryService using dependency injection
   - Accept an int id parameter from the route
   - Call DeleteCategoryAsync(id)
   - Return 204 No Content if successful, 404 Not Found if the category doesn't exist

Make sure to:
- Include appropriate error handling
- Keep all existing endpoints and code
```

### Prompt 9: Unit Tests for CategoryService

```
Create unit tests for CategoryService in the EcommerceAPI.Tests project:

1. Create a CategoryServiceTests.cs file
2. Write tests for each CRUD operation:
   - TestGetAllCategories
   - TestGetCategoryById
   - TestCreateCategory
   - TestUpdateCategory
   - TestDeleteCategory

Consider:
- Creating a temporary JSON file for testing
- Using a setup method to initialize the test data
- Using a teardown method to clean up after tests
- Testing both successful and failure scenarios
- Verifying that the service behaves as expected

Use xUnit or NUnit, whichever is already set up in the project.
```

### Prompt 10: Integration Tests for API Endpoints

```
Create integration tests for the API endpoints in the EcommerceAPI.Tests project:

1. Create a CategoryEndpointTests.cs file
2. Set up a test web application host
3. Write tests for each endpoint:
   - TestGetAllCategories
   - TestGetCategoryById
   - TestCreateCategory
   - TestUpdateCategory
   - TestDeleteCategory

Consider:
- Using WebApplicationFactory<Program> for testing
- Testing both successful and failure scenarios
- Verifying that the endpoints return the expected status codes and responses
- Testing validation error cases
```

## Final Review

With these steps and prompts, a developer should be able to build a fully functional RESTful API for managing product categories. The implementation follows best practices by:

1. Separating concerns with proper layering (models, services, API endpoints)
2. Using dependency injection for better testability and flexibility
3. Following RESTful principles for API design
4. Implementing proper error handling and validation
5. Including tests to verify functionality

Each step builds incrementally on the previous one, ensuring that the application remains in a working state throughout development. The implementation is kept simple to match the proof-of-concept requirements while still following good software engineering practices.