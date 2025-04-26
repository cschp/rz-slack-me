# RZ Slack Me - CI/CD Pipeline Documentation

## Local Development Setup

### Prerequisites
- Docker
- Docker Compose (optional, for local development)

### Running Locally with Docker

1. Build the Docker image:
```bash
docker build -t rz-slack-me --build-arg SLACK_SECRET=your_test_secret .
```

2. Run the container:
```bash
docker run -e SLACK_SECRET=your_test_secret rz-slack-me
```

Expected output:
```
SUCCESS! A message was sent
```

## CI/CD Pipeline Setup

### GitHub Repository Configuration

1. Configure the following secrets in your GitHub repository:
   - `DOCKERHUB_USERNAME`: Your Docker Hub username
   - `DOCKERHUB_TOKEN`: Your Docker Hub access token
   - `SLACK_SECRET`: Your Slack webhook secret

2. To add secrets:
   - Go to your GitHub repository
   - Navigate to Settings > Secrets and variables > Actions
   - Click "New repository secret"
   - Add each secret with its corresponding value

### Pipeline Triggers

The pipeline will run in two scenarios:
1. When a new git tag is pushed to the repository
2. When manually triggered through the GitHub Actions interface

### Pipeline Steps

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

### Running the Production Image

To run the production Docker image:

```bash
docker run -e SLACK_SECRET=your_slack_secret your_dockerhub_username/rz-slack-me:v1.0.0
```

Replace:
- `your_slack_secret` with your actual Slack webhook secret
- `your_dockerhub_username` with your Docker Hub username
- `v1.0.0` with the specific version tag you want to run

## Security Considerations

1. **Secret Management**
   - All sensitive information is stored as GitHub secrets
   - Secrets are never exposed in logs or build artifacts
   - The SLACK_SECRET is passed securely through build arguments

2. **Production Image Security**
   - Development dependencies are excluded from the final image
   - Only necessary PHP extensions are installed
   - The image is built from official, trusted base images

3. **Deployment Control**
   - Docker image pushes only occur on git tag pushes
   - Each deployment is versioned and traceable
   - Manual workflow triggers are available for testing

## Troubleshooting

### Common Issues

1. **Build Failures**
   - Check GitHub Actions logs for detailed error messages
   - Verify PHP version compatibility
   - Ensure all required secrets are configured

2. **Docker Hub Authentication**
   - Verify Docker Hub credentials
   - Check repository permissions
   - Ensure the token has push access

3. **Application Errors**
   - Check the SLACK_SECRET environment variable
   - Verify network connectivity to Slack
   - Review application logs

### Support

For additional support:
1. Review the GitHub Actions documentation
2. Check the Laravel documentation for PHP-specific issues
3. Consult the Docker documentation for container-related problems 