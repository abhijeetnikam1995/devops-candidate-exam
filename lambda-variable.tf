variable "lambda_function_name" {
  description = "The name to use for the lambda function"
  type        = string
  default     = "email-lambda"
}

variable "lambda_description" {
  description = "The description to use for the AWS Lambda"
  type        = string
  default     = "this is lambda for email"
}

variable "lambda_package_type" {
  description = "The lambda deployment package type. Valid values are \"Zip\" and \"Image\". Defaults to \"Zip\"."
  type        = string
  default     = "Zip"
  nullable    = false
}

variable "lambda_zip_path" {
  description = "The location where the generated zip file should be stored. Required when `lambda_package_type` is \"Zip\"."
  type        = string
  default     = null
}

variable "lambda_handler" {
  description = "The name of the handler to use for the lambda function. Required when `lambda_package_type` is \"Zip\"."
  type        = string
  default     = null
}

variable "lambda_runtime" {
  description = "The runtime to use for the lambda function"
  type        = string
  default     = "nodejs14.x"
  nullable    = false
}

variable "lambda_image_uri" {
  description = "The ECR image URI containing the function's deployment package. Required when `lambda_package_type` is \"Image\"."
  type        = string
  default     = null
}

variable "lambda_image_config" {
  description = "Container image configuration values that override the values in the container image Dockerfile."
  type = object({
    command: optional(list(string)),
    entry_point: optional(list(string)),
    working_directory: optional(string)
  })
  default = {
    command: null,
    entry_point: null,
    working_directory: null
  }
  nullable = false
}

variable "lambda_timeout" {
  description = "The timeout period to use for the lambda function"
  default     = 30
  nullable    = false
}

variable "lambda_memory_size" {
  description = "The amount of memeory to use for the lambda function"
  default     = 128
  nullable    = false
}

variable "lambda_reserved_concurrent_executions" {
  description = "Amount of reserved concurrent executions for this lambda function"
  default     = -1
  nullable    = false
}

variable "lambda_execution_role_policy_document" {
  description = "A policy document for the execution role policy assumed by the lambda during execution."
  type        = string
  default     = ""
  nullable    = false
}

variable "lambda_execution_role_source_policy_document" {
  description = "A source policy document to include in the default execution role policy created for use by the lambda."
  type        = string
  default     = ""
  nullable    = false
}

variable "lambda_assume_role_policy_document" {
  description = "A policy document for the assume role policy allowing the lambda service to assume the created execution role."
  type        = string
  default     = ""
  nullable    = false
}

variable "lambda_environment_variables" {
  description = "Environment variables to be provided to the lambda function."
  type        = map(string)
  default     = null
}

variable "tags" {
  description = "AWS tags to use on created infrastructure components"
  type        = map(string)
  default     = {}
  nullable    = false
}


variable "include_vpc_access" {
  description = "Whether or not to allow the lambda to access a VPC."
  type        = bool
  default     = false
  nullable    = false
}

variable "include_execution_role_policy_vpc_access_management_statement" {
  description = "Whether or not to include a execution role policy statement to allow network management for VPC access. Defaults to `true`."
  type = bool
  default = true
  nullable = false
}

variable "include_execution_role_policy_log_management_statement" {
  description = "Whether or not to include a execution role policy statement to allow log management for lambda logging. Defaults to `true`."
  type = bool
  default = true
  nullable = false
}

variable "publish" {
  description = "Whether or not to publish creation / change as a new lambda function version."
  type        = bool
  default     = false
  nullable    = false
}
