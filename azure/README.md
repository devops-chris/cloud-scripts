# Azure Key Vault Secrets CLI

This CLI script provides functionality to interact with Azure Key Vault secrets from the command line on a macOS environment.


## Installation

1. Clone the repository:

   ```bash
   git clone <repository_url>
   ```

2. Navigate to the script directory:

   ```bash
   cd <repository_directory>/azure
   ```

3. Make the setup script executable:

   ```bash
   chmod +x setup.sh
   ```

4. Run the setup script to install and configure the CLI:

   ```bash
   ./setup.sh
   ```

## Usage
### List Secrets
To list all available secrets in your Azure Key Vaults
  ```bash
  azv
  ```

### Set a Secret
To set a new secret in a specific Key Vault:
  ```bash
  azv --set
  ```

### List a Secret
To delete a specific secret from a Key Vault:
  ```bash
  azv --delete
  ```