module "module_test" {
    variable "test_variable" {
      type        = string
      description = "description"
    }
    resource "aws_instance" "mon_instance" {

    }

    output "result_module" {
      value       = ""
      sensitive   = true
      description = "description"
      depends_on  = []
    }
    
}