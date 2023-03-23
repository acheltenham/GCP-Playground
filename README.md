# Google Cloud Platform Serverless Portfolio Project
This repository demonstrates how to structure and manage multiple Google Cloud Platform (GCP) serverless solutions using Terraform. The primary focus is on organizing your infrastructure as code in a modular and scalable way.

## Project Structure

The general folder structure is organized as follows:

```
├── main.tf
├── variables.tf
├── outputs.tf
├── README.md
├── cloud_run_job/service1
│   ├── main.tf
│   ├── variables.tf
└── cloud_function/function1
    ├── main.tf
    ├── variables.tf
```

`main.tf`: The root module file that sets up and configures the provider, as well as instantiates the service1 and function1 modules.
`variables.tf`: The root module's variable definitions file, where shared variables are defined.
`outputs.tf`: The root module's output definitions file, where shared outputs are defined.
`service1` and `function1`: Module folders that each contain their own `main.tf`, `variables.tf`, and `outputs.tf` (*optional*) files, specific to the respective module.

### Prerequisites

1. Install [Terraform](https://www.terraform.io/downloads.html) latest version
2. Set up a [GCP account](https://console.cloud.google.com/) and create a project.
3. Configure the [Google Cloud SDK](https://cloud.google.com/sdk/docs/quickstarts) and authenticate with your GCP account.

### Usage

Clone this repository:

```
git clone https://github.com/acheltenham/GCP-Playground.git
```

Change to the repository directory:

```
cd your-repo
```

Update the `terraform.tfvars` file in the root folder with your GCP project ID and any other required values.

Initialize Terraform:

```
terraform init
```

Review the execution plan:

```
terraform plan
```

Apply the changes:

```
terraform apply
```

To destroy the infrastructure when you are done, run:

```
terraform destroy
```

### Contributing

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Commit your changes and push to your branch.
4. Create a pull request.

## Local Testing

Local testing allows you to verify your serverless solutions before deploying them to a live environment. This is essential for detecting issues early on in the development process, minimizing the risk of errors in production.

### Google Cloud Functions

For Google Cloud Functions, you can use the Functions Framework to test your functions locally. Follow these steps:

1. Install the Functions Framework for your preferred runtime. For example, for Python:

```
pip install functions-framework
```

2. Navigate to the directory containing your function's source code.

3. Start the [Functions Framework](https://cloud.google.com/functions/docs/functions-framework) with your function's target:

```
functions-framework --target your_function_name
```

Replace your_function_name with the name of your function. And use the `--source` flag to targer the folder you are testing.

4. Open your browser or use a tool like curl to send requests to http://localhost:8080.

### Google Cloud Run

For Google Cloud Run, you can test your services locally using Docker. Follow these steps:

1. Make sure you have [Docker](https://docs.docker.com/get-docker/) installed on your machine.
2. Navigate to the directory containing your service's source code.
3. Create a Dockerfile in the same directory, if you haven't already. The Dockerfile should define your service's container image.
4. Build the container image:

> Note it is best practice to spearate the build process and if we try to kick off the build using terraform it will make the code less usable to contributors. 

```
docker build -t your_service_name 
```

Replace your_service_name with a descriptive name for your service. 

Run the container locally:


### To Do 

- [ ] Find best solution to trigger cloud-run job on a schedule. 