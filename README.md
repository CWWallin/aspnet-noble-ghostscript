# ASP.NET Noble Ghostscript Docker Images

This repository contains Docker images based on ASP.NET 10.0 Noble with Ghostscript tools installed.

## Docker Images

The repository provides two Docker images:

### aspnet-noble-ghostscript (Root)
- Base: `mcr.microsoft.com/dotnet/aspnet:10.0-noble`
- Ghostscript for PDF processing
- zbar-tools for barcode/QR code processing
- Pre-configured GhostScript settings

### aspnet-noble-ghostscript-xps (XPS)
- Base: `mcr.microsoft.com/dotnet/aspnet:10.0-noble`
- Ghostscript 9.53.3 (latest version)
- gpcl6 for PCL processing
- gxps for XPS processing
- Full GhostPDL suite

## GitHub Actions CI/CD

### Automated Builds

The repository includes a GitHub Actions workflow that:
- Runs nightly at 2 AM UTC
- Triggers on pushes to the main branch
- Builds both Docker images in parallel using matrix strategy
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
- **Push triggers**: Runs on every push to the main branch
- **Matrix strategy**: Builds both images in parallel for faster execution
- **Manual triggers**: Can be triggered manually from the Actions tab
- **Simple tagging**: Uses only the `latest` tag for all builds
- **Docker CLI**: Uses standard `docker build` and `docker push` commands

### Image Tags

The workflow creates a single tag for each image:
- `aspnet-noble-ghostscript:latest` - Standard Ghostscript image
- `aspnet-noble-ghostscript-xps:latest` - Full GhostPDL suite image

## Usage

Once the images are built and pushed to your Azure Container Registry, you can pull them using:

```bash
# Standard Ghostscript image
docker pull <your-registry>.azurecr.io/aspnet-noble-ghostscript:latest

# Full GhostPDL suite image (includes XPS and PCL support)
docker pull <your-registry>.azurecr.io/aspnet-noble-ghostscript-xps:latest
```

## Environment Variables

The standard image (`aspnet-noble-ghostscript`) includes pre-configured environment variables for GhostScript:

- `GhostScriptSettings__Executable="/usr/bin/gs"`
- `GhostScriptSettings__Parameter="-sDEVICE=pdfwrite -o \"{1}\" -dCompatibilityLevel=\"1.4\" -dPDFSETTINGS=\"/screen\" -dNOPAUSE -dQUIET -dBATCH \"{0}\""`
- `GhostScriptSettings__WorkDir="/tmp"`

The XPS image (`aspnet-noble-ghostscript-xps`) includes the full GhostPDL suite with:
- Ghostscript 9.53.3 at `/usr/local/bin/gs`
- gpcl6 for PCL processing at `/usr/local/bin/gpcl6`
- gxps for XPS processing at `/usr/local/bin/gxps`
