# Terraform Module: GCP Datadog Integration

This Terraform module allows you to easily integrate your Google Cloud Platform (GCP) resources with Datadog, a popular monitoring and analytics platform. By using this module, you can send metrics and logs from your GCP resources to Datadog, enabling you to gain valuable insights and ensure the health and performance of your infrastructure.

## Features

- Seamless integration of GCP resources with Datadog
- Automatic collection and forwarding of metrics and logs
- Customizable configuration options to fit your specific needs
- Easy setup and maintenance with Terraform

## Usage

To use this module, include the following code in your Terraform configuration:

```hcl
module "gcp_datadog_integration" {
    source  = "github.com/brandlive1941/terraform-module-gcp-datadog-integration"

    # Specify your configuration options here
    # ...
}
```

Make sure to replace `github.com/brandlive1941/terraform-module-gcp-datadog-integration` with the actual source of this module.

## Configuration

This module supports the following configuration options:

- `api_key` (required): The Datadog API key used for authentication.
- `app_key` (required): The Datadog APP key used for identification.
- `gcp_project_id` (required): The ID of the GCP project where the resources are located.
- `principal_account` (required): The Datadog Principal account created for your project
- `site` (optional): The Datadog site to send the metrics and logs to (e.g., `datadoghq.com` or `datadoghq.eu`).

For more detailed information on the Datadog integration, please refer to the [documentation](https://docs.datadoghq.com/integrations/google_cloud_platform/?tab=project#setup).

## Contributing

Contributions are welcome! If you have any ideas, suggestions, or bug reports, please open an issue or submit a pull request on the [GitHub repository](https://github.com/brandlive1941/terraform-module-gcp-datadog-integration).

## License

This module is licensed under the [GNU General Public License](https://opensource.org/licenses/MIT). Please see the [LICENSE](https://github.com/brandlive1941/terraform-module-gcp-datadog-integration/blob/main/LICENSE) file for more details.
