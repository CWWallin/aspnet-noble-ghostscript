# ASP.NET Noble Ghostscript Docker Image

This repository contains a Docker image based on ASP.NET 10.0 Noble with Ghostscript and zbar-tools installed.

## Docker Image

The Dockerfile creates an image with:
- Base: `mcr.microsoft.com/dotnet/aspnet:10.0-noble`
- Ghostscript for PDF processing
- zbar-tools for barcode/QR code processing
- Pre-configured GhostScript settings

## GitHub Actions CI/CD

### Nightly Builds

The repository includes a GitHub Actions workflow that:
- Runs nightly at 2 AM UTC
- Builds the Docker image
- Pushes to Azure Container Registry
- Supports manual triggering via `workflow_dispatch`

### Required GitHub Secrets

To use the GitHub Actions workflow, you need to configure the following secrets in your repository:

1. **ACR_LOGIN_SERVER** - Your Azure Container Registry login server URL
   - Example: `myregistry.azurecr.io`

2. **ACR_USERNAME** - Your Azure Container Registry username
   - Example: `myregistry` (usually the same as registry name)

3. **ACR_PASSWORD** - Your Azure Container Registry password
   - You can get this from Azure Portal > Container Registry > Access Keys

### Setting up GitHub Secrets

1. Go to your GitHub repository
2. Navigate to Settings > Secrets and variables > Actions
3. Click "New repository secret"
4. Add each of the three secrets listed above

### Workflow Features

- **Scheduled builds**: Runs automatically every night at 2 AM UTC
- **Manual triggers**: Can be triggered manually from the Actions tab
- **Simple tagging**: Uses only the `latest` tag for all builds
- **Build caching**: Uses GitHub Actions cache for faster builds
- **Buildx support**: Uses Docker Buildx for advanced build features

### Image Tags

The workflow creates a single tag:
- `latest` - All builds are tagged as latest, overwriting the previous version

## Usage

Once the image is built and pushed to your Azure Container Registry, you can pull it using:

```bash
docker pull <your-registry>.azurecr.io/aspnet-noble-ghostscript:latest
```

## Environment Variables

The image includes pre-configured environment variables for GhostScript:

- `GhostScriptSettings__Executable="/usr/bin/gs"`
- `GhostScriptSettings__Parameter="-sDEVICE=pdfwrite -o \"{1}\" -dCompatibilityLevel=\"1.4\" -dPDFSETTINGS=\"/screen\" -dNOPAUSE -dQUIET -dBATCH \"{0}\""`
- `GhostScriptSettings__WorkDir="/tmp"`
