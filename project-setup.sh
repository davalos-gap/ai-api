#!/bin/bash

# Check if a project name was provided as a parameter
if [ $# -eq 0 ]; then
    echo "No project name provided. Using default name 'EcommerceAPI'."
    PROJECT_NAME="EcommerceAPI"
else
    PROJECT_NAME="$1"
    echo "Using provided project name: $PROJECT_NAME"
fi

# Create a new .Net minimal API project
echo "CREATING A NEW .NET MINIMAL API PROJECT"
dotnet new webapi -n $PROJECT_NAME

# Create a new test project for the minimal api .Net project
echo "CREATING A NEW TEST PROJECT FOR THE MINIMAL API .NET PROJECT"
dotnet new xunit -n $PROJECT_NAME.Tests

# Reference the projects
echo "REFERENCING THE PROJECTS"
dotnet add $PROJECT_NAME.Tests/$PROJECT_NAME.Tests.csproj reference $PROJECT_NAME/$PROJECT_NAME.csproj

# Create a solution file
echo "CREATING A SOLUTION FILE"
dotnet new sln -n $PROJECT_NAME

# Add both projects to the solution
echo "ADDING BOTH PROJECTS TO THE SOLUTION"
dotnet sln $PROJECT_NAME.sln add $PROJECT_NAME/$PROJECT_NAME.csproj
dotnet sln $PROJECT_NAME.sln add $PROJECT_NAME.Tests/$PROJECT_NAME.Tests.csproj

# Add the needed dependencies for the minimal API test project
echo "ADDING THE NEEDED DEPENDENCIES FOR THE MINIMAL API TEST PROJECT"
dotnet add $PROJECT_NAME.Tests/$PROJECT_NAME.Tests.csproj package Microsoft.AspNetCore.Mvc.Testing
dotnet add $PROJECT_NAME.Tests/$PROJECT_NAME.Tests.csproj package Minivalidation
