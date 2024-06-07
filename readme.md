## Database Setup
- Create MySQL database in GCP
- The database is called "test"
- Create a firewall rule for the database to open port 3306 to allow connnection

## Application Setup
- Test both frontend and backend locally

## Backend Setup and Testing
- Dockerize the backend application
- Test the docker image

## Frontend Setup and Testing
- Dockerize the frontend application
- Test the docker image

## Artifact Repository
- Create A repository in GCP
- For security purposes this can be a private repository
- This is where all images will be pushed 

## Create a CI/CD Pipeline to GCP Cloud Run
- For the CI/CD we will use github actions (Find the workflows in .github/workflows for both backend and frontend)
- The workflow will update images and push the image to cloudrun for deployment

## IaC
- Terraform will be used to provision the infrastructure on GCP
- That is the cloud run
