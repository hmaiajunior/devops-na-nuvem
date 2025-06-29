variable "tags" {
    type = map(string)
    default = {
        Enviroment = "uat"
    }
}

variable "domain" {
    type = string
    default = "amoachados.com"
}