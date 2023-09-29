variable "user_uuid" {
  type        = string
  description = "A uuid variable"

  validation {
    condition     = can(regex("^([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})$", var.user_uuid))
    error_message = "The input is not a valid UUID."
  }
}