# Terraform with GCP - deploy website

## Description

This is a simple Terraform configuration designed for deployment on Google Cloud Platform (GCP). It illustrates infrastructure as code best practices and is tailored to streamline the process of setting up and managing GCP resources.

## Table of Contents

- [Getting Started](#getting-started)
- [SSL Certificate](#ssl-certificate)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Cleanup](#cleanup)
- [Folder Structure](#folder-structure)
- [Contributing](#contributing)
- [License](#license)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

## SSL Certificate

In case you want to enable SSL certificate for your website look inside the main.tf file for the comments in the last 3 resources, you should uncomment the whole `Create HTTPS certificate` resource, and replace the commented line with the uncommented line in the last two resources: `GCP HTTP Proxy` and `GCP forwarding rule`

## Prerequisites

- Google Cloud account:
    - Existing project for the deployment
    - Enable the following APIs:
        - Cloud DNS API
	    - Compute Engine API
	    - Identity and Access Management (IAM) API
    - Service account for terraform
        - Access key (Make sure to give access only to needed actions and store your key in a safe location)
    - An active DNS zone associated with your GCP account
- Terraform installed on your local machine
- gcloud cli installed on your local machine

## Installation

1. **Clone the repository:**

    ```sh
    git clone https://github.com/adibnaya/terraform_with_gcp.git
    ```
    NOTE: After you clone the repo make sure to apply your personal details such as:
	renaming the terraform.tfvars.example file to terraform.tfvars and modify it's content to your real values
	download your GCP key file and create a file named "key.json" in the root directory of the project (Alternatively you can modify the name of the file in terraform.tfvars file)

2.  **Navigate to the project directory:**

    ```bash
    cd terraform_gcp/infra
    ```

3. **Initialize Terraform:**

    NOTE: Only initiate the project after modifying the files as instructed at the end of step 1 above

    ```sh
    terraform init
    ```

    This command will initialize Terraform and download the required providers.

## Usage

1. **Plan Your Changes:**

    ```sh
    terraform plan
    ```

    Review the plan to ensure the changes are expected and correct.

2. **Apply the Configuration:**

    ```sh
    terraform apply
    ```

    Apply the configuration to your GCP environment.

## Cleanup

To revert all the changes in your GCP account use the `terraform destroy` command

	```bash
    terraform destroy
    ```

## Folder Structure

website: contains the index.html file which represent the website
infra: contains the configuration files for terraform

## Contributing

If you wish to contribute to this project, please fork the repository and submit a pull request. For major changes, please open an issue first to discuss what you would like to change. Ensure you update tests as appropriate.

## License

Distributed under the MIT License. See `LICENSE` file for more information.
