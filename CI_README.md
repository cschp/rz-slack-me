# CI/CD Pipeline Setup Instructions

## Prerequisites
- GitHub repository with the application code
- Docker Hub account
- GitHub repository secrets configured

## GitHub Secrets Configuration
The following secrets need to be configured in your GitHub repository:
- `DOCKERHUB_USERNAME`: Your Docker Hub username
- `DOCKERHUB_TOKEN`: Your Docker Hub access token
- `SLACK_SECRET`: Your Slack webhook secret

To configure these secrets:
1. Go to your GitHub repository
2. Navigate to Settings > Secrets and variables > Actions
3. Click "New repository secret"
4. Add each secret with its corresponding value

## Pipeline Triggers
The pipeline will run in two scenarios:
1. When a new git tag is pushed to the repository
2. When manually triggered through the GitHub Actions interface

## Pipeline Steps
1. **Build and Test**
   - Sets up PHP 8.2 and Composer 2
   - Installs dependencies
   - Runs unit tests
   - This step runs on both tag pushes and manual triggers

2. **Build and Push Docker Image**
   - Builds a production Docker image without dev dependencies
   - Pushes the image to Docker Hub
   - This step only runs on tag pushes
   - The image tag will match the git tag

## Running the Docker Image Locally
To run the Docker image locally, use the following command:

```bash
docker run -e SLACK_SECRET=your_slack_secret your_dockerhub_username/rz-slack-me:tag
```

Replace:
- `your_slack_secret` with your actual Slack webhook secret
- `your_dockerhub_username` with your Docker Hub username
- `tag` with the specific version tag you want to run

## Security Considerations
1. All sensitive information (Docker Hub credentials, Slack secret) is stored as GitHub secrets
2. The production Docker image does not include development dependencies
3. The Slack secret is passed as a build argument and environment variable securely
4. The pipeline only pushes to Docker Hub when a git tag is pushed, ensuring controlled deployments

## Troubleshooting
If you encounter any issues:
1. Check the GitHub Actions logs for detailed error messages
2. Verify that all required secrets are properly configured
3. Ensure your Docker Hub credentials have the necessary permissions
4. Verify that the Slack webhook URL is valid and accessible 